package top.reed.core.executor.function.extension;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Component;
import top.reed.core.annotation.Comment;
import top.reed.core.annotation.Example;
import top.reed.core.executor.FunctionExtension;
import top.reed.core.utils.ExtractUtils;

import java.util.Objects;

@Component
public class ObjectFunctionExtension implements FunctionExtension {

    @Comment("将对象转为string类型")
    @Example("${objVar.string()}")
    public static String string(Object obj) {
        if (obj instanceof String) {
            return (String) obj;
        }
        return Objects.toString(obj);
    }

    @Comment("根据jsonpath提取内容")
    @Example("${objVar.jsonpath('$.code')}")
    public static Object jsonpath(Object obj, String path) {
        if (obj instanceof String) {
            return ExtractUtils.getValueByJsonPath(JSON.parse((String) obj), path);
        }
        return ExtractUtils.getValueByJsonPath(obj, path);
    }

    @Comment("睡眠等待一段时间")
    @Example("${objVar.sleep(1000)}")
    public static Object sleep(Object obj, int millis) {
        try {
            Thread.sleep(millis);
        } catch (InterruptedException ignored) {
        }
        return obj;
    }

    @Override
    public Class<?> support() {
        return Object.class;
    }
}
