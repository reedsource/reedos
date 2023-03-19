package top.reed.common.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.utils.bean.BeanUtils;

/**
 * shiro 工具类
 *
 * @author reedsource
 */
public class ShiroUtils {
    public static Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    public static Session getSession() {
        return SecurityUtils.getSubject().getSession();
    }

    /**
     * 注销当前登录用户
     */
    public static void logout() {
        getSubject().logout();
    }

    /**
     * @return 获取当前登录用户
     */
    public static SysUser getSysUser() {
        SysUser user = null;
        Object obj = getSubject().getPrincipal();
        if (StringUtils.isNotNull(obj)) {
            user = new SysUser();
            BeanUtils.copyBeanProp(user, obj);
        }
        return user;
    }

    /**
     * 将当前用户添加到缓存中
     *
     * @param user 当前用户
     */
    public static void setSysUser(SysUser user) {
        Subject subject = getSubject();
        PrincipalCollection principalCollection = subject.getPrincipals();
        String realmName = principalCollection.getRealmNames().iterator().next();
        PrincipalCollection newPrincipalCollection = new SimplePrincipalCollection(user, realmName);
        // 重新加载Principal
        subject.runAs(newPrincipalCollection);
    }

    public static Long getUserId() {
        return getSysUser().getUserId();
    }

    public static String getLoginName() {
        return getSysUser().getLoginName();
    }

    public static String getIp() {
        return StringUtils.substring(getSubject().getSession().getHost(), 0, 128);
    }

    public static String getSessionId() {
        return String.valueOf(getSubject().getSession().getId());
    }

    /**
     * 生成随机盐
     */
    public static String randomSalt() {
        //安全随机数生成器
        SecureRandomNumberGenerator secureRandom = new SecureRandomNumberGenerator();
        // 一个Byte占两个字节，此处生成的3字节，字符串长度为6
        return secureRandom.nextBytes(3).toHex();
    }
}
