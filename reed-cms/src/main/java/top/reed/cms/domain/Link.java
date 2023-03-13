package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 链接对象 cms_link
 *
 * @author reedsource
 * date 2019-11-26
 */
@Getter
@Setter
public class Link extends BaseEntity {
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

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("linkId", getLinkId())
                .append("linkType", getLinkType())
                .append("linkName", getLinkName())
                .append("keywords", getKeywords())
                .append("link", getLink())
                .append("description", getDescription())
                .append("logo", getLogo())
                .append("auditState", getAuditState())
                .append("detail", getDetail())
                .append("sort", getSort())
                .append("upVote", getUpVote())
                .append("commentFlag", getCommentFlag())
                .append("status", getStatus())
                .toString();
    }
}
