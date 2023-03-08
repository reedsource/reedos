package top.reed.ehcache.service;

import com.alibaba.fastjson.JSON;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.utils.RStringUtils;
import top.reed.ehcache.util.EhCacheUtils;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class EhCacheMonitorService {

	private final String cacheValueKey = "key";
	private final String cacheNameKey = "cachename";
	private final String cacheSizeKey = "size";
	private final String cacheMsSizeKey = "memorystoresize";
	private final String cacheDsSizeKey = "diskstoresize";
	private final String cachesImKey = "sizeinmemory";
	private final String cacheExplainKey = "explain";

	//系统缓存
	public Map<String, Object> sysCacheState() {
		//获得系统缓存对象
		Cache cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.SYS_CACHE);
		Map<String, Object> m = new HashMap<>();
		m.put(cacheNameKey, cache.getName());
		m.put(cacheSizeKey, cache.getSize());
		m.put(cacheMsSizeKey, cache.getMemoryStoreSize());
		m.put(cacheDsSizeKey, cache.getDiskStoreSize());
		m.put(cachesImKey, cache.calculateInMemorySize());
		return m;
	}

	//用户缓存
	public Map<String, Object> userCacheState() {
		//获得用户缓存对象
		Cache cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.USER_CACHE);

		Map<String, Object> m = new HashMap<>();
		m.put(cacheNameKey, cache.getName());
		m.put(cacheSizeKey, cache.getSize());
		m.put(cacheMsSizeKey, cache.getMemoryStoreSize());
		m.put(cacheDsSizeKey, cache.getDiskStoreSize());
		m.put(cachesImKey, cache.calculateInMemorySize());
		return m;
	}

	/**
	 * 获得特定key的系统缓存详情
	 *
	 * @param map
	 * @return
	 */
	public Map<String, String> getSysCacheByKey(Map<String, String> map) {
		//获得系统缓存对象
		Cache cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.SYS_CACHE);
		Map<String, String> m = new HashMap<>();
		Object key = map.get(cacheValueKey);
		if (key == null || "".equals(key.toString())) {
			m.put(cacheExplainKey, "");
		} else {
			m.put(cacheValueKey, key.toString());
			Element element = cache.getQuiet(key.toString());
			if (element != null) {
				m.put(cacheExplainKey, element.toString());
			} else {
				m.put(cacheExplainKey, "");
			}
		}
		return m;
	}

	//获得指定key的缓存信息
	public Map<String, Object> viewCacheInfoByKey(String key) {
		if (RStringUtils.isNotEmpty(key)) {
			Map<String, Object> res = getCacheInfoByKey(key, EhCacheUtils.SYS_CACHE);
			if (res == null) {
				res = getCacheInfoByKey(key, EhCacheUtils.USER_CACHE);
				if (res == null) {
					res = getCacheInfoByKey(key, EhCacheUtils.DEFAULT_CACHE);
				}
			}
			return res;
		}
		return null;
	}

	private Map<String, Object> getCacheInfoByKey(String key, String cacheType) {
		if (RStringUtils.isEmpty(key)) {
			return null;
		}
		Cache cache;
		if (cacheType.equals(EhCacheUtils.SYS_CACHE)) {
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.SYS_CACHE);
		} else if (cacheType.equals(EhCacheUtils.USER_CACHE)) {
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.USER_CACHE);
		} else {
			//return null;
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.DEFAULT_CACHE);
		}
		List<String> keysList = cache.getKeys();
		keysList = keysList.stream().filter(s -> s.contains(key)).collect(Collectors.toList());
		List<Map<String, Object>> mapList = new ArrayList<>();
		Map<String, Object> returnMap = new HashMap<>();
		if (CollectionUtils.isNotEmpty(keysList)) {
			int keysCount = keysList.size();

			for (String s : keysList) {
				Element element = cache.getQuiet(s);

				Map<String, Object> elMap = new HashMap<>();
				elMap.put(cacheValueKey, s);
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar calendar = Calendar.getInstance();
				calendar.setTimeInMillis(element.getCreationTime());
				elMap.put("value", JSON.toJSONString(element.getObjectValue()));
				elMap.put("creattime", formatter.format(calendar.getTime()));
				calendar.setTimeInMillis(element.getLatestOfCreationAndUpdateTime());
				elMap.put("lastupdatetime", formatter.format(calendar.getTime()));
				calendar.setTimeInMillis(element.getLastAccessTime());
				elMap.put("lastaccesstime", formatter.format(calendar.getTime()));
				elMap.put("hittimes", element.getHitCount());

				mapList.add(elMap);
			}
			returnMap.put("total", keysCount);
			returnMap.put("rows", mapList);
			return returnMap;
		} else {
			return null;
		}
	}

	/**
	 * 根据key清除EhCache
	 *
	 * @param key key
	 * @return 通用信息
	 */
	public Object removeCacheByKey(String key) {

		if (RStringUtils.isNotEmpty(key)) {
			Cache cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.SYS_CACHE);
			Element element = cache.getQuiet(key);
			if (element != null) {
				cache.remove(key);
				return AjaxResult.success("清除缓存成功!");
			} else {
				Cache cacheUser = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.USER_CACHE);
				Element elementUser = cacheUser.getQuiet(key);
				if (elementUser != null) {
					cacheUser.remove(key);
					return AjaxResult.success("清除缓存成功!");
				} else {
					Cache cacheDefault = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.DEFAULT_CACHE);
					Element elementDefault = cacheDefault.getQuiet(key);
					if (elementDefault != null) {
						cacheDefault.remove(key);
						return AjaxResult.success("清除缓存成功!");
					} else {
						return AjaxResult.error("不存在key=" + key + "的缓存!");
					}
				}
			}
		} else {
			return AjaxResult.error("请指定要清除的缓存的key!");
		}

	}

	/**
	 * 获得缓存详情 0系统缓存，1用户缓存
	 *
	 * @param map
	 * @return
	 */
	public Object getCacheInfo(Map<String, Object> map) {
		//获得系统缓存对象
		String cachetype = String.valueOf(map.get("cachetype"));
		Cache cache;
		if ("1".equals(cachetype)) {
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.USER_CACHE);
		} else if ("0".equals(cachetype)) {
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.SYS_CACHE);
		} else {
			cache = EhCacheUtils.getCacheManager().getCache(EhCacheUtils.DEFAULT_CACHE);
		}
		String keyContent = String.valueOf(map.get("keyContent"));
		try {
			String pageStr = (String) map.get("pageNum");//当前页
			String limitStr = (String) map.get("pageSize");//每页几条数据
			pageStr = RStringUtils.assertNotNullOrEmpty(pageStr, "1");
			limitStr = RStringUtils.assertNotNullOrEmpty(limitStr, "10");
			int page = Integer.parseInt(pageStr);
			int limit = Integer.parseInt(limitStr);
			int start = page - 1;
			if (page == 1 || page == 0) {
				start = 0;
			}
			List<String> keysList = cache.getKeys();

			int keysCount = keysList.size();
			if (RStringUtils.isNotEmpty(keyContent) && !"null".equals(keyContent)) {
				keysList = keysList.stream().filter(s -> s.contains(keyContent)).collect(Collectors.toList());

				keysCount = keysList.size();
			}
			long serializeLong = 0L;
			for (String s : keysList) {
				Element e = cache.getQuiet(s);
				serializeLong += e.getSerializedSize();
			}
			List<Map<String, Object>> mapList = new ArrayList<>();
			for (int i = start * limit; i < keysCount && i < (start + 1) * limit; i++) {
				Element element = cache.getQuiet(keysList.get(i));

				long l = element.getSerializedSize();
				Map<String, Object> elMap = new HashMap<>();
				elMap.put(cacheValueKey, keysList.get(i));
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar calendar = Calendar.getInstance();
				calendar.setTimeInMillis(element.getCreationTime());
				elMap.put("value", JSON.toJSONString(element.getObjectValue()));
				elMap.put("creattime", formatter.format(calendar.getTime()));
				calendar.setTimeInMillis(element.getLatestOfCreationAndUpdateTime());
				elMap.put("lastupdatetime", formatter.format(calendar.getTime()));
				calendar.setTimeInMillis(element.getLastAccessTime());
				elMap.put("lastaccesstime", formatter.format(calendar.getTime()));
				elMap.put("hittimes", element.getHitCount());
				if (serializeLong == 0L) {
					elMap.put(cacheSizeKey, "0");
					elMap.put("proprotion", "0%");
				} else {
					double d = l * 100.0D / serializeLong;
					elMap.put(cacheSizeKey, new DecimalFormat("####,###").format(l));
					elMap.put("proprotion", new DecimalFormat("####.00").format(d) + "%");
				}
				mapList.add(elMap);
			}

			TableDataInfo tableDataInfo = new TableDataInfo();
			tableDataInfo.setTotal(keysList.size());
			tableDataInfo.setRows(mapList);
			tableDataInfo.setCode(0);
			tableDataInfo.setMsg("0");

			return tableDataInfo;
		} catch (Exception e) {
			return AjaxResult.error("获得系统缓存详情失败！");
		}
	}
}
