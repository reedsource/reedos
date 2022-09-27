package top.reed.core.job;

import org.quartz.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.core.Spider;
import top.reed.core.model.SpiderFlow;

import java.util.Date;

/**
 * 自动化任务定时执行管理
 * @author Administrator
 *
 */
@Component
public class SpiderJobManager {
	
	private static Logger logger = LoggerFactory.getLogger(SpiderJobManager.class);
	
	private final static String JOB_NAME = "SPIDER_TASK_";
	
	public final static String JOB_PARAM_NAME = "SPIDER_FLOW";
	
	@Autowired
	private SpiderJob spiderJob;
	
	/**
	 * 调度器
	 */
	@Autowired
	private Scheduler scheduler;
	
	private JobKey getJobKey(String id){
		return JobKey.jobKey(JOB_NAME + id);
	}
	
	private TriggerKey getTriggerKey(String id){
		return TriggerKey.triggerKey(JOB_NAME + id);
	}
	
	public void run(String id){
		Spider.executorInstance.submit(()->{
			spiderJob.run(id);
		});
	}
}
