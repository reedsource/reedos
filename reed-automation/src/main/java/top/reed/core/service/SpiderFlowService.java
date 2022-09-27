package top.reed.core.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
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
import top.reed.core.Spider;
import top.reed.core.job.SpiderJobContext;
import top.reed.core.mapper.SpiderFlowMapper;
import top.reed.core.model.SpiderFlow;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 自动化任务流程执行服务
 * @author Administrator
 *
 */
@Service
public class SpiderFlowService extends ServiceImpl<SpiderFlowMapper, SpiderFlow> {
	
	@Autowired
	private SpiderFlowMapper sfMapper;

	@Autowired
	private Spider spider;

	private static Logger logger = LoggerFactory.getLogger(SpiderFlowService.class);

	@Value("${spider.workspace}")
	private String workspace;

	public IPage<SpiderFlow> selectSpiderPage(Page<SpiderFlow> page, String name){
		return sfMapper.selectSpiderPage(page,name);
	}

	@Override
	public boolean save(SpiderFlow spiderFlow){

		if (!StringUtils.isNotEmpty(spiderFlow.getId())) {//insert 任务
			String id = UUID.randomUUID().toString().replace("-", "");
			sfMapper.insertSpiderFlow(id, spiderFlow.getName(), spiderFlow.getXml());
			spiderFlow.setId(id);
		}
		File file = new File(workspace,spiderFlow.getId() + File.separator + "xmls" + File.separator + System.currentTimeMillis() + ".xml");
		try {
			FileUtils.write(file,spiderFlow.getXml(),"UTF-8");
		} catch (IOException e) {
			logger.error("保存历史记录出错",e);
		}
		return true;
	}
	
	public void stop(String id){
		sfMapper.resetSpiderStatus(id,"0");
	}
	
	public void start(String id){
			sfMapper.resetSpiderStatus(id, "1");
	}
	
	public void run(String id){
		Spider.executorInstance.submit(()->{
			run(getById(id));
		});
	}
	public void run(SpiderFlow spiderFlow ) {
		SpiderJobContext context = null;
		try {
			context = SpiderJobContext.create(this.workspace, spiderFlow.getId(),false);
			SpiderContextHolder.set(context);
			logger.info("开始执行任务{}", spiderFlow.getName());
			spider.run(spiderFlow, context);
			logger.info("执行任务{}完毕", spiderFlow.getName());
		} catch (Exception e) {
			logger.error("执行任务{}出错", spiderFlow.getName(), e);
		} finally {
			if (context != null) {
				context.close();
			}
			SpiderContextHolder.remove();
		}
	}

	public void remove(String id){
		sfMapper.deleteById(id);
	}
	
	public List<SpiderFlow> selectOtherFlows(String id){
		return sfMapper.selectOtherFlows(id);
	}
	
	public List<SpiderFlow> selectFlows(){
		return sfMapper.selectFlows();
	}

    /**
     * 根据表达式获取最近几次运行时间
	 * @param cron 表达式
	 * @param numTimes 几次
	 * @return
     */
	public List<String> getRecentTriggerTime(String cron,int numTimes) {
		List<String> list = new ArrayList<>();
		CronTrigger trigger;
		try {
			trigger = TriggerBuilder.newTrigger()
					.withSchedule(CronScheduleBuilder.cronSchedule(cron))
					.build();
		}catch (Exception e) {
			list.add("cron表达式 "+cron+" 有误：" + e.getCause());
			return list;
		}
		List<Date> dates = TriggerUtils.computeFireTimes((OperableTrigger) trigger, null, numTimes);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Date date : dates) {
			list.add(dateFormat.format(date));
		}
		return list;
	}

	public List<Long> historyList(String id){
		File directory = new File(workspace, id + File.separator + "xmls");
		if(directory.exists() && directory.isDirectory()){
			File[] files = directory.listFiles((dir, name) -> name.endsWith(".xml"));
			if(files != null && files.length > 0){
				return Arrays.stream(files).map(f-> Long.parseLong(f.getName().replace(".xml",""))).sorted().collect(Collectors.toList());
			}
		}
		return Collections.emptyList();
	}

	public String readHistory(String id,String timestamp){
		File file = new File(workspace, id + File.separator + "xmls" + File.separator + timestamp + ".xml");
		if(file.exists()){
			try {
				return FileUtils.readFileToString(file,"UTF-8");
			} catch (IOException e) {
				logger.error("读取历史版本出错",e);
			}
		}
		return null;
	}
}
