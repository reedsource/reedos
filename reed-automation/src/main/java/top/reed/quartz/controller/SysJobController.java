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
import top.reed.quartz.domain.SysJob;
import top.reed.quartz.service.ISysJobService;
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
public class SysJobController extends BaseController {

	@Autowired
	private ISysJobService jobService;

	@RequiresPermissions("quartz:job:view")
	@GetMapping()
	public String job() {
		return "quartz/job/job";
	}

	@RequiresPermissions("quartz:job:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(SysJob job) {
		startPage();
		List<SysJob> list = jobService.selectJobList(job);
		return getDataTable(list);
	}

	@Log(title = "定时任务", businessType = BusinessType.EXPORT)
	@RequiresPermissions("quartz:job:export")
	@PostMapping("/export")
	@ResponseBody
	public AjaxResult export(SysJob job) {
		List<SysJob> list = jobService.selectJobList(job);
		ExcelUtil<SysJob> util = new ExcelUtil<>(SysJob.class);
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
	public String detail(@PathVariable("jobId") Long jobId, ModelMap mmap) {
		mmap.put("name", "job");
		mmap.put("job", jobService.selectJobById(jobId));
		return "quartz/job/detail";
	}

	/**
	 * 任务调度状态修改
	 */
	@Log(title = "定时任务", businessType = BusinessType.UPDATE)
	@RequiresPermissions("quartz:job:changeStatus")
	@PostMapping("/changeStatus")
	@ResponseBody
	public AjaxResult changeStatus(SysJob job) throws SchedulerException {
		SysJob newJob = jobService.selectJobById(job.getJobId());
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
	public AjaxResult run(SysJob job) throws SchedulerException {
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
	public AjaxResult addSave(@Validated SysJob job) throws SchedulerException, TaskException {
		if (!CronUtils.isValid(job.getCronExpression())) {
			return error("新增任务'" + job.getJobName() + "'失败，Cron表达式不正确");
		} else if (StringUtils.containsIgnoreCase(job.getInvokeTarget(), Constants.LOOKUP_RMI)) {
			return error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'rmi'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.LOOKUP_LDAP, Constants.LOOKUP_LDAPS})) {
			return error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'ldap(s)'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.HTTP, Constants.HTTPS})) {
			return error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'http(s)'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), Constants.JOB_ERROR_STR)) {
			return error("新增任务'" + job.getJobName() + "'失败，目标字符串存在违规");
		} else if (!QuartzUtils.whiteList(job.getInvokeTarget())) {
			return error("新增任务'" + job.getJobName() + "'失败，目标字符串不在白名单内");
		}
		job.setCreateBy(getLoginName());
		return toAjax(jobService.insertJob(job));
	}

	/**
	 * 修改调度
	 */
	@RequiresPermissions("quartz:job:edit")
	@GetMapping("/edit/{jobId}")
	public String edit(@PathVariable("jobId") Long jobId, ModelMap mmap) {
		mmap.put("job", jobService.selectJobById(jobId));
		return "quartz/job/edit";
	}

	/**
	 * 修改保存调度
	 */
	@Log(title = "定时任务", businessType = BusinessType.UPDATE)
	@RequiresPermissions("quartz:job:edit")
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(@Validated SysJob job) throws SchedulerException, TaskException {
		if (!CronUtils.isValid(job.getCronExpression())) {
			return error("修改任务'" + job.getJobName() + "'失败，Cron表达式不正确");
		} else if (StringUtils.containsIgnoreCase(job.getInvokeTarget(), Constants.LOOKUP_RMI)) {
			return error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'rmi'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.LOOKUP_LDAP, Constants.LOOKUP_LDAPS})) {
			return error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'ldap'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{Constants.HTTP, Constants.HTTPS})) {
			return error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'http(s)'调用");
		} else if (StringUtils.containsAnyIgnoreCase(job.getInvokeTarget(), Constants.JOB_ERROR_STR)) {
			return error("修改任务'" + job.getJobName() + "'失败，目标字符串存在违规");
		} else if (!QuartzUtils.whiteList(job.getInvokeTarget())) {
			return error("修改任务'" + job.getJobName() + "'失败，目标字符串不在白名单内");
		}
		return toAjax(jobService.updateJob(job));
	}

	/**
	 * 校验cron表达式是否有效
	 */
	@PostMapping("/checkCronExpressionIsValid")
	@ResponseBody
	public boolean checkCronExpressionIsValid(SysJob job) {
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
