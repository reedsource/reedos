package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Category;

import java.util.List;

/**
 * 栏目分类Mapper接口
 *
 * @author reedsource
 * date 2019-10-28
 */
@Mapper
public interface CategoryMapper {
    /**
     * 查询栏目分类
     *
     * @param categoryId 栏目分类ID
     * @return 栏目分类
     */
    Category selectCategoryById(Long categoryId);

    /**
     * 查询栏目分类列表
     *
     * @param category 栏目分类
     * @return 栏目分类集合
     */
    List<Category> selectCategoryList(Category category);

    /**
     * 新增栏目分类
     *
     * @param category 栏目分类
     * @return 结果
     */
    int insertCategory(Category category);

    /**
     * 修改栏目分类
     *
     * @param category 栏目分类
     * @return 结果
     */
    int updateCategory(Category category);

    /**
     * 删除栏目分类
     *
     * @param categoryId 栏目分类ID
     * @return 结果
     */
    int deleteCategoryById(String categoryId);

    /**
     * 批量删除栏目分类
     *
     * @param categoryIds 需要删除的数据ID
     * @return 结果
     */
    int deleteCategoryByIds(String[] categoryIds);

    /**
     * 查询导航栏目
     */
    List<Category> selectNavCategories(Category category);

}
