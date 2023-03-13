package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 模板对象 cms_template
 *
 * @author reedsource
 * date 2019-11-17
 */
@Getter
@Setter
public class Template extends BaseEntity {
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

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("templateId", getTemplateId())
                .append("templateCode", getTemplateCode())
                .append("templateType", getTemplateType())
                .append("templateName", getTemplateName())
                .append("templateContent", getTemplateContent())
                .toString();
    }
}
