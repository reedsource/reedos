package top.reed.core.expression.parsing;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import top.reed.core.expression.DynamicMethod;
import top.reed.core.expression.ExpressionError;
import top.reed.core.expression.ExpressionError.TemplateException;
import top.reed.core.expression.ExpressionTemplate;
import top.reed.core.expression.ExpressionTemplateContext;
import top.reed.core.expression.interpreter.AstInterpreter;
import top.reed.core.expression.interpreter.JavaReflection;
import top.reed.core.expression.interpreter.Reflection;
import top.reed.core.script.ScriptManager;

import javax.xml.transform.Source;
import java.io.IOException;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.util.*;


/**
 * 模板由解析器解析为抽象语法树（AST）节点。此类包含所有AST节点类型
 */
public abstract class Ast {

    /**
     * 所有AST节点的基类。节点最低限度地存储引用其在源中位置的Span。
     **/
    public abstract static class Node {
        private final Span span;

        public Node(Span span) {
            this.span = span;
        }

        /**
         * 返回引用此节点在源中的位置的跨度
         **/
        public Span getSpan() {
            return span;
        }

        @Override
        public String toString() {
            return span.getText();
        }

        public abstract Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException;
    }

    /**
     * 文本节点表示源中应该逐字发出的“未模板化”跨度。
     **/
    public static class Text extends Node {
        private final String content;

        public Text(Span text) {
            super(text);
            String unescapedValue = text.getText();
            StringBuilder builder = new StringBuilder();

            CharacterStream stream = new CharacterStream(unescapedValue);
            while (stream.hasMore()) {
                if (stream.match("\\{", true)) {
                    builder.append('{');
                } else if (stream.match("\\}", true)) {
                    builder.append('}');
                } else {
                    builder.append(stream.consume());
                }
            }
            content = builder.toString();
        }

        /**
         * 返回此文本节点的UTF-8表示形式
         **/
        public String getContent() {
            return content;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return null;
        }
    }

    /**
     * 所有表达式都是此节点类型的子类。表达式分为一元运算（！，-）、二元运算（+，-，*，/等）和三元运算（？：）
     */
    public abstract static class Expression extends Node {
        public Expression(Span span) {
            super(span);
        }
    }

    /**
     * 一元运算节点表示逻辑或数字的否定。
     **/
    public static class UnaryOperation extends Expression {

        private final UnaryOperator operator;
        private final Expression operand;

        public UnaryOperation(Token operator, Expression operand) {
            super(operator.getSpan());
            this.operator = UnaryOperator.getOperator(operator);
            this.operand = operand;
        }

        public UnaryOperator getOperator() {
            return operator;
        }

        public Expression getOperand() {
            return operand;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            Object operand = getOperand().evaluate(template, context);

            if (getOperator() == UnaryOperator.Negate) {
                if (operand instanceof Integer) {
                    return -(Integer) operand;
                } else if (operand instanceof Float) {
                    return -(Float) operand;
                } else if (operand instanceof Double) {
                    return -(Double) operand;
                } else if (operand instanceof Byte) {
                    return -(Byte) operand;
                } else if (operand instanceof Short) {
                    return -(Short) operand;
                } else if (operand instanceof Long) {
                    return -(Long) operand;
                } else {
                    ExpressionError.error("Operand of operator '" + getOperator().name() + "' must be a number, got " + operand, getSpan());
                    return null; // 从未达到
                }
            } else if (getOperator() == UnaryOperator.Not) {
                if (!(operand instanceof Boolean)) {
                    ExpressionError.error("Operand of operator '" + getOperator().name() + "' must be a boolean", getSpan());
                }
                return !(Boolean) operand;
            } else {
                return operand;
            }
        }

        public enum UnaryOperator {
            Not, Negate, Positive;

            public static UnaryOperator getOperator(Token op) {
                if (op.getType() == TokenType.Not) {
                    return UnaryOperator.Not;
                }
                if (op.getType() == TokenType.Plus) {
                    return UnaryOperator.Positive;
                }
                if (op.getType() == TokenType.Minus) {
                    return UnaryOperator.Negate;
                }
                ExpressionError.error("Unknown unary operator " + op + ".", op.getSpan());
                return null; // 从未达到
            }
        }
    }

    /**
     * 二进制运算表示算术运算符，如加法或除法，比较运算符，如小于或等于，逻辑运算符，如和，或赋值
     **/
    public static class BinaryOperation extends Expression {

        private final Expression leftOperand;
        private final BinaryOperator operator;
        private final Expression rightOperand;

