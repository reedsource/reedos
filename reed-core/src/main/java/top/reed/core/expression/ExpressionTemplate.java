package top.reed.core.expression;

import top.reed.core.expression.interpreter.AstInterpreter;
import top.reed.core.expression.parsing.Ast.Node;
import top.reed.core.expression.parsing.Parser;

import java.util.List;


/**
 * 表达式模板
 * <p>
 * 模板由 从标有基础模板语言的文件加载。
 * 模板可以通过调用其中一个方法呈现为 或StringOutputStream。
 * render()传递给render()方法用于ExpressionTemplateContext查找模板中引用的变量值。
 */
public class ExpressionTemplate {
    private final List<Node> nodes;

    private ExpressionTemplate(List<Node> nodes) {
        this.nodes = nodes;
    }

    public static ExpressionTemplate create(String source) {
        return new ExpressionTemplate(Parser.parse(source));
    }

    /**
     * 内部。解析后表示此模板的 AST 节点。请参阅 Ast。由 使用 AstInterpreter。
     **/
    public List<Node> getNodes() {
        return nodes;
    }

    /**
     * 使用 TemplateContext 呈现模板以解析模板中引用的变量值。
     **/
    public Object render(ExpressionTemplateContext context) {
        return AstInterpreter.interpret(this, context);
    }
}
