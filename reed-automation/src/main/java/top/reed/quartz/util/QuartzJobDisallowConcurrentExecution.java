package top.reed.quartz.util;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import top.reed.quartz.domain.AutoJob;

/**
 * 定时任务处理（禁止并发执行）
 *
 * @author reedsource
 */
@DisallowConcurrentExecution
public class QuartzJobDisallowConcurrentExecution extends QuartzJob {
    @Override
    protected void doExecute(JobExecutionContext context, AutoJob autoJob) throws Exception {
        QuartzJobInvokeUtil.invokeMethod(autoJob);
    }
}
