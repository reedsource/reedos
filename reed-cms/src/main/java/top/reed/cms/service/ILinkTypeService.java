package top.reed.cms.service;

import top.reed.cms.domain.LinkType;

import java.util.List;

/**
 * 链接分类Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ILinkTypeService {
	/**
	 * 查询链接分类
	 *
	 * @param id 链接分类ID
	 * @return 链接分类
	 */
	LinkType selectLinkTypeById(Long id);

	/**
	 * 根据分类代码查询链接分类
	 *
	 * @param type 链接分类代码
	 * @return 链接分类
	 */
	LinkType selectLinkTypeByType(String type);

	/**
	 * 查询链接分类列表
	 *
	 * @param linkType 链接分类
	 * @return 链接分类集合
	 */
	List<LinkType> selectLinkTypeList(LinkType linkType);

	/**
	 * 新增链接分类
	 *
	 * @param linkType 链接分类
	 * @return 结果
	 */
	int insertLinkType(LinkType linkType);

	/**
	 * 修改链接分类
	 *
	 * @param linkType 链接分类
	 * @return 结果
	 */
	int updateLinkType(LinkType linkType);

	/**
	 * 批量删除链接分类
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteLinkTypeByIds(String ids);

	/**
	 * 删除链接分类信息
	 *
	 * @param id 链接分类ID
	 * @return 结果
	 */
	int deleteLinkTypeById(Long id);
}
