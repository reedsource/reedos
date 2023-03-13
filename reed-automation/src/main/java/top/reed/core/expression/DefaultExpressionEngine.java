package top.reed.core.expression;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.api.ExpressionEngine;
import top.reed.api.executor.FunctionExecutor;
import top.reed.api.executor.FunctionExtension;
import top.reed.core.expression.interpreter.Reflection;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;

@Component
public class DefaultExpressionEngine implements ExpressionEngine {

    @Autowired
    private List<FunctionExecutor> functionExecutors;

    @Autowired
    private List<FunctionExtension> functionExtensions;

    @PostConstruct
    private void init() {
        for (FunctionExtension extension : functionExtensions) {
            Reflection.getInstance().registerExtensionClass(extension.support(), extension.getClass());
        }
    }

    @Override
    public Object execute(String expression, Map<String, Object> variables) {
        if (StringUtils.isBlank(expression)) {
            return expression;
        }
        ExpressionTemplateContext context = new ExpressionTemplateContext(variables);
        for (FunctionExecutor executor : functionExecutors) {
            context.set(executor.getFunctionPrefix(), executor);
        }
        //加载表达式全局变量
        ExpressionGlobalVariables.getVariables().entrySet().forEach(entry -> {
            context.set(entry.getKey(), ExpressionTemplate.create(entry.getValue()).render(context));
        });
        try {
            ExpressionTemplateContext.set(context);
            return ExpressionTemplate.create(expression).render(context);
        } finally {
            ExpressionTemplateContext.remove();
        }
    }

}
