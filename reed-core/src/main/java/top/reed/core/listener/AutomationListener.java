package top.reed.core.listener;

import top.reed.core.context.AutomationContext;

/**
 * 自动化侦听器
 */
public interface AutomationListener {

    /**
     * 开始执行之前
     */
    void beforeStart(AutomationContext context);

    /**
     * 执行完毕之后
     */
    void afterEnd(AutomationContext context);

}
