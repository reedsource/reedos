package top.reed.cms.service;

import top.reed.cms.domain.MaterialGroup;
import top.reed.common.core.domain.Ztree;

import java.util.List;

/**
 * 素材分组Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IMaterialGroupService {
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
     * 批量删除素材分组
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteMaterialGroupByIds(String ids);

    /**
     * 删除素材分组信息
     *
     * @param groupId 素材分组ID
     * @return 结果
     */
    int deleteMaterialGroupById(Long groupId);

    /**
     * 查询素材分组树列表
     *
     * @return 所有素材分组信息
     */
    List<Ztree> selectMaterialGroupTree();
}