        public BinaryOperation(Expression leftOperand, Token operator, Expression rightOperand) {
            super(operator.getSpan());
            this.leftOperand = leftOperand;
            this.operator = BinaryOperator.getOperator(operator);
            this.rightOperand = rightOperand;
        }

        public Expression getLeftOperand() {
            return leftOperand;
        }

        public BinaryOperator getOperator() {
            return operator;
        }

        public Expression getRightOperand() {
            return rightOperand;
        }

        private Object evaluateAddition(Object left, Object right) {
            if (left instanceof String || right instanceof String) {
                return left.toString() + right.toString();
            }
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() + ((Number) right).doubleValue();
            }
            if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() + ((Number) right).floatValue();
            }
            if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() + ((Number) right).longValue();
            }
            if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() + ((Number) right).intValue();
            }
            if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() + ((Number) right).shortValue();
            }
            if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() + ((Number) right).byteValue();
            }

            ExpressionError.error("Operands for addition operator must be numbers or strings, got " + left + ", " + right + ".", getSpan());
            return null; // 从未达到
        }

        private Object evaluateSubtraction(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() - ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() - ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() - ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() - ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() - ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() - ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for subtraction operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateMultiplication(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() * ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() * ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() * ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() * ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() * ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() * ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for multiplication operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateDivision(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() / ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() / ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() / ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() / ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() / ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() / ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for division operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateModulo(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() % ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() % ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() % ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() % ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() % ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() % ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for modulo operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private boolean evaluateLess(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() < ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() < ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() < ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() < ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() < ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() < ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for less operator must be numbers" + left + ", " + right + ".", getSpan());
                return false; // 从未达到
            }
        }

        private Object evaluateLessEqual(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() <= ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() <= ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() <= ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() <= ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() <= ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() <= ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for less/equal operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateGreater(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() > ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() > ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() > ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() > ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() > ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() > ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for greater operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateGreaterEqual(Object left, Object right) {
            if (left instanceof Double || right instanceof Double) {
                return ((Number) left).doubleValue() >= ((Number) right).doubleValue();
            } else if (left instanceof Float || right instanceof Float) {
                return ((Number) left).floatValue() >= ((Number) right).floatValue();
            } else if (left instanceof Long || right instanceof Long) {
                return ((Number) left).longValue() >= ((Number) right).longValue();
            } else if (left instanceof Integer || right instanceof Integer) {
                return ((Number) left).intValue() >= ((Number) right).intValue();
            } else if (left instanceof Short || right instanceof Short) {
                return ((Number) left).shortValue() >= ((Number) right).shortValue();
            } else if (left instanceof Byte || right instanceof Byte) {
                return ((Number) left).byteValue() >= ((Number) right).byteValue();
            } else {
                ExpressionError.error("Operands for greater/equal operator must be numbers" + left + ", " + right + ".", getSpan());
                return null; // 从未达到
            }
        }

        private Object evaluateAnd(Object left, ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            if (!(left instanceof Boolean)) {
                ExpressionError.error("Left operand must be a boolean, got " + left + ".", getLeftOperand().getSpan());
            }
            if (!(Boolean) left) {
                return false;
            }
            Object right = getRightOperand().evaluate(template, context);
            if (!(right instanceof Boolean)) {
                ExpressionError.error("Right operand must be a boolean, got " + right + ".", getRightOperand().getSpan());
            }
            return (Boolean) left && (Boolean) right;
        }

        private Object evaluateOr(Object left, ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            if (!(left instanceof Boolean)) {
                ExpressionError.error("Left operand must be a boolean, got " + left + ".", getLeftOperand().getSpan());
            }
            if ((Boolean) left) {
                return true;
            }
            Object right = getRightOperand().evaluate(template, context);
            if (!(right instanceof Boolean)) {
                ExpressionError.error("Right operand must be a boolean, got " + right + ".", getRightOperand().getSpan());
            }
            return (Boolean) left || (Boolean) right;
        }

        private Object evaluateXor(Object left, Object right) {
            if (!(left instanceof Boolean)) {
                ExpressionError.error("Left operand must be a boolean, got " + left + ".", getLeftOperand().getSpan());
            }
            if (!(right instanceof Boolean)) {
                ExpressionError.error("Right operand must be a boolean, got " + right + ".", getRightOperand().getSpan());
            }
            return (Boolean) left ^ (Boolean) right;
        }

        private Object evaluateEqual(Object left, Object right) {
            if (left != null) {
                return left.equals(right);
            }
            if (right != null) {
                return right.equals(left);
            }
            return true;
        }

        private Object evaluateNotEqual(Object left, Object right) {
            return !(Boolean) evaluateEqual(left, right);
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            if (getOperator() == BinaryOperator.Assignment) {
                if (!(getLeftOperand() instanceof VariableAccess)) {
                    ExpressionError.error("Can only assign to top-level variables in context.", getLeftOperand().getSpan());
                }
                Object value = getRightOperand().evaluate(template, context);
                context.set(((VariableAccess) getLeftOperand()).getVariableName().getText(), value);
                return null;
            }

            Object left = getLeftOperand().evaluate(template, context);
            Object right = getOperator() == BinaryOperator.And || getOperator() == BinaryOperator.Or ? null : getRightOperand().evaluate(template, context);

            switch (getOperator()) {
                case Addition:
                    return evaluateAddition(left, right);
                case Subtraction:
                    return evaluateSubtraction(left, right);
                case Multiplication:
                    return evaluateMultiplication(left, right);
                case Division:
                    return evaluateDivision(left, right);
                case Modulo:
                    return evaluateModulo(left, right);
                case Less:
                    return evaluateLess(left, right);
                case LessEqual:
                    return evaluateLessEqual(left, right);
                case Greater:
                    return evaluateGreater(left, right);
                case GreaterEqual:
                    return evaluateGreaterEqual(left, right);
                case Equal:
                    return evaluateEqual(left, right);
                case NotEqual:
                    return evaluateNotEqual(left, right);
                case And:
                    return evaluateAnd(left, template, context);
                case Or:
                    return evaluateOr(left, template, context);
                case Xor:
                    return evaluateXor(left, right);
                default:
                    ExpressionError.error("Binary operator " + getOperator().name() + " not implemented", getSpan());
                    return null;
            }
        }

        public enum BinaryOperator {
            Addition, Subtraction, Multiplication, Division, Modulo, Equal, NotEqual, Less, LessEqual, Greater, GreaterEqual, And, Or, Xor, Assignment;

            public static BinaryOperator getOperator(Token op) {
                if (op.getType() == TokenType.Plus) {
                    return BinaryOperator.Addition;
                }
                if (op.getType() == TokenType.Minus) {
                    return BinaryOperator.Subtraction;
                }
                if (op.getType() == TokenType.Asterisk) {
                    return BinaryOperator.Multiplication;
                }
                if (op.getType() == TokenType.ForwardSlash) {
                    return BinaryOperator.Division;
                }
                if (op.getType() == TokenType.Percentage) {
                    return BinaryOperator.Modulo;
                }
                if (op.getType() == TokenType.Equal) {
                    return BinaryOperator.Equal;
                }
                if (op.getType() == TokenType.NotEqual) {
                    return BinaryOperator.NotEqual;
                }
                if (op.getType() == TokenType.Less) {
                    return BinaryOperator.Less;
                }
                if (op.getType() == TokenType.LessEqual) {
                    return BinaryOperator.LessEqual;
                }
                if (op.getType() == TokenType.Greater) {
                    return BinaryOperator.Greater;
                }
                if (op.getType() == TokenType.GreaterEqual) {
                    return BinaryOperator.GreaterEqual;
                }
                if (op.getType() == TokenType.And) {
                    return BinaryOperator.And;
                }
                if (op.getType() == TokenType.Or) {
                    return BinaryOperator.Or;
                }
                if (op.getType() == TokenType.Xor) {
                    return BinaryOperator.Xor;
                }
                if (op.getType() == TokenType.Assignment) {
                    return BinaryOperator.Assignment;
                }
                ExpressionError.error("Unknown binary operator " + op + ".", op.getSpan());
                return null; // 从未达到
            }
        }
    }

    /**
     * 三元运算是一种缩写的if/then/else运算，相当于Java中的三元运算符
     **/
    public static class TernaryOperation extends Expression {
        private final Expression condition;
        private final Expression trueExpression;
        private final Expression falseExpression;

        public TernaryOperation(Expression condition, Expression trueExpression, Expression falseExpression) {
            super(new Span(condition.getSpan(), falseExpression.getSpan()));
            this.condition = condition;
            this.trueExpression = trueExpression;
            this.falseExpression = falseExpression;
        }

        public Expression getCondition() {
            return condition;
        }

        public Expression getTrueExpression() {
            return trueExpression;
        }

        public Expression getFalseExpression() {
            return falseExpression;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            Object condition = getCondition().evaluate(template, context);
            if (!(condition instanceof Boolean)) {
                ExpressionError.error("三元运算符的条件必须是布尔值，得到 " + condition + ".", getSpan());
            }
            return ((Boolean) condition) ? getTrueExpression().evaluate(template, context) : getFalseExpression().evaluate(template, context);
        }
    }

    /**
     * null文本，单个值为null
     **/
    public static class NullLiteral extends Expression {
        public NullLiteral(Span span) {
            super(span);
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return null;
        }
    }

    /**
     * 布尔文字，值为true和false
     **/
    public static class BooleanLiteral extends Expression {
        private final Boolean value;

        public BooleanLiteral(Span literal) {
            super(literal);
            this.value = Boolean.parseBoolean(literal.getText());
        }

        public Boolean getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 双精度浮点文字。必须标有d后缀，例如“1.0d”
     **/
    public static class DoubleLiteral extends Expression {
        private final Double value;

        public DoubleLiteral(Span literal) {
            super(literal);
            this.value = Double.parseDouble(literal.getText().substring(0, literal.getText().length() - 1));
        }

        public Double getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 单精度浮点literal。可以选择标记f后缀，例如“1.0f”
     **/
    public static class FloatLiteral extends Expression {
        private final Float value;

        public FloatLiteral(Span literal) {
            super(literal);
            String text = literal.getText();
            if (text.charAt(text.length() - 1) == 'f') {
                text = text.substring(0, text.length() - 1);
            }
            this.value = Float.parseFloat(text);
        }

        public Float getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 字节文字。必须标有b后缀，例如“123b”。
     **/
    public static class ByteLiteral extends Expression {
        private final Byte value;

        public ByteLiteral(Span literal) {
            super(literal);
            this.value = Byte.parseByte(literal.getText().substring(0, literal.getText().length() - 1));
        }

        public Byte getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 简短的文字。必须标有s后缀，例如“123s”。
     **/
    public static class ShortLiteral extends Expression {
        private final Short value;

        public ShortLiteral(Span literal) {
            super(literal);
            this.value = Short.parseShort(literal.getText().substring(0, literal.getText().length() - 1));
        }

        public Short getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 一个整数文本。
     **/
    public static class IntegerLiteral extends Expression {
        private final Integer value;

        public IntegerLiteral(Span literal) {
            super(literal);
            this.value = Integer.parseInt(literal.getText());
        }

        public Integer getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 一个长的整数文本。必须标有l后缀，例如“123l”。
     **/
    public static class LongLiteral extends Expression {
        private final Long value;

        public LongLiteral(Span literal) {
            super(literal);
            this.value = Long.parseLong(literal.getText().substring(0, literal.getText().length() - 1));
        }

        public Long getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 一种文字字符，用单引号括起来。支持转义序列\n、\r、\t、\'和\\。
     **/
    public static class CharacterLiteral extends Expression {
        private final Character value;

        public CharacterLiteral(Span literal) {
            super(literal);

            String text = literal.getText();
            if (text.length() > 3) {
                if (text.charAt(2) == 'n') {
                    value = '\n';
                } else if (text.charAt(2) == 'r') {
                    value = '\r';
                } else if (text.charAt(2) == 't') {
                    value = '\t';
                } else if (text.charAt(2) == '\\') {
                    value = '\\';
                } else if (text.charAt(2) == '\'') {
                    value = '\'';
                } else {
                    ExpressionError.error("Unknown escape sequence '" + literal.getText() + "'.", literal);
                    value = 0; // 从未达到
                }
            } else {
                this.value = literal.getText().charAt(1);
            }
        }

        public Character getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 字符串文字，用双引号括起来。支持转义序列\n、\r、\t、\“和\\
     **/
    public static class StringLiteral extends Expression {
        private final String value;

        public StringLiteral(Span literal) {
            super(literal);
            String text = getSpan().getText();
            String unescapedValue = text.substring(1, text.length() - 1);
            StringBuilder builder = new StringBuilder();

            CharacterStream stream = new CharacterStream(unescapedValue);
            while (stream.hasMore()) {
                if (stream.match("\\\\", true)) {
                    builder.append('\\');
                } else if (stream.match("\\n", true)) {
                    builder.append('\n');
                } else if (stream.match("\\r", true)) {
                    builder.append('\r');
                } else if (stream.match("\\t", true)) {
                    builder.append('\t');
                } else if (stream.match("\\\"", true)) {
                    builder.append('"');
                } else {
                    builder.append(stream.consume());
                }
            }
            value = builder.toString();
        }

        /**
         * 返回不带引号的文字
         **/
        public String getValue() {
            return value;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            return value;
        }
    }

    /**
     * 按名称表示顶级变量访问。例如，在表达式“a+1”中，a将被编码为VariableAccess节点。
     * 变量既可以读取（在表达式中），也可以写入（在赋值中）。查找变量值并将其写入ExpressionTemplateContext
     **/
    public static class VariableAccess extends Expression {
        public VariableAccess(Span name) {
            super(name);
        }

        public Span getVariableName() {
            return getSpan();
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) {
            Object value = context.get(getSpan().getText());
            //if (value == null) ExpressionError.error("找不到变量'" + getSpan().getText() + "'或变量值为null", getSpan());
            return value;
        }
    }

    /**
     * 表示形式为mapOrArray[keyOrIndex]的映射或数组元素访问。映射和数组只能从中读取。
     **/
    public static class MapOrArrayAccess extends Expression {
        private final Expression mapOrArray;
        private final Expression keyOrIndex;

        public MapOrArrayAccess(Span span, Expression mapOrArray, Expression keyOrIndex) {
            super(span);
            this.mapOrArray = mapOrArray;
            this.keyOrIndex = keyOrIndex;
        }

        /**
         * 返回一个必须计算为映射或数组的表达式。
         **/
        public Expression getMapOrArray() {
            return mapOrArray;
        }

        /**
         * 返回一个表达式，该表达式用作获取映射或数组元素的键或索引。
         **/
        public Expression getKeyOrIndex() {
            return keyOrIndex;
        }

        @SuppressWarnings("rawtypes")
        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            Object mapOrArray = getMapOrArray().evaluate(template, context);
            if (mapOrArray == null) {
                return null;
            }
            Object keyOrIndex = getKeyOrIndex().evaluate(template, context);
            if (keyOrIndex == null) {
                return null;
            }

            if (mapOrArray instanceof Map) {
                return ((Map) mapOrArray).get(keyOrIndex);
            } else if (mapOrArray instanceof List) {
                if (!(keyOrIndex instanceof Number)) {
                    ExpressionError.error("列表索引必须是整数，但" + keyOrIndex.getClass().getSimpleName(), getKeyOrIndex().getSpan());
                }
                int index = ((Number) keyOrIndex).intValue();
                return ((List) mapOrArray).get(index);
            } else {
                if (!(keyOrIndex instanceof Number)) {
                    ExpressionError.error("数组索引必须是整数，但为 " + keyOrIndex.getClass().getSimpleName(), getKeyOrIndex().getSpan());
                }
                int index = ((Number) keyOrIndex).intValue();
                if (mapOrArray instanceof int[]) {
                    return ((int[]) mapOrArray)[index];
                } else if (mapOrArray instanceof float[]) {
                    return ((float[]) mapOrArray)[index];
                } else if (mapOrArray instanceof double[]) {
                    return ((double[]) mapOrArray)[index];
                } else if (mapOrArray instanceof boolean[]) {
                    return ((boolean[]) mapOrArray)[index];
                } else if (mapOrArray instanceof char[]) {
                    return ((char[]) mapOrArray)[index];
                } else if (mapOrArray instanceof short[]) {
                    return ((short[]) mapOrArray)[index];
                } else if (mapOrArray instanceof long[]) {
                    return ((long[]) mapOrArray)[index];
                } else if (mapOrArray instanceof byte[]) {
                    return ((byte[]) mapOrArray)[index];
                } else if (mapOrArray instanceof String) {
                    return Character.toString(((String) mapOrArray).charAt(index));
                } else {
                    return ((Object[]) mapOrArray)[index];
                }
            }
        }
    }

    /**
     * 表示对窗体对象.member的成员（字段、方法或映射中的条目）的访问。只能从中读取成员
     **/
    public static class MemberAccess extends Expression {
        private final Expression object;
        private final Span name;
        private Object cachedMember;

        public MemberAccess(Expression object, Span name) {
            super(name);
            this.object = object;
            this.name = name;
        }

        /**
         * 返回要访问其成员的对象
         **/
        public Expression getObject() {
            return object;
        }

        /**
         * The name of the member.
         **/
        public Span getName() {
            return name;
        }

        /**
         * 返回Reflection.getField（Object，String）或Reflection.getMethod（Object，String，Object…）返回的缓存成员描述符。请参阅setCachedMember（Object）
         **/
        public Object getCachedMember() {
            return cachedMember;
        }

        /**
         * 将成员描述符设置为由Reflection.getField（Object，String）或Reflection.getMethod（Object，String，Object…）返回，
         * 以便更快地查找成员。在第一次评估此节点时由AstInterpreter调用。后续的求值可以使用缓存的描述符，从而避免了代价高昂的反射查找
         **/
        public void setCachedMember(Object cachedMember) {
            this.cachedMember = cachedMember;
        }

        @SuppressWarnings("rawtypes")
        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            Object object = getObject().evaluate(template, context);
            if (object == null) {
                return null;
            }

            // 数组长度的特殊情况
            if (object.getClass().isArray() && getName().getText().equals("length")) {
                return Array.getLength(object);
            }

            // map的特殊情况，允许使用map.key而不是map[key]
            if (object instanceof Map map) {
                return map.get(getName().getText());
            }

            Object field = getCachedMember();
            if (field != null) {
                try {
                    return Reflection.getInstance().getFieldValue(object, field);
                } catch (Throwable t) {
                    //  空 不处理
                }
            }
            String text = getName().getText();
            field = Reflection.getInstance().getField(object, text);
            if (field == null) {
                String methodName;
                if (text.length() > 1) {
                    methodName = text.substring(0, 1).toUpperCase() + text.substring(1);
                } else {
                    methodName = text.toUpperCase();
                }
                MemberAccess access = new MemberAccess(this.object, new Span("get" + methodName));
                MethodCall methodCall = new MethodCall(getName(), access, Collections.emptyList());
                try {
                    return methodCall.evaluate(template, context);
                } catch (TemplateException e) {
                    if (ExceptionUtils.indexOfThrowable(e, InvocationTargetException.class) > -1) {
                        ExpressionError.error(String.format("在%s中调用方法get%s发生异常"
                                , object.getClass()
                                , methodName), getSpan(), e);
                        return null;
                    }
                    access = new MemberAccess(this.object, new Span("is" + methodName));
                    methodCall = new MethodCall(getName(), access, Collections.emptyList());
                    try {
                        return methodCall.evaluate(template, context);
                    } catch (TemplateException e1) {
                        if (ExceptionUtils.indexOfThrowable(e1, InvocationTargetException.class) > -1) {
                            ExpressionError.error(String.format("在%s中调用方法is%s发生异常"
                                    , object.getClass()
                                    , methodName), getSpan(), e);
                            return null;
                        }
                        ExpressionError.error(String.format("在%s中找不到属性%s或者方法get%s、方法is%s"
                                , object.getClass()
                                , getName().getText()
                                , methodName
                                , methodName), getSpan());
                    }
                }
            }
            setCachedMember(field);
            return Reflection.getInstance().getFieldValue(object, field);
        }
    }

    /**
     * 表示对顶级函数的调用。函数可以是存储在ExpressionTemplateContext中的FunctionalInterface，也可以是在模板中定义的。
     */
    public static class FunctionCall extends Expression {
        private final Expression function;
        private final List<Expression> arguments;
        private final ThreadLocal<Object[]> cachedArguments;
        private Object cachedFunction;

        public FunctionCall(Span span, Expression function, List<Expression> arguments) {
            super(span);
            this.function = function;
            this.arguments = arguments;
            this.cachedArguments = new ThreadLocal<>();
        }

        /**
         * 返回必须计算为FunctionalInterface或的表达式。
         **/
        public Expression getFunction() {
            return function;
        }

        /**
         * 返回要作为参数传递给函数的表达式列表
         **/
        public List<Expression> getArguments() {
            return arguments;
        }

        /**
         * 返回Reflection.getMethod（Object，String，Object…）或返回的缓存“函数”描述符。请参见setCachedFunction（对象）。
         **/
        public Object getCachedFunction() {
            return cachedFunction;
        }

        /**
         * 将Reflection.getMethod（Object、String、Object…）返回的“函数”描述符设置为更快的查找或要调用的。
         * 在第一次评估此节点时由AstInterpreter调用。后续的求值可以使用缓存的描述符，从而避免了代价高昂的反射查找
         **/
        public void setCachedFunction(Object cachedFunction) {
            this.cachedFunction = cachedFunction;
        }

        /**
         * 在AstInterpreter中调用函数时，返回一个临时缓冲区以存储参数。避免产生垃圾
         **/
        public Object[] getCachedArguments() {
            Object[] args = cachedArguments.get();
            if (args == null) {
                args = new Object[arguments.size()];
                cachedArguments.set(args);
            }
            return args;
        }

        /**
         * 必须在完成此节点的评估时调用，这样我们就不会泄露内存
         **/
        public void clearCachedArguments() {
            Object[] args = getCachedArguments();
            for (int i = 0; i < args.length; i++) {
                args[i] = null;
            }
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            try {
                Object[] argumentValues = getCachedArguments();
                List<Expression> arguments = getArguments();
                for (int i = 0, n = argumentValues.length; i < n; i++) {
                    Expression expr = arguments.get(i);
                    argumentValues[i] = expr.evaluate(template, context);
                }

                // 这是处理模板级宏的特殊情况。如果调用宏，由于在上下文中找不到函数名，因此计算函数表达式将导致异常。
                // 相反，我们需要手动检查函数表达式是否是VariableAccess，如果是，是否可以在上下文中找到它
                Object function;
                if (getFunction() instanceof VariableAccess varAccess) {
                    function = context.get(varAccess.getVariableName().getText());
                } else {
                    function = getFunction().evaluate(template, context);
                }

                if (function != null) {
                    Object method = getCachedFunction();
                    if (method != null) {
                        try {
                            return Reflection.getInstance().callMethod(function, method, argumentValues);
                        } catch (Throwable t) {
                            //  空 不处理
                        }
                    }
                    method = Reflection.getInstance().getMethod(function, null, argumentValues);
                    if (method == null) {
                        ExpressionError.error("Couldn't find function.", getSpan());
                    }
                    setCachedFunction(method);
                    try {
                        return Reflection.getInstance().callMethod(function, method, argumentValues);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        return null; // 从未达到
                    }
                } else if (ScriptManager.containsFunction(getFunction().getSpan().getText())) {
                    try {
                        return ScriptManager.eval(context, getFunction().getSpan().getText(), argumentValues);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        return null; // 从未达到
                    }
                } else {
                    ExpressionError.error("Couldn't find function " + getFunction(), getSpan());
                    return null; // 从未达到
                }
            } finally {
                clearCachedArguments();
            }
        }
    }

    /**
     * 表示对窗体对象.method（a，b，c）的方法的调用。
     **/
    public static class MethodCall extends Expression {
        private final MemberAccess method;
        private final List<Expression> arguments;
        private final ThreadLocal<Object[]> cachedArguments;
        private Object cachedMethod;

        public MethodCall(Span span, MemberAccess method, List<Expression> arguments) {
            super(span);
            this.method = method;
            this.arguments = arguments;
            this.cachedArguments = new ThreadLocal<>();
        }

        /**
         * 返回要调用该方法的对象
         **/
        public Expression getObject() {
            return method.getObject();
        }

        /**
         * 返回要调用的方法
         **/
        public MemberAccess getMethod() {
            return method;
        }

        /**
         * 返回要作为参数传递给函数的表达式列表
         **/
        public List<Expression> getArguments() {
            return arguments;
        }

        /**
         * 返回Reflection.getMethod（Object，String，Object…）返回的缓存成员描述符。
         **/
        public Object getCachedMethod() {
            return cachedMethod;
        }

        /**
         * 将方法描述符设置为Reflection.getMethod（Object，String，Object…）返回的值，以加快查找速度。
         * 在第一次评估此节点时由AstInterpreter调用。后续的求值可以使用缓存的描述符，从而避免了代价高昂的反射查找。
         **/
        public void setCachedMethod(Object cachedMethod) {
            this.cachedMethod = cachedMethod;
        }

        /**
         * 在AstInterpreter中调用函数时，返回一个临时缓冲区以存储参数。避免产生垃圾。
         **/
        public Object[] getCachedArguments() {
            Object[] args = cachedArguments.get();
            if (args == null) {
                args = new Object[arguments.size()];
                cachedArguments.set(args);
            }
            return args;
        }

        /**
         * 必须在完成此节点的评估时调用，这样我们就不会泄露内存
         **/
        public void clearCachedArguments() {
            Object[] args = getCachedArguments();
            for (int i = 0; i < args.length; i++) {
                args[i] = null;
            }
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            try {
                Object object = getObject().evaluate(template, context);
                if (object == null) {
                    return null;
                }

                Object[] argumentValues = getCachedArguments();
                List<Expression> arguments = getArguments();
                for (int i = 0, n = argumentValues.length; i < n; i++) {
                    Expression expr = arguments.get(i);
                    argumentValues[i] = expr.evaluate(template, context);
                }
                if (object instanceof DynamicMethod) {
                    try {
                        Object method = DynamicMethod.class.getDeclaredMethod("execute", String.class, List.class);
                        Object[] newArgumentValues = new Object[]{getMethod().getName().getText(), Arrays.asList(argumentValues)};
                        return Reflection.getInstance().callMethod(object, method, newArgumentValues);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        return null; // 从未达到
                    }
                }

                // 否则，请尝试查找指向lambda的相应方法或字段
                Object method = getCachedMethod();
                if (method != null) {
                    try {
                        return Reflection.getInstance().callMethod(object, method, argumentValues);
                    } catch (Throwable t) {
                        //  空 不处理
                    }
                }

                method = Reflection.getInstance().getMethod(object, getMethod().getName().getText(), argumentValues);
                if (method != null) {
                    //在对象上找到方法，调用它
                    setCachedMethod(method);
                    try {
                        return Reflection.getInstance().callMethod(object, method, argumentValues);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        return null; // 从未达到
                    }
                }
                method = Reflection.getInstance().getExtensionMethod(object, getMethod().getName().getText(), argumentValues);
                if (method != null) {
                    try {
                        int argumentLength = argumentValues == null ? 0 : argumentValues.length;
                        Object[] parameters = new Object[argumentLength + 1];
                        if (argumentLength > 0) {
                            System.arraycopy(argumentValues, 0, parameters, 1, argumentLength);
                        }
                        parameters[0] = object;
                        if (object.getClass().isArray()) {
                            Object[] objs = new Object[Array.getLength(object)];
                            for (int i = 0, len = objs.length; i < len; i++) {
                                Array.set(objs, i, Array.get(object, i));
                            }
                            parameters[0] = objs;
                        }
                        return Reflection.getInstance().callMethod(object, method, parameters);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        //  空 不处理
                        return null;
                    }
                } else {
                    // 在对象上找不到方法，请尝试查找指向lambda的字段
                    Object field = Reflection.getInstance().getField(object, getMethod().getName().getText());
                    if (field == null) {
                        ExpressionError.error("在'" + object.getClass() + "'中找不到方法 " + getMethod().getName().getText() + "(" + StringUtils.join(JavaReflection.getStringTypes(argumentValues), ",") + ")",
                                getSpan());
                    }
                    Object function = Reflection.getInstance().getFieldValue(object, field);
                    method = Reflection.getInstance().getMethod(function, null, argumentValues);
                    if (method == null) {
                        ExpressionError.error("在'" + object.getClass() + "'中找不到方法 " + getMethod().getName().getText() + "(" + StringUtils.join(JavaReflection.getStringTypes(argumentValues), ",") + ")",
                                getSpan());
                    }
                    try {
                        return Reflection.getInstance().callMethod(function, method, argumentValues);
                    } catch (Throwable t) {
                        ExpressionError.error(t.getMessage(), getSpan(), t);
                        return null; // 从未达到
                    }
                }
            } finally {
                clearCachedArguments();
            }
        }
    }

    /**
     * 表示可以嵌套的形式为｛key:value，key2:value，…｝的映射文本
     */
    public static class MapLiteral extends Expression {
        private final List<Token> keys;
        private final List<Expression> values;

        public MapLiteral(Span span, List<Token> keys, List<Expression> values) {
            super(span);
            this.keys = keys;
            this.values = values;
        }

        public List<Token> getKeys() {
            return keys;
        }

        public List<Expression> getValues() {
            return values;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0, n = keys.size(); i < n; i++) {
                Object value = values.get(i).evaluate(template, context);
                Token tokenKey = keys.get(i);
                String key = tokenKey.getSpan().getText();
                if (tokenKey.getType() == TokenType.StringLiteral) {
                    key = (String) new StringLiteral(tokenKey.getSpan()).evaluate(template, context);
                } else if (key != null && key.startsWith("$")) {
                    Object objKey = context.get(key.substring(1));
                    if (objKey != null) {
                        key = objKey.toString();
                    } else {
                        key = null;
                    }
                }
                map.put(key, value);
            }
            return map;
        }
    }

    /**
     * 表示可以嵌套的[value，value2，value3，…]形式的列表文字
     */
    public static class ListLiteral extends Expression {
        public final List<Expression> values;

        public ListLiteral(Span span, List<Expression> values) {
            super(span);
            this.values = values;
        }

        public List<Expression> getValues() {
            return values;
        }

        @Override
        public Object evaluate(ExpressionTemplate template, ExpressionTemplateContext context) throws IOException {
            List<Object> list = new ArrayList<>();
            for (Expression value : values) {
                list.add(value.evaluate(template, context));
            }
            return list;
        }
    }

}
