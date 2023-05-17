package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 文章模板对象 cms_article_template
 *
 * @author reedsource
 * date 2019-12-31
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ArticleTemplate extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 文章模板名称
     */
    @Excel(name = "文章模板名称")
    private String name;

    /**
     * 标签
     */
    @Excel(name = "标签")
    private String tags;

    private String tagNames;

    /**
     * 用户ID
     */
    private String userId;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 内容
     */
    private String content;

    /**
     * 共享类型
     */
    @Excel(name = "共享类型")
    private String shareType;

    /**
     * 权重
     */
    private Long weight;

    /**
     * 最热
     */
    private Integer hotFalg;

    /**
     * 最新
     */
    private Integer newFlag;

    /**
     * 审核标志
     */
    @Excel(name = "审核标志")
    private Integer audit;

    /**
     * 审核时间
     */
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date auditTime;

    /**
     * 审核人
     */
    private String auditBy;

    /**
     * 审核人名称
     */
    private String auditName;

    /**
     * 原因
     */
    private String auditReason;

}
