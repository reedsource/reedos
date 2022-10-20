package top.reed.framework.websocket.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.websocket.Session;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * websocket 客户端用户集
 *
 * @author reedsource
 */
public class WebSocketUsers {
	/**
	 * WebSocketUsers 日志控制器
	 */
	private static final Logger LOGGER = LoggerFactory.getLogger(WebSocketUsers.class);

	/**
	 * 用户集
	 */
	private static final Map<String, Session> USERS = new ConcurrentHashMap<>();

	/**
	 * 存储用户
	 *
	 * @param key     唯一键
	 * @param session 用户信息
	 */
	public static void put(String key, Session session) {
		USERS.put(key, session);

	}

	/**
	 * 移除用户
	 *
	 * @param session 用户信息
	 * @return 移除结果
	 */
	public static boolean remove(Session session) {
		String key = null;
		boolean flag = USERS.containsValue(session);
		if (flag) {
			Set<Map.Entry<String, Session>> entries = USERS.entrySet();
			for (Map.Entry<String, Session> entry : entries) {
				Session value = entry.getValue();
				if (value.equals(session)) {
					key = entry.getKey();
					break;
				}
			}
		} else {
			return true;
		}
		return remove(key);
	}

	/**
	 * 移出用户
	 *
	 * @param key 键
	 */
	public static boolean remove(String key) {
		LOGGER.info("\n 正在移出用户 - {}", key);
		Session remove = USERS.remove(key);
		if (remove != null) {
			boolean containsValue = USERS.containsValue(remove);
			LOGGER.info("\n 移出结果 - {}", containsValue ? "失败" : "成功");
			return containsValue;
		} else {
			return true;
		}
	}

	/**
	 * 获取在线用户列表
	 *
	 * @return 返回用户集合
	 */
	public static Map<String, Session> getUsers() {
		return USERS;
	}

	/**
	 * 群发消息文本消息
	 *
	 * @param message 消息内容
	 */
	public static void sendMessageToUsersByText(String message) {
		Collection<Session> values = USERS.values();
		for (Session value : values) {
			sendMessageToUserByText(value, message);
		}
	}

	/**
	 * 发送文本消息
	 *
	 * @param session session
	 * @param message 消息内容
	 */
	public static void sendMessageToUserByText(Session session, String message) {
		if (session != null) {
			try {
				// 为了防止消息中存在特殊字符（比如换行符）等造成前台解析错误，此处编码一次。前台对应的需要解码
				session.getBasicRemote().sendText(generateMsg("default", URLEncoder.encode(message, StandardCharsets.UTF_8.displayName())));
			} catch (IOException e) {
				LOGGER.error("\n[发送消息异常]", e);
			}
		} else {
			LOGGER.info("\n[你已离线]");
		}
	}

	/**
	 * 根据消息类型，生成发送到客户端的最终消息内容
	 *
	 * @param type    消息类型
	 * @param content 消息正文
	 */
	private static String generateMsg(String type, String content) {
		return String.format("{\"type\": \"%s\", \"msg\":\"%s\"}", type, content);
	}
}
