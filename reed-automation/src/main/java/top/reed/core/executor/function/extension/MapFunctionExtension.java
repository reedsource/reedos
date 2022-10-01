package top.reed.core.executor.function.extension;

import org.springframework.stereotype.Component;
import top.reed.api.annotation.Comment;
import top.reed.api.annotation.Example;
import top.reed.api.executor.FunctionExtension;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class MapFunctionExtension implements FunctionExtension {

	@Comment("将map转换为List")
	@Example("${mapmVar.toList('=')}")
	public static List<String> toList(Map<?, ?> map, String separator) {
		return map.entrySet().stream().map(entry -> entry.getKey() + separator + entry.getValue()).collect(Collectors.toList());
	}

	@Override
	public Class<?> support() {
		return Map.class;
	}
}
