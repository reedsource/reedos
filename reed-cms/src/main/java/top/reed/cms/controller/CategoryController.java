package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Category;
import top.reed.cms.service.ICategoryService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.domain.Ztree;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.RStringUtils;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 栏目分类Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/category")
public class CategoryController extends BaseController {

    @Autowired
    private ICategoryService categoryService;

    @RequiresPermissions("cms:category:view")
    @GetMapping()
    public String category() {
        return  "cms/category/category";
    }

    /**
     * 查询栏目分类树列表
     */
    @RequiresPermissions("cms:category:list")
    @PostMapping("/list")
    @ResponseBody
    public List<Category> list(Category category) {
        return categoryService.selectCategoryList(category);
    }

    /**
     * 导出栏目分类列表
     */
    @RequiresPermissions("cms:category:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Category category) {
        List<Category> list = categoryService.selectCategoryList(category);
        ExcelUtil<Category> util = new ExcelUtil<>(Category.class);
        return util.exportExcel(list, "category");
    }

    /**
     * 新增栏目分类
     */
    @GetMapping(value = {"/add/{categoryId}", "/add/"})
    public String add(@PathVariable(value = "categoryId", required = false) Long categoryId, ModelMap mmap) {
        if (RStringUtils.isNotNull(categoryId)) {
            mmap.put("category", categoryService.selectCategoryById(categoryId));
        }
        return  "cms/category/add";
    }

    /**
     * 新增保存栏目分类
     */
    @RequiresPermissions("cms:category:add")
    @Log(title = "栏目分类", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Category category) {
        return toAjax(categoryService.insertCategory(category));
    }

    /**
     * 修改栏目分类
     */
    @GetMapping("/edit/{categoryId}")
    public String edit(@PathVariable("categoryId") Long categoryId, ModelMap mmap) {
        Category category = categoryService.selectCategoryById(categoryId);
        mmap.put("category", category);
        return  "cms/category/edit";
    }

    /**
     * 修改保存栏目分类
     */
    @RequiresPermissions("cms:category:edit")
    @Log(title = "栏目分类", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Category category) {
        return toAjax(categoryService.updateCategory(category));
    }

    /**
     * 删除
     */
    @RequiresPermissions("cms:category:remove")
    @Log(title = "栏目分类", businessType = BusinessType.DELETE)
    @GetMapping("/remove/{categoryId}")
    @ResponseBody
    public AjaxResult remove(@PathVariable("categoryId") String categoryId) {
        return toAjax(categoryService.deleteCategoryById(categoryId));
    }

    /**
     * 选择栏目分类树
     */
    @GetMapping(value = {"/selectCategoryTree/{categoryId}", "/selectCategoryTree/"})
    public String selectCategoryTree(@PathVariable(value = "categoryId", required = false) Long categoryId, ModelMap mmap) {
        if (RStringUtils.isNotNull(categoryId)) {
            mmap.put("category", categoryService.selectCategoryById(categoryId));
        }
        return  "cms/category/tree";
    }

    /**
     * 加载栏目分类树列表
     */
    @GetMapping("/treeData")
    @ResponseBody
    public List<Ztree> treeData() {
        return categoryService.selectCategoryTree();
    }
}
