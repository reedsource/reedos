package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 文件类型对象 cms_filetype
 *
 * @author reedsource
 * date 2019-11-01
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Filetype extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 后缀
     */
    @Excel(name = "后缀")
    private String suffix;

    /**
     * 中文名称
     */
    @Excel(name = "中文名称")
    private String name;

    /**
     * 图标
     */
    @Excel(name = "图标")
    private String icon;

}
