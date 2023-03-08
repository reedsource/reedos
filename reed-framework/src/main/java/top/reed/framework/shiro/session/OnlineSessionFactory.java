package top.reed.framework.shiro.session;


import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.SessionContext;
import org.apache.shiro.session.mgt.SessionFactory;
import org.apache.shiro.web.session.mgt.WebSessionContext;
import org.springframework.stereotype.Component;
import top.reed.common.utils.IpUtils;
import top.reed.common.utils.http.UserAgent;

import javax.servlet.http.HttpServletRequest;

/**
 * 自定义sessionFactory会话
 *
 * @author reedsource
 */
@Component
public class OnlineSessionFactory implements SessionFactory {
	@Override
	public Session createSession(SessionContext initData) {
		OnlineSession session = new OnlineSession();
		if (initData instanceof WebSessionContext) {
			WebSessionContext sessionContext = (WebSessionContext) initData;
			HttpServletRequest request = (HttpServletRequest) sessionContext.getServletRequest();
			if (request != null) {
				//获取用户User-Agent并解析为userAgent对象
				UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
				// 获取客户端操作系统
				String os = userAgent.getOperatingSystem();
				// 获取客户端浏览器
				String browser = userAgent.getBrowser();
				session.setHost(IpUtils.getIpAddr(request));
				session.setBrowser(browser);
				session.setOs(os);
			}
		}
		return session;
	}
}
