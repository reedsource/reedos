package top.reed.core.executor;

import top.reed.core.context.AutomationContext;
import top.reed.core.model.AutomationNode;
import top.reed.core.model.Shape;

import java.util.Map;

/**
 * 执行器接口
 *
 * @author reedsource
 */
public interface ShapeExecutor {

    String LOOP_VARIABLE_NAME = "loopVariableName" ;

    String LOOP_COUNT = "loopCount" ;

    String THREAD_COUNT = "threadCount" ;

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
    void execute(AutomationNode node, AutomationContext context, Map<String, Object> variables);

    default boolean allowExecuteNext(AutomationNode node, AutomationContext context, Map<String, Object> variables) {
        return true;
    }

    default boolean isThread() {
        return true;
    }
}
