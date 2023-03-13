package top.reed.core.executor.function.extension;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import top.reed.api.annotation.Example;
import top.reed.api.executor.FunctionExtension;

import java.util.HashMap;
import java.util.Map;

@Component
public class SqlRowSetExtension implements FunctionExtension {
    public static Map<String, String[]> tableMetaMap = new HashMap<>();

    @Example("${rs.nextToMap()}")
    public static Map<String, Object> nextToMap(SqlRowSet sqlRowSet) {
        try {
            if (!sqlRowSet.next()) {
                return null;
            }
            String[] columnNames = sqlRowSet.getMetaData().getColumnNames();
            Map<String, Object> result = new HashMap<>();
            for (String columnName : columnNames) {
                result.put(columnName, sqlRowSet.getObject(columnName));
            }
            return result;
        } catch (Exception e) {
            ExceptionUtils.wrapAndThrow(e);
        }
        return null;
    }

    @Override
    public Class<?> support() {
        return SqlRowSet.class;
    }


}
