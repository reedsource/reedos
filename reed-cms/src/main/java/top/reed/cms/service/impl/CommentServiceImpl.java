package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Comment;
import top.reed.cms.mapper.CommentMapper;
import top.reed.cms.service.ICommentService;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;

import java.util.List;

/**
 * 评论Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class CommentServiceImpl implements ICommentService {
    @Autowired
    private CommentMapper commentMapper;

    /**
     * 查询评论
     *
     * @param id 评论ID
     * @return 评论
     */
    @Override
    public Comment selectCommentById(Long id) {
        return commentMapper.selectCommentById(id);
    }

    /**
     * 查询评论列表
     *
     * @param comment 评论
     * @return 评论
     */
    @Override
    public List<Comment> selectCommentList(Comment comment) {
        return commentMapper.selectCommentList(comment);
    }

    @Override
    public List<Comment> selectComments(Comment comment) {
        return commentMapper.selectComments(comment);
    }

    /**
     * 新增评论
     *
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int insertComment(Comment comment) {
        comment.setCreateTime(DateUtils.getNowDate());
        return commentMapper.insertComment(comment);
    }

    /**
     * 修改评论
     *
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int updateComment(Comment comment) {
        comment.setUpdateTime(DateUtils.getNowDate());
        return commentMapper.updateComment(comment);
    }

    /**
     * 删除评论对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteCommentByIds(String ids) {
        return commentMapper.deleteCommentByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除评论信息
     *
     * @param id 评论ID
     * @return 结果
     */
    @Override
    public int deleteCommentById(Long id) {
        return commentMapper.deleteCommentById(id);
    }

    @Override
    public int upVote(String id) {
        return commentMapper.upVote(id);
    }
}
