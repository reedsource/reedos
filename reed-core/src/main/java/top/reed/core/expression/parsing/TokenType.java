package top.reed.core.expression.parsing;

import java.util.Arrays;
import java.util.Comparator;

/**
 * 令牌类型的枚举。令牌类型由错误消息的表示形式组成，并且可以选择指定CharacterStream用于识别令牌的文字。
 * 令牌类型根据其文字长度进行排序，以便将令牌类型与常见前缀（例如“<”和“<=”）轻松匹配。首先匹配文本较长的令牌类型。
 */
public enum TokenType {
    // @off
    TextBlock("a text block"),
    Period(".", "."),
    Comma(",", ","),
    Semicolon(";", ";"),
    Colon(":", ":"),
    Plus("+", "+"),
    Minus("-", "-"),
    Asterisk("*", "*"),
    ForwardSlash("/", "/"),
    PostSlash("\\", "\\"),
    Percentage("%", "%"),
    LeftParantheses("(", ")"),
    RightParantheses(")", ")"),
    LeftBracket("[", "["),
    RightBracket("]", "]"),
    LeftCurly("{", "{"),
    RightCurly("}"), // 特殊待遇！
    Less("<", "<"),
    Greater(">", ">"),
    LessEqual("<=", "<="),
    GreaterEqual(">=", ">="),
    Equal("==", "=="),
    NotEqual("!=", "!="),
    Assignment("=", "="),
    And("&&", "&&"),
    Or("||", "||"),
    Xor("^", "^"),
    Not("!", "!"),
    Questionmark("?", "?"),
    DoubleQuote("\"", "\""),
    SingleQuote("'", "'"),
    BooleanLiteral("true or false"),
    DoubleLiteral("双浮点数"),
    FloatLiteral("浮点数"),
    LongLiteral("一个长整数"),
    IntegerLiteral("an integer number"),
    ShortLiteral("a short integer number"),
    ByteLiteral("a byte integer number"),
    CharacterLiteral("a character"),
    StringLiteral("a string"),
    NullLiteral("null"),
    Identifier("an identifier");

    private static final TokenType[] values;

    static {
        // 按标记类型的文字长度对其进行排序。字符流使用此顺序首先匹配长度最长的令牌。
        values = TokenType.values();
        Arrays.sort(values, new Comparator<TokenType>() {
            @Override
            public int compare(TokenType o1, TokenType o2) {
                if (o1.literal == null && o2.literal == null) return 0;
                if (o1.literal == null && o2.literal != null) return 1;
                if (o1.literal != null && o2.literal == null) return -1;
                return o2.literal.length() - o1.literal.length();
            }
        });
    }

    private final String literal;
    private final String error;

    TokenType(String error) {
        this.literal = null;
        this.error = error;
    }

    TokenType(String literal, String error) {
        this.literal = literal;
        this.error = error;
    }

    /**
     * 返回一个令牌类型数组，根据其文字长度按降序排序。CharacterStream首先使用它来匹配具有最长文字的令牌类型。例如，“<=”将在“<”之前匹配。
     **/
    public static TokenType[] getSortedValues() {
        return values;
    }

    /**
     * 要匹配的文字可能为null
     **/
    public String getLiteral() {
        return literal;
    }

    /**
     * 在错误消息中报告此令牌类型时要使用的错误字符串
     **/
    public String getError() {
        return error;
    }
}
