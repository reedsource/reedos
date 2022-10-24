package top.reed.framework.shiro.service;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import top.reed.common.constant.Constants;
import top.reed.common.constant.ShiroConstants;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.exception.user.UserPasswordNotMatchException;
import top.reed.common.exception.user.UserPasswordRetryLimitExceedException;
import top.reed.common.utils.MessageUtils;
import top.reed.framework.manager.AsyncManager;
import top.reed.framework.manager.factory.AsyncFactory;

import javax.annotation.PostConstruct;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 登录密码方法
 *
 * @author reedsource
 */
@Component
public class SysPasswordService {
	@Autowired
	private CacheManager cacheManager;

	private Cache<String, AtomicInteger> loginRecordCache;

	@Value(value = "${user.password.maxRetryCount}")
	private String maxRetryCount;

	@PostConstruct
	public void init() {
		loginRecordCache = cacheManager.getCache(ShiroConstants.LOGINRECORDCACHE);
	}

	/**
	 * 验证密码
	 *
	 * @param user     用户
	 * @param password 密码
	 */
	public void validate(SysUser user, String password) {
		String loginName = user.getLoginName();

		//原子递增计数器中判断是否已经有当前用户
		AtomicInteger retryCount = loginRecordCache.get(loginName);

		//加入缓存
		if (retryCount == null) {
			retryCount = new AtomicInteger(0);
			loginRecordCache.put(loginName, retryCount);
		}
		//如果加入缓存后的总登陆用户数量大于设定的最大用户数量
		if (retryCount.incrementAndGet() > Integer.parseInt(maxRetryCount)) {
			//根据消息键和参数 获取消息 委托给spring messageSource
			//记录登录信息
			//异步任务管理器将信息记录
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.LOGIN_FAIL, MessageUtils.message("user.password.retry.limit.exceed", maxRetryCount)));
			//抛出用户错误最大次数异常类异常
			throw new UserPasswordRetryLimitExceedException(Integer.parseInt(maxRetryCount));
		}
		//校验密码
		if (!matches(user, password)) {
			AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.LOGIN_FAIL, MessageUtils.message("user.password.retry.limit.count", retryCount)));
			loginRecordCache.put(loginName, retryCount);
			throw new UserPasswordNotMatchException();
		} else {
			clearLoginRecordCache(loginName);
		}
	}

	/**
	 * 判断密码是否正确
	 *
	 * @param user        用户
	 * @param newPassword 密码
	 */
	public boolean matches(SysUser user, String newPassword) {
		return user.getPassword().equals(encryptPassword(newPassword, user.getSalt()));
	}

	/**
	 * 清除登录记录缓存
	 *
	 * @param loginName 账户名称
	 */
	public void clearLoginRecordCache(String loginName) {
		loginRecordCache.remove(loginName);
	}

	/**
	 * 加密密码
	 * 这里使用 账户id 为有可能的变更用户名称做准备
	 *
	 * @param password  密码
	 * @param salt      盐
	 */
	public String encryptPassword(String password, String salt) {
		return new Md5Hash(password + salt).toHex();
	}
}
