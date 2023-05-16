package top.reed.core.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import top.reed.core.executor.ShapeExecutor;
import top.reed.core.model.Shape;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 *
 * @author reedsource
 */
@Component
public class ExecutorsUtils implements ApplicationContextAware {

    /**
     * 节点执行器列表 当前自动化任务的全部流程
     */
    private static List<ShapeExecutor> executors;

    private static Map<String, ShapeExecutor> executorMap;

    private static ApplicationContext applicationContext;

    @Autowired
    ExecutorsUtils(List<ShapeExecutor> executors) {
        ExecutorsUtils.executors = executors;
    }

    public static List<Shape> shapes() {
        return executors.stream().map(ShapeExecutor::shape).filter(Objects::nonNull).collect(Collectors.toList());
    }

    public static ShapeExecutor get(String shape) {
        return executorMap.get(shape);
    }

    @PostConstruct
    private void init() {
        executorMap = executors.stream().collect(Collectors.toMap(ShapeExecutor::supportShape, v -> v));
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ExecutorsUtils.applicationContext = applicationContext;
    }
}
