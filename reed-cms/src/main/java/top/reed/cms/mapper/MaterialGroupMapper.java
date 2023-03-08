package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.MaterialGroup;

import java.util.List;

/**
 * 素材分组Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface MaterialGroupMapper {
	/**
	 * 查询素材分组
	 *
	 * @param groupId 素材分组ID
	 * @return 素材分组
	 */
	MaterialGroup selectMaterialGroupById(Long groupId);

	/**
	 * 查询素材分组列表
	 *
	 * @param materialGroup 素材分组
	 * @return 素材分组集合
	 */
	List<MaterialGroup> selectMaterialGroupList(MaterialGroup materialGroup);

	/**
	 * 新增素材分组
	 *
	 * @param materialGroup 素材分组
	 * @return 结果
	 */
	int insertMaterialGroup(MaterialGroup materialGroup);

	/**
	 * 修改素材分组
	 *
	 * @param materialGroup 素材分组
	 * @return 结果
	 */
	int updateMaterialGroup(MaterialGroup materialGroup);

	/**
	 * 删除素材分组
	 *
	 * @param groupId 素材分组ID
	 * @return 结果
	 */
	int deleteMaterialGroupById(Long groupId);

	/**
	 * 批量删除素材分组
	 *
	 * @param groupIds 需要删除的数据ID
	 * @return 结果
	 */
	int deleteMaterialGroupByIds(String[] groupIds);
}
