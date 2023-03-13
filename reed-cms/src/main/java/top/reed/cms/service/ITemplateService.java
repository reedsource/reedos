package top.reed.cms.service;

import top.reed.cms.domain.Template;

import java.util.List;

/**
 * 模板Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ITemplateService {
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
     * 批量删除模板
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteTemplateByIds(String ids);

    /**
     * 删除模板信息
     *
     * @param templateId 模板ID
     * @return 结果
     */
    int deleteTemplateById(Long templateId);
}
