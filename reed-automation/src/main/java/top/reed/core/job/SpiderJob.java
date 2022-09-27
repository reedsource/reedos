package top.reed.core.job;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;
import top.reed.api.context.SpiderContextHolder;
import top.reed.core.Spider;
import top.reed.core.model.SpiderFlow;
import top.reed.core.service.SpiderFlowService;

import java.util.Date;
/**
 * 自动化任务定时执行
 *
 * @author Administrator
 */
@Component
public class SpiderJob extends QuartzJobBean {

	@Autowired
	private Spider spider;

	@Autowired
	private SpiderFlowService spiderFlowService;

	@Value("${spider.job.enable:true}")
	private boolean spiderJobEnable;

	@Value("${spider.workspace}")
	private String workspace;

	private static Logger logger = LoggerFactory.getLogger(SpiderJob.class);

	@Override
	protected void executeInternal(JobExecutionContext context) {
		if (!spiderJobEnable) {
			return;
		}
		JobDataMap dataMap = context.getMergedJobDataMap();
		SpiderFlow spiderFlow = (SpiderFlow) dataMap.get(SpiderJobManager.JOB_PARAM_NAME);
		if("1".equalsIgnoreCase(spiderFlow.getEnabled())){
			run(spiderFlow, context.getNextFireTime());
		}
	}

	public void run(String id) {
		run(spiderFlowService.getById(id), null);
	}

	public void run(SpiderFlow spiderFlow, Date nextExecuteTime) {
		SpiderJobContext context = null;
		Date now = new Date();
		try {
			context = SpiderJobContext.create(this.workspace, spiderFlow.getId(),false);
			SpiderContextHolder.set(context);
			logger.info("开始执行任务{}", spiderFlow.getName());
			spider.run(spiderFlow, context);
			logger.info("执行任务{}完毕，下次执行时间：{}", spiderFlow.getName(), nextExecuteTime == null ? null : DateFormatUtils.format(nextExecuteTime, "yyyy-MM-dd HH:mm:ss"));
		} catch (Exception e) {
			logger.error("执行任务{}出错", spiderFlow.getName(), e);
		} finally {
			if (context != null) {
				context.close();
			}
			SpiderContextHolder.remove();
		}
		spiderFlowService.executeCountIncrement(spiderFlow.getId(), now, nextExecuteTime);
	}
}
