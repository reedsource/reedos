package top.reed.automation.logback;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.FileAppender;
import ch.qos.logback.core.spi.DeferredProcessingAware;
import ch.qos.logback.core.status.ErrorStatus;
import top.reed.core.context.AutomationContext;
import top.reed.core.context.AutomationContextHolder;
import top.reed.core.context.AutomationJobContext;

import java.io.IOException;
import java.io.OutputStream;

/**
 * 自动话程序附加程序
 */
public class AutoFlowFileAppender extends FileAppender<ILoggingEvent> {

    @Override
    protected void subAppend(ILoggingEvent event) {
        AutomationContext context = AutomationContextHolder.get();
        OutputStream os = getOutputStream();
        if (context instanceof AutomationJobContext jobContext) {
            os = jobContext.getOutputstream();
        }
        try {
            if (event instanceof DeferredProcessingAware) {
                ((DeferredProcessingAware) event).prepareForDeferredProcessing();
            }
            byte[] byteArray = this.encoder.encode(event);
            writeBytes(os, byteArray);

        } catch (IOException ioe) {
            this.started = false;
            addStatus(new ErrorStatus("IO failure in appender", this, ioe));
        }
    }

    private void writeBytes(OutputStream os, byte[] byteArray) throws IOException {
        if (byteArray == null || byteArray.length == 0)
            return;

        lock.lock();
        try {
            os.write(byteArray);
            if (isImmediateFlush()) {
                os.flush();
            }
        } finally {
            lock.unlock();
        }
    }
}
