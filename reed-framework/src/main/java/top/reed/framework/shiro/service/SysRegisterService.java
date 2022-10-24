package top.reed.framework.shiro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.common.constant.Constants;
import top.reed.common.constant.ShiroConstants;
import top.reed.common.constant.UserConstants;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.utils.*;
import top.reed.framework.manager.AsyncManager;
import top.reed.framework.manager.factory.AsyncFactory;
import top.reed.system.service.ISysUserService;

/**
 * 注册校验方法
 *
 * @author reedsource
 */
@Component
public class SysRegisterService {
	@Autowired
	private ISysUserService userService;

	@Autowired
	private SysPasswordService passwordService;

	/**
	 * 注册
	 */
	public String register(SysUser user) {
		String msg = "", loginName = user.getLoginName(), password = user.getPassword();

		if (ShiroConstants.CAPTCHA_ERROR.equals(ServletUtils.getRequest().getAttribute(ShiroConstants.CURRENT_CAPTCHA))) {
			msg = "验证码错误";
		} else if (StringUtils.isEmpty(loginName)) {
			msg = "用户名不能为空";
		} else if (StringUtils.isEmpty(password)) {
			msg = "用户密码不能为空";
		} else if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
				|| password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
			msg = "密码长度必须在5到20个字符之间";
		} else if (loginName.length() < UserConstants.USERNAME_MIN_LENGTH
				|| loginName.length() > UserConstants.USERNAME_MAX_LENGTH) {
			msg = "账户长度必须在2到20个字符之间";
		} else if (UserConstants.USER_NAME_NOT_UNIQUE.equals(userService.checkLoginNameUnique(user))) {
			msg = "保存用户'" + loginName + "'失败，注册账号已存在";
		} else {
			user.setPwdUpdateDate(DateUtils.getNowDate());
			user.setUserName(loginName);
			user.setSalt(ShiroUtils.randomSalt());
			user.setPassword(passwordService.encryptPassword(password, user.getSalt()));
			//注册用户信息
			boolean regFlag = userService.registerUser(user);
			if (!regFlag) {
				msg = "注册失败,请联系系统管理人员";
			} else {
				AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.REGISTER, MessageUtils.message("user.register.success")));
			}
		}
		return msg;
	}
}
