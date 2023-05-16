package top.reed.core.utils;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.core.ExpressionEngine;
import top.reed.core.model.AutomationNode;

import java.util.Map;
import java.util.Objects;

/**
 *
 * @author reedsource
 */
@Component
public class ExpressionUtils {

    private static final Logger logger = LoggerFactory.getLogger(ExpressionUtils.class);

    /**
     * 选择器
     */
    private static ExpressionEngine engine;

    @Autowired
    private ExpressionUtils(ExpressionEngine engine) {
        ExpressionUtils.engine = engine;
    }

    public static boolean executeCondition(AutomationNode fromNode, AutomationNode node, Map<String, Object> variables) {
        if (fromNode != null) {
            String condition = node.getCondition(fromNode.getNodeId());
            if (StringUtils.isNotBlank(condition)) { // 判断是否有条件
                Object result = null;
                try {
                    result = engine.execute(condition, variables);
                } catch (Exception e) {
                    logger.error("判断{}出错,异常信息： {}", condition, e.toString());
                }
                if (result != null) {
                    boolean isContinue = "true".equals(result) || Objects.equals(result, true);
                    logger.debug("判断{}={}", condition, isContinue);
                    return isContinue;
                }
                return false;
            }
        }
        return true;
    }

    public static Object execute(String expression, Map<String, Object> variables) {
        return engine.execute(expression, variables);
    }
}
