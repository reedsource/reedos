package top.reed.common.utils;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Map通用处理方法
 *
 * @author reedsource
 */
public class MapDataUtil {
	public static Map<String, Object> convertDataMap(HttpServletRequest request) {
		Map<String, String[]> properties = request.getParameterMap();
		Map<String, Object> returnMap = new HashMap<>();
		Iterator<?> entries = properties.entrySet().iterator();
		Map.Entry<?, ?> entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Entry<?, ?>) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				value = "";
				for (String s : values) {
					value += s + ",";
				}
				if (value.length() > 0) {
					value = value.substring(0, value.length() - 1);
				}
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		return returnMap;
	}
}
