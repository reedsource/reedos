package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 广告位对象 cms_ad
 *
 * @author reedsource
 * date 2019-11-16
 */
@Getter
@Setter
public class Ad extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 广告位ID
     */
    private Long adId;

    /**
     * 广告位编码
     */
    @Excel(name = "广告位编码")
    private String adCode;

    /**
     * 广告位名称
     */
    @Excel(name = "广告位名称")
    private String adName;

    /**
     * 宽度
     */
    @Excel(name = "宽度")
    private Integer width;

    /**
     * 高度
     */
    @Excel(name = "高度")
    private Integer height;

    /**
     * 状态
     */
    @Excel(name = "状态")
    private Integer status;

    /**
     * 创建人ID
     */
    private String userId;

    /**
     * 部门ID
     */
    private String deptId;

    /**
     * 描述
     */
    private String description;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("adId", getAdId())
                .append("adCode", getAdCode())
                .append("adName", getAdName())
                .append("width", getWidth())
                .append("height", getHeight())
                .append("status", getStatus())
                .append("userId", getUserId())
                .append("deptId", getDeptId())
                .append("description", getDescription())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .toString();
    }
}
