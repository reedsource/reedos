package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 励志短语对象 cms_short_words
 *
 * @author reedsource
 * date 2019-11-22
 */
@Getter
@Setter
public class ShortWords extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private Long id;

	/**
	 * 短语
	 */
	@Excel(name = "短语")
	private String shortWords;

	/**
	 * 标签
	 */
	@Excel(name = "标签")
	private String tagids;

	/**
	 * 用户ID
	 */
	@Excel(name = "用户ID")
	private String userId;

	/**
	 * 字数
	 */
	@Excel(name = "字数")
	private Long wordsCount;

	/**
	 * 权重
	 */
	@Excel(name = "权重")
	private Long weight;

	/**
	 * 审核状态
	 */
	@Excel(name = "审核状态")
	private Integer auditState;

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("id", getId())
				.append("shortWords", getShortWords())
				.append("tagids", getTagids())
				.append("userId", getUserId())
				.append("wordsCount", getWordsCount())
				.append("weight", getWeight())
				.append("auditState", getAuditState())
				.toString();
	}
}
