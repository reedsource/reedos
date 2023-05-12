package top.reed.core.executor.shape;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import top.reed.core.context.AutomationContext;
import top.reed.core.executor.ShapeExecutor;
import top.reed.core.model.AutomationNode;
import top.reed.core.utils.ExpressionUtils;

import java.util.List;
import java.util.Map;

/**
 * 函数执行器
 *
 * @author reedsource
 */
@Component
public class FunctionExecutor implements ShapeExecutor {

    public static final String FUNCTION = "function" ;

    private static final Logger logger = LoggerFactory.getLogger(FunctionExecutor.class);

    @Override
    public void execute(AutomationNode node, AutomationContext context, Map<String, Object> variables) {
        List<Map<String, String>> functions = node.getListJsonValue(FUNCTION);
        for (Map<String, String> item : functions) {
            String function = item.get(FUNCTION);
            if (StringUtils.isNotBlank(function)) {
                try {
                    logger.debug("执行函数{}", function);
                    ExpressionUtils.execute(function, variables);
                } catch (Exception e) {
                    logger.error("执行函数{}失败,异常信息:{}", function, e);
                    ExceptionUtils.wrapAndThrow(e);
                }
            }
        }
    }

    @Override
    public String supportShape() {
        return "function" ;
    }

}
