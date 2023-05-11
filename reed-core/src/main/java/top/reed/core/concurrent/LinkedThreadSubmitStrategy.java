package top.reed.core.concurrent;

import top.reed.core.model.AutomationNode;

import java.util.Comparator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class LinkedThreadSubmitStrategy implements ThreadSubmitStrategy {

    private final List<AutomationFutureTask<?>> taskList = new CopyOnWriteArrayList<>();

    @Override
    public Comparator<AutomationNode> comparator() {
        return (o1, o2) -> -1;
    }

    @Override
    public void add(AutomationFutureTask<?> task) {
        taskList.add(task);
    }

    @Override
    public boolean isEmpty() {
        return taskList.isEmpty();
    }

    @Override
    public AutomationFutureTask<?> get() {
        return taskList.remove(0);
    }
}
