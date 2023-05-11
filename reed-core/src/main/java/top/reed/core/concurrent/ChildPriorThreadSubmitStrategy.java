package top.reed.core.concurrent;

import top.reed.core.model.AutomationNode;

import java.util.Comparator;
import java.util.PriorityQueue;

public class ChildPriorThreadSubmitStrategy implements ThreadSubmitStrategy {

    private final Object mutex = this;

    private final Comparator<AutomationNode> comparator = (o1, o2) -> {
        if (o1.hasLeftNode(o2.getNodeId())) {
            return -1;
        }
        return 1;
    };

    private final PriorityQueue<AutomationFutureTask<?>> priorityQueue = new PriorityQueue<>((o1, o2) -> comparator.compare(o1.getNode(), o2.getNode()));

    @Override
    public Comparator<AutomationNode> comparator() {
        return comparator;
    }

    @Override
    public void add(AutomationFutureTask<?> task) {
        synchronized (mutex) {
            priorityQueue.add(task);
        }
    }

    @Override
    public boolean isEmpty() {
        synchronized (mutex) {
            return priorityQueue.isEmpty();
        }
    }

    @Override
    public AutomationFutureTask<?> get() {
        synchronized (mutex) {
            return priorityQueue.poll();
        }
    }
}
