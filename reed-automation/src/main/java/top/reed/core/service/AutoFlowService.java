package top.reed.core.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.io.FileUtils;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerUtils;
import org.quartz.spi.OperableTrigger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import top.reed.api.context.SpiderContextHolder;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.mapper.AutooFlowMapper;
import top.reed.core.Spider;
import top.reed.core.job.SpiderJobContext;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 自动化任务流程执行服务
 *
 * @author reedsource
 */
@Service
public class AutoFlowService {

	private static Logger logger = LoggerFactory.getLogger(AutoFlowService.class);
	@Autowired
	AutooFlowMapper autooFlowMapper;
	@Autowired
	private Spider spider;
	@Value("${spider.workspace}")
	private String workspace;

	public boolean save(AutoFlow autoFlow) {
		autooFlowMapper.insertAutoFlow(autoFlow);
		String id = autooFlowMapper.selectAutoFlowList(autoFlow).get(0).getId().toString();
		File file = new File(workspace, id + File.separator + "xmls" + File.separator + System.currentTimeMillis() + ".xml");
		try {
			FileUtils.write(file, autoFlow.getXml(), "UTF-8");
		} catch (IOException e) {
			logger.error("保存历史记录出错", e);
		}
		return true;
	}


	public void run(Long id) {
		Spider.executorInstance.submit(() -> {
			run(autooFlowMapper.selectAutoFlowById(id));
		});
	}

	public void run(AutoFlow autoFlow) {
		SpiderJobContext context = null;
		try {
			context = SpiderJobContext.create(this.workspace, autoFlow.getId().toString(), false);
			SpiderContextHolder.set(context);
			logger.info("开始执行任务{}", autoFlow.getName());
			spider.run(autoFlow, context);
			logger.info("执行任务{}完毕", autoFlow.getName());
		} catch (Exception e) {
			logger.error("执行任务{}出错", autoFlow.getName(), e);
		} finally {
			if (context != null) {
				context.close();
			}
			SpiderContextHolder.remove();
		}
	}

	public void remove(Long id) {
		autooFlowMapper.deleteAutoFlowById(id);
	}

	public List<AutoFlow> selectOtherFlows(AutoFlow autoFlow) {
		return autooFlowMapper.selectAutoFlowList(autoFlow);
	}

	/**
	 * 根据表达式获取最近几次运行时间
	 *
	 * @param cron     表达式
	 * @param numTimes 几次
	 * @return
	 */
	public List<String> getRecentTriggerTime(String cron, int numTimes) {
		List<String> list = new ArrayList<>();
		CronTrigger trigger;
		try {
			trigger = TriggerBuilder.newTrigger()
					.withSchedule(CronScheduleBuilder.cronSchedule(cron))
					.build();
		} catch (Exception e) {
			list.add("cron表达式 " + cron + " 有误：" + e.getCause());
			return list;
		}
		List<Date> dates = TriggerUtils.computeFireTimes((OperableTrigger) trigger, null, numTimes);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Date date : dates) {
			list.add(dateFormat.format(date));
		}
		return list;
	}

	public List<Long> historyList(String id) {
		File directory = new File(workspace, id + File.separator + "xmls");
		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles((dir, name) -> name.endsWith(".xml"));
			if (files != null && files.length > 0) {
				return Arrays.stream(files).map(f -> Long.parseLong(f.getName().replace(".xml", ""))).sorted().collect(Collectors.toList());
			}
		}
		return Collections.emptyList();
	}

	public String readHistory(String id, String timestamp) {
		File file = new File(workspace, id + File.separator + "xmls" + File.separator + timestamp + ".xml");
		if (file.exists()) {
			try {
				return FileUtils.readFileToString(file, "UTF-8");
			} catch (IOException e) {
				logger.error("读取历史版本出错", e);
			}
		}
		return null;
	}
}
