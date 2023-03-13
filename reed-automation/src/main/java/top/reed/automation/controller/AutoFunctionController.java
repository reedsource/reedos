package top.reed.automation.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.automation.domain.AutoFunction;
import top.reed.automation.service.AutoFunctionService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 自定义函数Controller
 *
 * @author reedsource
 * date 2022-09-29
 */
@Controller
@RequestMapping("/automation/autofunction")
public class AutoFunctionController extends BaseController {

    private final AutoFunctionService autoFunctionService;

    public AutoFunctionController(AutoFunctionService autoFunctionService) {
        this.autoFunctionService = autoFunctionService;
    }

    @RequiresPermissions("automation:autofunction:view")
    @GetMapping()
    public String autofunction() {
        return "automation/autofunction/autofunction";
    }

    /**
     * 查询自定义函数列表
     */
    @RequiresPermissions("automation:autofunction:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(AutoFunction autoFunction) {
        startPage();
        List<AutoFunction> list = autoFunctionService.selectAutoFunctionList(autoFunction);
        return getDataTable(list);
    }

    /**
     * 导出自定义函数列表
     */
    @RequiresPermissions("automation:autofunction:export")
    @Log(title = "自定义函数", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(AutoFunction autoFunction) {
        List<AutoFunction> list = autoFunctionService.selectAutoFunctionList(autoFunction);
        ExcelUtil<AutoFunction> util = new ExcelUtil<>(AutoFunction.class);
        return util.exportExcel(list, "自定义函数数据");
    }

    /**
     * 新增自定义函数
     */
    @GetMapping("/add")
    public String add() {
        return "automation/autofunction/add";
    }

    /**
     * 新增保存自定义函数
     */
    @RequiresPermissions("automation:autofunction:add")
    @Log(title = "自定义函数", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(AutoFunction autoFunction) {
        return toAjax(autoFunctionService.insertAutoFunction(autoFunction));
    }

    /**
     * 修改自定义函数
     */
    @RequiresPermissions("automation:autofunction:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap) {
        AutoFunction autoFunction = autoFunctionService.selectAutoFunctionById(id);
        mmap.put("autoFunction", autoFunction);
        return "automation/autofunction/edit";
    }

    /**
     * 修改保存自定义函数
     */
    @RequiresPermissions("automation:autofunction:edit")
    @Log(title = "自定义函数", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(AutoFunction autoFunction) {
        return toAjax(autoFunctionService.updateAutoFunction(autoFunction));
    }

    /**
     * 删除自定义函数
     */
    @RequiresPermissions("automation:autofunction:remove")
    @Log(title = "自定义函数", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(autoFunctionService.deleteAutoFunctionByIds(ids));
    }
}
