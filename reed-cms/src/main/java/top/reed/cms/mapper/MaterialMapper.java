package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.reed.cms.domain.AlbumMaterial;
import top.reed.cms.domain.Material;
import top.reed.cms.domain.MaterialUse;

import java.util.List;

/**
 * 素材Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface MaterialMapper {
	/**
	 * 查询素材
	 *
	 * @param materialId 素材ID
	 * @return 素材
	 */
	Material selectMaterialById(String materialId);

	/**
	 * 查询素材列表
	 *
	 * @param material 素材
	 * @return 素材集合
	 */
	List<Material> selectMaterialList(Material material);

	/**
	 * 新增素材
	 *
	 * @param material 素材
	 * @return 结果
	 */
	int insertMaterial(Material material);

	/**
	 * 修改素材
	 *
	 * @param material 素材
	 * @return 结果
	 */
	int updateMaterial(Material material);

	/**
	 * 删除素材
	 *
	 * @param materialId 素材ID
	 * @return 结果
	 */
	int deleteMaterialById(String materialId);

	/**
	 * 批量删除素材
	 *
	 * @param materialIds 需要删除的数据ID
	 * @return 结果
	 */
	int deleteMaterialByIds(String[] materialIds);

	/**
	 * 批量审核素材
	 *
	 * @param materialIds 需要审核的数据ID
	 * @return 结果
	 */
	int auditMaterialByIds(String[] materialIds);

	/**
	 * 根据ids查询素材
	 *
	 * @param materialIds 需要查询数据ID
	 * @return 结果
	 */
	List<Material> selectMaterialByIds(String[] materialIds);

	/**
	 * 查询专辑关联的素材
	 *
	 * @param material
	 * @return
	 */
	List<AlbumMaterial> selectAlbumMaterialList(Material material);

	/**
	 * 排除ids查询素材（查询专辑未关联的素材）
	 *
	 * @param material
	 * @return 结果
	 */
	List<Material> selectAlbumUnMaterialList(Material material);


	/**
	 * 插入使用记录
	 *
	 * @param materialUse
	 * @return
	 */

	int insertMaterialUse(MaterialUse materialUse);

	/**
	 * 批量插入使用记录
	 *
	 * @param materialUses
	 * @return
	 */

	int insertMaterialUseBatch(List<MaterialUse> materialUses);

	/**
	 * 查询素材使用记录
	 *
	 * @param materialUse
	 * @return
	 */
	List<MaterialUse> selectMaterialUseList(MaterialUse materialUse);

	/**
	 * 根据主键查询素材使用记录
	 *
	 * @param ids
	 * @return
	 */
	List<MaterialUse> selectMaterialUseByIds(String[] ids);

	/**
	 * 批量删除素材使用记录
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteMaterialUseBatch(String[] ids);

	/**
	 * 删除素材使用；注意和上面的方法区分，有本质的不同，请看sql
	 *
	 * @param materialUse
	 * @return
	 */
	int deleteMaterialUse(MaterialUse materialUse);

	int deleteMaterialUseByMx(@Param("materialId") String materialId, @Param("table") String table, @Param("useId") String useId, @Param("column") String column);


	/**
	 * 查询某个素材有几条使用记录（cms_material_use）
	 *
	 * @param materialId
	 * @return
	 */
	int selectCountMaterialUse(String materialId);

	/**
	 * 根据素材ids查询素材是否在使用（cms_material）
	 *
	 * @param materialIds
	 * @return
	 */
	int selectCountUse(String[] materialIds);

	/**
	 * 更新素材的使用状态
	 *
	 * @param materialId
	 * @param useState
	 * @return
	 */
	int updateMaterialUseState(@Param("materialId") String materialId, @Param("useState") String useState);
}
