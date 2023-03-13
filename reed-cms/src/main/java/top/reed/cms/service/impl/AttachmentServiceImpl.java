package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Attachment;
import top.reed.cms.mapper.AttachmentMapper;
import top.reed.cms.service.IAttachmentService;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.Guid;
import top.reed.common.utils.ShiroUtils;

import java.util.List;

/**
 * 附件Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class AttachmentServiceImpl implements IAttachmentService {
    @Autowired
    private AttachmentMapper attachmentMapper;

    /**
     * 查询附件
     *
     * @param attachId 附件ID
     * @return 附件
     */
    @Override
    public Attachment selectAttachmentById(String attachId) {
        return attachmentMapper.selectAttachmentById(attachId);
    }

    @Override
    public List<Attachment> selectAttachmentsByZid(String zid) {
        Attachment attachment = new Attachment();
        attachment.setZid(zid);
        return attachmentMapper.selectAttachmentList(attachment);
    }

    /**
     * 查询附件列表
     *
     * @param attachment 附件
     * @return 附件
     */
    @Override
    public List<Attachment> selectAttachmentList(Attachment attachment) {
        return attachmentMapper.selectAttachmentList(attachment);
    }

    /**
     * 新增附件
     *
     * @param attachment 附件
     * @return 结果
     */
    @Override
    public int insertAttachment(Attachment attachment) {
        attachment.setAttachId(Guid.get());
        SysUser user = ShiroUtils.getSysUser();
        attachment.setUserId(user.getUserId().toString());
        attachment.setCreateBy(user.getUserName());
        attachment.setCreateTime(DateUtils.getNowDate());
        return attachmentMapper.insertAttachment(attachment);
    }

    /**
     * 修改附件
     *
     * @param attachment 附件
     * @return 结果
     */
    @Override
    public int updateAttachment(Attachment attachment) {
        attachment.setUpdateTime(DateUtils.getNowDate());
        return attachmentMapper.updateAttachment(attachment);
    }

    /**
     * 删除附件对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteAttachmentByIds(String ids) {
        return attachmentMapper.deleteAttachmentByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除附件信息
     *
     * @param attachId 附件ID
     * @return 结果
     */
    @Override
    public int deleteAttachmentById(String attachId) {
        return attachmentMapper.deleteAttachmentById(attachId);
    }
}
