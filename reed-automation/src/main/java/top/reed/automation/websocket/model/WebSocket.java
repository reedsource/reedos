package top.reed.automation.websocket.model;

/**
 * WebSocket事件
 *
 * @param <T>
 * @author reedsource
 */
public class WebSocket<T> {

    private String eventType;

    private String timestamp;

    private T message;

    public WebSocket(String eventType, T message) {
        this.eventType = eventType;
        this.message = message;
    }

    public WebSocket(String eventType, String timestamp, T message) {
        this.eventType = eventType;
        this.timestamp = timestamp;
        this.message = message;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public T getMessage() {
        return message;
    }

    public void setMessage(T message) {
        this.message = message;
    }
}
