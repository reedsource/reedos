package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.ArticleTemplate;
import top.reed.cms.domain.Tags;

import java.util.List;

/**
 * 文章模板Mapper接口
 *
 * @author reedsource
 * date 2019-12-31
 */
@Mapper
public interface ArticleTemplateMapper {
	/**
	 * 查询文章模板
	 *
	 * @param id 文章模板ID
	 * @return 文章模板
	 */
	ArticleTemplate selectArticleTemplateById(Long id);

	/**
	 * 查询文章模板列表
	 *
	 * @param articleTemplate 文章模板
	 * @return 文章模板集合
	 */
	List<ArticleTemplate> selectArticleTemplateList(ArticleTemplate articleTemplate);

	/**
	 * 新增文章模板
	 *
	 * @param articleTemplate 文章模板
	 * @return 结果
	 */
	int insertArticleTemplate(ArticleTemplate articleTemplate);

	/**
	 * 修改文章模板
	 *
	 * @param articleTemplate 文章模板
	 * @return 结果
	 */
	int updateArticleTemplate(ArticleTemplate articleTemplate);

	/**
	 * 删除文章模板
	 *
	 * @param id 文章模板ID
	 * @return 结果
	 */
	int deleteArticleTemplateById(Long id);

	/**
	 * 批量删除文章模板
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteArticleTemplateByIds(String[] ids);


	/**
	 * 查询文字模板标签
	 *
	 * @return
	 */
	List<Tags> selectArticleTemplateTags();
}
