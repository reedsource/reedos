package top.reed.core.executor.function.extension;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import top.reed.api.annotation.Comment;
import top.reed.api.annotation.Example;
import top.reed.api.executor.FunctionExtension;

import java.util.Arrays;
import java.util.List;

@Component
public class ArrayFunctionExtension implements FunctionExtension {

    @Comment("获取数组的长度")
    @Example("${arrayVar.size()}")
    public static int size(Object[] objs) {
        return objs.length;
    }

    @Comment("将数组拼接起来")
    @Example("${arrayVar.join()}")
    public static String join(Object[] objs, String separator) {
        return StringUtils.join(objs, separator);
    }

    @Comment("将数组用separator拼接起来")
    @Example("${arrayVar.join('-')}")
    public static String join(Object[] objs) {
        return StringUtils.join(objs);
    }

    @Comment("将数组转为List")
    @Example("${arrayVar.toList()}")
    public static List<?> toList(Object[] objs) {
        return Arrays.asList(objs);
    }

    @Override
    public Class<?> support() {
        return Object[].class;
    }

}
