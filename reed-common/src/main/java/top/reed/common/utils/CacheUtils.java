package top.reed.common.utils;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import top.reed.common.utils.spring.SpringUtils;

import java.util.Set;

/**
 * Cache工具类
 *
 * @author reedsource
 */
public class CacheUtils {
	private static final String SYS_CACHE = "sys-cache";
	private static Logger logger = LoggerFactory.getLogger(CacheUtils.class);
	private static CacheManager cacheManager = SpringUtils.getBean(CacheManager.class);

	/**
	 * 获取SYS_CACHE缓存
	 *
	 * @param key 缓存组下的具体key名称
	 * @return
	 */
	public static Object get(String key) {
		return get(SYS_CACHE, key);
	}

	/**
	 * 获取SYS_CACHE缓存
	 *
	 * @param key 缓存组下的具体key名称
	 * @param defaultValue 如空默认值
	 * @return
	 */
	public static Object get(String key, Object defaultValue) {
		Object value = get(key);
		return value != null ? value : defaultValue;
	}

	/**
	 * 写入SYS_CACHE缓存
	 *
	 * @param key 缓存组下的具体key名称
	 * @return
	 */
	public static void put(String key, Object value) {
		put(SYS_CACHE, key, value);
	}

	/**
	 * 从SYS_CACHE缓存中移除
	 *
	 * @param key 缓存组下的具体key名称
	 * @return
	 */
	public static void remove(String key) {
		remove(SYS_CACHE, key);
	}

	/**
	 * 获取缓存
	 *
	 * @param cacheName 缓存组名称
	 * @param key 缓存组下的具体key名称
	 * @return
	 */
	public static Object get(String cacheName, String key) {
		return getCache(cacheName).get(key);
	}

	/**
	 * 获取缓存
	 *
	 * @param cacheName 缓存组名称
	 * @param key 缓存组下的具体key名称
	 * @param defaultValue 如空默认值
	 * @return
	 */
	public static Object get(String cacheName, String key, Object defaultValue) {
		Object value = get(cacheName, key);
		return value != null ? value : defaultValue;
	}

	/**
	 * 写入缓存
	 *
	 * @param cacheName 缓存组名称
	 * @param key 缓存组下的具体key名称
	 * @param value
	 */
	public static void put(String cacheName, String key, Object value) {
		getCache(cacheName).put(key, value);
	}

	/**
	 * 从缓存中移除
	 *
	 * @param cacheName 缓存组名称
	 * @param key 缓存组下的具体key名称
	 */
	public static void remove(String cacheName, String key) {
		getCache(cacheName).remove(key);
	}

	/**
	 * 从缓存中移除所有
	 *
	 * @param cacheName 缓存组名称
	 */
	public static void removeAll(String cacheName) {
		Cache<String, Object> cache = getCache(cacheName);
		Set<String> keys = cache.keys();
		for (String key : keys) {
			cache.remove(key);
		}
		logger.info("清理缓存： {} => {}", cacheName, keys);
	}

	/**
	 * 从缓存中移除指定key
	 *
	 * @param keys 缓存组下的具体key名称set
	 */
	public static void removeByKeys(Set<String> keys) {
		removeByKeys(SYS_CACHE, keys);
	}

	/**
	 * 从缓存中移除指定key
	 *
	 * @param cacheName 缓存组名称
	 * @param keys 缓存组下的具体key名称set
	 */
	public static void removeByKeys(String cacheName, Set<String> keys) {
		for (String key : keys) {
			remove(key);
		}
		logger.info("清理缓存： {} => {}", cacheName, keys);
	}

	/**
	 * 获得一个Cache，没有则显示日志。
	 *
	 * @param cacheName 缓存组名称
	 * @return
	 */
	public static Cache<String, Object> getCache(String cacheName) {
		Cache<String, Object> cache = cacheManager.getCache(cacheName);
		if (cache == null) {
			throw new RuntimeException("当前系统中没有定义“" + cacheName + "”这个缓存。");
		}
		return cache;
	}

	/**
	 * 获取所有缓存
	 *
	 * @return 缓存组
	 */
	public static String[] getCacheNames() {
		return ((EhCacheManager) cacheManager).getCacheManager().getCacheNames();
	}
}
