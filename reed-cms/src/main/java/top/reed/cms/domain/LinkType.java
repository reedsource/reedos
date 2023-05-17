package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;
import java.util.List;

/**
 * 链接分类对象 cms_link_type
 *
 * @author reedsource
 * date 2019-11-26
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class LinkType extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 链接分类
     */
    @Excel(name = "链接分类")
    private String linkType;

    /**
     * 链接分类名称
     */
    @Excel(name = "链接分类名称")
    private String linkTypeName;
    /**
     * 链接分类描述
     */
    @Excel(name = "链接分类描述")
    private String description;
    /**
     * 封面图片
     */
    @Excel(name = "封面图片")
    private String coverImage;

    /**
     * 排序
     */
    @Excel(name = "排序")
    private Integer sort;

    /**
     * 状态
     */
    @Excel(name = "状态")
    private Integer status;

    private List<Link> children;//扩展字段

}
