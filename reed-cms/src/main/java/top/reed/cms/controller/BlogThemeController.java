package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.BlogTheme;
import top.reed.cms.service.IBlogThemeService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 博客主题Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/blogTheme")
public class BlogThemeController extends BaseController {

    @Autowired
    private IBlogThemeService blogThemeService;

    @RequiresPermissions("cms:blogTheme:view")
    @GetMapping()
    public String blogTheme() {
        return "cms/blogTheme/blogTheme";
    }

    /**
     * 查询博客主题列表
     */
    @RequiresPermissions("cms:blogTheme:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(BlogTheme blogTheme) {
        startPage();
        List<BlogTheme> list = blogThemeService.selectBlogThemeList(blogTheme);
        return getDataTable(list);
    }

    /**
     * 导出博客主题列表
     */
    @RequiresPermissions("cms:blogTheme:export")
    @Log(title = "博客主题", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(BlogTheme blogTheme) {
        List<BlogTheme> list = blogThemeService.selectBlogThemeList(blogTheme);
        ExcelUtil<BlogTheme> util = new ExcelUtil<>(BlogTheme.class);
        return util.exportExcel(list, "theme");
    }

    /**
     * 新增博客主题
     */
    @GetMapping("/add")
    public String add() {
        return "cms/blogTheme/add";
    }

    /**
     * 新增保存博客主题
     */
    @RequiresPermissions("cms:blogTheme:add")
    @Log(title = "博客主题", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(BlogTheme blogTheme) {
        return toAjax(blogThemeService.insertBlogTheme(blogTheme));
    }

    /**
     * 修改博客主题
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap modelMap) {
        BlogTheme blogTheme = blogThemeService.selectBlogThemeById(id);
        modelMap.put("blogTheme", blogTheme);
        return "cms/blogTheme/edit";
    }

    /**
     * 修改保存博客主题
     */
    @RequiresPermissions("cms:blogTheme:edit")
    @Log(title = "博客主题", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(BlogTheme blogTheme) {
        return toAjax(blogThemeService.updateBlogTheme(blogTheme));
    }

    /**
     * 删除博客主题
     */
    @RequiresPermissions("cms:blogTheme:remove")
    @Log(title = "博客主题", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(blogThemeService.deleteBlogThemeByIds(ids));
    }

}
