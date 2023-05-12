package top.reed.core.expression.parsing;

/**
 * 令牌生成器生成的令牌
 */
public class Token {
    private final TokenType type;
    private final Span span;

    public Token(TokenType type, Span span) {
        this.type = type;
        this.span = span;
    }

    public TokenType getType() {
        return type;
    }

    public Span getSpan() {
        return span;
    }

    public String getText() {
        return span.getText();
    }

    @Override
    public String toString() {
        return "Token [type=" + type + ", span=" + span + "]" ;
    }
}
