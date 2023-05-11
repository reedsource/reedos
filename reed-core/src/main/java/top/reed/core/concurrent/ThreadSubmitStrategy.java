package top.reed.core.concurrent;

import top.reed.core.model.AutomationNode;

import java.util.Comparator;

public interface ThreadSubmitStrategy {

    Comparator<AutomationNode> comparator();

    void add(AutomationFutureTask<?> task);

    boolean isEmpty();

    AutomationFutureTask<?> get();
}
