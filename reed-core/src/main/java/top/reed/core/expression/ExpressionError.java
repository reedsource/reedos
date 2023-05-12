package top.reed.core.expression;

import top.reed.core.expression.parsing.Span;
import top.reed.core.expression.parsing.Span.Line;
import top.reed.core.expression.parsing.TokenStream;

import java.io.Serial;

/**
 * 表达式错误
 * 库报告的所有错误都通过此类的静态函数
 */
public class ExpressionError {

    /**
     * 根据提供的消息和流创建错误消息，突出显示发生错误的行。如果流具有更多令牌，则会突出显示下一个令牌。否则，流源的末尾将突出显示。
     * 抛出一个 RuntimeException
     */
    public static void error(String message, TokenStream stream) {
        if (stream.hasMore())
            error(message, stream.consume().getSpan());
        else {
            String source = stream.getSource();
            if (source == null)
                error(message, new Span(" ", 0, 1));
            else
                error(message, new Span(source, source.length() - 1, source.length()));
        }
    }

    /**
     * 据提供的消息和位置创建错误消息，突出显示发生错误的行中的位置。抛出一个 ExpressionError.TemplateException
     **/
    public static void error(String message, Span location, Throwable cause) {

        Line line = location.getLine();
        message = "Error (" + line.getLineNumber() + "): " + message + "\n\n" ;
        message += line.getText();
        message += "\n" ;

        int errorStart = location.getStart() - line.getStart();
        int errorEnd = errorStart + location.getText().length() - 1;
        for (int i = 0, n = line.getText().length(); i < n; i++) {
            boolean useTab = line.getText().charAt(i) == '\t';
            message += i >= errorStart && i <= errorEnd ? "^" : useTab ? "\t" : " " ;
        }

        if (cause == null)
            throw new TemplateException(message, location);
        else
            throw new TemplateException(message, location, cause);
    }

    /**
     * 据提供的消息和位置创建错误消息，突出显示发生错误的行中的位置。抛出一个 ExpressionError.TemplateException
     **/
    public static void error(String message, Span location) {
        error(message, location, null);
    }

    /**
     * 所有基础模板代码通过 引发 error(String, Span)的异常。如果在包含的模板列表中深处发生错误， getMessage() 该方法将返回压缩的错误消息。
     **/
    public static class TemplateException extends RuntimeException {
        @Serial
        private static final long serialVersionUID = 1L;
        private final Span location;
        private final String errorMessage;

        private TemplateException(String message, Span location) {
            super(message);
            this.errorMessage = message;
            this.location = location;
        }

        public TemplateException(String message, Span location, Throwable cause) {
            super(message, cause);
            this.errorMessage = message;
            this.location = location;
        }

        /**
         * 返回模板中发生错误的位置。
         **/
        public Span getLocation() {
            return location;
        }

        @Override
        public String getMessage() {
            StringBuilder builder = new StringBuilder();

            if (getCause() == null || getCause() == this) {
                return super.getMessage();
            }

            builder.append(errorMessage, 0, errorMessage.indexOf('\n'));
            builder.append("\n");

            Throwable cause = getCause();
            while (cause != null && cause != this) {
                if (cause instanceof TemplateException ex) {
                    if (ex.getCause() == null || ex.getCause() == ex)
                        builder.append(ex.errorMessage);
                    else
                        builder.append(ex.errorMessage, 0, ex.errorMessage.indexOf('\n'));
                    builder.append("\n");
                }
                cause = cause.getCause();
            }
            return builder.toString();
        }
    }

    public static class StringLiteralException extends RuntimeException {

        @Serial
        private static final long serialVersionUID = 1L;

    }
}
