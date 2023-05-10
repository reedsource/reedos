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
import top.reed.quartz.domain.AutoJob;
import top.reed.quartz.domain.AutoJobLog;
import top.reed.quartz.service.AutoJobLogService;

import java.util.Date;

/**
 * 抽象quartz调用实现
 * <p>
 * 由表示要执行的“job”的类实现的接口。
 * job的实例必须具有公共的无参数构造函数。
 * JobDataMap为该接口的某些实现可能需要的“实例成员数据”提供了一种机制。
 *
 * @author reedsource
 */
public abstract class QuartzJob implements Job {
    private static final Logger log = LoggerFactory.getLogger(QuartzJob.class);

    /**
     * 线程本地变量
     */
    private static final ThreadLocal<Date> threadLocal = new ThreadLocal<>();

    /**
     * 当触发与作业关联的触发器时，由调度程序调用
     * 在该方法退出之前，实现可能希望在JobExecutionContext上设置一个结果对象。
     * 结果本身对Quartz来说没有意义，但对于正在监视作业执行的JobListeners或TriggerListeners来说可能有提示信息。
     * 抛出: JobExecutionException–如果在执行作业时出现异常。
     *
     * @param context 结果对象
     */
    @Override
    public void execute(JobExecutionContext context) {
        //定时任务调度表对象
        AutoJob autoJob = new AutoJob();
        BeanUtils.copyBeanProp(autoJob, context.getMergedJobDataMap().get(ScheduleConstants.TASK_PROPERTIES));
        try {
            //调度执行前记录时间
            before(context, autoJob);
            //调度任务
            doExecute(context, autoJob);
            //调度后记录日志信息
            after(context, autoJob, null);
        } catch (Exception e) {
            log.error("任务执行异常  - ：", e);
            after(context, autoJob, e);
        }
    }

    /**
     * 执行前
     *
     * @param context 工作执行上下文对象
     * @param autoJob 系统计划任务
     */
    protected void before(JobExecutionContext context, AutoJob autoJob) {
        threadLocal.set(new Date());
    }

    /**
     * 执行后
     *
     * @param context 工作执行上下文对象
     */
    protected void after(JobExecutionContext context, AutoJob autoJob, Exception e) {
        Date startTime = threadLocal.get();
        threadLocal.remove();

        final AutoJobLog autoJobLog = new AutoJobLog();
        autoJobLog.setJobName(autoJob.getJobName());
        autoJobLog.setJobGroup(autoJob.getJobGroup());
        autoJobLog.setInvokeTarget(autoJob.getInvokeTarget());
        autoJobLog.setStartTime(startTime);
        autoJobLog.setEndTime(new Date());
        long runMs = autoJobLog.getEndTime().getTime() - autoJobLog.getStartTime().getTime();
        autoJobLog.setJobMessage(autoJobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
        if (e != null) {
            autoJobLog.setStatus(Constants.FAIL);
            String errorMsg = StringUtils.substring(ExceptionUtil.getExceptionMessage(e), 0, 2000);
            autoJobLog.setExceptionInfo(errorMsg);
        } else {
            autoJobLog.setStatus(Constants.SUCCESS);
        }

        // 写入数据库当中
        SpringUtils.getBean(AutoJobLogService.class).addJobLog(autoJobLog);
    }

    /**
     * 执行方法，由子类重载
     *
     * @param context 工作执行上下文对象
     * @param autoJob 系统计划任务
     *                throws Exception 执行过程中的异常
     */
    protected abstract void doExecute(JobExecutionContext context, AutoJob autoJob) throws Exception;
}
