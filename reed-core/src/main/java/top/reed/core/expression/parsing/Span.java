package top.reed.core.expression.parsing;

/**
 * 源字符串中的跨度，由起始索引和结束索引表示，后者是互斥的。
 */
public class Span {
    /**
     * 此跨度所指的源字符串
     **/
    private final String source;
    /**
     * 缓存字符串实例以减轻GC的压力
     **/
    private final String cachedText;
    /**
     * 源字符串中的起始索引，从0开始
     **/
    private final int start;
    /**
     * 源字符串中的结束索引，独占，从0开始
     **/
    private final int end;

    public Span(String source) {
        this(source, 0, source.length());
    }

    public Span(String source, int start, int end) {
        if (start > end) throw new IllegalArgumentException("Start must be <= end.");
        if (start < 0) throw new IndexOutOfBoundsException("Start must be >= 0.");
        if (start > source.length() - 1)
            throw new IndexOutOfBoundsException("Start outside of string.");
        if (end > source.length()) throw new IndexOutOfBoundsException("End outside of string.");

        this.source = source;
        this.start = start;
        this.end = end;
        this.cachedText = source.substring(start, end);
    }

    public Span(Span start, Span end) {
        if (!start.source.equals(end.source))
            throw new IllegalArgumentException("这两个跨度不引用同一个源。");
        if (start.start > end.end) throw new IllegalArgumentException("Start must be <= end.");
        if (start.start < 0) throw new IndexOutOfBoundsException("Start must be >= 0.");
        if (start.start > start.source.length() - 1) throw new IndexOutOfBoundsException("Start outside of string.");
        if (end.end > start.source.length()) throw new IndexOutOfBoundsException("End outside of string.");

        this.source = start.source;
        this.start = start.start;
        this.end = end.end;
        this.cachedText = source.substring(this.start, this.end);
    }

    /**
     * 返回此跨度引用的文本
     **/
    public String getText() {
        return cachedText;
    }

    /**
     * 返回此跨度的第一个字符的索引
     **/
    public int getStart() {
        return start;
    }

    /**
     * 返回此跨度的最后一个字符的索引加1
     **/
    public int getEnd() {
        return end;
    }

    /**
     * 返回此跨度引用的源字符串
     **/
    public String getSource() {
        return source;
    }

    @Override
    public String toString() {
        return "Span [text=" + getText() + ", start=" + start + ", end=" + end + "]" ;
    }

    /**
     * 返回此跨度所在的行。对于跨多行的跨度，不返回正确的结果
     **/
    public Line getLine() {
        int lineStart = start;
        while (true) {
            if (lineStart < 0) break;
            char c = source.charAt(lineStart);
            if (c == '\n') {
                lineStart = lineStart + 1;
                break;
            }
            lineStart--;
        }
        if (lineStart < 0) lineStart = 0;

        int lineEnd = end;
        while (true) {
            if (lineEnd > source.length() - 1) break;
            char c = source.charAt(lineEnd);
            if (c == '\n') {
                break;
            }
            lineEnd++;
        }

        int lineNumber = 0;
        int idx = lineStart;
        while (idx > 0) {
            char c = source.charAt(idx);
            if (c == '\n') {
                lineNumber++;
            }
            idx--;
        }
        lineNumber++;

        return new Line(source, lineStart, lineEnd, lineNumber);
    }

    /**
     * 源中的一行
     **/
    public static class Line {
        private final String source;
        private final int start;
        private final int end;
        private final int lineNumber;

        public Line(String source, int start, int end, int lineNumber) {
            this.source = source;
            this.start = start;
            this.end = end;
            this.lineNumber = lineNumber;
        }

        public String getSource() {
            return source;
        }

        public int getStart() {
            return start;
        }

        public int getEnd() {
            return end;
        }

        public int getLineNumber() {
            return lineNumber;
        }

        public String getText() {
            return source.substring(start, end);
        }
    }
}
