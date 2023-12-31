package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 评论对象 cms_comment
 *
 * @author reedsource
 * date 2019-11-19
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Comment extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Long id;

    /**
     * 父ID
     */
    private Long pid;

    /**
     * 目标ID
     */
    @Excel(name = "目标ID")
    private String tid;

    /**
     * 呸数
     */
    private Integer numPei;

    /**
     * 喷子数
     */
    private Integer numPenzi;

    /**
     * 逗个数
     */
    private Integer numDou;

    /**
     * 给力数
     */
    private Integer numGeili;

    /**
     * 评论类型
     */
    @Excel(name = "评论类型")
    private String type;

    /**
     * 用户id
     */
    private String userId;

    /**
     * 用户名称
     */
    @Excel(name = "用户名称")
    private String userName;

    /**
     * 用户头像
     */
    @Excel(name = "用户头像")
    private String avatar;

    /**
     * 评论内容
     */
    private String content;

    /**
     * 点赞数
     */
    @Excel(name = "点赞数")
    private Long upVote;

    /**
     * 反对数
     */
    private Long downVote;

    /**
     * QQ
     */
    @Excel(name = "QQ")
    private String qq;

    /**
     * 邮箱
     */
    private String email;

    /**
     * IP
     */
    @Excel(name = "IP")
    private String ip;

    /**
     * 地址
     */
    @Excel(name = "地址")
    private String address;

    /**
     * 状态0正常
     */
    @Excel(name = "状态0正常")
    private Integer status;

    private Comment parent;//扩展字段

    private Article article;//扩展字段
}
