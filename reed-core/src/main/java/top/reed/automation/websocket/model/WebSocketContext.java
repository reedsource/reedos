package top.reed.automation.websocket.model;

import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.time.DateFormatUtils;
import top.reed.core.context.AutomationContext;
import top.reed.core.model.AutomationLog;
import top.reed.core.model.AutomationOutput;
import top.reed.core.serializer.FastJsonSerializer;

import javax.websocket.Session;
import java.io.Serial;
import java.util.Date;

/**
 * WebSocket通讯中自动化任务的上下文域
 *
 * @author reedsource
 */
public class WebSocketContext extends AutomationContext {

    @Serial
    private static final long serialVersionUID = -1205530535069540245L;

    private final Session session;

    private boolean debug;

    private final Object lock = new Object();

    public WebSocketContext(Session session) {
        this.session = session;
    }

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    @Override
    public void addOutput(AutomationOutput output) {
        this.write(new WebSocket<>("output", output));
    }

    public void log(AutomationLog log) {
        write(new WebSocket<>("log", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"), log));
    }

    public <T> void write(WebSocket<T> event) {
        try {
            String message = JSON.toJSONString(event, FastJsonSerializer.serializeConfig);
            if (session.isOpen()) {
                synchronized (session) {
                    session.getBasicRemote().sendText(message);
                }
            }
        } catch (Throwable ignored) {
        }
    }

    @Override
    public void pause(String nodeId, String event, String key, Object value) {
        if (this.debug && this.isRunning()) {
            synchronized (this) {
                if (this.debug && this.isRunning()) {
                    synchronized (lock) {
                        try {
                            write(new WebSocket<>("debug", new DebugInfo(nodeId, event, key, value)));
                            lock.wait();
                        } catch (InterruptedException ignored) {
                        }
                    }
                }
            }
        }
    }

    @Override
    public void resume() {
        if (this.debug) {
            synchronized (lock) {
                lock.notify();
            }
        }
    }

    @Override
    public void stop() {
        if (this.debug) {
            synchronized (lock) {
                lock.notifyAll();
            }
        }
    }

    static class DebugInfo {

        private String nodeId;

        private String event;

        private String key;

        private Object value;

        public DebugInfo(String nodeId, String event, String key, Object value) {
            this.nodeId = nodeId;
            this.event = event;
            this.key = key;
            this.value = value;
        }

        public String getNodeId() {
            return nodeId;
        }

        public void setNodeId(String nodeId) {
            this.nodeId = nodeId;
        }

        public String getEvent() {
            return event;
        }

        public void setEvent(String event) {
            this.event = event;
        }

        public String getKey() {
            return key;
        }

        public void setKey(String key) {
            this.key = key;
        }

        public Object getValue() {
            return value;
        }

        public void setValue(Object value) {
            this.value = value;
        }
    }
}
