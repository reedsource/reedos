package top.reed.automation.logback;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.classic.spi.ThrowableProxy;
import ch.qos.logback.core.UnsynchronizedAppenderBase;
import top.reed.automation.websocket.model.WebSocketContext;
import top.reed.core.context.AutomationContext;
import top.reed.core.context.AutomationContextHolder;
import top.reed.core.model.AutomationLog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class AutoFlowWebSocketAppender extends UnsynchronizedAppenderBase<ILoggingEvent> {

    @Override
    protected void append(ILoggingEvent event) {
        AutomationContext context = AutomationContextHolder.get();
        if (context instanceof WebSocketContext socketContext) {
            Object[] argumentArray = event.getArgumentArray();
            List<Object> arguments = argumentArray == null ? Collections.emptyList() : new ArrayList<>(Arrays.asList(argumentArray));
            ThrowableProxy throwableProxy = (ThrowableProxy) event.getThrowableProxy();
            if (throwableProxy != null) {
                arguments.add(throwableProxy.getThrowable());
            }
            socketContext.log(new AutomationLog(event.getLevel().levelStr.toLowerCase(), event.getMessage(), arguments));
        }
    }
}
