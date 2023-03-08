package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.util.Date;

/**
 * 素材对象 cms_material
 *
 * @author reedsource
 * date 2019-11-05
 */
@Getter
@Setter
public class Material extends BaseEntity {
	private static final long serialVersionUID = 1L;
	// private String[] paramMaterialIds;//扩展字段
	public String albumId;//扩展字段
	/**
	 * ID
	 */
	private String materialId;
	/**
	 * 分组id
	 */
	private String groupId;
	/**
	 * 分组名称
	 */
	private String groupName;//扩展
	private Long deptId;//部门id
	/**
	 * 素材名称
	 */
	@Excel(name = "素材名称")
	private String materialName;
	/**
	 * 素材类型 字典 1图片2视频3文本
	 */
	@Excel(name = "素材类型 字典 1图片2视频3文本")
	private String materialType;
	/**
	 * 素材描述
	 */
	@Excel(name = "素材描述")
	private String description;
	/**
	 * 素材大小
	 */
	@Excel(name = "素材大小")
	private String materialSize;
	/**
	 * 保存路径
	 */
	private String savePath;
	/**
	 * 缩略图
	 */
	private String thumbnail;
	/**
	 * 审核状态 0待审批2未通过1通过
	 */
	@Excel(name = "审核状态 0待审批2未通过1通过")
	private String auditState;
	/**
	 * 审核意见
	 */
	@Excel(name = "审核意见")
	private String auditReason;
	/**
	 * 可用状态 0停用1启用
	 */
	@Excel(name = "可用状态 0停用1启用")
	private String useState;
	/**
	 * 分辨率 宽
	 */
	@Excel(name = "分辨率 宽")
	private String width;
	/**
	 * 分辨率 高
	 */
	@Excel(name = "分辨率 高")
	private String height;
	/**
	 * 上传者 id
	 */
	private String uploaderId;
	/**
	 * 上传日期
	 */
	@Excel(name = "上传日期", width = 30, dateFormat = "yyyy-MM-dd")
	private Date uploadTime;

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("materialId", getMaterialId())
				.append("groupId", getGroupId())
				.append("materialName", getMaterialName())
				.append("materialType", getMaterialType())
				.append("description", getDescription())
				.append("materialSize", getMaterialSize())
				.append("savePath", getSavePath())
				.append("thumbnail", getThumbnail())
				.append("auditState", getAuditState())
				.append("auditReason", getAuditReason())
				.append("useState", getUseState())
				.append("width", getWidth())
				.append("height", getHeight())
				.append("uploaderId", getUploaderId())
				.append("uploadTime", getUploadTime())
				.append("remark", getRemark())
				.toString();
	}
}
