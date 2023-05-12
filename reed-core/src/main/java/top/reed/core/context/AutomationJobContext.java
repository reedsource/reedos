package top.reed.core.context;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import top.reed.core.model.AutomationOutput;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.Serial;
import java.util.ArrayList;
import java.util.List;

public class AutomationJobContext extends AutomationContext {

    @Serial
    private static final long serialVersionUID = 9099787449108938453L;

    private static final Logger logger = LoggerFactory.getLogger(AutomationJobContext.class);

    private final OutputStream outputstream;

    private final List<AutomationOutput> outputs = new ArrayList<>();

    private final boolean output;

    public AutomationJobContext(OutputStream outputstream, boolean output) {
        super();
        this.outputstream = outputstream;
        this.output = output;
    }

    /**
     * @param directory 自动化日志路径
     * @param id        自动化流程id
     * @param output
     * @return
     */
    public static AutomationJobContext create(String directory, String id, boolean output) {
        OutputStream os = null;
        try {
            //
            File file = new File(new File(directory), id + File.separator + "logs" + File.separator + ".log");
            File dirFile = file.getParentFile();
            if (!dirFile.exists()) {
                dirFile.mkdirs();
            }
            os = new FileOutputStream(file, true);
        } catch (Exception e) {
            logger.error("创建日志文件出错", e);
        }
        AutomationJobContext context = new AutomationJobContext(os, output);
        context.setFlowId(id);
        return context;
    }

    public void close() {
        try {
            this.outputstream.close();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void addOutput(AutomationOutput output) {
        if (this.output) {
            synchronized (this.outputs) {
                this.outputs.add(output);
            }
        }
    }

    @Override
    public List<AutomationOutput> getOutputs() {
        return outputs;
    }

    public OutputStream getOutputstream() {
        return this.outputstream;
    }
}
