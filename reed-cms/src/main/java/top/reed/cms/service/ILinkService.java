package top.reed.cms.service;

import top.reed.cms.domain.Link;

import java.util.List;

/**
 * 链接Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ILinkService {
	/**
	 * 查询链接
	 *
	 * @param linkId 链接ID
	 * @return 链接
	 */
	Link selectLinkById(Long linkId);

	/**
	 * 查询链接列表
	 *
	 * @param link 链接
	 * @return 链接集合
	 */
	List<Link> selectLinkList(Link link);

	/**
	 * 新增链接
	 *
	 * @param link 链接
	 * @return 结果
	 */
	int insertLink(Link link);

	/**
	 * 修改链接
	 *
	 * @param link 链接
	 * @return 结果
	 */
	int updateLink(Link link);

	/**
	 * 批量删除链接
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteLinkByIds(String ids);

	/**
	 * 删除链接信息
	 *
	 * @param linkId 链接ID
	 * @return 结果
	 */
	int deleteLinkById(Long linkId);
}
