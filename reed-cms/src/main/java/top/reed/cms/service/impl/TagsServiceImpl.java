package top.reed.cms.service.impl;

import cn.hutool.cache.Cache;
import cn.hutool.cache.CacheUtil;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Tags;
import top.reed.cms.mapper.TagsMapper;
import top.reed.cms.service.ITagsService;
import top.reed.cms.util.CmsConstants;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.CacheUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 标签管理Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class TagsServiceImpl implements ITagsService {
    private static final Cache<String, Tags> tagsCache = CacheUtil.newLRUCache(1000, 1000 * 60 * 60);
    @Autowired
    private TagsMapper tagsMapper;

    /**
     * 查询标签管理
     *
     * @param tagId 标签管理ID
     * @return 标签管理
     */
    @Override
    public Tags selectTagsById(Long tagId) {
        Tags tag = tagsCache.get(tagId.toString());
        if (tag == null) {
            tag = tagsMapper.selectTagsById(tagId);
            tagsCache.put(tagId.toString(), tag);
        }
        return tag;
    }

    @Override
    public Tags getTagByName(String type, String name) {
        return tagsMapper.getTagByName(type, name);
    }

    /**
     * 查询标签管理列表
     *
     * @param tags 标签管理
     * @return 标签管理
     */
    @Override
    public List<Tags> selectTagsList(Tags tags) {
        return tagsMapper.selectTagsList(tags);
    }

    /**
     * 新增标签管理
     *
     * @param tags 标签管理
     * @return 结果
     */
    @Override
    public int insertTags(Tags tags) {
        return tagsMapper.insertTags(tags);
    }

    /**
     * 修改标签管理
     *
     * @param tags 标签管理
     * @return 结果
     */
    @Override
    public int updateTags(Tags tags) {
        return tagsMapper.updateTags(tags);
    }

    /**
     * 删除标签管理对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteTagsByIds(String ids) {
        return tagsMapper.deleteTagsByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除标签管理信息
     *
     * @param tagId 标签管理ID
     * @return 结果
     */
    @Override
    public int deleteTagsById(Long tagId) {
        return tagsMapper.deleteTagsById(tagId);
    }

    @Override
    public List<Tags> selectTagsAll() {
        return tagsMapper.selectTagsAll();
    }

    @Override
    public List<Tags> selectSelectedTagsAll(String selectedIds) {

        List<Tags> tags = this.selectTagsAll();

        if (StringUtils.isNotEmpty(selectedIds)) {
            if (selectedIds.endsWith(",")) {
                selectedIds = selectedIds.substring(0, selectedIds.length() - 1);
            }
            String[] arr = Convert.toStrArray(selectedIds);
            List<String> list = Lists.newArrayList(arr);
            tags.forEach(t -> {
                if (list.contains(t.getTagId().toString())) {
                    t.setSelected(true);
                }
            });
        }
        return tags;
    }

    @Override
    public List<Tags> selectBlogTabs() {
        Object object = CacheUtils.get("reed-cms", CmsConstants.KEY_TAGS_BLOG);
        List<Tags> tags;
        if (object instanceof ArrayList) {
            tags = (ArrayList) object;
        } else {
            String s = (String) object;
            if (StringUtils.isNotEmpty(s)) {
                tags = JSONArray.parseArray(s, Tags.class);
            } else {
                tags = tagsMapper.selectBlogTabs();
                CacheUtils.put("reed-cms", CmsConstants.KEY_TAGS_BLOG, tags);
            }
        }

        return tags;
    }
}
