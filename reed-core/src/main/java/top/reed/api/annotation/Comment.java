package top.reed.api.annotation;

import java.lang.annotation.*;

/**
 * 该注解用来标注自定义的方法注释，用来页面代码提示
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface Comment {
    String value();
}
