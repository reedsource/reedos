package top.reed.quartz.util;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import top.reed.common.constant.Constants;
import top.reed.common.constant.ScheduleConstants;
import top.reed.common.utils.ExceptionUtil;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.bean.BeanUtils;
import top.reed.common.utils.spring.SpringUtils;
import top.reed.quartz.domain.SysJob;
import top.reed.quartz.domain.SysJobLog;
import top.reed.quartz.service.ISysJobLogService;

import java.util.Date;

/**
 * 抽象quartz调用
 *
 * @author reedsource
 */
public abstract class AbstractQuartzJob implements Job {
	private static final Logger log = LoggerFactory.getLogger(AbstractQuartzJob.class);

	/**
	 * 线程本地变量
	 */
	private static ThreadLocal<Date> threadLocal = new ThreadLocal<>();

	@Override
	public void execute(JobExecutionContext context) {
		SysJob sysJob = new SysJob();
		BeanUtils.copyBeanProp(sysJob, context.getMergedJobDataMap().get(ScheduleConstants.TASK_PROPERTIES));
		try {
			before(context, sysJob);
			if (sysJob != null) {
				doExecute(context, sysJob);
			}
			after(context, sysJob, null);
		} catch (Exception e) {
			log.error("任务执行异常  - ：", e);
			after(context, sysJob, e);
		}
	}

	/**
	 * 执行前
	 *
	 * @param context 工作执行上下文对象
	 * @param sysJob  系统计划任务
	 */
	protected void before(JobExecutionContext context, SysJob sysJob) {
		threadLocal.set(new Date());
	}

	/**
	 * 执行后
	 *
	 * @param context        工作执行上下文对象
	 */
	protected void after(JobExecutionContext context, SysJob sysJob, Exception e) {
		Date startTime = threadLocal.get();
		threadLocal.remove();

		final SysJobLog sysJobLog = new SysJobLog();
		sysJobLog.setJobName(sysJob.getJobName());
		sysJobLog.setJobGroup(sysJob.getJobGroup());
		sysJobLog.setInvokeTarget(sysJob.getInvokeTarget());
		sysJobLog.setStartTime(startTime);
		sysJobLog.setEndTime(new Date());
		long runMs = sysJobLog.getEndTime().getTime() - sysJobLog.getStartTime().getTime();
		sysJobLog.setJobMessage(sysJobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (e != null) {
			sysJobLog.setStatus(Constants.FAIL);
			String errorMsg = StringUtils.substring(ExceptionUtil.getExceptionMessage(e), 0, 2000);
			sysJobLog.setExceptionInfo(errorMsg);
		} else {
			sysJobLog.setStatus(Constants.SUCCESS);
		}

		// 写入数据库当中
		SpringUtils.getBean(ISysJobLogService.class).addJobLog(sysJobLog);
	}

	/**
	 * 执行方法，由子类重载
	 *
	 * @param context 工作执行上下文对象
	 * @param sysJob  系统计划任务
	 * @throws Exception 执行过程中的异常
	 */
	protected abstract void doExecute(JobExecutionContext context, SysJob sysJob) throws Exception;
}