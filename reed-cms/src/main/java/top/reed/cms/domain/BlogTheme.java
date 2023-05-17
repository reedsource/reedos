package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 博客主题对象 blog_theme
 *
 * @author reedsource
 * date 2019-12-20
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class BlogTheme extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 主题名称
     */
    @Excel(name = "主题名称")
    private String name;

    /**
     * 主题代码
     */
    @Excel(name = "主题代码")
    private String code;

    /**
     * 封面图片
     */
    @Excel(name = "封面图片")
    private String coverImg;

}
