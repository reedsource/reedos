package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.reed.cms.domain.Article;

import java.util.List;
import java.util.Map;

/**
 * 文章管理Mapper接口
 *
 * @author reedsource
 * date 2019-10-28
 */
@Mapper
public interface ArticleMapper {
	/**
	 * 查询文章
	 *
	 * @param id 文章ID
	 * @return 文章
	 */
	Article selectArticleById(String id);

	/**
	 * 查询文章内容
	 *
	 * @param article_id
	 * @return
	 */
	Map<String, Object> getArticleContent(String article_id);

	/**
	 * 查询文章列表
	 *
	 * @param article 文章
	 * @return 文章集合
	 */
	List<Article> selectArticleList(Article article);

	/**
	 * 查询文章专区不为空的文章列表，这类文章才可以在博客首页展示
	 *
	 * @param article 文章
	 * @return 文章集合
	 */
	List<Article> selectArticlesRegionNotNull(Article article);

	/**
	 * 查询文章专区为空的文章，这类文章可用于猜你喜欢来推荐
	 * 注意这类文章和上面的区别是：
	 * 上面方法的文章是网站管理员精心编辑策划的、来画好专区的，是由很大几率展示的
	 * 而下面的文章属于坐冷板凳的
	 *
	 * @param article 文章
	 * @return 文章集合
	 */
	List<Article> selectArticlesRegionIsNull(Article article);

	/**
	 * 新增文章管理
	 *
	 * @param article 文章
	 * @return 结果
	 */
	int insertArticle(Article article);

	/**
	 * 插入文章内容
	 *
	 * @param article
	 */
	int insertArticleContent(Article article);

	/**
	 * 修改文章
	 *
	 * @param article 文章
	 * @return 结果
	 */
	int updateArticle(Article article);

	/**
	 * 更新文章内容
	 *
	 * @param article
	 * @return
	 */
	int updateArticleContent(Article article);

	/**
	 * 删除文章
	 *
	 * @param id 文章ID
	 * @return 结果
	 */
	int deleteArticleById(String id);

	/**
	 * 删除文章内容
	 *
	 * @param id 文章ID
	 * @return 结果
	 */
	int deleteArticleContentById(String id);

	/**
	 * 批量删除文章
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteArticleByIds(String[] ids);

	/**
	 * 批量删除文章内容
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteArticleContentByIds(String[] ids);


	int checkExistsByTitleAndLink(@Param("title") String title, @Param("link") String link);

	/**
	 * 文章点赞+1
	 *
	 * @param id
	 * @return
	 */
	int upVote(String id);

	/**
	 * 文章点击数+1
	 *
	 * @param id
	 * @return
	 */
	int articleLook(String id);
}
