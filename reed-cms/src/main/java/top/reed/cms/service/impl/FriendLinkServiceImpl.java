package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.FriendLink;
import top.reed.cms.mapper.FriendLinkMapper;
import top.reed.cms.service.IFriendLinkService;
import top.reed.common.core.text.Convert;

import java.util.List;

/**
 * 友情链接Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class FriendLinkServiceImpl implements IFriendLinkService {
	@Autowired
	private FriendLinkMapper friendLinkMapper;

	/**
	 * 查询友情链接
	 *
	 * @param id 友情链接ID
	 * @return 友情链接
	 */
	@Override
	public FriendLink selectFriendLinkById(Long id) {
		return friendLinkMapper.selectFriendLinkById(id);
	}

	/**
	 * 查询友情链接列表
	 *
	 * @param friendLink 友情链接
	 * @return 友情链接
	 */
	@Override
	public List<FriendLink> selectFriendLinkList(FriendLink friendLink) {
		return friendLinkMapper.selectFriendLinkList(friendLink);
	}

	/**
	 * 新增友情链接
	 *
	 * @param friendLink 友情链接
	 * @return 结果
	 */
	@Override
	public int insertFriendLink(FriendLink friendLink) {
		return friendLinkMapper.insertFriendLink(friendLink);
	}

	/**
	 * 修改友情链接
	 *
	 * @param friendLink 友情链接
	 * @return 结果
	 */
	@Override
	public int updateFriendLink(FriendLink friendLink) {
		return friendLinkMapper.updateFriendLink(friendLink);
	}

	/**
	 * 删除友情链接对象
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	@Override
	public int deleteFriendLinkByIds(String ids) {
		return friendLinkMapper.deleteFriendLinkByIds(Convert.toStrArray(ids));
	}

	/**
	 * 删除友情链接信息
	 *
	 * @param id 友情链接ID
	 * @return 结果
	 */
	@Override
	public int deleteFriendLinkById(Long id) {
		return friendLinkMapper.deleteFriendLinkById(id);
	}
}
