package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 附件对象 cms_attachment
 *
 * @author reedsource
 * date 2019-11-01
 */
@Getter
@Setter
public class Attachment extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private String attachId;

	/**
	 * 组ID
	 */
	@Excel(name = "组ID")
	private String zid;

	/**
	 * 用户ID
	 */
	@Excel(name = "用户ID")
	private String userId;

	/**
	 * 类型
	 */
	@Excel(name = "类型")
	private String fileType;

	/**
	 * 名称
	 */
	@Excel(name = "名称")
	private String fileName;

	/**
	 * 路径
	 */
	@Excel(name = "路径")
	private String filePath;

	/**
	 * URL
	 */
	@Excel(name = "URL")
	private String fileUrl;

	/**
	 * 大小
	 */
	@Excel(name = "大小")
	private Long size;

	/**
	 * 排序
	 */
	@Excel(name = "排序")
	private Integer sort;

	private String suffix;


	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("attachId", getAttachId())
				.append("zid", getZid())
				.append("userId", getUserId())
				.append("fileType", getFileType())
				.append("fileName", getFileName())
				.append("filePath", getFilePath())
				.append("size", getSize())
				.append("createBy", getCreateBy())
				.append("createTime", getCreateTime())
				.append("sort", getSort())
				.toString();
	}
}
