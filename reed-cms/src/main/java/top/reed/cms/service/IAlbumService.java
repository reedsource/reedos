package top.reed.cms.service;

import top.reed.cms.domain.Album;
import top.reed.cms.domain.AlbumMaterial;
import top.reed.cms.domain.Material;

import java.util.List;
import java.util.Map;

/**
 * 素材相册Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IAlbumService {
    /**
     * 查询素材专辑
     *
     * @param albumId 素材专辑ID
     * @return 素材专辑
     */
    Album selectAlbumById(String albumId);

    /**
     * 查询素材专辑列表
     *
     * @param album 素材专辑
     * @return 素材专辑集合
     */
    List<Album> selectAlbumList(Album album);

    /**
     * 新增素材专辑
     *
     * @param album 素材专辑
     * @return 结果
     */
    int insertAlbum(Album album);

    /**
     * 修改素材专辑
     *
     * @param album 素材专辑
     * @return 结果
     */
    int updateAlbum(Album album);

    /**
     * 批量删除素材专辑
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteAlbumByIds(String ids);

    /**
     * 删除素材专辑信息
     *
     * @param albumId 素材专辑ID
     * @return 结果
     */
    int deleteAlbumById(String albumId);

    /**
     * 专辑绑定的素材列表
     *
     * @param material
     * @return
     */
    List<AlbumMaterial> selectAlbumMaterialList(Material material);

    /**
     * 专辑未绑定的素材列表
     *
     * @param material
     * @return
     */
    List<Material> selectAlbumUnMaterialList(Material material);

    /**
     * 取消关联的素材
     *
     * @param ids
     */
    void deleteMaterialBatch(String ids);

    /**
     * 保存关联的素材
     *
     * @param albumId
     * @param materialIds
     */
    void saveMaterial(String albumId, String materialIds);

    /**
     * 获取一个专辑banner
     *
     * @param code
     * @return
     */
    Map getAlbum(String code);
}
