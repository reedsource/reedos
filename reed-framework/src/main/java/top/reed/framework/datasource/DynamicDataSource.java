package top.reed.framework.datasource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import top.reed.common.config.datasource.DynamicDataSourceContextHolder;

import javax.sql.DataSource;
import java.util.Map;

/**
 * 动态数据源
 *
 * @author reedsource
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    public DynamicDataSource(DataSource defaultTargetDataSource, Map<Object, Object> targetDataSources) {
        super.setDefaultTargetDataSource(defaultTargetDataSource);
        super.setTargetDataSources(targetDataSources);
        super.afterPropertiesSet();
    }

    @Override
    protected Object determineCurrentLookupKey() {
        return DynamicDataSourceContextHolder.getDataSourceType();
    }
}