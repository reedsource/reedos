package top.reed.core.executor.shape;

import org.springframework.stereotype.Component;
import top.reed.core.context.AutomationContext;
import top.reed.core.executor.ShapeExecutor;
import top.reed.core.model.AutomationNode;

import java.util.Map;

/**
 * 循环执行器
 *
 * @author reedsource
 */
@Component
public class LoopExecutor implements ShapeExecutor {

    public static final String LOOP_ITEM = "loopItem";

    public static final String LOOP_START = "loopStart";

    public static final String LOOP_END = "loopEnd";

    @Override
    public void execute(AutomationNode node, AutomationContext context, Map<String, Object> variables) {
    }

    @Override
    public String supportShape() {
        return "loop";
    }
}
