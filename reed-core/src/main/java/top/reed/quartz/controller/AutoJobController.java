package top.reed.quartz.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import top.reed.common.annotation.Log;
import top.reed.common.constant.Constants;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.exception.job.TaskException;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.poi.ExcelUtil;
import top.reed.quartz.domain.AutoJob;
import top.reed.quartz.service.AutoJobService;
import top.reed.quartz.util.CronUtils;
import top.reed.quartz.util.QuartzUtils;

import java.util.List;

/**
 * 调度任务信息操作处理
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/quartz/job")
public class AutoJobController extends BaseController {


    @Autowired
    private AutoJobService jobService;

    @RequiresPermissions("quartz:job:view")
    @GetMapping()
    public String job() {
        return "quartz/job/job";
    }

    @RequiresPermissions("quartz:job:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(AutoJob job) {
        startPage();
        List<AutoJob> list = jobService.selectJobList(job);
        return getDataTable(list);
    }

    @Log(title = "定时任务", businessType = BusinessType.EXPORT)
    @RequiresPermissions("quartz:job:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(AutoJob job) {
        List<AutoJob> list = jobService.selectJobList(job);
        ExcelUtil<AutoJob> util = new ExcelUtil<>(AutoJob.class);
        return util.exportExcel(list, "定时任务");
    }

    @Log(title = "定时任务", businessType = BusinessType.DELETE)
    @RequiresPermissions("quartz:job:remove")
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) throws SchedulerException {
        jobService.deleteJobByIds(ids);
        return success();
    }

    @RequiresPermissions("quartz:job:detail")
    @GetMapping("/detail/{jobId}")
    public String detail(@PathVariable("jobId") Long jobId, ModelMap modelMap) {
        modelMap.put("name", "job");
        modelMap.put("job", jobService.selectJobById(jobId));
        return "quartz/job/detail";
    }

    /**
     * 任务调度状态修改
     */
    @Log(title = "定时任务", businessType = BusinessType.UPDATE)
    @RequiresPermissions("quartz:job:changeStatus")
    @PostMapping("/changeStatus")
    @ResponseBody
    public AjaxResult changeStatus(AutoJob job) throws SchedulerException {
        AutoJob newJob = jobService.selectJobById(job.getJobId());
        newJob.setStatus(job.getStatus());
        return toAjax(jobService.changeStatus(newJob));
    }

    /**
     * 任务调度立即执行一次
     */
    @Log(title = "定时任务", businessType = BusinessType.UPDATE)
    @RequiresPermissions("quartz:job:changeStatus")
    @PostMapping("/run")
    @ResponseBody
    public AjaxResult run(AutoJob job) throws SchedulerException {
        boolean result = jobService.run(job);
        return result ? success() : error("任务不存在或已过期！");
    }

    /**
     * 新增调度
     */
    @GetMapping("/add")
    public String add() {
        return "quartz/job/add";
    }

    /**
     * 新增保存调度
     */
    @Log(title = "定时任务", businessType = BusinessType.INSERT)
    @RequiresPermissions("quartz:job:add")
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(@Validated AutoJob job) throws SchedulerException, TaskException {
        String m = "新增";
        AjaxResult ajaxResult = getAjaxResult(job, m);
        if (ajaxResult.isError()) {
            return ajaxResult;
        } else {
            job.setCreateBy(getLoginName());
            return toAjax(jobService.insertJob(job));
        }
    }

    /**
     * 修改调度
     */
    @RequiresPermissions("quartz:job:edit")
    @GetMapping("/edit/{jobId}")
    public String edit(@PathVariable("jobId") Long jobId, ModelMap modelMap) {
        modelMap.put("job", jobService.selectJobById(jobId));
        return "quartz/job/edit";
    }

    /**
     * 修改保存调度
     */
    @Log(title = "定时任务", businessType = BusinessType.UPDATE)
    @RequiresPermissions("quartz:job:edit")
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(@Validated AutoJob job) throws SchedulerException, TaskException {
        String m = "修改";
        AjaxResult ajaxResult = getAjaxResult(job, m);
        if (ajaxResult.isError()) {
            return ajaxResult;
        } else {
            return toAjax(jobService.updateJob(job));
        }
    }

    /**
     * @param job 定时任务任务
     * @param m   任务类型
     * @return 校验结构
     */
    private AjaxResult getAjaxResult(AutoJob job, String m) {
        AjaxResult ajaxResult = new AjaxResult();
        if ("0".equals(job.getJobType())) {
            //处理前端两个相同name导致的提交值多了,
            job.setInvokeTarget(job.getInvokeTarget().replaceAll(",", ""));
            //获取自动化任务id
            try {
                long autoId = Long.parseLong(job.getInvokeTarget());
            } catch (NumberFormatException e) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，自动化任务id异常");
            }
        } else {
            if (!CronUtils.isValid(job.getCronExpression())) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，Cron表达式不正确");
            } else if (StringUtils.containsIgnoreCase(job.getInvokeTarget(), Constants.LOOKUP_RMI)) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，目标字符串不允许'rmi'调用");
            } else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.LOOKUP_LDAP, Constants.LOOKUP_LDAPS})) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，目标字符串不允许'ldap(s)'调用");
            } else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.HTTP, Constants.HTTPS})) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，目标字符串不允许'http(s)'调用");
            } else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), Constants.JOB_ERROR_STR)) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，目标字符串存在违规");
            } else if (QuartzUtils.whiteList(job.getInvokeTarget())) {
                ajaxResult = error(m + "任务'" + job.getJobName() + "'失败，目标字符串不在白名单内");
            }
        }
        return ajaxResult;
    }

    /**
     * 校验cron表达式是否有效
     */
    @PostMapping("/checkCronExpressionIsValid")
    @ResponseBody
    public boolean checkCronExpressionIsValid(AutoJob job) {
        return jobService.checkCronExpressionIsValid(job.getCronExpression());
    }

    /**
     * Cron表达式在线生成
     */
    @GetMapping("/cron")
    public String cron() {
        return "quartz/job/cron";
    }

    /**
     * 查询cron表达式近5次的执行时间
     */
    @GetMapping("/queryCronExpression")
    @ResponseBody
    public AjaxResult queryCronExpression(@RequestParam(value = "cronExpression", required = false) String cronExpression) {
        if (jobService.checkCronExpressionIsValid(cronExpression)) {
            List<String> dateList = CronUtils.getRecentTriggerTime(cronExpression);
            return success(dateList);
        } else {
            return error("表达式无效");
        }
    }
}
