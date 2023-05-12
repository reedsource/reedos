package top.reed.cms.service;

import top.reed.cms.domain.Material;
import top.reed.cms.domain.MaterialUse;

import java.util.List;

/**
 * 素材Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IMaterialService {
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
     * 批量删除素材
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteMaterialByIds(String ids);

    /**
     * 删除素材信息
     *
     * @param materialId 素材ID
     * @return 结果
     */
    int deleteMaterialById(String materialId);

    /**
     * 批量审核素材
     *
     * @param ids 需要审核的数据ID
     * @return 结果
     */
    int auditMaterialByIds(String ids);

    /**
     * 查询素材使用记录
     */
    List<MaterialUse> selectMaterialUseList(MaterialUse materialUse);

    /**
     * 1.删除素材使用记录，2.更新素材表use_state字段 3删除使用地方的表的真实使用记录
     */
    void deleteMaterialUseBatch(MaterialUse materialUse);
}
