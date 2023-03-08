package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 文件类型对象 cms_filetype
 *
 * @author reedsource
 * date 2019-11-01
 */
@Getter
@Setter
public class Filetype extends BaseEntity {
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

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("id", getId())
				.append("suffix", getSuffix())
				.append("name", getName())
				.append("icon", getIcon())
				.toString();
	}
}
