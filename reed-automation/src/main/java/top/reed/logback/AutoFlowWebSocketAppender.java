package top.reed.logback;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.classic.spi.ThrowableProxy;
import ch.qos.logback.core.UnsynchronizedAppenderBase;
import top.reed.api.context.SpiderContext;
import top.reed.api.context.SpiderContextHolder;
import top.reed.api.model.SpiderLog;
import top.reed.model.SpiderWebSocketContext;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class AutoFlowWebSocketAppender extends UnsynchronizedAppenderBase<ILoggingEvent> {

	@Override
	protected void append(ILoggingEvent event) {
		SpiderContext context = SpiderContextHolder.get();
		if (context instanceof SpiderWebSocketContext) {
			SpiderWebSocketContext socketContext = (SpiderWebSocketContext) context;
			Object[] argumentArray = event.getArgumentArray();
			List<Object> arguments = argumentArray == null ? Collections.emptyList() : new ArrayList<>(Arrays.asList(argumentArray));
			ThrowableProxy throwableProxy = (ThrowableProxy) event.getThrowableProxy();
			if (throwableProxy != null) {
				arguments.add(throwableProxy.getThrowable());
			}
			socketContext.log(new SpiderLog(event.getLevel().levelStr.toLowerCase(), event.getMessage(), arguments));
		}
	}
}
