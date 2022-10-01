package top.reed.api.listener;

import top.reed.api.context.SpiderContext;

public interface SpiderListener {

	/**
	 * 开始执行之前
	 */
	void beforeStart(SpiderContext context);

	/**
	 * 执行完毕之后
	 */
	void afterEnd(SpiderContext context);

}
