package top.reed.cms.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * cms模块相关配置
 *
 * @author reedsource
 */
@Component
@PropertySource(value = {"classpath:cms.properties"})
public class CmsConfig {

    public static String mailHost;

    public static String mailPort;

    /**
     * 邮件发送服务
     */
    public static String fromEmail;
    /**
     * 邮件发送服务
     */
    public static String fromEmailPwd;

    public static String getMailHost() {
        return mailHost;
    }

    @Value("${cms.email.host}")
    public void setMailHost(String mailHost) {
        CmsConfig.mailHost = mailHost;
    }

    public static String getMailPort() {
        return mailPort;
    }

    @Value("${cms.email.port}")
    public void setMailPort(String mailPort) {
        CmsConfig.mailPort = mailPort;
    }

    public static String getFromEmail() {
        return fromEmail;
    }

    @Value("${cms.email.fromEmail}")
    public void setFromEmail(String fromEmail) {
        CmsConfig.fromEmail = fromEmail;
    }

    public static String getFromEmailPwd() {
        return fromEmailPwd;
    }

    @Value("${cms.email.fromEmailPwd}")
    public void setFromEmailPwd(String fromEmailPwd) {
        CmsConfig.fromEmailPwd = fromEmailPwd;
    }


}
