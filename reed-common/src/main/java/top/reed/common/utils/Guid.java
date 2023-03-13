package top.reed.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Guid {
    public static String get() {
        StringBuilder now = new StringBuilder(new SimpleDateFormat(
                "yyyyMMddHHmmssSSS").format(new Date()));
        int n = (int) (Math.random() * 90000.0D + 10000.0D);
        return now.append(n).toString();
    }
}
