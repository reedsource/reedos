package top.reed.websocket.server;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;
import top.reed.core.Spider;
import top.reed.core.utils.AutoFlowUtils;
import top.reed.websocket.model.WebSocketContext;
import top.reed.websocket.model.WebSocket;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * WebSocket通讯编辑服务
 *
 * @author reedsource
 */
@ServerEndpoint("/ws")
@Component
public class WebSocketEditorServer {

	public static Spider spider;

	private WebSocketContext context;

	/**
	 * 收到客户端消息后调用的方法
	 *
	 * @param message 客户端发送过来的消息
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		JSONObject event = JSON.parseObject(message);
		String eventType = event.getString("eventType");
		boolean isDebug = "debug".equalsIgnoreCase(eventType);
		if ("test".equalsIgnoreCase(eventType) || isDebug) {
			context = new WebSocketContext(session);
			context.setDebug(isDebug);
			context.setRunning(true);
			new Thread(() -> {
				String xml = event.getString("message");
				if (xml != null) {
					spider.runWithTest(AutoFlowUtils.loadXMLFromString(xml), context);
					context.write(new WebSocket<>("finish", null));
				} else {
					context.write(new WebSocket<>("error", "xml不正确！"));
				}
				context.setRunning(false);
			}).start();
		} else if ("stop".equals(eventType) && context != null) {
			context.setRunning(false);
			context.stop();
		} else if ("resume".equalsIgnoreCase(eventType) && context != null) {
			context.resume();
		}
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose() {
		context.setRunning(false);
		context.stop();
	}
}
