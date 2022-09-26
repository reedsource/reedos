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
 * 爬虫定时执行管理
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
	
	/**
	 * 新建定时任务
	 * @param spiderFlow 爬虫流程图
	 * @return boolean true/false
	 */
	public Date addJob(SpiderFlow spiderFlow){
		try {
			JobDetail job = JobBuilder.newJob(SpiderJob.class).withIdentity(getJobKey(spiderFlow.getId())).build();
			job.getJobDataMap().put(JOB_PARAM_NAME, spiderFlow);
			
			CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(spiderFlow.getCron()).withMisfireHandlingInstructionDoNothing();
			
			CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(getTriggerKey(spiderFlow.getId())).withSchedule(cronScheduleBuilder).build();
			
			return scheduler.scheduleJob(job,trigger);
		} catch (SchedulerException e) {
			logger.error("创建定时任务出错",e);
			return null;
		}
	}
	
	public void run(String id){
		Spider.executorInstance.submit(()->{
			spiderJob.run(id);
		});
	}
	
	public boolean remove(String id){
		try {
			scheduler.deleteJob(getJobKey(id));
			return true;
		} catch (SchedulerException e) {
			logger.error("删除定时任务失败",e);
			return false;
		}
	}

}
