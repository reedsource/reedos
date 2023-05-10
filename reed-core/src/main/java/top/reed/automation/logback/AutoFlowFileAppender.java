package top.reed.automation.logback;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.FileAppender;
import ch.qos.logback.core.spi.DeferredProcessingAware;
import ch.qos.logback.core.status.ErrorStatus;
import top.reed.api.context.SpiderContext;
import top.reed.api.context.SpiderContextHolder;
import top.reed.core.job.SpiderJobContext;

import java.io.IOException;
import java.io.OutputStream;

/**
 * 自动话程序附加程序
 */
public class AutoFlowFileAppender extends FileAppender<ILoggingEvent> {

    @Override
    protected void subAppend(ILoggingEvent event) {
        SpiderContext context = SpiderContextHolder.get();
        OutputStream os = getOutputStream();
        if (context instanceof SpiderJobContext jobContext) {
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
