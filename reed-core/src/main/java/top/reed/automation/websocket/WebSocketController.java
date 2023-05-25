package top.reed.automation.websocket;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.reed.common.annotation.Log;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.enums.BusinessType;
import top.reed.framework.websocket.server.WebSocketServer;
import top.reed.framework.websocket.util.WebSocketUsers;

/**
 * WebSocket服务说明
 * 2023年05月14日 添加固定的cipherKey密钥 之后
 * 用户登录产生的cookie密钥是固定的,当遇到服务器重启之类的情况时
 * 重新点击左上角图标进入首页,会自动断线重连
 */
@Controller
@RequestMapping("/automation")
public class WebSocketController {

    private static final Logger log = LoggerFactory.getLogger(WebSocketController.class);

    @Autowired
    private WebSocketServer websocketServer;

    @RequiresPermissions("automation:websocket:view")
    @GetMapping("/notice")
    public String notice(Model model) {
        model.addAttribute("online", websocketServer.getOnlineUserCount());
        return "/websocket/notification";
    }

    /**
     * 发送消息通知
     */
    @RequiresPermissions("automation:websocket:view")
    @PostMapping("/notice")
    @Log(title = "通过websocket向前台用户发送通知", businessType = BusinessType.OTHER)
    @ResponseBody
    public AjaxResult notice(String msg) {
        log.info("发送全局用户socket消息 {}", msg);
        WebSocketUsers.sendMessageToUsersByText(msg);
        return AjaxResult.success("消息发送成功");
    }
}
