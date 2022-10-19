package top.reed.framework.websocket.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.Semaphore;

/**
 * 信号量相关处理
 *
 * @author reedsource
 */
public class SemaphoreUtils {

	/**
	 * SemaphoreUtils 日志控制器
	 */
	private static final Logger LOGGER = LoggerFactory.getLogger(SemaphoreUtils.class);

	/**
	 * 获取信号量
	 *
	 * @param semaphore 信号量
	 * @return 当前信号是否可以访问
	 */
	public static boolean tryAcquire(Semaphore semaphore) {
		boolean flag = false;
		try {
			flag = semaphore.tryAcquire();
		} catch (Exception e) {
			LOGGER.error("获取信号量异常", e);
		}
		return flag;
	}

	/**
	 * 释放信号量
	 *
	 * @param semaphore 信号量
	 */
	public static void release(Semaphore semaphore) {

		try {
			semaphore.release();
		} catch (Exception e) {
			LOGGER.error("释放信号量异常", e);
		}
	}
}
