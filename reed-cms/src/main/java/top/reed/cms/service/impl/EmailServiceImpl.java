package top.reed.cms.service.impl;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.config.CmsConfig;
import top.reed.cms.domain.Email;
import top.reed.cms.mapper.EmailMapper;
import top.reed.cms.service.IEmailService;
import top.reed.cms.util.email.MailSenderInfo;
import top.reed.cms.util.email.SimpleMailSender;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.Guid;
import top.reed.common.utils.ShiroUtils;

import java.util.List;

/**
 * 邮件Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class EmailServiceImpl implements IEmailService {
    @Autowired
    private EmailMapper emailMapper;


    /**
     * 查询邮件
     *
     * @param id 邮件ID
     * @return 邮件
     */
    @Override
    public Email selectEmailById(String id) {
        return emailMapper.selectEmailById(id);
    }

    /**
     * 查询邮件列表
     *
     * @param email 邮件
     * @return 邮件
     */
    @Override
    public List<Email> selectEmailList(Email email) {
        return emailMapper.selectEmailList(email);
    }

    /**
     * 新增邮件
     *
     * @param email 邮件
     * @return 结果
     */
    @Override
    public int insertEmail(Email email) {
        email.setId(Guid.get());
        SysUser user = ShiroUtils.getSysUser();
        email.setFromEmail(CmsConfig.getFromEmail());
        email.setFromEmailPwd(CmsConfig.getFromEmailPwd());
        email.setUserId(user.getUserId().toString());
        email.setCreateBy(user.getUserName());
        email.setCreateTime(DateUtils.getNowDate());

        if (email.getSendType() == null) {
            //off 为null 默认为0
            email.setSendType("0");
        }
        if ("on".equals(email.getSendType())) {
            email.setSendType("1");
        }
        if ("off".equals(email.getSendType())) {
            email.setSendType("0");
        }

        return emailMapper.insertEmail(email);
    }

    /**
     * 修改邮件
     *
     * @param email 邮件
     * @return 结果
     */
    @Override
    public int updateEmail(Email email) {
        email.setUpdateTime(DateUtils.getNowDate());
        if (email.getSendType() == null) {
            //off 为null 默认为0
            email.setSendType("0");
        }
        if ("on".equals(email.getSendType())) {
            email.setSendType("1");
        }
        if ("off".equals(email.getSendType())) {
            email.setSendType("0");
        }
        return emailMapper.updateEmail(email);
    }

    /**
     * 删除邮件对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteEmailByIds(String ids) {
        return emailMapper.deleteEmailByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除邮件信息
     *
     * @param id 邮件ID
     * @return 结果
     */
    @Override
    public int deleteEmailById(Long id) {
        return emailMapper.deleteEmailById(id);
    }

    /**
     * 发送邮件
     *
     * @param ids 需要发送邮件的数据ID
     */
    @Override
    public void sendEmail(String ids) {
        String[] arr = Convert.toStrArray(ids);
        List<String> list = Lists.newArrayList(arr);
        list.forEach(id -> {
            Email e = this.selectEmailById(id);
            if (e != null) {
                MailSenderInfo info = new MailSenderInfo();
                info.setMailServiceHost(CmsConfig.getMailHost());//qq邮箱服务器
                info.setMailServicePort(CmsConfig.getMailPort());//端口号
                info.setFromAddress(e.getFromEmail());
                info.setValidate(true);
                info.setUserName(e.getFromEmail());
                info.setPassword(e.getFromEmailPwd());
                String[] to = {e.getToEmail()};
                info.setToAddress(to);
                info.setSubject(e.getSubject());
                info.setContent(e.getContent());
                SimpleMailSender sender = new SimpleMailSender();
                boolean b = sender.sendHtmlMail(info);
                if (b) {
                    e.setSendFlag(1);
                    e.setSendTime(DateUtils.getNowDate());
                    this.updateEmail(e);
                }
            }
        });
    }
}
