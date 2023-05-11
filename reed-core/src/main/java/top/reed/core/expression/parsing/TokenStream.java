package top.reed.core.expression.parsing;

import top.reed.core.expression.ExpressionError;

import java.util.List;


/**
 * 在令牌实例列表上迭代，提供匹配预期令牌的方法，并在不匹配的情况下抛出错误
 */
public class TokenStream {
    private final List<Token> tokens;
    private final int end;
    private int index;

    public TokenStream(List<Token> tokens) {
        this.tokens = tokens;
        this.index = 0;
        this.end = tokens.size();
    }

    /**
     * 返回流中是否有更多令牌。
     **/
    public boolean hasMore() {
        return index < end;
    }

    public boolean hasNext() {
        return index + 1 < end;
    }

    public boolean hasPrev() {
        return index > 0;
    }

    /**
     * 消耗下一个令牌并将其返回。
     **/
    public Token consume() {
        if (!hasMore()) throw new RuntimeException("Reached the end of the source.");
        return tokens.get(index++);
    }

    public Token next() {
        if (!hasMore()) throw new RuntimeException("Reached the end of the source.");
        return tokens.get(++index);
    }

    public Token prev() {
        if (index == 0) {
            throw new RuntimeException("Reached the end of the source.");
        }
        return tokens.get(--index);
    }

    /**
     * 检查下一个令牌是否具有给定类型并可选地消耗，或者如果下一个标记与该类型不匹配则抛出错误。
     */
    public Token expect(TokenType type) {
        boolean result = match(type, true);
        if (!result) {
            Token token = index < tokens.size() ? tokens.get(index) : null;
            Span span = token != null ? token.getSpan() : null;
            if (span == null)
                ExpressionError.error("Expected '" + type.getError() + "', but reached the end of the source.", this);
            else
                ExpressionError.error("Expected '" + type.getError() + "', but got '" + token.getText() + "'", span);
            return null; // 从未达到
        } else {
            return tokens.get(index - 1);
        }
    }

    /**
     * 检查下一个令牌是否与给定的文本匹配并可选地消耗，或者如果下一个标记与文本不匹配则抛出错误。
     */
    public Token expect(String text) {
        boolean result = match(text, true);
        if (!result) {
            Token token = index < tokens.size() ? tokens.get(index) : null;
            Span span = token != null ? token.getSpan() : null;
            if (span == null)
                ExpressionError.error("Expected '" + text + "', but reached the end of the source.", this);
            else
                ExpressionError.error("Expected '" + text + "', but got '" + token.getText() + "'", span);
            return null; // 从未达到
        } else {
            return tokens.get(index - 1);
        }
    }

    /**
     * 匹配并在匹配的情况下选择性地消耗下一个令牌。返回令牌是否匹配。
     */
    public boolean match(TokenType type, boolean consume) {
        if (index >= end) return false;
        if (tokens.get(index).getType() == type) {
            if (consume) index++;
            return true;
        }
        return false;
    }

    /**
     * 匹配并在匹配的情况下选择性地消耗下一个令牌。返回令牌是否匹配。
     */
    public boolean match(String text, boolean consume) {
        if (index >= end) return false;
        if (tokens.get(index).getText().equals(text)) {
            if (consume) index++;
            return true;
        }
        return false;
    }

    /**
     * 匹配任何一种令牌类型，并在匹配的情况下选择性地使用下一个令牌。返回令牌是否匹配。
     */
    public boolean match(boolean consume, TokenType... types) {
        for (TokenType type : types) {
            if (match(type, consume)) return true;
        }
        return false;
    }

    /**
     * 匹配任何令牌文本，并在匹配的情况下选择性地使用下一个令牌。返回令牌是否匹配。
     */
    public boolean match(boolean consume, String... tokenTexts) {
        for (String text : tokenTexts) {
            if (match(text, consume)) return true;
        }
        return false;
    }

    /**
     * 返回此流包装的源
     */
    public String getSource() {
        if (tokens.size() == 0) return null;
        return tokens.get(0).getSpan().getSource();
    }
}
