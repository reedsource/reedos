package top.reed.web.controller.system;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.ServletUtils;
import top.reed.common.utils.ShiroUtils;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.security.RsaUtils;
import top.reed.framework.web.service.ConfigService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录验证
 *
 * @author reedsource
 */
@Controller
public class SysLoginController extends BaseController {
	/**
	 * 是否开启记住我功能
	 */
	@Value("${shiro.rememberMe.enabled: false}")
	private boolean rememberMe;

	@Autowired
	private ConfigService configService;

	@GetMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, ModelMap mmap) {
		// 如果是Ajax请求，返回Json字符串。
		if (ServletUtils.isAjaxRequest(request)) {
			return ServletUtils.renderString(response, "{\"code\":\"1\",\"msg\":\"未登录或登录超时。请重新登录\"}");
		}
		// 是否开启记住我
		mmap.put("isRemembered", rememberMe);
		// 是否开启用户注册
		mmap.put("isAllowRegister", Convert.toBool(configService.getKey("sys.account.registerUser"), false));
		//当前用户是否已经登录时 直接跳转到登录页
		//如果此主题/用户在当前会话期间通过提供与系统已知凭据匹配的有效凭据来证明其身份，则返回true，否则返回false。
		//请注意，即使通过“记住我”服务记住了此主题的身份，此方法仍将返回false，除非用户在当前会话期间实际使用正确的凭据登录
		if(ShiroUtils.getSubject().isAuthenticated()){
			return redirect("/index");
		}

		//当用户登录时勾选记住我时,直接跳转到首页,实际上没有经过身份验证
		//但是，如果尝试做一些敏感的事情 需要在功能的入口增加isAuthenticated判断,确定只有身份验证的情况下,才可以操作
		if(ShiroUtils.getSubject().isRemembered()){
			return redirect("/index");
		}

		return "login";
	}

	@PostMapping("/login")
	@ResponseBody
	public AjaxResult ajaxLogin(String username, String password, Boolean rememberMe) {
		try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, RsaUtils.decryptByPrivateKey(password), rememberMe);
			Subject subject = SecurityUtils.getSubject();
			subject.login(token);
			return success();
		} catch (Exception e) {
			String msg = "用户或密码错误";
			if (StringUtils.isNotEmpty(e.getMessage())) {
				msg = e.getMessage();
			}
			return error(msg);
		}
	}

	@GetMapping("/unauth")
	public String unauth() {
		return "error/unauth";
	}
}
