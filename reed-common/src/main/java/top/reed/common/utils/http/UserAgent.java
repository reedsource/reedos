package top.reed.common.utils.http;

import com.blueconic.browscap.Capabilities;
import com.blueconic.browscap.UserAgentParser;
import com.blueconic.browscap.UserAgentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 功能简述:
 * 〈browscap-java解析客户端操作系统、浏览器等 实现〉
 *
 * @author reedsource
 * reedsource@189.cn
 */
public class UserAgent {
	private static final Logger log = LoggerFactory.getLogger(UserAgent.class);

	/**
	 * 浏览器
	 */
	public String browser = "";

	/**
	 * 操作系统
	 */
	public String operatingSystem = "";

	/**
	 * 解析器
	 */
	private static UserAgentParser parser = null;

	static {
		try {
			//静态化加载分析器
			parser = new UserAgentService().loadParser();
		} catch (Exception e) {
			log.error("获取用户代理异常", e);
		}
	}

	/**
	 * Agent标头值解析解析处理
	 *
	 * @param userAgentString Agent标头值
	 */
	public UserAgent(String userAgentString) {
		if (parser != null) {
			//使用默认区域设置的规则将此字符串中的所有字符转换为小写
			String userAgentLowercaseString = userAgentString == null ? null : userAgentString.toLowerCase();
			//将User Agent标头值解析为Capabilities对象
			Capabilities capabilities = parser.parse(userAgentLowercaseString);
			//浏览器信息拼装   返回浏览器值(例如 e.g. Chrome)  返回浏览器的主要版本
			this.browser = String.format("%s %s", capabilities.getBrowser(), capabilities.getBrowserMajorVersion());
			//平台名称
			this.operatingSystem = capabilities.getPlatform();
		}
	}

	/**
	 * @param userAgentString 用户代理字符串
	 * @return 用户代理信息
	 */
	public static UserAgent parseUserAgentString(String userAgentString) {
		return new UserAgent(userAgentString);
	}

	/**
	 * @return 获取客户端浏览器
	 */
	public String getBrowser() {
		return browser;
	}

	/**
	 * @return 获取操作系统
	 */
	public String getOperatingSystem() {
		return operatingSystem;
	}
}
