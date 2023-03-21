package top.reed.core.serializer;

import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.ObjectSerializer;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.math.BigInteger;

/**
 * 快速Json序列化程序
 */
public class FastJsonSerializer implements ObjectSerializer {

    public static SerializeConfig serializeConfig;

    static {
        serializeConfig = new SerializeConfig();
        FastJsonSerializer serializer = new FastJsonSerializer();
        serializeConfig.put(Long.TYPE, serializer);
        serializeConfig.put(Long.class, serializer);
        serializeConfig.put(BigDecimal.class, serializer);
        serializeConfig.put(BigInteger.class, serializer);
    }

    @Override
    public void write(JSONSerializer serializer, Object object, Object fieldName, Type fieldType, int features) {
        if (object == null) {
            if (serializer.isEnabled(SerializerFeature.WriteNullNumberAsZero)) {
                serializer.out.write("0");
            } else {
                serializer.out.writeNull();
            }
            return;
        }
        serializer.out.writeString(object.toString());
    }
}
