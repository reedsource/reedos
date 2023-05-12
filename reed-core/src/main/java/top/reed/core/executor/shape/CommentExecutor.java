package top.reed.core.executor.shape;

import org.springframework.stereotype.Component;
import top.reed.core.context.AutomationContext;
import top.reed.core.executor.ShapeExecutor;
import top.reed.core.model.AutomationNode;

import java.util.Map;

@Component
public class CommentExecutor implements ShapeExecutor {

    @Override
    public void execute(AutomationNode node, AutomationContext context, Map<String, Object> variables) {

    }

    @Override
    public String supportShape() {
        return "comment" ;
    }

}
