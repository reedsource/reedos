package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 模板对象 cms_template
 *
 * @author reedsource
 * date 2019-11-17
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Template extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long templateId;

    /**
     * 模板代码
     */
    @Excel(name = "模板代码")
    private String templateCode;

    /**
     * 模板分类
     */
    @Excel(name = "模板分类")
    private String templateType;

    /**
     * 模板名称
     */
    @Excel(name = "模板名称")
    private String templateName;

    /**
     * 模板内容
     */
    @Excel(name = "模板内容")
    private String templateContent;

}
