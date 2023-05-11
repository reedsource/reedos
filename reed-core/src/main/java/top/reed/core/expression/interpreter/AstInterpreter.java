package top.reed.core.expression.interpreter;

import top.reed.core.expression.ExpressionError;
import top.reed.core.expression.ExpressionError.TemplateException;
import top.reed.core.expression.ExpressionTemplate;
import top.reed.core.expression.ExpressionTemplateContext;
import top.reed.core.expression.parsing.Ast;
import top.reed.core.expression.parsing.Ast.Node;
import top.reed.core.expression.parsing.Ast.Text;

import java.io.IOException;
import java.util.List;

/**
 * 解释给定模板上下文的模板以查找变量值，并将评估结果写入输出流。
 * 使用返回Reflection.getInstance()的全局Reflection实例来访问成员和调用方法。
 *
 * 交互器遍历存储在 中的 ExpressionTemplate.getNodes()AST。
 * 交互器对每个 AST 节点类型都有一个方法（请参阅 Ast 评估该节点的方法。节点可以返回一个值，用于解释父节点或写入输出流。
 **/
public class AstInterpreter {
    /**
     * 解释
     *
     * @param template
     * @param context
     * @return
     */
    public static Object interpret(ExpressionTemplate template, ExpressionTemplateContext context) {
        try {
            return interpretNodeList(template.getNodes(), template, context);
        } catch (Throwable t) {
            if (t instanceof TemplateException)
                throw (TemplateException) t;
            else {
                ExpressionError.error("执行表达式出错 " + t.getMessage(), template.getNodes().get(0).getSpan(), t);
                return null; // 从未达到
            }
        }
    }

    public static Object interpretNodeList(List<Node> nodes, ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
        String result = "";
        for (int i = 0, n = nodes.size(); i < n; i++) {
            Node node = nodes.get(i);
            Object value = node.evaluate(template, context);
            if (node instanceof Text) {
                result += node.getSpan().getText();
            } else if (value == null) {
                if (i == 0 && i + 1 == n) {
                    return null;
                }
                result += "null";
            } else if (value instanceof String || value instanceof Number || value instanceof Boolean) {
                if (i == 0 && i + 1 == n) {
                    return value;
                }
                result += value;
            } else if (i + 1 < n) {
                ExpressionError.error("表达式执行错误", node.getSpan());
            } else {
                return value;
            }
        }
        return result;
    }
}
