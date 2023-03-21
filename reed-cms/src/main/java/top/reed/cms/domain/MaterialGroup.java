package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.TreeEntity;

import java.io.Serial;

/**
 * 素材分组对象 cms_material_group
 *
 * @author reedsource
 * date 2019-11-07
 */
@Getter
@Setter
public class MaterialGroup extends TreeEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long groupId;

    /**
     * 部门ID
     */
    @Excel(name = "部门ID")
    private String deptId;

    /**
     * 分组名称
     */
    @Excel(name = "分组名称")
    private String groupName;

    /**
     * 描述
     */
    @Excel(name = "描述")
    private String description;

    /**
     * 排序
     */
    @Excel(name = "排序")
    private Integer sort;

    /**
     * 创建人用户ID
     */
    private String userId;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("groupId", getGroupId())
                .append("parentId", getParentId())
                .append("deptId", getDeptId())
                .append("groupName", getGroupName())
                .append("description", getDescription())
                .append("sort", getSort())
                .append("userId", getUserId())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .toString();
    }
}
