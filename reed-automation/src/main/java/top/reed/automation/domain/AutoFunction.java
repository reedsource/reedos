package top.reed.automation.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 自定义函数对象 auto_function
 *
 * @author reedsource
 * date 2022-09-29
 */
public class AutoFunction extends BaseEntity {
	@Serial
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private Long id;

	/**
	 * 函数名
	 */
	@Excel(name = "函数名")
	private String name;

	/**
	 * 参数
	 */
	@Excel(name = "参数")
	private String parameter;

	/**
	 * js脚本
	 */
	private String script;

	/**
	 * 创建时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd")
	@Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
	private Date createDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("id", getId())
				.append("name", getName())
				.append("parameter", getParameter())
				.append("script", getScript())
				.append("createDate", getCreateDate())
				.toString();
	}
}
