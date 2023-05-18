package top.reed.core.executor;

/**
 * 功能执行器接口
 * 函数实现都基于对本接口的实现
 */
public interface FunctionExecutor {

    /**
     * @return 获取实现类中设定好的实现类组名称
     */
    String getFunctionPrefix();

}
