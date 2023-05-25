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
    /**
     * @param request request
     * @return 转换数据映射
     */
    public static Map<String, Object> convertDataMap(HttpServletRequest request) {
        Map<String, String[]> properties = request.getParameterMap();
        Map<String, Object> returnMap = new HashMap<>();
        Iterator<?> entries = properties.entrySet().iterator();
        Map.Entry<?, ?> entry;
        String name;
        StringBuilder value;
        while (entries.hasNext()) {
            entry = (Entry<?, ?>) entries.next();
            name = (String) entry.getKey();
            Object valueObj = entry.getValue();
            if (null == valueObj) {
                value = new StringBuilder();
            } else if (valueObj instanceof String[] values) {
                value = new StringBuilder();
                for (String s : values) {
                    value.append(s).append(",");
                }
                if (value.length() > 0) {
                    value = new StringBuilder(value.substring(0, value.length() - 1));
                }
            } else {
                value = new StringBuilder(valueObj.toString());
            }
            returnMap.put(name, value.toString());
        }
        return returnMap;
    }
}
