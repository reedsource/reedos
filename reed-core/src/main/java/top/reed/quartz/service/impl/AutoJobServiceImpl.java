package top.reed.quartz.service.impl;

import org.quartz.JobDataMap;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import top.reed.common.constant.ScheduleConstants;
import top.reed.common.core.text.Convert;
import top.reed.common.exception.job.TaskException;
import top.reed.quartz.domain.AutoJob;
import top.reed.quartz.mapper.AutoJobMapper;
import top.reed.quartz.service.AutoJobService;
import top.reed.quartz.util.CronUtils;
import top.reed.quartz.util.QuartzUtils;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * 定时任务调度信息 服务层
 *
 * @author reedsource
 */
@Service
public class AutoJobServiceImpl implements AutoJobService {
    /**
     * Quartz Scheduler的主实现。
     * 计划程序维护作业详细信息和触发器的注册表。
     * 一旦注册，调度程序负责在作业的关联触发器触发时（当其计划时间到达时）执行作业。
     */
    @Autowired
    private Scheduler scheduler;

    @Autowired
    private AutoJobMapper jobMapper;

    /**
     * 项目启动时，初始化定时器
     * 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
     */
    @PostConstruct
    public void init() throws SchedulerException, TaskException {
        //清除（删除！）所有计划数据-所有作业、触发器日历
        scheduler.clear();
        List<AutoJob> jobList = jobMapper.selectJobAll();
        for (AutoJob job : jobList) {
            //把所有的计划数据添加到定时任务中
            QuartzUtils.createScheduleJob(scheduler, job);
        }
    }

    /**
     * 获取quartz调度器的计划任务列表
     *
     * @param job 调度信息
     */
    @Override
    public List<AutoJob> selectJobList(AutoJob job) {
        return jobMapper.selectJobList(job);
    }

    /**
     * 通过调度任务ID查询调度信息
     *
     * @param jobId 调度任务ID
     * @return 调度任务对象信息
     */
    @Override
    public AutoJob selectJobById(Long jobId) {
        return jobMapper.selectJobById(jobId);
    }

    /**
     * 暂停任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pauseJob(AutoJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            scheduler.pauseJob(QuartzUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 恢复任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int resumeJob(AutoJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            scheduler.resumeJob(QuartzUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 删除任务后，所对应的trigger也将被删除
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteJob(AutoJob job) throws SchedulerException {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        int rows = jobMapper.deleteJobById(jobId);
        if (rows > 0) {
            scheduler.deleteJob(QuartzUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 批量删除调度信息
     *
     * @param ids 需要删除的数据ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobByIds(String ids) throws SchedulerException {
        Long[] jobIds = Convert.toLongArray(ids);
        for (Long jobId : jobIds) {
            AutoJob job = jobMapper.selectJobById(jobId);
            deleteJob(job);
        }
    }

    /**
     * 任务调度状态修改
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int changeStatus(AutoJob job) throws SchedulerException {
        int rows = 0;
        String status = job.getStatus();
        if (ScheduleConstants.Status.NORMAL.getValue().equals(status)) {
            rows = resumeJob(job);
        } else if (ScheduleConstants.Status.PAUSE.getValue().equals(status)) {
            rows = pauseJob(job);
        }
        return rows;
    }

    /**
     * 立即运行任务
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean run(AutoJob job) throws SchedulerException {
        boolean result = false;
        Long jobId = job.getJobId();
        AutoJob tmpObj = selectJobById(job.getJobId());
        // 创建一个保存作业实例的状态信息HashMap 默认长度为15
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, tmpObj);
        //构建唯一标识JobDetail
        JobKey jobKey = QuartzUtils.getJobKey(jobId, tmpObj.getJobGroup());
        //确定调度程序中是否已存在具有给定标识符的作业。
        // 形参: jobKey–要检查的标识符
        // 返回值: 如果存在具有给定标识符的作业，则为true
        // 抛出: 计划程序异常
        if (scheduler.checkExists(jobKey)) {
            result = true;
            //触发已标识的JobDetail（立即执行）
            //触发 QuartzJob.execute()
            // 形参: data–与立即触发作业的触发器关联的（可能为空）JobDataMap
            scheduler.triggerJob(jobKey, dataMap);
        }
        return result;
    }

    /**
     * 新增任务
     *
     * @param job 调度信息 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertJob(AutoJob job) throws SchedulerException, TaskException {
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = jobMapper.insertJob(job);
        if (rows > 0) {
            QuartzUtils.createScheduleJob(scheduler, job);
        }
        return rows;
    }

    /**
     * 更新任务的时间表达式
     *
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateJob(AutoJob job) throws SchedulerException, TaskException {
        AutoJob properties = selectJobById(job.getJobId());
        int rows = jobMapper.updateJob(job);
        if (rows > 0) {
            updateSchedulerJob(job, properties.getJobGroup());
        }
        return rows;
    }

    /**
     * 更新任务
     *
     * @param job      任务对象
     * @param jobGroup 任务组名
     */
    public void updateSchedulerJob(AutoJob job, String jobGroup) throws SchedulerException, TaskException {
        Long jobId = job.getJobId();
        // 判断是否存在
        JobKey jobKey = QuartzUtils.getJobKey(jobId, jobGroup);
        if (scheduler.checkExists(jobKey)) {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(jobKey);
        }
        QuartzUtils.createScheduleJob(scheduler, job);
    }

    /**
     * 校验cron表达式是否有效
     *
     * @param cronExpression 表达式
     * @return 结果
     */
    @Override
    public boolean checkCronExpressionIsValid(String cronExpression) {
        return CronUtils.isValid(cronExpression);
    }
}