package top.reed.api.expression;

import java.util.List;

public interface DynamicMethod {

    Object execute(String methodName, List<Object> parameters);

}
