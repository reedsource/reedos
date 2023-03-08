package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Template;
import top.reed.cms.mapper.TemplateMapper;
import top.reed.cms.service.ITemplateService;
import top.reed.common.core.text.Convert;

import java.util.List;

/**
 * 模板Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class TemplateServiceImpl implements ITemplateService {
	@Autowired
	private TemplateMapper templateMapper;

	/**
	 * 查询模板
	 *
	 * @param templateId 模板ID
	 * @return 模板
	 */
	@Override
	public Template selectTemplateById(Long templateId) {
		return templateMapper.selectTemplateById(templateId);
	}

	/**
	 * 查询模板列表
	 *
	 * @param template 模板
	 * @return 模板
	 */
	@Override
	public List<Template> selectTemplateList(Template template) {
		return templateMapper.selectTemplateList(template);
	}

	/**
	 * 新增模板
	 *
	 * @param template 模板
	 * @return 结果
	 */
	@Override
	public int insertTemplate(Template template) {
		return templateMapper.insertTemplate(template);
	}

	/**
	 * 修改模板
	 *
	 * @param template 模板
	 * @return 结果
	 */
	@Override
	public int updateTemplate(Template template) {
		return templateMapper.updateTemplate(template);
	}

	/**
	 * 删除模板对象
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	@Override
	public int deleteTemplateByIds(String ids) {
		return templateMapper.deleteTemplateByIds(Convert.toStrArray(ids));
	}

	/**
	 * 删除模板信息
	 *
	 * @param templateId 模板ID
	 * @return 结果
	 */
	@Override
	public int deleteTemplateById(Long templateId) {
		return templateMapper.deleteTemplateById(templateId);
	}
}
