package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 标签管理对象 cms_tags
 *
 * @author reedsource
 * date 2019-10-29
 */
@Getter
@Setter
public class Tags extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private Long tagId;

	/**
	 * 标签类型，如s系统标签，p个人标签
	 */
	@Excel(name = "标签类型，如s系统标签，p个人标签")
	private String tagType;

	/**
	 * 谁增加的该标签
	 */
	@Excel(name = "谁增加的该标签")
	private String userId;

	/**
	 * 分类名称
	 */
	@Excel(name = "分类名称")
	private String tagName;

	/**
	 * 排序
	 */
	@Excel(name = "排序")
	private Long sort;

	/**
	 * 状态
	 */
	@Excel(name = "状态")
	private Integer status;

	/**
	 * 链接
	 */
	@Excel(name = "链接")
	private String url;

	/**
	 * 是否选中，默认否。
	 */
	private boolean selected = false;

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("tagId", getTagId())
				.append("tagType", getTagType())
				.append("userId", getUserId())
				.append("tagName", getTagName())
				.append("sort", getSort())
				.append("status", getStatus())
				.append("url", getUrl())
				.toString();
	}
}
