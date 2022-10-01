package top.reed.api.concurrent;

import top.reed.api.model.SpiderNode;

import java.util.Comparator;

public interface ThreadSubmitStrategy {

	Comparator<SpiderNode> comparator();

	void add(SpiderFutureTask<?> task);

	boolean isEmpty();

	SpiderFutureTask<?> get();
}
