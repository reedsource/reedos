package top.reed.cms.service.impl;


import org.apache.commons.compress.utils.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import top.reed.cms.domain.Ad;
import top.reed.cms.domain.AdMaterial;
import top.reed.cms.domain.MaterialUse;
import top.reed.cms.mapper.AdMapper;
import top.reed.cms.mapper.MaterialMapper;
import top.reed.cms.service.IAdService;
import top.reed.cms.util.CmsConstants;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.ShiroUtils;

import java.util.Date;
import java.util.List;

/**
 * 广告位Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class AdServiceImpl implements IAdService {
    @Autowired
    private AdMapper adMapper;
    @Autowired
    private MaterialMapper materialMapper;

    /**
     * 查询广告位
     *
     * @param adId 广告位ID
     * @return 广告位
     */
    @Override
    public Ad selectAdById(Long adId) {
        return adMapper.selectAdById(adId);
    }

    /**
     * 查询广告位列表
     *
     * @param ad 广告位
     * @return 广告位
     */
    @Override
    public List<Ad> selectAdList(Ad ad) {
        return adMapper.selectAdList(ad);
    }

    /**
     * 新增广告位
     *
     * @param ad 广告位
     * @return 结果
     */
    @Override
    public int insertAd(Ad ad) {
        ad.setCreateTime(DateUtils.getNowDate());
        return adMapper.insertAd(ad);
    }

    /**
     * 修改广告位
     *
     * @param ad 广告位
     * @return 结果
     */
    @Override
    public int updateAd(Ad ad) {
        ad.setUpdateTime(DateUtils.getNowDate());
        return adMapper.updateAd(ad);
    }

    /**
     * 删除广告位对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteAdByIds(String ids) {
        return adMapper.deleteAdByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除广告位信息
     *
     * @param adId 广告位ID
     * @return 结果
     */
    @Override
    public int deleteAdById(Long adId) {
        return adMapper.deleteAdById(adId);
    }

    /*****************************************分割线****************************************************/

    @Override
    public AdMaterial selectAdMaterialById(Long id) {
        return adMapper.selectAdMaterialById(id);
    }

    @Override
    public List<AdMaterial> selectAdMaterialList(AdMaterial adMaterial) {
        return adMapper.selectAdMaterialList(adMaterial);
    }

    @Override
    @Transactional
    public int insertAdMaterial(AdMaterial adMaterial) {
        //插入使用记录 cms_material_use
        MaterialUse use = new MaterialUse();
        SysUser user = ShiroUtils.getSysUser();
        use.setUseId(adMaterial.getAdId().toString());
        use.setMaterialId(adMaterial.getMaterialId());
        use.setUserId(user.getUserId().toString());
        use.setCreateBy(user.getUserName());
        use.setCreateTime(new Date());
        use.setUserId(user.getUserId().toString());
        use.setUseTable(CmsConstants.MATERIAL_USE_AD_TABLE_NAME);
        use.setUseColumn(CmsConstants.MATERIAL_USE_AD_COLUMN_NAME);
        materialMapper.insertMaterialUse(use);
        adMaterial.setUseHisId(Integer.parseInt(use.getId()));
        //更新素材使用状态
        materialMapper.updateMaterialUseState(adMaterial.getMaterialId(), CmsConstants.USE_STATE_YES);
        return adMapper.insertAdMaterial(adMaterial);
    }

    @Override
    public int updateAdMaterial(AdMaterial adMaterial) {
        return adMapper.updateAdMaterial(adMaterial);
    }

    @Override
    public int deleteAdMaterialByIds(String ids) {
        List<AdMaterial> list = adMapper.selectAdMaterialByIds(Convert.toStrArray(ids));
        List<String> idList = Lists.newArrayList();
        for (AdMaterial material : list) {
            idList.add(String.valueOf(material.getUseHisId()));
        }
        String[] useIds = idList.toArray(new String[idList.size()]);
        materialMapper.deleteMaterialUseBatch(useIds);
        for (AdMaterial material : list) {
            int n = materialMapper.selectCountMaterialUse(material.getMaterialId());
            if (n == 0) {
                materialMapper.updateMaterialUseState(material.getMaterialId(), CmsConstants.USE_STATE_NO);
            }
        }
        return adMapper.deleteAdMaterialByIds(Convert.toStrArray(ids));
    }

    @Override
    public List<AdMaterial> selectAdUnMaterialList(AdMaterial adMaterial) {
        return adMapper.selectAdUnMaterialList(adMaterial);
    }
}
