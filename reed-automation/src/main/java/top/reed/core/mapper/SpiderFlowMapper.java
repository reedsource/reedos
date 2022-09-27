package top.reed.core.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.*;
import top.reed.core.model.SpiderFlow;

import java.util.Date;
import java.util.List;

/**
 * 自动化任务资源库 实现自动化任务的入库
 * @author Administrator
 *
 */
@Mapper
public interface SpiderFlowMapper extends BaseMapper<SpiderFlow>{

	@Select({
			"<script>",
				"select",
					"id,name,enabled,create_date",
				"from sp_flow sf",
				"<if test=\"name != null and name != ''\">",
					"where name like concat('%',#{name},'%')",
				"</if>",
				"order by create_date desc",
			"</script>"
	})
	IPage<SpiderFlow> selectSpiderPage(Page<SpiderFlow> page,@Param("name") String name);

	@Insert("insert into sp_flow(id,name,xml,enabled) values(#{id},#{name},#{xml},'0')")
	int insertSpiderFlow(@Param("id") String id, @Param("name") String name, @Param("xml") String xml);
	
	@Update("update sp_flow set name = #{name},xml = #{xml} where id = #{id}")
	int updateSpiderFlow(@Param("id") String id, @Param("name") String name, @Param("xml") String xml);

	@Update("update sp_flow set enabled = #{enabled} where id = #{id}")
	int resetSpiderStatus(@Param("id") String id, @Param("enabled") String enabled);
	
	@Select("select id,name from sp_flow")
	List<SpiderFlow> selectFlows();
	
	@Select("select id,name from sp_flow where id != #{id}")
	List<SpiderFlow> selectOtherFlows(@Param("id") String id);
	
	@Select("select COUNT(id) from sp_flow where id = #{id}")
	Integer getCountById(@Param("id")String id);
}
