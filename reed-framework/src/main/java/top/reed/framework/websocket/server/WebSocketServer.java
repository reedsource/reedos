package top.reed.framework.websocket.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import top.reed.framework.websocket.util.SemaphoreUtils;
import top.reed.framework.websocket.util.WebSocketUsers;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.concurrent.Semaphore;

/**
 * 全局 websocket 消息处理
 *
 * @author reedsource
 */
@Component
@ServerEndpoint("/websocket/{guest-id}")
public class WebSocketServer {
    /**
     * WebSocketServer 日志控制器
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(WebSocketServer.class);

    /**
     * 默认最多允许同时在线人数100
     */
    public static final int socketMaxOnlineCount = 100;

    /**
     * 信号量维护 达到限流作用
     */
    private static final Semaphore socketSemaphore = new Semaphore(socketMaxOnlineCount);

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) throws Exception {
        boolean semaphoreFlag;
        // 尝试获取信号量
        semaphoreFlag = SemaphoreUtils.tryAcquire(socketSemaphore);
        if (semaphoreFlag) {
            // 添加用户
            WebSocketUsers.put(session.getId(), session);
            LOGGER.info("建立连接 - {}", session);
            LOGGER.info("当前人数 - {}", WebSocketUsers.getUsers().size());
            WebSocketUsers.sendMessageToUserByText(session, "系统服务连接成功");
        } else {
            // 未获取到信号量
            LOGGER.error("当前在线人数超过限制数- {}", socketMaxOnlineCount);
            WebSocketUsers.sendMessageToUserByText(session, "当前在线人数超过限制数：" + socketMaxOnlineCount);
            session.close();
        }
    }

    /**
     * 连接关闭时处理
     */
    @OnClose
    public void onClose(Session session) {
        LOGGER.info("关闭连接 - {}", session);
        // 移除用户
        WebSocketUsers.remove(session.getId());
        // 获取到信号量则需释放
        SemaphoreUtils.release(socketSemaphore);
    }

    /**
     * 抛出异常时处理
     */
    @OnError
    public void onError(Session session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            // 关闭连接
            session.close();
        }
        String sessionId = session.getId();
        LOGGER.info("连接异常 - {} 异常信息 - {}", sessionId, exception.toString());
        // 移出用户
        WebSocketUsers.remove(sessionId);
        // 获取到信号量则需释放
        SemaphoreUtils.release(socketSemaphore);
    }

    /**
     * 服务器接收到客户端消息时调用的方法
     *
     * @param guestID 发起websocket时的实际后缀 对应上方 {guest-id}
     * @param message 客户端发送过来的消息
     * @param session session
     */
    @OnMessage
    public void onMessage(@PathParam("guest-id") String guestID, String message, Session session) {
        LOGGER.info("收到到来自客户端{} 类型{} 消息: {}", session.getId(), guestID, message);

        String msg = message.replace("你", "我").replace("吗", "");
        WebSocketUsers.sendMessageToUserByText(session, msg);
    }

    /**
     * @return 当前在线人数
     */
    public int getOnlineUserCount() {
        return WebSocketUsers.getUsers().size();
    }


}
