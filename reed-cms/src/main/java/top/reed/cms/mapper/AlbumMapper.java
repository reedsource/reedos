package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Album;
import top.reed.cms.domain.AlbumMaterial;

import java.util.List;

/**
 * 相册Mapper接口
 *
 * @author reedsource
 * date 2019-11-08
 */
@Mapper
public interface AlbumMapper {
	/**
	 * 查询专辑
	 *
	 * @param albumId 专辑ID
	 * @return 专辑
	 */
	Album selectAlbumById(String albumId);

	/**
	 * 查询专辑
	 *
	 * @param code 专辑编码
	 * @return 专辑
	 */
	Album selectAlbumByCode(String code);

	/**
	 * 查询专辑列表
	 *
	 * @param album 专辑
	 * @return 专辑集合
	 */
	List<Album> selectAlbumList(Album album);

	/**
	 * 新增专辑
	 *
	 * @param album 专辑
	 * @return 结果
	 */
	int insertAlbum(Album album);

	/**
	 * 插入专辑素材
	 *
	 * @param albumMaterial 专辑素材
	 * @return 结果
	 */
	int insertAlbumMaterial(AlbumMaterial albumMaterial);

	/**
	 * 批量插入专辑素材
	 *
	 * @param albumMaterials 专辑素材
	 * @return 结果
	 */
	int insertAlbumMaterialBatch(List<AlbumMaterial> albumMaterials);

	/**
	 * 修改专辑
	 *
	 * @param album 专辑
	 * @return 结果
	 */
	int updateAlbum(Album album);

	/**
	 * 删除专辑
	 *
	 * @param albumId 专辑ID
	 * @return 结果
	 */
	int deleteAlbumById(String albumId);

	/**
	 * 批量删除专辑
	 *
	 * @param albumIds 需要删除的数据ID
	 * @return 结果
	 */
	int deleteAlbumByIds(String[] albumIds);

	/**
	 * 批量删除专辑素材
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteAlbumMaterialByIds(String[] ids);


	List<AlbumMaterial> selectAlbumMaterialByIds(String[] ids);
}
