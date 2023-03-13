package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Filetype;
import top.reed.cms.service.IFiletypeService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 文件类型Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/filetype")
public class FiletypeController extends BaseController {
    private final String prefix = "cms/filetype";

    @Autowired
    private IFiletypeService filetypeService;

    @RequiresPermissions("cms:filetype:view")
    @GetMapping()
    public String filetype() {
        return prefix + "/filetype";
    }

    /**
     * 查询文件类型列表
     */
    @RequiresPermissions("cms:filetype:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Filetype filetype) {
        startPage();
        List<Filetype> list = filetypeService.selectFiletypeList(filetype);
        return getDataTable(list);
    }

    /**
     * 导出文件类型列表
     */
    @RequiresPermissions("cms:filetype:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Filetype filetype) {
        List<Filetype> list = filetypeService.selectFiletypeList(filetype);
        ExcelUtil<Filetype> util = new ExcelUtil<>(Filetype.class);
        return util.exportExcel(list, "filetype");
    }

    /**
     * 新增文件类型
     */
    @GetMapping("/add")
    public String add() {
        return prefix + "/add";
    }

    /**
     * 新增保存文件类型
     */
    @RequiresPermissions("cms:filetype:add")
    @Log(title = "文件类型", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Filetype filetype) {
        return toAjax(filetypeService.insertFiletype(filetype));
    }

    /**
     * 修改文件类型
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap) {
        Filetype filetype = filetypeService.selectFiletypeById(id);
        mmap.put("filetype", filetype);
        return prefix + "/edit";
    }

    /**
     * 修改保存文件类型
     */
    @RequiresPermissions("cms:filetype:edit")
    @Log(title = "文件类型", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Filetype filetype) {
        return toAjax(filetypeService.updateFiletype(filetype));
    }

    /**
     * 删除文件类型
     */
    @RequiresPermissions("cms:filetype:remove")
    @Log(title = "文件类型", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(filetypeService.deleteFiletypeByIds(ids));
    }

    /*@GetMapping( "/selectDictData")
    @ResponseBody
    public Object selectDictData(){
        return filetypeService.selectDictData();
    }*/
}
