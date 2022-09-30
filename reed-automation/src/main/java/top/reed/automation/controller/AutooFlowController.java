package top.reed.automation.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.service.AutooFlowService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 自动化任务Controller
 *
 * @author reedsource
 * date 2022-09-29
 */
@Controller
@RequestMapping("/automation/autoflow")
public class AutooFlowController extends BaseController {

	private final AutooFlowService autooFlowService;

	public AutooFlowController(AutooFlowService autooFlowService) {
		this.autooFlowService = autooFlowService;
	}

	@RequiresPermissions("automation:autoflow:view")
	@GetMapping()
	public String autoflow() {
		return "automation/autoflow/autoflow";
	}

	/**
	 * 查询自动化任务列表
	 */
	@RequiresPermissions("automation:autoflow:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(AutoFlow autoFlow) {
		startPage();
		List<AutoFlow> list = autooFlowService.selectAutoFlowList(autoFlow);
		return getDataTable(list);
	}

	/**
	 * 导出自动化任务列表
	 */
	@RequiresPermissions("automation:autoflow:export")
	@Log(title = "自动化任务", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	@ResponseBody
	public AjaxResult export(AutoFlow autoFlow) {
		List<AutoFlow> list = autooFlowService.selectAutoFlowList(autoFlow);
		ExcelUtil<AutoFlow> util = new ExcelUtil<>(AutoFlow.class);
		return util.exportExcel(list, "自动化任务数据");
	}

	/**
	 * 新增自动化任务
	 */
	@GetMapping("/add")
	public String add() {
		return "automation/autoflow/editor";
	}

	/**
	 * 新增保存自动化任务
	 */
	@RequiresPermissions("automation:autoflow:add")
	@Log(title = "自动化任务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(AutoFlow autoFlow) {
		return toAjax(autooFlowService.insertAutoFlow(autoFlow));
	}

	/**
	 * 修改自动化任务
	 */
	@RequiresPermissions("automation:autoflow:edit")
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") String id, HttpServletRequest request) {
        //在ry_ui.js的editTab打开一个新的选项卡中 将请求id作为了新的选项卡的dataId
		//本处将dataId发送到界面,由static/js/common.js getQueryString()接收
		//由autoflow.js关闭选项卡使用
		String url = request.getRequestURI();
		//转发数据id到editor编辑页面
		return redirect("/editor?id=" + id + "&dataId=" + url);
	}

	/**
	 * 修改保存自动化任务
	 */
	@RequiresPermissions("automation:autoflow:edit")
	@Log(title = "自动化任务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(AutoFlow autoFlow) {
		return toAjax(autooFlowService.updateAutoFlow(autoFlow));
	}

	/**
	 * 删除自动化任务
	 */
	@RequiresPermissions("automation:autoflow:remove")
	@Log(title = "自动化任务", businessType = BusinessType.DELETE)
	@PostMapping("/remove")
	@ResponseBody
	public AjaxResult remove(String ids) {
		return toAjax(autooFlowService.deleteAutoFlowByIds(ids));
	}


	/**
	 * 根据id执行一次自动化任务
	 *
	 * @param id 自动化任务id
	 */
	@RequestMapping("/run")
	@ResponseBody
	public AjaxResult run(Long id) {
		autooFlowService.run(id);
		return success();
	}


}
