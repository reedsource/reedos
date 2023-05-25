package top.reed.cms.service.impl;

import com.alibaba.fastjson.JSON;
import org.apache.commons.compress.utils.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import top.reed.cms.domain.Album;
import top.reed.cms.domain.AlbumMaterial;
import top.reed.cms.domain.Material;
import top.reed.cms.domain.MaterialUse;
import top.reed.cms.mapper.AlbumMapper;
import top.reed.cms.mapper.MaterialMapper;
import top.reed.cms.service.IAlbumService;
import top.reed.cms.util.CmsConstants;
import top.reed.common.annotation.DataScope;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.Guid;
import top.reed.common.utils.ShiroUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 素材相册Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class AlbumServiceImpl implements IAlbumService {
    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private MaterialMapper materialMapper;

    /**
     * 查询素材专辑
     *
     * @param albumId 素材专辑ID
     * @return 素材专辑
     */
    @Override
    public Album selectAlbumById(String albumId) {
        return albumMapper.selectAlbumById(albumId);
    }

    /**
     * 查询素材专辑列表
     *
     * @param album 素材专辑
     * @return 素材专辑
     */
    @Override
    @DataScope(deptAlias = "a", userAlias = "a")
    public List<Album> selectAlbumList(Album album) {
        return albumMapper.selectAlbumList(album);
    }

    /**
     * 新增素材专辑
     *
     * @param album 素材专辑
     * @return 结果
     */
    @Override
    public int insertAlbum(Album album) {
        album.setAlbumId(Guid.get());
        SysUser user = ShiroUtils.getSysUser();
        album.setDeptId(user.getDeptId().toString());
        album.setUserId(user.getUserId().toString());
        album.setCreateBy(user.getUserName());
        album.setCreateTime(DateUtils.getNowDate());
        return albumMapper.insertAlbum(album);
    }

    /**
     * 修改素材专辑
     *
     * @param album 素材专辑
     * @return 结果
     */
    @Override
    public int updateAlbum(Album album) {
        album.setUpdateTime(DateUtils.getNowDate());
        return albumMapper.updateAlbum(album);
    }

    /**
     * 删除素材专辑对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteAlbumByIds(String ids) {
        return albumMapper.deleteAlbumByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除素材专辑信息
     *
     * @param albumId 素材专辑ID
     * @return 结果
     */
    @Override
    public int deleteAlbumById(String albumId) {
        return albumMapper.deleteAlbumById(albumId);
    }

    /**
     * 查询专辑【关联】的素材
     *
     * @param material 素材对象
     * @return 相册素材实体类集
     */
    @Override
    public List<AlbumMaterial> selectAlbumMaterialList(Material material) {

        return materialMapper.selectAlbumMaterialList(material);
    }

    /**
     * 查询专辑【未关联】的素材
     *
     * @param material 素材对象
     * @return 素材对象集
     */
    @Override
    public List<Material> selectAlbumUnMaterialList(Material material) {

        return materialMapper.selectAlbumUnMaterialList(material);
    }

    /**
     * 删除专辑关联的素材
     *
     * @param ids 待删除素材集
     */
    @Override
    @Transactional
    public void deleteMaterialBatch(String ids) {
        String[] arr = Convert.toStrArray(ids);
        //in查询全部素材
        List<AlbumMaterial> albumMaterials = albumMapper.selectAlbumMaterialByIds(arr);
        for (AlbumMaterial albumMaterial : albumMaterials) {
            materialMapper.deleteMaterialUseByMx(albumMaterial.getMaterialId(), "cms_album_material", albumMaterial.getAlbumId(), "album_id");
            int n = materialMapper.selectCountMaterialUse(albumMaterial.getMaterialId());
            if (n == 0) {
                materialMapper.updateMaterialUseState(albumMaterial.getMaterialId(), CmsConstants.USE_STATE_NO);
            }
        }
        albumMapper.deleteAlbumMaterialByIds(arr);
    }

    /**
     * 保存专辑关联的素材
     */
    @Override
    @Transactional
    public void saveMaterial(String albumId, String materialIds) {
        String[] addArr = Convert.toStrArray(materialIds);

        SysUser user = ShiroUtils.getSysUser();

        if (addArr.length > 0) {
            List<AlbumMaterial> list = Lists.newArrayList();
            AlbumMaterial albumMaterial;
            int i = 0;
            for (String s : addArr) {
                i++;
                albumMaterial = new AlbumMaterial();
                albumMaterial.setAlbumId(albumId);
                albumMaterial.setMaterialId(s);
                albumMaterial.setSort(Integer.toString(i));
                list.add(albumMaterial);
            }
            albumMapper.insertAlbumMaterialBatch(list);

            //插入使用记录 cms_material_use
            List<MaterialUse> useList = Lists.newArrayList();
            MaterialUse use;
            for (String s : addArr) {
                use = new MaterialUse();
                use.setUseId(albumId);
                use.setMaterialId(s);
                use.setUserId(user.getUserId().toString());
                use.setCreateBy(user.getUserName());
                use.setCreateTime(new Date());
                use.setUseTable(CmsConstants.MATERIAL_USE_ALBUM_TABLE_NAME);
                use.setUseColumn(CmsConstants.MATERIAL_USE_ALBUM_COLUMN_NAME);
                useList.add(use);
            }
            materialMapper.insertMaterialUseBatch(useList);

            //更新素材使用状态
            for (String mid : addArr) {
                materialMapper.updateMaterialUseState(mid, CmsConstants.USE_STATE_YES);
            }
        }

    }

    @Override
    public Map getAlbum(String code) {
        Album album = albumMapper.selectAlbumByCode(code);
        if (album != null) {
            Material queryForm = new Material();
            queryForm.setAlbumId(album.getAlbumId());
            List<AlbumMaterial> images = materialMapper.selectAlbumMaterialList(queryForm);
            album.setImages(images);
            return JSON.parseObject(JSON.toJSONString(album), Map.class);
        }
        return null;
    }
}
