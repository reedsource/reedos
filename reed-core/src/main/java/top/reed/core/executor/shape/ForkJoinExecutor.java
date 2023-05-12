package top.reed.core.executor.shape;

import org.springframework.stereotype.Component;
import top.reed.core.context.AutomationContext;
import top.reed.core.executor.ShapeExecutor;
import top.reed.core.model.AutomationNode;

import java.util.HashMap;
import java.util.Map;

/**
 * 等待执行结束执行器
 */
@Component
public class ForkJoinExecutor implements ShapeExecutor {

    /**
     * 缓存已完成节点的变量
     */
    private final Map<String, Map<String, Object>> cachedVariables = new HashMap<>();

    @Override
    public void execute(AutomationNode node, AutomationContext context, Map<String, Object> variables) {
    }

    @Override
    public String supportShape() {
        return "forkJoin" ;
    }

    @Override
    public boolean allowExecuteNext(AutomationNode node, AutomationContext context, Map<String, Object> variables) {
        String key = context.getId() + "-" + node.getNodeId();
        synchronized (node) {
            boolean isDone = node.isDone();
            Map<String, Object> cached = cachedVariables.get(key);
            if (!isDone) {
                if (cached == null) {
                    cached = new HashMap<>();
                    cachedVariables.put(key, cached);
                }
                cached.putAll(variables);
            } else if (cached != null) {
                //将缓存的变量存入到当前变量中,传递给下一级
                variables.putAll(cached);
                cachedVariables.remove(key);
            }
            return isDone;
        }
    }
}
