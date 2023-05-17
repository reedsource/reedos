package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 励志短语对象 cms_short_words
 *
 * @author reedsource
 * date 2019-11-22
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ShortWords extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 短语
     */
    @Excel(name = "短语")
    private String shortWords;

    /**
     * 标签
     */
    @Excel(name = "标签")
    private String tagids;

    /**
     * 用户ID
     */
    @Excel(name = "用户ID")
    private String userId;

    /**
     * 字数
     */
    @Excel(name = "字数")
    private Long wordsCount;

    /**
     * 权重
     */
    @Excel(name = "权重")
    private Long weight;

    /**
     * 审核状态
     */
    @Excel(name = "审核状态")
    private Integer auditState;
}
