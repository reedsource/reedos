package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.MaterialGroup;
import top.reed.cms.mapper.MaterialGroupMapper;
import top.reed.cms.service.IMaterialGroupService;
import top.reed.common.core.domain.Ztree;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.ShiroUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 素材分组Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class MaterialGroupServiceImpl implements IMaterialGroupService {
    @Autowired
    private MaterialGroupMapper materialGroupMapper;

    /**
     * 查询素材分组
     *
     * @param groupId 素材分组ID
     * @return 素材分组
     */
    @Override
    public MaterialGroup selectMaterialGroupById(Long groupId) {
        return materialGroupMapper.selectMaterialGroupById(groupId);
    }

    /**
     * 查询素材分组列表
     *
     * @param materialGroup 素材分组
     * @return 素材分组
     */
    @Override
    public List<MaterialGroup> selectMaterialGroupList(MaterialGroup materialGroup) {
        return materialGroupMapper.selectMaterialGroupList(materialGroup);
    }

    /**
     * 新增素材分组
     *
     * @param materialGroup 素材分组
     * @return 结果
     */
    @Override
    public int insertMaterialGroup(MaterialGroup materialGroup) {
        SysUser user = ShiroUtils.getSysUser();
        materialGroup.setUserId(user.getUserId().toString());
        materialGroup.setCreateBy(user.getUserName());
        materialGroup.setDeptId(user.getDeptId().toString());
        materialGroup.setCreateTime(DateUtils.getNowDate());
        return materialGroupMapper.insertMaterialGroup(materialGroup);
    }

    /**
     * 修改素材分组
     *
     * @param materialGroup 素材分组
     * @return 结果
     */
    @Override
    public int updateMaterialGroup(MaterialGroup materialGroup) {
        materialGroup.setUpdateTime(DateUtils.getNowDate());
        return materialGroupMapper.updateMaterialGroup(materialGroup);
    }

    /**
     * 删除素材分组对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteMaterialGroupByIds(String ids) {
        return materialGroupMapper.deleteMaterialGroupByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除素材分组信息
     *
     * @param groupId 素材分组ID
     * @return 结果
     */
    @Override
    public int deleteMaterialGroupById(Long groupId) {
        return materialGroupMapper.deleteMaterialGroupById(groupId);
    }

    /**
     * 查询素材分组树列表
     *
     * @return 所有素材分组信息
     */
    @Override
    public List<Ztree> selectMaterialGroupTree() {
        List<MaterialGroup> materialGroupList = materialGroupMapper.selectMaterialGroupList(new MaterialGroup());
        List<Ztree> ztrees = new ArrayList<>();
        for (MaterialGroup materialGroup : materialGroupList) {
            Ztree ztree = new Ztree();
            ztree.setId(materialGroup.getGroupId());
            ztree.setpId(materialGroup.getParentId());
            ztree.setName(materialGroup.getGroupName());
            ztree.setTitle(materialGroup.getGroupName());
            ztrees.add(ztree);
        }
        return ztrees;
    }
}
