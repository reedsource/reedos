package top.reed.automation.service.impl;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import top.reed.api.context.SpiderContextHolder;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.mapper.AutoFlowMapper;
import top.reed.automation.service.AutoFlowService;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.CacheUtils;
import top.reed.core.Auto;
import top.reed.core.job.SpiderJobContext;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 自动化任务Service业务层处理
 *
 * @author reedsource
 * date 2022-09-29
 */
@Service
public class AutoFlowServiceImpl implements AutoFlowService {
	private static Logger logger = LoggerFactory.getLogger(AutoFlowServiceImpl.class);
	private final AutoFlowMapper autoFlowMapper;
	/**
	 * 自动化任务的工作空间
	 */
	@Value("${auto.workspace}")
	private String workspace;
	@Autowired
	private Auto auto;

	public AutoFlowServiceImpl(AutoFlowMapper autoFlowMapper) {
		this.autoFlowMapper = autoFlowMapper;
	}

	/**
	 * 查询自动化任务
	 *
	 * @param id 自动化任务主键
	 * @return 自动化任务
	 */
	@Override
	public AutoFlow selectAutoFlowById(Long id) {
		return autoFlowMapper.selectAutoFlowById(id);
	}

	/**
	 * 查询自动化任务列表
	 *
	 * @param autoFlow 自动化任务
	 * @return 自动化任务
	 */
	@Override
	public List<AutoFlow> selectAutoFlowList(AutoFlow autoFlow) {
		return autoFlowMapper.selectAutoFlowList(autoFlow);
	}

	/**
	 * 保存自动化任务
	 *
	 * @param autoFlow 自动化任务
	 * @return 结果
	 */
	@Override
	public int saveAutoFlow(AutoFlow autoFlow) {
		int i;
		//任务存在更新
		if (autoFlowMapper.selectAutoFlowById(autoFlow.getId()) != null) {
			i = autoFlowMapper.updateAutoFlow(autoFlow);
		} else {
			//任务不存在添加
			i = autoFlowMapper.insertAutoFlow(autoFlow);
		}
		String id = autoFlowMapper.selectAutoFlowList(autoFlow).get(0).getId().toString();
		//更新缓存
		CacheUtils.put("auto_job_name", id, autoFlow.getName());
		File file = new File(workspace, id + File.separator + "xmls" + File.separator + System.currentTimeMillis() + ".xml");
		try {
			FileUtils.write(file, autoFlow.getXml(), "UTF-8");
		} catch (IOException e) {
			logger.error("保存历史记录出错", e);
		}
		return i;
	}

	/**
	 * 修改自动化任务状态
	 *
	 * @param autoFlow 自动化任务
	 * @return 结果
	 */
	@Override
	public int updateStatus(AutoFlow autoFlow) {
		int i = 0;
		//任务存在更新
		if (autoFlowMapper.selectAutoFlowById(autoFlow.getId()) != null) {
			i = autoFlowMapper.updateAutoFlow(autoFlow);
		} else {
			logger.error("修改自动化任务状态出错,任务id不存在");
		}
		return i;
	}


	/**
	 * 批量删除自动化任务
	 *
	 * @param ids 需要删除的自动化任务主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoFlowByIds(String ids) {
		return autoFlowMapper.deleteAutoFlowByIds(Convert.toStrArray(ids));
	}

	/**
	 * 删除自动化任务信息
	 *
	 * @param id 自动化任务主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoFlowById(Long id) {
		return autoFlowMapper.deleteAutoFlowById(id);
	}

	/**
	 * 执行一次流程
	 *
	 * @param id 自动化流程id
	 */
	@Override
	public void run(Long id) {
		Auto.executorInstance.submit(() -> {
			run(selectAutoFlowById(id));
		});
	}

	/**
	 * 执行一次流程
	 *
	 * @param autoFlow 自动化流程
	 */
	public void run(AutoFlow autoFlow) {
		SpiderJobContext context = null;
		try {
			context = SpiderJobContext.create(this.workspace, autoFlow.getId().toString(), false);
			SpiderContextHolder.set(context);
			logger.info("开始执行任务{}", autoFlow.getName());
			auto.run(autoFlow, context);
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
}
