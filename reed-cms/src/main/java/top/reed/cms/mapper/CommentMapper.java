package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Comment;

import java.util.List;

/**
 * 评论Mapper接口
 *
 * @author reedsource
 * date 2019-11-19
 */
@Mapper
public interface CommentMapper {
    /**
     * 查询评论
     *
     * @param id 评论ID
     * @return 评论
     */
    Comment selectCommentById(Long id);

    /**
     * 查询评论列表
     *
     * @param comment 评论
     * @return 评论集合
     */
    List<Comment> selectCommentList(Comment comment);


    /**
     * 用于前台查询评论列表
     *
     * @param comment 评论
     * @return 评论集合
     */
    List<Comment> selectComments(Comment comment);

    /**
     * 新增评论
     *
     * @param comment 评论
     * @return 结果
     */
    int insertComment(Comment comment);

    /**
     * 修改评论
     *
     * @param comment 评论
     * @return 结果
     */
    int updateComment(Comment comment);

    /**
     * 删除评论
     *
     * @param id 评论ID
     * @return 结果
     */
    int deleteCommentById(Long id);

    /**
     * 批量删除评论
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteCommentByIds(String[] ids);


    /**
     * 评论点赞+1
     */
    int upVote(String id);
}
