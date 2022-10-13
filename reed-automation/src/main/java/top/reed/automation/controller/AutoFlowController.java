package top.reed.automation.controller;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import top.reed.api.Grammerable;
import top.reed.api.annotation.Comment;
import top.reed.api.executor.FunctionExecutor;
import top.reed.api.executor.FunctionExtension;
import top.reed.api.executor.PluginConfig;
import top.reed.api.model.Grammer;
import top.reed.api.model.JsonBean;
import top.reed.api.model.Plugin;
import top.reed.api.model.Shape;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.service.AutoFlowService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.exception.ServiceException;
import top.reed.common.utils.CacheUtils;
import top.reed.common.utils.poi.ExcelUtil;
import top.reed.core.utils.ExecutorsUtils;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 自动化任务Controller
 *
 * @author reedsource
 * date 2022-09-29
 */
@Controller
@RequestMapping("/automation/autoflow")
public class AutoFlowController extends BaseController {

	private final AutoFlowService autoFlowService;

	public AutoFlowController(AutoFlowService autoFlowService) {
		this.autoFlowService = autoFlowService;
	}

	private final List<Grammer> grammers = new ArrayList<Grammer>();
	@Autowired
	private List<FunctionExecutor> functionExecutors;
	@Autowired
	private List<FunctionExtension> functionExtensions;
	@Autowired
	private List<Grammerable> grammerables;

	@Autowired(required = false)
	private List<PluginConfig> pluginConfigs;

	@Value("${spider.workspace}")
	private String workspace;

	@RequiresPermissions("automation:autoflow:view")
	@GetMapping()
	public String autoflow() {
		return "automation/autoflow/autoflow";
	}

	/**
	 * @return 自动化任务流程编辑页面
	 */
	@GetMapping("/editor")
	public String editor() {
		return "automation/autoflow/editor";
	}

	/**
	 * @return 全局配置
	 */
	@GetMapping("/root")
	public String flowEditorRoot() {
		return "automation/autoflow/flowEditor/root";
	}

	/**
	 * @return 开始
	 */
	@GetMapping("/start")
	public String flowEditorStart() {
		return "automation/autoflow/flowEditor/start";
	}

	/**
	 * @return 循环
	 */
	@GetMapping("/loop")
	public String flowEditorLoop() {
		return "automation/autoflow/flowEditor/loop";
	}

	/**
	 * @return 执行结束
	 */
	@GetMapping("/forkJoin")
	public String flowEditorForkJoin() {
		return "automation/autoflow/flowEditor/forkJoin";
	}

	/**
	 * @return 注释
	 */
	@GetMapping("/comment")
	public String flowEditorComment() {
		return "automation/autoflow/flowEditor/comment";
	}

	/**
	 * @return 执行sql
	 */
	@GetMapping("/executeSql")
	public String flowEditorExecuteSql() {
		return "automation/autoflow/flowEditor/executeSql";
	}

	/**
	 * @return 执行函数
	 */
	@GetMapping("/function")
	public String flowEditorFunction() {
		return "automation/autoflow/flowEditor/function";
	}

	/**
	 * @return 子流程
	 */
	@GetMapping("/process")
	public String flowEditorProcess() {
		return "automation/autoflow/flowEditor/process";
	}

	/**
	 * 调试窗口
	 *
	 * @return 界面
	 */
	@GetMapping("/request")
	public String flowEditorRequest() {
		return "automation/autoflow/flowEditor/request";
	}

	/**
	 * 调试窗口下一步
	 *
	 * @return 界面
	 */
	@GetMapping("/variable")
	public String flowEditorVariable() {
		return "automation/autoflow/flowEditor/variable";
	}

	/**
	 * 调试窗口下一步输出
	 *
	 * @return 界面
	 */
	@GetMapping("/output")
	public String flowEditorOutput() {
		return "automation/autoflow/flowEditor/output";
	}

	/**
	 * 查询自动化任务列表
	 */
	@RequiresPermissions("automation:autoflow:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(AutoFlow autoFlow) {
		startPage();
		List<AutoFlow> list = autoFlowService.selectAutoFlowList(autoFlow);
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
		List<AutoFlow> list = autoFlowService.selectAutoFlowList(autoFlow);
		ExcelUtil<AutoFlow> util = new ExcelUtil<>(AutoFlow.class);
		return util.exportExcel(list, "自动化任务数据");
	}

	/**
	 * 新增自动化任务
	 */
	@GetMapping("/add")
	public String add(HttpServletRequest request) {
		//在ry_ui.js的editTab打开一个新的选项卡中 将请求id作为了新的选项卡的dataId
		//本处将dataId发送到界面,由static/js/common.js getQueryString()接收
		//由autoflow.js关闭选项卡使用
		String url = request.getRequestURI();
		//转发数据id到editor编辑页面
		return redirect("/automation/autoflow/editor?dataId=" + url);
	}

