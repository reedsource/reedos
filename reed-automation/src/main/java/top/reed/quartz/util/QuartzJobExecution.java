package top.reed.quartz.util;

import org.quartz.JobExecutionContext;
import top.reed.quartz.domain.AutoJob;

/**
 * 定时任务处理（允许并发执行）
 *
 * @author reedsource
 */
public class QuartzJobExecution extends QuartzJob {
    @Override
    protected void doExecute(JobExecutionContext context, AutoJob autoJob) throws Exception {
        QuartzJobInvokeUtil.invokeMethod(autoJob);
    }
}
