package top.reed.quartz.util;

import org.quartz.*;
import top.reed.common.constant.Constants;
import top.reed.common.constant.ScheduleConstants;
import top.reed.common.exception.job.TaskException;
import top.reed.common.exception.job.TaskException.Code;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.spring.SpringUtils;
import top.reed.quartz.domain.SysJob;

/**
 * 定时任务工具类
 *
 * @author reedsource
 */
public class QuartzUtils {
	/**
	 * 得到quartz任务类
	 *
	 * @param sysJob 执行计划
	 * @return 具体执行任务类 是否运行并发执行
	 */
	private static Class<? extends Job> getQuartzJobClass(SysJob sysJob) {
		boolean isConcurrent = "0".equals(sysJob.getConcurrent());
		return isConcurrent ? QuartzJobExecution.class : QuartzJobDisallowConcurrentExecution.class;
	}

	/**
	 * 构建任务触发对象
	 */
	public static TriggerKey getTriggerKey(Long jobId, String jobGroup) {
		return TriggerKey.triggerKey(ScheduleConstants.TASK_CLASS_NAME + jobId, jobGroup);
	}

	/**
	 * 构建任务键对象 构造一个唯一标识JobDetail新键
	 */
	public static JobKey getJobKey(Long jobId, String jobGroup) {
		//用给定的名称和组构造一个唯一标识JobDetail新键。 形参: name–名称group–组
		return JobKey.jobKey(ScheduleConstants.TASK_CLASS_NAME + jobId, jobGroup);
	}

	/**
	 * 创建定时任务
	 *
	 * @param scheduler Quartz Scheduler的主实现
	 * @param job       定时任务对象
	 */
	public static void createScheduleJob(Scheduler scheduler, SysJob job) throws SchedulerException, TaskException {
		//根据设置返回符合 并发执行 需求的 job 调用执行子实现类
		Class<? extends Job> jobClass = getQuartzJobClass(job);
		// 构建job信息
		Long jobId = job.getJobId();
		String jobGroup = job.getJobGroup();
		//传递给定作业实例的数据映射集详细属性
		JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(getJobKey(jobId, jobGroup)).build();

		// 表达式调度构建器
		//使用给定的cron表达式字符串创建CronScheduleBuilder，该字符串被假定为有效的cron表达（因此，如果不是，则只会抛出RuntimeException）
		CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
		//设置定时任务策略
		cronScheduleBuilder = handleCronScheduleMisfirePolicy(job, cronScheduleBuilder);

		// 按新的cronExpression表达式构建一个新的trigger触发器
		CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(getTriggerKey(jobId, jobGroup))
				.withSchedule(cronScheduleBuilder).build();

		// 作业关联的作业数据映射 放入参数，运行时的方法可以获取
		jobDetail.getJobDataMap().put(ScheduleConstants.TASK_PROPERTIES, job);

		// 判断是否存在
		if (scheduler.checkExists(getJobKey(jobId, jobGroup))) {
			// 防止创建时存在数据问题 先移除，然后在执行创建操作
			scheduler.deleteJob(getJobKey(jobId, jobGroup));
		}

		// 判断任务是否过期
		if (StringUtils.isNotNull(CronUtils.getNextExecution(job.getCronExpression()))) {
			// 执行调度任务 作业实例数据映射集 触发器
			scheduler.scheduleJob(jobDetail, trigger);
		}

		// 使用给定键暂停JobDetail-通过暂停其所有当前触发器
		// 暂停任务
		if (ScheduleConstants.Status.PAUSE.getValue().equals(job.getStatus())) {
			scheduler.pauseJob(QuartzUtils.getJobKey(jobId, jobGroup));
		}
	}

	/**
	 * 设置定时任务策略
	 */
	public static CronScheduleBuilder handleCronScheduleMisfirePolicy(SysJob job, CronScheduleBuilder cb)
			throws TaskException {
		//0=默认,1=立即触发执行,2=触发一次执行,3=不触发立即执行
		switch (job.getMisfirePolicy()) {
			case ScheduleConstants.MISFIRE_DEFAULT:
				return cb;
			case ScheduleConstants.MISFIRE_IGNORE_MISFIRES:
				return cb.withMisfireHandlingInstructionIgnoreMisfires();
			case ScheduleConstants.MISFIRE_FIRE_AND_PROCEED:
				return cb.withMisfireHandlingInstructionFireAndProceed();
			case ScheduleConstants.MISFIRE_DO_NOTHING:
				return cb.withMisfireHandlingInstructionDoNothing();
			default:
				throw new TaskException("定时任务执行策略 '" + job.getMisfirePolicy()
						+ "' 不能在cron计划任务中使用", Code.CONFIG_ERROR);
		}
	}

	/**
	 * 检查包名是否为白名单配置
	 *
	 * @param invokeTarget 目标字符串
	 * @return 结果
	 */
	public static boolean whiteList(String invokeTarget) {
		String packageName = StringUtils.substringBefore(invokeTarget, "(");
		int count = StringUtils.countMatches(packageName, ".");
		if (count > 1) {
			return StringUtils.containsAnyIgnoreCase(invokeTarget, Constants.JOB_WHITELIST_STR);
		}
		Object obj = SpringUtils.getBean(StringUtils.split(invokeTarget, ".")[0]);
		return StringUtils.containsAnyIgnoreCase(obj.getClass().getPackage().getName(), Constants.JOB_WHITELIST_STR);
	}
}