	/**
	 * 保存修改自动化任务
	 */
	@RequiresPermissions("automation:autoflow:add")
	@Log(title = "自动化任务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(AutoFlow autoFlow) {
		return toAjax(autoFlowService.saveAutoFlow(autoFlow));
	}

	/**
	 * 修改自动化任务进入修改页面
	 */
	@RequiresPermissions("automation:autoflow:edit")
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") String id, HttpServletRequest request) {
		//在ry_ui.js的editTab打开一个新的选项卡中 将请求id作为了新的选项卡的dataId
		//本处将dataId发送到界面,由static/js/common.js getQueryString()接收
		//由autoflow.js关闭选项卡使用
		String url = request.getRequestURI();
		//转发数据id到editor编辑页面
		return redirect("/automation/autoflow/editor?id=" + id + "&dataId=" + url);
	}

	/**
	 * 修改自动化任务状态
	 *
	 * @param autoFlow 自动化任务
	 */
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult edit(AutoFlow autoFlow) {
		if (autoFlowService.updateStatus(autoFlow) != 1) {
			throw new ServiceException("修改自动化任务状态失败！数据异常");
		}
		return success("自动化任务状态修改成功");
	}

	/**
	 * 删除自动化任务
	 */
	@RequiresPermissions("automation:autoflow:remove")
	@Log(title = "自动化任务", businessType = BusinessType.DELETE)
	@PostMapping("/remove")
	@ResponseBody
	public AjaxResult remove(String ids) {
		return toAjax(autoFlowService.deleteAutoFlowByIds(ids));
	}


	/**
	 * 根据id执行一次自动化任务
	 *
	 * @param id 自动化任务id
	 */
	@RequestMapping("/run")
	@ResponseBody
	public AjaxResult run(Long id) {
		autoFlowService.run(id);
		return success();
	}

	@PostConstruct
	private void init() {
		for (FunctionExecutor executor : functionExecutors) {
			String function = executor.getFunctionPrefix();
			grammers.addAll(Grammer.findGrammers(executor.getClass(), function, function, true));
			Comment comment = executor.getClass().getAnnotation(Comment.class);
			Grammer grammer = new Grammer();
			if (comment != null) {
				grammer.setComment(comment.value());
			}
			grammer.setFunction(function);
			grammers.add(grammer);
		}

		for (FunctionExtension extension : functionExtensions) {
			String owner = extension.support().getSimpleName();
			grammers.addAll(Grammer.findGrammers(extension.getClass(), null, owner, true));
		}
		for (Grammerable grammerable : grammerables) {
			grammers.addAll(grammerable.grammers());
		}

		//全部自动化任务名称写入缓存

		List<AutoFlow> list = autoFlowService.selectAutoFlowList(new AutoFlow());
		for (AutoFlow autoFlow : list) {
			CacheUtils.put("auto_job_name", autoFlow.getId().toString(), autoFlow.getName());
		}
	}

	@RequestMapping("/save")
	@ResponseBody
	public String save(AutoFlow autoFlow) {
		return String.valueOf(autoFlowService.saveAutoFlow(autoFlow));
	}

	@RequestMapping("/history")
	@ResponseBody
	public JsonBean<?> history(String id, String timestamp) {
		if (StringUtils.isNotBlank(timestamp)) {
			return new JsonBean<>(autoFlowService.readHistory(id, timestamp));
		} else {
			return new JsonBean<>(autoFlowService.historyList(id));
		}
	}

	@RequestMapping("/other")
	@ResponseBody
	public List<AutoFlow> other(AutoFlow autoFlow) {
		return autoFlowService.selectAutoFlowList(autoFlow);
	}

	@RequestMapping("/remove")
	@ResponseBody
	public void remove(Long id) {
		autoFlowService.deleteAutoFlowById(id);
		//删除缓存
		CacheUtils.remove("auto_job_name", id.toString());
	}

	@RequestMapping("/xml")
	@ResponseBody
	public String xml(String id) {
		return autoFlowService.selectAutoFlowById(Long.valueOf(id)).getXml();
	}

	@RequestMapping("/shapes")
	@ResponseBody
	public List<Shape> shapes() {
		return ExecutorsUtils.shapes();
	}

	@RequestMapping("/pluginConfigs")
	@ResponseBody
	public List<Plugin> pluginConfigs() {
		return null == pluginConfigs ? Collections.emptyList() : pluginConfigs.stream().filter(e -> e.plugin() != null).map(plugin -> plugin.plugin()).collect(Collectors.toList());
	}

	/**
	 * @return 系统内置定义函数
	 */
	@RequestMapping("/grammers")
	@ResponseBody
	public JsonBean<List<Grammer>> grammers() {
		return new JsonBean<>(this.grammers);
	}
}
