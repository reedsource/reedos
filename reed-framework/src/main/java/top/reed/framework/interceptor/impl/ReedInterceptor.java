package top.reed.framework.interceptor.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 功能简述:
 * 〈自定义拦截器〉
 *
 * @author reedsource
 * @version 1.0.0
 * reedsource@189.cn
 */
@Component
public class ReedInterceptor implements HandlerInterceptor {
	private static final Logger log = LoggerFactory.getLogger(ReedInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		//获取用户的请求uri
		String url = request.getRequestURI();
		String[] split = url.split("/");
		if (split.length > 0) {
			if (!split[1].equals("js") && !split[1].equals("css")) {
				log.info("请求 {}", url);
			}
		}
		return true;
	}
}
