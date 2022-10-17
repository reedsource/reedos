package top.reed.websocket.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import top.reed.websocket.util.WebSocketUtil;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author reedsource
 * @version 1.0
 * date 2022/9/12
 * @since 1.0
 */

@ServerEndpoint("/websocket/{guest-id}")
@Component
public class WebSocketServer {
	/**
	 * 线程安全的socket集合
	 */
	private static final CopyOnWriteArraySet<Session> webSocketSet = new CopyOnWriteArraySet<>();
	/**
	 * 初始在线人数
	 */
	private static final AtomicInteger onlineCount = new AtomicInteger(0);
	private static final Logger logger = LoggerFactory.getLogger(WebSocketServer.class);

	/**
	 * 连接建立成功调用的方法
	 */
	@OnOpen
	public void onOpen(Session session) {
		webSocketSet.add(session);
		int count = onlineCount.incrementAndGet();
		logger.info("[Socket] 有链接加入 id {} ，当前在线人数为: {}", session.getId(), count);

		WebSocketUtil.sendOnlineMsg(Integer.toString(count), webSocketSet);
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose(Session session) {
		int count = onlineCount.decrementAndGet();
		logger.info("[Socket] 有链接关闭 id {} ,当前在线人数为: {}", session.getId(), count);
		WebSocketUtil.sendOnlineMsg(Integer.toString(count), webSocketSet);
	}

	/**
	 * 收到客户端消息后调用的方法
	 *
	 * @param guestID 发起websocket时的实际后缀 对应上方 {guest-id}
	 * @param message 客户端发送过来的消息
	 * @param session session
	 */
	@OnMessage
	public void onMessage(@PathParam("guest-id") String guestID, String message, Session session) {
		logger.info("[Socket] {}来自客户端的消息:{} {}", session.getId(), guestID, message);
	}

	/**
	 * 连接产生错误
	 *
	 * @param session session
	 */
	@OnError
	public void onCerror(Session session, Throwable throwable) {
		logger.info("[Socket] 有错误连接 id {} 错误 {} ", session.getId(), throwable.getMessage());
	}

	/**
	 * 获取在线用户数量
	 */
	public int getOnlineUserCount() {
		return onlineCount.get();
	}

	/**
	 * 获取在线用户的会话信息
	 */
	public CopyOnWriteArraySet<Session> getOnlineUsers() {
		return webSocketSet;
	}
}
