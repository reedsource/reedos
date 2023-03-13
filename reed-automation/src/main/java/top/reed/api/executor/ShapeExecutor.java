package top.reed.api.executor;

import top.reed.api.context.SpiderContext;
import top.reed.api.model.Shape;
import top.reed.api.model.SpiderNode;

import java.util.Map;

/**
 * 执行器接口
 *
 * @author jmxd
 */
public interface ShapeExecutor {

    String LOOP_VARIABLE_NAME = "loopVariableName";

    String LOOP_COUNT = "loopCount";

    String THREAD_COUNT = "threadCount";

    default Shape shape() {
        return null;
    }

    /**
     * 节点形状
     *
     * @return 节点形状名称
     */
    String supportShape();

    /**
     * 执行器具体的功能实现
     *
     * @param node      当前要执行的自动化任务节点
     * @param context   自动化任务上下文
     * @param variables 节点流程的全部变量的集合
     */
    void execute(SpiderNode node, SpiderContext context, Map<String, Object> variables);

    default boolean allowExecuteNext(SpiderNode node, SpiderContext context, Map<String, Object> variables) {
        return true;
    }

    default boolean isThread() {
        return true;
    }
}
