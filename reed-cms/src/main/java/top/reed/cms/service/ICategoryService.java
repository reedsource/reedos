package top.reed.cms.service;

import top.reed.cms.domain.Category;
import top.reed.common.core.domain.Ztree;

import java.util.List;

/**
 * 栏目分类Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ICategoryService {
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
     * 批量删除栏目分类
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteCategoryByIds(String ids);

    /**
     * 删除栏目分类信息
     *
     * @param categoryId 栏目分类ID
     * @return 结果
     */
    int deleteCategoryById(String categoryId);

    /**
     * 查询栏目分类树列表
     *
     * @return 所有栏目分类信息
     */
    List<Ztree> selectCategoryTree();

    /**
     * 查询导航栏目
     */
    List<Category> selectNavCategories(Category category);
}
