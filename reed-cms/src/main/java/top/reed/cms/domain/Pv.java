package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * PV对象 cms_pv
 *
 * @author reedsource
 * date 2019-11-29
 */
@Getter
@Setter
public class Pv extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private Long id;

	/**
	 * 用户ID
	 */
	@Excel(name = "用户ID")
	private String uid;

	/**
	 * 模块
	 */
	@Excel(name = "模块")
	private String module;

	/**
	 * 浏览器
	 */
	@Excel(name = "浏览器")
	private String browser;

	/**
	 * referer
	 */
	@Excel(name = "referer")
	private String referer;

	/**
	 * 操作系统
	 */
	@Excel(name = "操作系统")
	private String os;

	/**
	 * 页面内容ID
	 */
	private String pageId;

	/**
	 * URL
	 */
	@Excel(name = "URL")
	private String url;

	/**
	 * 设备类型
	 */
	@Excel(name = "设备类型")
	private String deviceType;

	/**
	 * 时区
	 */
	@Excel(name = "时区")
	private String timeZone;

	/**
	 * ip地址
	 */
	@Excel(name = "ip地址")
	private String ip;

	/**
	 * 地址
	 */
	@Excel(name = "地址")
	private String location;

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("id", getId())
				.append("uid", getUid())
				.append("module", getModule())
				.append("browser", getBrowser())
				.append("referer", getReferer())
				.append("os", getOs())
				.append("pageId", getPageId())
				.append("url", getUrl())
				.append("deviceType", getDeviceType())
				.append("timeZone", getTimeZone())
				.append("ip", getIp())
				.append("location", getLocation())
				.append("createTime", getCreateTime())
				.toString();
	}
}
