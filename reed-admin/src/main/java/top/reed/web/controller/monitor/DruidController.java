package top.reed.web.controller.monitor;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import top.reed.common.core.controller.BaseController;

/**
 * druid 监控
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/monitor/data")
public class DruidController extends BaseController {

	@RequiresPermissions("monitor:data:view")
	@GetMapping()
	public String index() {
		return redirect("/druid/index.html");
	}
}
