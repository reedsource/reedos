package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.ArticleTemplate;
import top.reed.cms.domain.Tags;
import top.reed.cms.service.IArticleTemplateService;
import top.reed.cms.util.CmsConstants;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.system.service.ISysConfigService;

import java.util.List;

/**
 * 文章模板Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/articleTemplate")
public class ArticleTemplateController extends BaseController {

    @Autowired
    private IArticleTemplateService articleTemplateService;

    @Autowired
    private ISysConfigService configService;

    private String getEditorType() {
        return configService.selectConfigByKey(CmsConstants.KEY_EDITOR_TYPE);
    }


    @RequiresPermissions("cms:articleTemplate:view")
    @GetMapping()
    public String articleTemplate(ModelMap modelMap) {
        String editor = getEditorType();
        if (!CmsConstants.EDITOR_TYPE_UEDITOR.equals(editor)) {
            modelMap.put("editorOK", false);
        } else {
            modelMap.put("editorOK", true);
        }
        return "cms/articleTemplate/articleTemplate";
    }

    /**
     * 查询文章模板列表
     */
    @RequiresPermissions("cms:articleTemplate:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(ArticleTemplate articleTemplate) {
        startPage();
        List<ArticleTemplate> list = articleTemplateService.selectArticleTemplateList(articleTemplate);
        return getDataTable(list);
    }

    /**
     * 新增文章模板
     */
    @GetMapping("/add")
    public String add(ModelMap modelMap) {
        List<Tags> tags = articleTemplateService.selectArticleTemplateTags("");
        modelMap.put("tags", tags);
        return "cms/articleTemplate/add";
    }

    /**
     * 新增保存文章模板
     */
    @RequiresPermissions("cms:articleTemplate:add")
    @Log(title = "文章模板", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(ArticleTemplate articleTemplate) {
        return toAjax(articleTemplateService.insertArticleTemplate(articleTemplate));
    }

    /**
     * 修改文章模板
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap modelMap) {
        ArticleTemplate articleTemplate = articleTemplateService.selectArticleTemplateById(id);
        modelMap.put("articleTemplate", articleTemplate);
        List<Tags> tags = articleTemplateService.selectArticleTemplateTags(articleTemplate.getTags());
        modelMap.put("tags", tags);
        return "cms/articleTemplate/edit";
    }

    /**
     * 修改保存文章模板
     */
    @RequiresPermissions("cms:articleTemplate:edit")
    @Log(title = "文章模板", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(ArticleTemplate articleTemplate) {
        return toAjax(articleTemplateService.updateArticleTemplate(articleTemplate));
    }

    /**
     * 删除文章模板
     */
    @RequiresPermissions("cms:articleTemplate:remove")
    @Log(title = "文章模板", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(articleTemplateService.deleteArticleTemplateByIds(ids));
    }

    /*#############################华丽的分割线#####################################*/
    @GetMapping("/listNew")
    public String articleTemplateList() {
        return "cms/articleTemplate/articleTemplateList";
    }

}
