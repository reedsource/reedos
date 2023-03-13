package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.FriendLink;

import java.util.List;

/**
 * 友情链接Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface FriendLinkMapper {
    /**
     * 查询友情链接
     *
     * @param id 友情链接ID
     * @return 友情链接
     */
    FriendLink selectFriendLinkById(Long id);

    /**
     * 查询友情链接列表
     *
     * @param friendLink 友情链接
     * @return 友情链接集合
     */
    List<FriendLink> selectFriendLinkList(FriendLink friendLink);

    /**
     * 新增友情链接
     *
     * @param friendLink 友情链接
     * @return 结果
     */
    int insertFriendLink(FriendLink friendLink);

    /**
     * 修改友情链接
     *
     * @param friendLink 友情链接
     * @return 结果
     */
    int updateFriendLink(FriendLink friendLink);

    /**
     * 删除友情链接
     *
     * @param id 友情链接ID
     * @return 结果
     */
    int deleteFriendLinkById(Long id);

    /**
     * 批量删除友情链接
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteFriendLinkByIds(String[] ids);
}
