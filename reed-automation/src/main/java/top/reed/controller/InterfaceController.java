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
	 * @return 开始
	 */
	@GetMapping("/flowEditor/start")
	public String flowEditorStart() {
		return "resources/flowEditor/start";
	}

	/**
	 * @return 循环
	 */
	@GetMapping("/flowEditor/loop")
	public String flowEditorLoop() {
		return "resources/flowEditor/loop";
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
