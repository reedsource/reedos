package top.reed.cms.service;

import top.reed.cms.domain.BlogTheme;

import java.util.List;

/**
 * 博客主题Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IBlogThemeService {
    /**
     * 查询博客主题
     *
     * @param id 博客主题ID
     * @return 博客主题
     */
    BlogTheme selectBlogThemeById(Long id);

    /**
     * 查询博客主题列表
     *
     * @param blogTheme 博客主题
     * @return 博客主题集合
     */
    List<BlogTheme> selectBlogThemeList(BlogTheme blogTheme);

    /**
     * 新增博客主题
     *
     * @param blogTheme 博客主题
     * @return 结果
     */
    int insertBlogTheme(BlogTheme blogTheme);

    /**
     * 修改博客主题
     *
     * @param blogTheme 博客主题
     * @return 结果
     */
    int updateBlogTheme(BlogTheme blogTheme);

    /**
     * 批量删除博客主题
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteBlogThemeByIds(String ids);

    /**
     * 删除博客主题信息
     *
     * @param id 博客主题ID
     * @return 结果
     */
    int deleteBlogThemeById(Long id);

}
