package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Template;
import top.reed.cms.service.ITemplateService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 模板Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/template")
public class TemplateController extends BaseController {

    @Autowired
    private ITemplateService templateService;

    @RequiresPermissions("cms:template:view")
    @GetMapping()
    public String template() {
        return "cms/template/template";
    }

    /**
     * 查询模板列表
     */
    @RequiresPermissions("cms:template:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Template template) {
        startPage();
        List<Template> list = templateService.selectTemplateList(template);
        return getDataTable(list);
    }

    /**
     * 导出模板列表
     */
    @RequiresPermissions("cms:template:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Template template) {
        List<Template> list = templateService.selectTemplateList(template);
        ExcelUtil<Template> util = new ExcelUtil<>(Template.class);
        return util.exportExcel(list, "template");
    }

    /**
     * 新增模板
     */
    @GetMapping("/add")
    public String add() {
        return "cms/template/add";
    }

    /**
     * 新增保存模板
     */
    @RequiresPermissions("cms:template:add")
    @Log(title = "模板", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Template template) {
        return toAjax(templateService.insertTemplate(template));
    }

    /**
     * 修改模板
     */
    @GetMapping("/edit/{templateId}")
    public String edit(@PathVariable("templateId") Long templateId, ModelMap modelMap) {
        Template template = templateService.selectTemplateById(templateId);
        modelMap.put("template", template);
        return "cms/template/edit";
    }

    /**
     * 修改保存模板
     */
    @RequiresPermissions("cms:template:edit")
    @Log(title = "模板", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Template template) {
        return toAjax(templateService.updateTemplate(template));
    }

    /**
     * 删除模板
     */
    @RequiresPermissions("cms:template:remove")
    @Log(title = "模板", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(templateService.deleteTemplateByIds(ids));
    }
}
