package top.reed.quartz.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.poi.ExcelUtil;
import top.reed.quartz.domain.AutoJob;
import top.reed.quartz.domain.AutoJobLog;
import top.reed.quartz.service.AutoJobLogService;
import top.reed.quartz.service.AutoJobService;

import java.util.List;

/**
 * 调度日志操作处理
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/quartz/jobLog")
public class AutoJobLogController extends BaseController {

    @Autowired
    private AutoJobService jobService;

    @Autowired
    private AutoJobLogService jobLogService;

    @RequiresPermissions("quartz:job:view")
    @GetMapping()
    public String jobLog(@RequestParam(value = "jobId", required = false) Long jobId, ModelMap modelMap) {
        if (StringUtils.isNotNull(jobId)) {
            AutoJob job = jobService.selectJobById(jobId);
            modelMap.put("job", job);
        }
        return "quartz/job/jobLog" ;
    }

    @RequiresPermissions("quartz:job:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(AutoJobLog jobLog) {
        startPage();
        List<AutoJobLog> list = jobLogService.selectJobLogList(jobLog);
        return getDataTable(list);
    }

    @Log(title = "调度日志", businessType = BusinessType.EXPORT)
    @RequiresPermissions("quartz:job:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(AutoJobLog jobLog) {
        List<AutoJobLog> list = jobLogService.selectJobLogList(jobLog);
        ExcelUtil<AutoJobLog> util = new ExcelUtil<>(AutoJobLog.class);
        return util.exportExcel(list, "调度日志");
    }

    @Log(title = "调度日志", businessType = BusinessType.DELETE)
    @RequiresPermissions("quartz:job:remove")
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(jobLogService.deleteJobLogByIds(ids));
    }

    @RequiresPermissions("quartz:job:detail")
    @GetMapping("/detail/{jobLogId}")
    public String detail(@PathVariable("jobLogId") Long jobLogId, ModelMap modelMap) {
        modelMap.put("name", "jobLog");
        modelMap.put("jobLog", jobLogService.selectJobLogById(jobLogId));
        return "quartz/job/detail" ;
    }

    @Log(title = "调度日志", businessType = BusinessType.CLEAN)
    @RequiresPermissions("quartz:job:remove")
    @PostMapping("/clean")
    @ResponseBody
    public AjaxResult clean() {
        jobLogService.cleanJobLog();
        return success();
    }
}
