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

import java.util.List;

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
        } else if (userService.checkLoginNameUnique(user)) {
            msg = "保存用户'" + loginName + "'失败，注册账号已存在";
        } else {
            //密码最后更新时间
            user.setPwdUpdateDate(DateUtils.getNowDate());
            //设置用户名称为登录名称
            user.setUserName(loginName);
            //设置密码随机盐
            user.setSalt(ShiroUtils.randomSalt());
            //设置加盐加密后的密码
            user.setPassword(passwordService.encryptPassword(password, user.getSalt()));
            //注册用户信息
            boolean regFlag = userService.registerUser(user);
            if (!regFlag) {
                msg = "注册失败,请联系系统管理人员";
            } else {
                // 执行任务 记录日志
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.REGISTER, MessageUtils.message("user.register.success")));

                //获取刚添加的用户
                List<SysUser> list = userService.selectUserList(user);
                user = list.get(0);
                //设置用户默认部门 市场部 默认用户
                user.setDeptId(122L);
                //设置用户默认角色组 注册默认角色
                user.setRoleIds(new Long[]{4L});
                //设置用户默认岗位组 默认用户
                user.setPostIds(new Long[]{3L});
                //更新用户
                userService.updateUser(user);
            }
        }
        return msg;
    }
}
