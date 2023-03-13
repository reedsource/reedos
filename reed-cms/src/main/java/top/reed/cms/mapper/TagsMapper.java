package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.reed.cms.domain.Tags;

import java.util.List;

/**
 * 标签管理Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface TagsMapper {
    /**
     * 查询标签管理
     *
     * @param tagId 标签管理ID
     * @return 标签管理
     */
    Tags selectTagsById(Long tagId);


    Tags getTagByName(@Param("type") String type, @Param("name") String name);

    /**
     * 查询标签管理列表
     *
     * @param tags 标签管理
     * @return 标签管理集合
     */
    List<Tags> selectTagsList(Tags tags);

    /**
     * 新增标签管理
     *
     * @param tags 标签管理
     * @return 结果
     */
    int insertTags(Tags tags);

    /**
     * 修改标签管理
     *
     * @param tags 标签管理
     * @return 结果
     */
    int updateTags(Tags tags);

    /**
     * 删除标签管理
     *
     * @param tagId 标签管理ID
     * @return 结果
     */
    int deleteTagsById(Long tagId);

    /**
     * 批量删除标签管理
     *
     * @param tagIds 需要删除的数据ID
     * @return 结果
     */
    int deleteTagsByIds(String[] tagIds);

    /**
     * 查询所有标签
     *
     * @return
     */
    List<Tags> selectTagsAll();

    /**
     * 查询前台页面fullTabs标签
     *
     * @return
     */
    List<Tags> selectBlogTabs();
}
