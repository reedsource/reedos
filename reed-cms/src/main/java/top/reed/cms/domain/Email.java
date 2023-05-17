package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 邮件对象 cms_email
 *
 * @author reedsource
 * date 2019-11-04
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Email extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private String id;

    /**
     * 邮件类型
     */
    @Excel(name = "邮件类型")
    private Integer emailType;

    /**
     * 用户ID
     */
    @Excel(name = "用户ID")
    private String userId;

    /**
     * 发送者邮箱
     */
    @Excel(name = "发送者邮箱")
    private String fromEmail;

    /**
     * 发送者邮箱密码
     */
    @Excel(name = "发送者邮箱密码")
    private String fromEmailPwd;

    /**
     * 接收者邮箱
     */
    @Excel(name = "接收者邮箱")
    private String toEmail;

    /**
     * 主题
     */
    @Excel(name = "主题")
    private String subject;

    /**
     * 内容
     */
    @Excel(name = "内容")
    private String content;

    /**
     * 是否发送
     */
    @Excel(name = "是否发送")
    private Integer sendFlag;

    /**
     * 发送时间
     */
    @Excel(name = "发送时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date sendTime;

    /**
     * 发送类型 0立即 1定时
     */
    @Excel(name = "发送类型 0立即 1定时")
    private String sendType;

    /**
     * 定时时间
     */
    @Excel(name = "定时时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date planTime;

    /**
     * 抄送用户
     */
    @Excel(name = "抄送用户")
    private String copyTo;

    /**
     * 附件
     */
    @Excel(name = "附件")
    private String attachfiles;
}
