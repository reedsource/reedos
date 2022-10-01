package top.reed.core.expression;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * 表达式全局变量
 */
public class ExpressionGlobalVariables {

	private static Map<String, String> variables = new HashMap<>();

	private static ReentrantReadWriteLock readWriteLock = new ReentrantReadWriteLock();

	public static void reset(Map<String, String> map) {
		Lock lock = readWriteLock.writeLock();
		lock.lock();
		try {
			variables.clear();
			variables.putAll(map);
		} finally {
			lock.unlock();
		}
	}

	public static Map<String, String> getVariables() {
		Lock lock = readWriteLock.readLock();
		lock.lock();
		try {
			return variables;
		} finally {
			lock.unlock();
		}
	}
}
