package top.reed.cms.service.impl;

import cn.hutool.cache.Cache;
import cn.hutool.cache.CacheUtil;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.ArticleTemplate;
import top.reed.cms.domain.Tags;
import top.reed.cms.mapper.ArticleTemplateMapper;
import top.reed.cms.mapper.TagsMapper;
import top.reed.cms.service.IArticleTemplateService;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.ShiroUtils;

import java.util.List;

/**
 * 文章模板Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class ArticleTemplateServiceImpl implements IArticleTemplateService {
    private final Cache<String, Tags> tagCache = CacheUtil.newLFUCache(100);
    @Autowired
    private ArticleTemplateMapper articleTemplateMapper;
    @Autowired
    private TagsMapper tagsMapper;

    /**
     * 查询文章模板
     *
     * @param id 文章模板ID
     * @return 文章模板
     */
    @Override
    public ArticleTemplate selectArticleTemplateById(Long id) {
        return articleTemplateMapper.selectArticleTemplateById(id);
    }

    /**
     * 查询文章模板列表
     *
     * @param articleTemplate 文章模板
     * @return 文章模板
     */
    @Override
    public List<ArticleTemplate> selectArticleTemplateList(ArticleTemplate articleTemplate) {

        List<ArticleTemplate> articleTemplates = articleTemplateMapper.selectArticleTemplateList(articleTemplate);
        selectTags(articleTemplates);
        return articleTemplates;
    }

    /**
     * 新增文章模板
     *
     * @param articleTemplate 文章模板
     * @return 结果
     */
    @Override
    public int insertArticleTemplate(ArticleTemplate articleTemplate) {
        SysUser user = ShiroUtils.getSysUser();
        articleTemplate.setUserId(user.getUserId().toString());
        articleTemplate.setUserName(user.getUserName());
        articleTemplate.setCreateTime(DateUtils.getNowDate());
        articleTemplate.setAudit(0);
        return articleTemplateMapper.insertArticleTemplate(articleTemplate);
    }

    /**
     * 修改文章模板
     *
     * @param articleTemplate 文章模板
     * @return 结果
     */
    @Override
    public int updateArticleTemplate(ArticleTemplate articleTemplate) {
        return articleTemplateMapper.updateArticleTemplate(articleTemplate);
    }

    /**
     * 删除文章模板对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteArticleTemplateByIds(String ids) {
        return articleTemplateMapper.deleteArticleTemplateByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除文章模板信息
     *
     * @param id 文章模板ID
     * @return 结果
     */
    @Override
    public int deleteArticleTemplateById(Long id) {
        return articleTemplateMapper.deleteArticleTemplateById(id);
    }

    @Override
    public List<Tags> selectArticleTemplateTags(String tagIds) {
        List<Tags> tags = articleTemplateMapper.selectArticleTemplateTags();
        if (StringUtils.isEmpty(tagIds)) {
            return tags;
        }
        if (tagIds.endsWith(",")) {
            tagIds = tagIds.substring(0, tagIds.length() - 1);
        }
        String[] arr = Convert.toStrArray(tagIds);
        List<String> list = Lists.newArrayList(arr);
        tags.forEach(t -> {
            if (list.contains(t.getTagId().toString())) {
                t.setSelected(true);
            }
        });
        return tags;
    }


    private void selectTags(List<ArticleTemplate> articleTemplates) {

        //转换标签名称，这部分可以使用缓存提升性能
        articleTemplates.forEach(a -> {
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
                a.setTagNames(tags_name.toString());
                //a.setTagList(tags);
            }
        });


    }
}
