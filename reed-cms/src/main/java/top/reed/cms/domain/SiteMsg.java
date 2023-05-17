package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 站内消息对象 cms_site_msg
 *
 * @author reedsource
 * date 2019-11-17
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class SiteMsg extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 发送者ID
     */
    @Excel(name = "发送者ID")
    private String fromId;

    /**
     * 发送者名称
     */
    @Excel(name = "发送者名称")
    private String fromName;

    /**
     * 接受者ID
     */
    @Excel(name = "接受者ID")
    private String toId;

    /**
     * 接受者名称
     */
    @Excel(name = "接受者名称")
    private String toName;

    /**
     * 消息类别
     */
    @Excel(name = "消息类别")
    private String msgType;

    /**
     * 消息内容
     */
    @Excel(name = "消息内容")
    private String content;

}
