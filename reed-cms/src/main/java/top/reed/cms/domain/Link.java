package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 链接对象 cms_link
 *
 * @author reedsource
 * date 2019-11-26
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Link extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 链接ID
     */
    private Long linkId;

    /**
     * 链接分类
     */
    @Excel(name = "链接分类")
    private String linkType;

    /**
     * 链接名称
     */
    @Excel(name = "链接名称")
    private String linkName;

    /**
     * 关键词
     */
    @Excel(name = "关键词")
    private String keywords;

    /**
     * 链接
     */
    @Excel(name = "链接")
    private String link;

    /**
     * 描述
     */
    private String description;

    /**
     * Logo
     */
    @Excel(name = "Logo")
    private String logo;

    /**
     * 审核状态
     */
    @Excel(name = "审核状态")
    private Integer auditState;

    /**
     * 详情
     */
    private String detail;

    /**
     * 排序
     */
    @Excel(name = "排序")
    private Long sort;

    /**
     * 点赞数
     */
    @Excel(name = "点赞数")
    private Long upVote;

    /**
     * 允许评论
     */
    @Excel(name = "允许评论")
    private Integer commentFlag;

    /**
     * 状态
     */
    @Excel(name = "状态")
    private Integer status;

}
