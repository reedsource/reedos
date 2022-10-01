package top.reed.core.executor.function.extension;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Component;
import top.reed.api.annotation.Comment;
import top.reed.api.annotation.Example;
import top.reed.api.executor.FunctionExtension;

import java.util.Date;

@Component
public class DateFunctionExtension implements FunctionExtension {

	@Comment("格式化日期")
	@Example("${dateVar.format()}")
	public static String format(Date date) {
		return format(date, "yyyy-MM-dd HH:mm:ss");
	}

	@Comment("格式化日期")
	@Example("${dateVar.format('yyyy-MM-dd HH:mm:ss')}")
	public static String format(Date date, String pattern) {
		return DateFormatUtils.format(date, pattern);
	}

	@Override
	public Class<?> support() {
		return Date.class;
	}
}
