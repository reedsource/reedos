package top.reed.cms.service;

import top.reed.cms.domain.Ad;
import top.reed.cms.domain.AdMaterial;

import java.util.List;

/**
 * 广告位Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IAdService {
	/**
	 * 查询广告位
	 *
	 * @param adId 广告位ID
	 * @return 广告位
	 */
	Ad selectAdById(Long adId);

	/**
	 * 查询广告位列表
	 *
	 * @param ad 广告位
	 * @return 广告位集合
	 */
	List<Ad> selectAdList(Ad ad);

	/**
	 * 新增广告位
	 *
	 * @param ad 广告位
	 * @return 结果
	 */
	int insertAd(Ad ad);

	/**
	 * 修改广告位
	 *
	 * @param ad 广告位
	 * @return 结果
	 */
	int updateAd(Ad ad);

	/**
	 * 批量删除广告位
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteAdByIds(String ids);

	/**
	 * 删除广告位信息
	 *
	 * @param adId 广告位ID
	 * @return 结果
	 */
	int deleteAdById(Long adId);

	/*****************************************分割线****************************************************/
	/**
	 * 查询广告位素材
	 *
	 * @param id 广告位素材ID
	 * @return
	 */
	AdMaterial selectAdMaterialById(Long id);

	/**
	 * 查询广告位素材列表
	 *
	 * @param adMaterial
	 * @return
	 */
	List<AdMaterial> selectAdMaterialList(AdMaterial adMaterial);

	/**
	 * 新增广告位素材
	 *
	 * @param adMaterial 广告位
	 * @return 结果
	 */
	int insertAdMaterial(AdMaterial adMaterial);

	/**
	 * 修改广告位素材
	 *
	 * @param adMaterial 广告位
	 * @return 结果
	 */
	int updateAdMaterial(AdMaterial adMaterial);

	/**
	 * 批量删除广告位素材
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteAdMaterialByIds(String ids);


	/**
	 * 查询广告位未绑定的广告素材列表
	 *
	 * @param adMaterial
	 * @return
	 */
	List<AdMaterial> selectAdUnMaterialList(AdMaterial adMaterial);
}
