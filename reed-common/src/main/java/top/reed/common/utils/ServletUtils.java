package top.reed.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import top.reed.common.core.text.Convert;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * 客户端工具类
 *
 * @author reedsource
 */
public enum ServletUtils {
    ;

    public static final String WINDOWS_NT = "Windows NT" ;
    private static final Logger log = LoggerFactory.getLogger(ServletUtils.class);
    /**
     * 定义移动端请求的所有可能类型
     */
    private static final String[] agent = {"Android", "iPhone", "iPod", "iPad", "Windows Phone", "MQQBrowser"};

    /**
     * 获取String参数
     */
    public static String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    /**
     * 获取Boolean参数
     */
    public static Boolean getParameterToBool(String name) {
        return Convert.toBool(getRequest().getParameter(name));
    }

    /**
     * 获取request
     */
    public static HttpServletRequest getRequest() {
        return getRequestAttributes().getRequest();
    }

    /**
     * 获取response
     */
    public static HttpServletResponse getResponse() {
        return getRequestAttributes().getResponse();
    }

    /**
     * 获取session
     */
    public static HttpSession getSession() {
        return getRequest().getSession();
    }

    public static ServletRequestAttributes getRequestAttributes() {
        return (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
    }

    /**
     * 将字符串渲染到客户端
     *
     * @param response 渲染对象
     * @param string   待渲染的字符串
     * @return null
     */
    public static String renderString(HttpServletResponse response, String string) {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().print(string);
        } catch (IOException e) {
            log.error("将字符串渲染到客户端", e);
        }
        return null;
    }

    /**
     * 是否是Ajax异步请求
     *
     * @param request request
     */
    public static boolean isAjaxRequest(HttpServletRequest request) {
        String accept = request.getHeader("accept");
        if (accept != null && accept.contains("application/json")) {
            return true;
        }

        String xRequestedWith = request.getHeader("X-Requested-With");
        if (xRequestedWith != null && xRequestedWith.contains("XMLHttpRequest")) {
            return true;
        }

        String uri = request.getRequestURI();
        if (RStringUtils.inStringIgnoreCase(uri, ".json", ".xml")) {
            return true;
        }

        String ajax = request.getParameter("__ajax");
        return RStringUtils.inStringIgnoreCase(ajax, "json", "xml");
    }

    /**
     * 判断User-Agent 是不是来自于手机
     */
    public static boolean checkAgentIsMobile(String ua) {
        boolean flag = false;
        // 排除 苹果桌面系统
        if ((!ua.contains(WINDOWS_NT) || (ua.contains(WINDOWS_NT) && ua.contains("compatible; MSIE 9.0;"))) && (!ua.contains(WINDOWS_NT) && !ua.contains("Macintosh"))) {
            for (String item : agent) {
                if (ua.contains(item)) {
                    flag = true;
                    break;
                }
            }
        }
        return flag;
    }

    /**
     * 返回包含此请求中包含的参数名称的String对象的Enumeration
     *
     * @param req 请求对象
     * @return 请求对象集
     */
    public static Map<String, String> getMap(HttpServletRequest req) {
        Map<String, String> map = new HashMap<>();
        Enumeration<String> enu = req.getParameterNames();
        while (enu.hasMoreElements()) {
            String paramName = enu.nextElement();
            String[] paramValues = req.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    map.put(paramName, paramValue);
                }
            }
        }
        return map;
    }
}
