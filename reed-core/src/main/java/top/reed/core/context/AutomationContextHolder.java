package top.reed.core.context;

import com.alibaba.ttl.TransmittableThreadLocal;

public class AutomationContextHolder {

    private static final ThreadLocal<AutomationContext> THREAD_LOCAL = new TransmittableThreadLocal<>();

    public static AutomationContext get() {
        return THREAD_LOCAL.get();
    }

    public static void set(AutomationContext context) {
        THREAD_LOCAL.set(context);
    }

    public static void remove() {
        THREAD_LOCAL.remove();
    }

}
