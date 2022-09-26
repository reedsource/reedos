package top.reed.core.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import top.reed.core.model.DataSource;

import java.util.List;

public interface DataSourceMapper extends BaseMapper<DataSource>{
	
	@Select("select id,name from sp_datasource")
	List<DataSource> selectAll();

}
