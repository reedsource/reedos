package top.reed.web.controller.monitor;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import top.reed.common.core.controller.BaseController;
import top.reed.framework.web.domain.Server;

/**
 * 服务器监控
 * 服务器当前信息数据
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/monitor/server")
public class ServerController extends BaseController {

    @RequiresPermissions("monitor:server:view")
    @GetMapping()
    public String server(ModelMap mmap) throws Exception {
        Server server = new Server();
        server.copyTo();
        mmap.put("server", server);
        return "monitor/server/server";
    }
}
