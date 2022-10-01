package top.reed.core.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.*;
import top.reed.automation.domain.AutoFlow;

import java.util.List;

/**
 * 自动化任务资源库 实现自动化任务的入库
 *
 * @author reedsource
 */
@Mapper
public interface AutoFlowMapper extends BaseMapper<AutoFlow> {

	@Select({
			"<script>",
			"select",
			"id,name,status,create_date",
			"from auto_flow sf",
			"<if test=\"name != null and name != ''\">",
			"where name like concat('%',#{name},'%')",
			"</if>",
			"order by create_date desc",
			"</script>"
	})
	IPage<AutoFlow> selectSpiderPage(Page<AutoFlow> page, @Param("name") String name);

	@Insert("insert into auto_flow(id,name,xml,status) values(#{id},#{name},#{xml},'0')")
	int insertSpiderFlow(@Param("id") String id, @Param("name") String name, @Param("xml") String xml);

	@Update("update auto_flow set name = #{name},xml = #{xml} where id = #{id}")
	int updateSpiderFlow(@Param("id") String id, @Param("name") String name, @Param("xml") String xml);

	@Update("update auto_flow set status = #{status} where id = #{id}")
	int resetSpiderStatus(@Param("id") String id, @Param("status") String status);

	@Select("select id,name from auto_flow")
	List<AutoFlow> selectFlows();

	@Select("select id,name from auto_flow where id != #{id}")
	List<AutoFlow> selectOtherFlows(@Param("id") String id);

	@Select("select COUNT(id) from auto_flow where id = #{id}")
	Integer getCountById(@Param("id") String id);
}
