package top.reed.core.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import top.reed.core.model.AutoDataSource;

import java.util.List;

public interface AutoDataSourceMapper extends BaseMapper<AutoDataSource>{
	
	@Select("select id,name from auto_datasource")
	List<AutoDataSource> selectAll();

}
