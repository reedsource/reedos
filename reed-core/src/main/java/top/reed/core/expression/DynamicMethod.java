package top.reed.core.expression;

import java.util.List;

/**
 * 动态方法
 */
public interface DynamicMethod {

    Object execute(String methodName, List<Object> parameters);

}
