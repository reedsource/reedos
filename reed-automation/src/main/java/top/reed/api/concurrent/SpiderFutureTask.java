package top.reed.api.concurrent;

import top.reed.api.concurrent.SpiderFlowThreadPoolExecutor.SubThreadPoolExecutor;
import top.reed.api.model.SpiderNode;

import java.util.concurrent.FutureTask;

public class SpiderFutureTask<V> extends FutureTask {

    private SubThreadPoolExecutor executor;

    private SpiderNode node;

    public SpiderFutureTask(Runnable runnable, V result, SpiderNode node, SubThreadPoolExecutor executor) {
        super(runnable, result);
        this.executor = executor;
        this.node = node;
    }

    public SubThreadPoolExecutor getExecutor() {
        return executor;
    }

    public SpiderNode getNode() {
        return node;
    }
}
