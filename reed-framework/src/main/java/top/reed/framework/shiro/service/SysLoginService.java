package top.reed.framework.shiro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.common.constant.Constants;
import top.reed.common.constant.ShiroConstants;
import top.reed.common.constant.UserConstants;
import top.reed.common.core.domain.entity.SysRole;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.enums.UserStatus;
import top.reed.common.exception.user.*;
import top.reed.common.utils.*;
import top.reed.framework.manager.AsyncManager;
import top.reed.framework.manager.factory.AsyncFactory;
import top.reed.system.service.ISysMenuService;
import top.reed.system.service.ISysUserService;

import java.util.List;
import java.util.Set;

/**
 * 登录校验方法
 *
 * @author reedsource
 */
@Component
public class SysLoginService {
	@Autowired
	private SysPasswordService passwordService;

	@Autowired
	private ISysUserService userService;

	@Autowired
	private ISysMenuService menuService;

	/**
	 * 登录
	 */
	public SysUser login(String username, String password) {
		// 验证码校验
		if (ShiroConstants.CAPTCHA_ERROR.equals(ServletUtils.getRequest().getAttribute(ShiroConstants.CURRENT_CAPTCHA))) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error" )));
			throw new CaptchaException();
		}
		// 用户名或密码为空 错误
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("not.null" )));
			throw new UserNotExistsException();
		}
		// 密码如果不在指定范围内 错误
		if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
				|| password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match" )));
			throw new UserPasswordNotMatchException();
		}

		// 用户名不在指定范围内 错误
		if (username.length() < UserConstants.USERNAME_MIN_LENGTH
				|| username.length() > UserConstants.USERNAME_MAX_LENGTH) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match" )));
			throw new UserPasswordNotMatchException();
		}

		// 查询用户信息
		SysUser user = userService.selectUserByLoginName(username);

		/**
		 if (user == null && maybeMobilePhoneNumber(username))
		 {
		 user = userService.selectUserByPhoneNumber(username);
		 }

		 if (user == null && maybeEmail(username))
		 {
		 user = userService.selectUserByEmail(username);
		 }
		 */

		if (user == null) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.not.exists" )));
			throw new UserNotExistsException();
		}

		if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.delete" )));
			throw new UserDeleteException();
		}

		if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.blocked" , user.getRemark())));
			throw new UserBlockedException();
		}

		passwordService.validate(user, password);

		AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success" )));
		setRolePermission(user);
		recordLoginInfo(user.getUserId());
		return user;
	}

	/**
	 private boolean maybeEmail(String username)
	 {
	 if (!username.matches(UserConstants.EMAIL_PATTERN))
	 {
	 return false;
	 }
	 return true;
	 }

	 private boolean maybeMobilePhoneNumber(String username)
	 {
	 if (!username.matches(UserConstants.MOBILE_PHONE_NUMBER_PATTERN))
	 {
	 return false;
	 }
	 return true;
	 }
	 */

	/**
	 * 设置角色权限
	 *
	 * @param user 用户信息
	 */
	public void setRolePermission(SysUser user) {
		List<SysRole> roles = user.getRoles();
		if (!roles.isEmpty() && roles.size() > 1) {
			// 多角色设置permissions属性，以便数据权限匹配权限
			for (SysRole role : roles) {
				Set<String> rolePerms = menuService.selectPermsByRoleId(role.getRoleId());
				role.setPermissions(rolePerms);
			}
		}
	}

	/**
	 * 记录登录信息
	 *
	 * @param userId 用户ID
	 */
	public void recordLoginInfo(Long userId) {
		SysUser user = new SysUser();
		user.setUserId(userId);
		user.setLoginIp(ShiroUtils.getIp());
		user.setLoginDate(DateUtils.getNowDate());
		userService.updateUserInfo(user);
	}
}
