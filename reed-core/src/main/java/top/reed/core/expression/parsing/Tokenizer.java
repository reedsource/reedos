package top.reed.core.expression.parsing;

import top.reed.core.expression.ExpressionError;
import top.reed.core.expression.ExpressionError.StringLiteralException;
import top.reed.core.expression.ExpressionError.TemplateException;

import java.util.ArrayList;
import java.util.List;


public class Tokenizer {

    private static List<Token> tokenizeCodeSpan(Span span) {
        String source = span.getSource();
        CharacterStream stream = new CharacterStream(source, span.getStart(), span.getEnd());
        List<Token> tokens = new ArrayList<Token>();

        // 匹配开始标签并将其扔掉
        if (!stream.match("${", true))
            ExpressionError.error("Expected ${", new Span(source, stream.getPosition(), stream.getPosition() + 1));
        int leftCount = 0;
        int rightCount = 0;
        outer:
        while (stream.hasMore()) {
            // 跳过空格
            stream.skipWhiteSpace();

            // 数字文字，包括整数和浮点数。数字文本可以由类型标识符后缀。
            if (stream.matchDigit(false)) {
                TokenType type = TokenType.IntegerLiteral;
                stream.startSpan();
                while (stream.matchDigit(true))
                    ;
                if (stream.match(TokenType.Period.getLiteral(), true)) {
                    type = TokenType.FloatLiteral;
                    while (stream.matchDigit(true))
                        ;
                }
                if (stream.match("b", true) || stream.match("B", true)) {
                    if (type == TokenType.FloatLiteral)
                        ExpressionError.error("Byte literal can not have a decimal point.", stream.endSpan());
                    type = TokenType.ByteLiteral;
                } else if (stream.match("s", true) || stream.match("S", true)) {
                    if (type == TokenType.FloatLiteral)
                        ExpressionError.error("Short literal can not have a decimal point.", stream.endSpan());
                    type = TokenType.ShortLiteral;
                } else if (stream.match("l", true) || stream.match("L", true)) {
                    if (type == TokenType.FloatLiteral)
                        ExpressionError.error("Long literal can not have a decimal point.", stream.endSpan());
                    type = TokenType.LongLiteral;
                } else if (stream.match("f", true) || stream.match("F", true)) {
                    type = TokenType.FloatLiteral;
                } else if (stream.match("d", true) || stream.match("D", true)) {
                    type = TokenType.DoubleLiteral;
                }
                Span numberSpan = stream.endSpan();
                tokens.add(new Token(type, numberSpan));
                continue;
            }

            // 字符串文字
            if (stream.match(TokenType.SingleQuote.getLiteral(), true)) {
                stream.startSpan();
                boolean matchedEndQuote = false;
                while (stream.hasMore()) {
                    //注意：像这样的转义序列 \n  是在StringLiteral中解析的
                    if (stream.match("\\", true)) {
                        stream.consume();
                    }
                    if (stream.match(TokenType.SingleQuote.getLiteral(), true)) {
                        matchedEndQuote = true;
                        break;
                    }
                    stream.consume();
                }
                if (!matchedEndQuote)
                    ExpressionError.error("字符串没有结束符'", stream.endSpan(), new StringLiteralException());
                Span stringSpan = stream.endSpan();
                stringSpan = new Span(stringSpan.getSource(), stringSpan.getStart() - 1, stringSpan.getEnd());
                tokens.add(new Token(TokenType.StringLiteral, stringSpan));
                continue;
            }

            // 字符串文字
            if (stream.match(TokenType.DoubleQuote.getLiteral(), true)) {
                stream.startSpan();
                boolean matchedEndQuote = false;
                while (stream.hasMore()) {
                    //注意：像这样的转义序列 \n  是在StringLiteral中解析的
                    if (stream.match("\\", true)) {
                        stream.consume();
                    }
                    if (stream.match(TokenType.DoubleQuote.getLiteral(), true)) {
                        matchedEndQuote = true;
                        break;
                    }
                    stream.consume();
                }
                if (!matchedEndQuote)
                    ExpressionError.error("字符串没有结束符\"", stream.endSpan(), new StringLiteralException());
                Span stringSpan = stream.endSpan();
                stringSpan = new Span(stringSpan.getSource(), stringSpan.getStart() - 1, stringSpan.getEnd());
                tokens.add(new Token(TokenType.StringLiteral, stringSpan));
                continue;
            }

            // 标识符、关键字、布尔文字或null文字
            if (stream.matchIdentifierStart(true)) {
                stream.startSpan();
                while (stream.matchIdentifierPart(true))
                    ;
                Span identifierSpan = stream.endSpan();
                identifierSpan = new Span(identifierSpan.getSource(), identifierSpan.getStart() - 1, identifierSpan.getEnd());

                if (identifierSpan.getText().equals("true") || identifierSpan.getText().equals("false")) {
                    tokens.add(new Token(TokenType.BooleanLiteral, identifierSpan));
                } else if (identifierSpan.getText().equals("null")) {
                    tokens.add(new Token(TokenType.NullLiteral, identifierSpan));
                } else {
                    tokens.add(new Token(TokenType.Identifier, identifierSpan));
                }
                continue;
            }

            // 简单令牌
            for (TokenType t : TokenType.getSortedValues()) {
                if (t.getLiteral() != null) {
                    if (stream.match(t.getLiteral(), true)) {
                        if (t == TokenType.LeftCurly) {
                            leftCount++;
                        }
                        tokens.add(new Token(t, new Span(source, stream.getPosition() - t.getLiteral().length(), stream.getPosition())));
                        continue outer;
                    }
                }
            }
            if (leftCount != rightCount && stream.match("}", true)) {
                rightCount++;
                tokens.add(new Token(TokenType.RightCurly, new Span(source, stream.getPosition() - 1, stream.getPosition())));
                continue outer;
            }
            // 匹配结束标记
            if (stream.match("}", false)) break;

            ExpressionError.error("Unknown token", new Span(source, stream.getPosition(), stream.getPosition() + 1));
        }

        // 代码跨度必须以｝结尾
        if (!stream.match("}", true))
            ExpressionError.error("Expected }", new Span(source, stream.getPosition(), stream.getPosition() + 1));
        return tokens;
    }

