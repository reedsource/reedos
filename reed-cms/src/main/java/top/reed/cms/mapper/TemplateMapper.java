package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Template;

import java.util.List;

/**
 * 模板Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface TemplateMapper {
	/**
	 * 查询模板
	 *
	 * @param templateId 模板ID
	 * @return 模板
	 */
	Template selectTemplateById(Long templateId);

	/**
	 * 查询模板列表
	 *
	 * @param template 模板
	 * @return 模板集合
	 */
	List<Template> selectTemplateList(Template template);

	/**
	 * 新增模板
	 *
	 * @param template 模板
	 * @return 结果
	 */
	int insertTemplate(Template template);

	/**
	 * 修改模板
	 *
	 * @param template 模板
	 * @return 结果
	 */
	int updateTemplate(Template template);

	/**
	 * 删除模板
	 *
	 * @param templateId 模板ID
	 * @return 结果
	 */
	int deleteTemplateById(Long templateId);

	/**
	 * 批量删除模板
	 *
	 * @param templateIds 需要删除的数据ID
	 * @return 结果
	 */
	int deleteTemplateByIds(String[] templateIds);
}
