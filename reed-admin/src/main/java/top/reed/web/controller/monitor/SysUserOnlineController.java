package top.reed.web.controller.monitor;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.core.text.Convert;
import top.reed.common.enums.BusinessType;
import top.reed.common.enums.OnlineStatus;
import top.reed.common.utils.ShiroUtils;
import top.reed.framework.shiro.session.OnlineSession;
import top.reed.framework.shiro.session.OnlineSessionDAO;
import top.reed.system.domain.SysUserOnline;
import top.reed.system.service.ISysUserOnlineService;

import java.util.List;

/**
 * 在线用户监控
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/monitor/online" )
public class SysUserOnlineController extends BaseController {
	private String prefix = "monitor/online" ;

	@Autowired
	private ISysUserOnlineService userOnlineService;

	@Autowired
	private OnlineSessionDAO onlineSessionDAO;

	@RequiresPermissions("monitor:online:view" )
	@GetMapping()
	public String online() {
		return prefix + "/online" ;
	}

	@RequiresPermissions("monitor:online:list" )
	@PostMapping("/list" )
	@ResponseBody
	public TableDataInfo list(SysUserOnline userOnline) {
		startPage();
		List<SysUserOnline> list = userOnlineService.selectUserOnlineList(userOnline);
		return getDataTable(list);
	}

	@RequiresPermissions(value = {"monitor:online:batchForceLogout" , "monitor:online:forceLogout"}, logical = Logical.OR)
	@Log(title = "在线用户" , businessType = BusinessType.FORCE)
	@PostMapping("/batchForceLogout" )
	@ResponseBody
	public AjaxResult batchForceLogout(String ids) {
		for (String sessionId : Convert.toStrArray(ids)) {
			SysUserOnline online = userOnlineService.selectOnlineById(sessionId);
			if (online == null) {
				return error("用户已下线" );
			}
			OnlineSession onlineSession = (OnlineSession) onlineSessionDAO.readSession(online.getSessionId());
			if (onlineSession == null) {
				return error("用户已下线" );
			}
			if (sessionId.equals(ShiroUtils.getSessionId())) {
				return error("当前登录用户无法强退" );
			}
			onlineSessionDAO.delete(onlineSession);
			online.setStatus(OnlineStatus.off_line);
			userOnlineService.saveOnline(online);
			userOnlineService.removeUserCache(online.getLoginName(), sessionId);
		}
		return success();
	}
}
