package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.util.List;

/**
 * 素材相册对象 cms_album
 *
 * @author reedsource
 * date 2019-11-08
 */
@Getter
@Setter
public class Album extends BaseEntity {
	private static final long serialVersionUID = 1L;
	List<AlbumMaterial> images;
	/**
	 * 相册ID
	 */
	private String albumId;
	/**
	 * 相册名称
	 */
	@Excel(name = "相册名称")
	private String albumName;
	/**
	 * 创建人ID
	 */
	private String userId;
	/**
	 * 部门ID
	 */
	private String deptId;
	/**
	 * 相册类型
	 */
	@Excel(name = "相册类型")
	private String albumType;
	/**
	 * 描述
	 */
	@Excel(name = "描述")
	private String description;
	/**
	 * 审核状态
	 */
	@Excel(name = "审核状态")
	private Integer auditState;
	@Excel(name = "编码")
	private String code;
	@Excel(name = "宽度")
	private Integer width;
	@Excel(name = "高度")
	private Integer height;


	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("albumId", getAlbumId())
				.append("albumName", getAlbumName())
				.append("userId", getUserId())
				.append("deptId", getDeptId())
				.append("albumType", getAlbumType())
				.append("description", getDescription())
				.append("createBy", getCreateBy())
				.append("createTime", getCreateTime())
				.append("auditState", getAuditState())
				.toString();
	}
}
