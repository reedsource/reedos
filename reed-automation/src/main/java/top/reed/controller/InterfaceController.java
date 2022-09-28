package top.reed.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 自动化部分统一界面跳转Controller
 */
@Controller
@RequestMapping("/")
public class InterfaceController {

	/**
	 * @return 主页
	 */
	@GetMapping("/aindex")
	public String aindex() {
		return "aindex";
	}

	/**
	 * @return 自动化任务列表
	 */
	@GetMapping("/spiderList")
	public String spiderList() {
		return "spiderList";
	}

	/**
	 * @return 自定义函数列表
	 */
	@GetMapping("/functions")
	public String functions() {
		return "functions";
	}

	/**
	 * @return 数据源列表
	 */
	@GetMapping("/datasources")
	public String datasources() {
		return "datasources";
	}

	/**
	 * @param id id
	 * @return 数据源添加更新修改
	 */
	@GetMapping("/datasource-edit")
	public String datasourceedit(String id) {
		return "datasource-edit";
	}


	/**
	 * @param id id
	 * @return 函数添加更新修改
	 */
	@GetMapping("/function-edit")
	public String functionedit(String id) {
		return "function-edit";
	}

	/**
	 * @return 自动化任务流程编辑页面
	 */
	@GetMapping("/editor")
	public String editor() {
		return "editor";
	}

	/**
	 * @return 全局配置
	 */
	@GetMapping("/flowEditor/root")
	public String flowEditorRoot() {
		return "resources/flowEditor/root";
	}

	/**
	 * 调试窗口
	 *
	 * @return 界面
	 */
	@GetMapping("/flowEditor/request")
	public String flowEditorRequest() {
		return "resources/flowEditor/request";
	}

	/**
	 * 调试窗口下一步
	 *
	 * @return 界面
	 */
	@GetMapping("/flowEditor/variable")
	public String flowEditorVariable() {
		return "resources/flowEditor/variable";
	}

	/**
	 * 调试窗口下一步输出
	 *
	 * @return 界面
	 */
	@GetMapping("/flowEditor/output")
	public String flowEditorOutput() {
		return "resources/flowEditor/output";
	}

}
