package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.TreeEntity;

import java.io.Serial;
import java.util.List;

/**
 * 栏目分类对象 cms_category
 *
 * @author reedsource
 * date 2019-10-28
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Category extends TreeEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类ID
     */
    private Long categoryId;

    /**
     * 分类名称
     */
    @Excel(name = "分类名称")
    private String categoryName;

    /**
     * 排序
     */
    @Excel(name = "排序")
    private Integer sort;

    /**
     * 分类描述
     */
    @Excel(name = "分类描述")
    private String description;

    /**
     * 状态（0正常 1停用）
     */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private Integer status;

    /**
     * 删除标志
     */
    private Integer delFlag;


    private Category parent;//扩展字段
    private List<Category> nodes;//扩展字段

}
