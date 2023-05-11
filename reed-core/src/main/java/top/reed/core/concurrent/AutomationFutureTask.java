package top.reed.core.concurrent;

import top.reed.core.concurrent.AutomationFlowThreadPoolExecutor.SubThreadPoolExecutor;
import top.reed.core.model.AutomationNode;

import java.util.concurrent.FutureTask;

public class AutomationFutureTask<V> extends FutureTask {

    private final SubThreadPoolExecutor executor;

    private final AutomationNode node;

    public AutomationFutureTask(Runnable runnable, V result, AutomationNode node, SubThreadPoolExecutor executor) {
        super(runnable, result);
        this.executor = executor;
        this.node = node;
    }

    public SubThreadPoolExecutor getExecutor() {
        return executor;
    }

    public AutomationNode getNode() {
        return node;
    }
}
