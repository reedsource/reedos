package top.reed.core.expression.interpreter;

/**
 * AstInterpreter用于访问对象的字段和方法。
 * 这是一个由所有AstInterpreter实例使用的单例类。通过setInstance（反射）替换默认实现。实现必须是线程安全的
 */
public abstract class Reflection {
    private static Reflection instance = new JavaReflection();

    /**
     * 返回用于获取字段和调用方法的反射实
     **/
    public synchronized static Reflection getInstance() {
        return instance;
    }

    /**
     * 设置所有模板解释器要使用的反射实例
     **/
    public synchronized static void setInstance(Reflection reflection) {
        instance = reflection;
    }

    /**
     * 为具有给定名称的字段返回不透明句柄，如果找不到该字段，则返回null
     **/
    public abstract Object getField(Object obj, String name);

    /**
     * 返回方法的不透明句柄，该方法的给定名称与给定参数所暗示的签名最匹配，如果找不到该方法，则返回null。
     * 如果obj是Class的实例，则返回匹配的静态方法。如果名称为null，并且对象是FunctionalInterface，则返回对象上声明的第一个方法。
     **/
    public abstract Object getMethod(Object obj, String name, Object... arguments);

    public abstract Object getExtensionMethod(Object obj, String name, Object... arguments);

    public abstract void registerExtensionClass(Class<?> target, Class<?> clazz);

    /**
     * 返回对象中字段的值。该字段必须以前通过getField（Object，String）检索过
     **/
    public abstract Object getFieldValue(Object obj, Object field);

    /**
     * 使用给定的参数调用对象上的方法。该方法必须以前通过getMethod（Object、String、Object…）检索过
     **/
    public abstract Object callMethod(Object obj, Object method, Object... arguments);
}