    /**
     * 将源标记为具有TokenType的标记。未包含在｛｛｝｝中的文本块将作为类型为TokenType.TextBlock的单个令牌返回。
     * ｛{和｝}不会作为单独的令牌返回。请参阅TokenType以获取此令牌化器所理解的令牌列表
     */
    public List<Token> tokenize(String source) {
        List<Token> tokens = new ArrayList<Token>();
        if (source.length() == 0) return tokens;
        CharacterStream stream = new CharacterStream(source);
        stream.startSpan();

        RuntimeException re;
        while (stream.hasMore()) {
            if (stream.match("${", false)) {
                if (!stream.isSpanEmpty()) tokens.add(new Token(TokenType.TextBlock, stream.endSpan()));
                stream.startSpan();
                boolean isContinue = false;
                do {
                    while (!stream.match("}", true)) {
                        if (!stream.hasMore()) ExpressionError.error("Did not find closing }.", stream.endSpan());
                        stream.consume();
                    }
                    try {
                        tokens.addAll(tokenizeCodeSpan(stream.endSpan()));
                        isContinue = false;
                        re = null;
                    } catch (TemplateException e) {
                        re = e;
                        if (e.getCause() != null || stream.hasMore()) {
                            isContinue = true;
                        }
                    }

                } while (isContinue);
                if (re != null) {
                    throw re;
                }
                stream.startSpan();
            } else {
                stream.consume();
            }
        }
        if (!stream.isSpanEmpty()) tokens.add(new Token(TokenType.TextBlock, stream.endSpan()));
        return tokens;
    }
}
