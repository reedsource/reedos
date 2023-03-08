package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Attachment;

import java.util.List;

/**
 * 附件Mapper接口
 *
 * @author reedsource
 * date 2019-11-01
 */
@Mapper
public interface AttachmentMapper {
	/**
	 * 查询附件
	 *
	 * @param attachId 附件ID
	 * @return 附件
	 */
	Attachment selectAttachmentById(String attachId);

	/**
	 * 查询附件列表
	 *
	 * @param attachment 附件
	 * @return 附件集合
	 */
	List<Attachment> selectAttachmentList(Attachment attachment);

	/**
	 * 新增附件
	 *
	 * @param attachment 附件
	 * @return 结果
	 */
	int insertAttachment(Attachment attachment);

	/**
	 * 修改附件
	 *
	 * @param attachment 附件
	 * @return 结果
	 */
	int updateAttachment(Attachment attachment);

	/**
	 * 删除附件
	 *
	 * @param attachId 附件ID
	 * @return 结果
	 */
	int deleteAttachmentById(String attachId);

	/**
	 * 批量删除附件
	 *
	 * @param attachIds 需要删除的数据ID
	 * @return 结果
	 */
	int deleteAttachmentByIds(String[] attachIds);
}
