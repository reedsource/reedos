package top.reed.cms.service.impl;


import cn.hutool.cache.Cache;
import cn.hutool.cache.CacheUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.compress.utils.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import top.reed.cms.domain.Article;
import top.reed.cms.domain.ArticleRegionType;
import top.reed.cms.domain.Category;
import top.reed.cms.domain.Tags;
import top.reed.cms.mapper.ArticleMapper;
import top.reed.cms.mapper.TagsMapper;
import top.reed.cms.service.IArticleService;
import top.reed.cms.service.ICategoryService;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.CacheUtils;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.Guid;
import top.reed.common.utils.ShiroUtils;

import java.util.List;
import java.util.Map;

/**
 * 文章管理Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class ArticleServiceImpl implements IArticleService {
    private final cn.hutool.cache.Cache<String, Category> categoryCache = CacheUtil.newLFUCache(100);
    private final Cache<String, Tags> tagCache = CacheUtil.newLFUCache(100);
    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private TagsMapper tagsMapper;
    @Autowired
    private ICategoryService categoryService;

    /**
     * 查询文章管理
     *
     * @param id 文章管理ID
     * @return 文章管理
     */
    @Override
    public Article selectArticleById(String id) {
        Article article = articleMapper.selectArticleById(id);
        Map<String, Object> m = articleMapper.getArticleContent(id);
        if (m != null) {
            article.setContent(String.valueOf(m.get("content")));
            article.setContent_markdown_source(String.valueOf(m.get("content_markdown_source")));
        }
        selectCategory(article);
        selectTags(article);
        return article;
    }

    /**
     * 查询文章管理列表
     *
     * @param article 文章管理
     * @return 文章管理
     */
    @Override
    public List<Article> selectArticleList(Article article) {
        List<Article> articles = articleMapper.selectArticleList(article);
        selectTags(articles);
        selectCategory(articles);
        return articles;
    }

    /**
     * 新增文章管理
     *
     * @param article 文章管理
     * @return 结果
     */
    @Override
    @Transactional
    public int insertArticle(Article article) {
        article.setId(Guid.get());
        article.setCreateTime(DateUtils.getNowDate());
        article.setUpdateTime(DateUtils.getNowDate());
        SysUser user = ShiroUtils.getSysUser();
        article.setYhid(user.getUserId().toString());
        article.setDeleted(0);
        String tags = article.getTags();
        if (StringUtils.isNotEmpty(tags)) {
            if (!tags.endsWith(",")) {
                tags += ",";
                article.setTags(tags);
            }
        }
        article.setAuthor(user.getUserName());

        if (article.getCommentFlag() == null) {
            article.setCommentFlag("0");
        }
        if ("on".equals(article.getCommentFlag())) {
            article.setCommentFlag("1");
        }
        if ("off".equals(article.getCommentFlag())) {
            article.setCommentFlag("0");
        }

        return articleMapper.insertArticleContent(article);
    }

    /**
     * 修改文章管理
     *
     * @param article 文章管理
     * @return 结果
     */
    @Override
    @Transactional
    public int updateArticle(Article article) {
        article.setUpdateTime(DateUtils.getNowDate());
        String tags = article.getTags();
        if (StringUtils.isNotEmpty(tags)) {
            if (!tags.endsWith(",")) {
                tags += ",";
                article.setTags(tags);
            }
        }
        if (article.getCommentFlag() == null) {
            article.setCommentFlag("0");
        }
        if ("on".equals(article.getCommentFlag())) {
            article.setCommentFlag("1");
        }
        if ("off".equals(article.getCommentFlag())) {
            article.setCommentFlag("0");
        }
        return articleMapper.updateArticleContent(article);
    }

    /**
     * 删除文章管理对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteArticleByIds(String ids) {
        articleMapper.deleteArticleContentByIds(Convert.toStrArray(ids));
        return articleMapper.deleteArticleByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除文章管理信息
     *
     * @param id 文章管理ID
     * @return 结果
     */
    @Override
    public int deleteArticleById(String id) {
        articleMapper.deleteArticleContentById(id);
        return articleMapper.deleteArticleById(id);
    }

    /**
     * 获取最新的文章
     *
     * @param articleRegionType 文章类型
     */
    @Override
    public List<Article> selectArticlesByArticleRegionType(ArticleRegionType articleRegionType) {
        List<Article> list = (List<Article>) CacheUtils.get("reed-cms-new", articleRegionType.getVal());
        if (CollectionUtils.isEmpty(list)) {
            list = this.selectArticlesByArticleRegionTypeInDb(articleRegionType);
            CacheUtils.put("reed-cms-new", articleRegionType.getVal(), list);
        }
        //selectCategory(list);
        return list;
    }

    @Override
    public List<Article> selectArticlesRegionNotNull(Article article) {
        List<Article> list = articleMapper.selectArticlesRegionNotNull(article);
        selectCategory(list);
        return list;
    }

    @Override
    public List<Article> selectArticlesRegionIsNull(Article article) {
        //selectCategory(list);
        return articleMapper.selectArticlesRegionIsNull(article);
    }

    @Override
    public int upVote(String id) {
        return articleMapper.upVote(id);
    }

    @Override
    public int articleLook(String id) {
        return articleMapper.articleLook(id);
    }

    private List<Article> selectArticlesByArticleRegionTypeInDb(ArticleRegionType articleRegionType) {
        Article queryForm = new Article();
        queryForm.setArticleRegion(articleRegionType.getVal());
        List<Article> list = this.selectArticleList(queryForm);
        selectCategory(list);
        return list;
    }

    private void selectCategory(List<Article> list) {
        list.forEach(a -> {
            String cid = a.getCategoryId();
            Category category = categoryCache.get(cid);
            if (category == null) {
                category = categoryService.selectCategoryById(Long.valueOf(cid));
                if (category != null) {
                    categoryCache.put(cid, category);
                }
            }
            if (category != null) {
                a.setCategory(category);
            }
        });
    }

    private void selectCategory(Article a) {

        String cid = a.getCategoryId();
        Category category = categoryCache.get(cid);
        if (category == null) {
            category = categoryService.selectCategoryById(Long.valueOf(cid));
            if (category != null) {
                categoryCache.put(cid, category);
            }
        }
        if (category != null) {
            a.setCategory(category);
        }
    }

    private void selectTags(List<Article> articles) {

        //转换标签名称，这部分可以使用缓存提升性能
        articles.forEach(a -> {
            String tagsStr = a.getTags();
            if (StringUtils.isNotEmpty(tagsStr)) {
                String[] tagsArr = Convert.toStrArray(tagsStr);
                StringBuilder tags_name = new StringBuilder();
                List<Tags> tags = Lists.newArrayList();
                for (String id : tagsArr) {
                    if (StringUtils.isNotEmpty(id)) {

                        Tags tag = tagCache.get(id);
                        if (tag == null) {
                            tag = tagsMapper.selectTagsById(Long.valueOf(id));
                            tagCache.put(id, tag);
                        }
                        tags.add(tag);
                        if (tag != null) {
                            tags_name.append(tag.getTagName()).append(",");
                        }
                    }
                }
                if (tags_name.toString().endsWith(",")) {
                    tags_name = new StringBuilder(StringUtils.substring(tags_name.toString(), 0, tags_name.length() - 1));
                }
                a.setTags_name(tags_name.toString());
                a.setTagList(tags);
            }
        });


    }

    private void selectTags(Article a) {
        String tids = a.getTags();//tagIds
        if (StringUtils.isEmpty(tids)) {
            return;
        }
        String[] arr = Convert.toStrArray(tids);
        List<Tags> tags = Lists.newArrayList();
        for (String tid : arr) {
            if (StringUtils.isEmpty(tid)) {
                continue;
            }
            Tags tag = tagCache.get(tid);
            if (tag == null) {
                tag = tagsMapper.selectTagsById(Long.valueOf(tid));
                tagCache.put(tid, tag);
            }
            tags.add(tag);
        }
        a.setTagList(tags);
    }
}
