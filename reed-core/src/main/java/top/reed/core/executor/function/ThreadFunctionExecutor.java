package top.reed.core.executor.function;

import org.springframework.stereotype.Component;
import top.reed.core.annotation.Comment;
import top.reed.core.annotation.Example;
import top.reed.core.executor.FunctionExecutor;

/**
 *
 * @author reedsource
 */
@Component
@Comment("thread常用方法")
public class ThreadFunctionExecutor implements FunctionExecutor {
    @Comment("线程休眠")
    @Example("${thread.sleep(1000L)}")
    public static void sleep(Long sleepTime) {
        try {
            Thread.sleep(sleepTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getFunctionPrefix() {
        return "thread" ;
    }
}
