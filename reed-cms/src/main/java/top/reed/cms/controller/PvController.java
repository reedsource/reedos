package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Pv;
import top.reed.cms.service.IPvService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;

import java.util.List;

/**
 * PVController
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/pv")
public class PvController extends BaseController {
    private final String prefix = "cms/pv";

    @Autowired
    private IPvService pvService;

    @RequiresPermissions("cms:pv:view")
    @GetMapping()
    public String pv() {
        return prefix + "/pv";
    }

    /**
     * 查询PV列表
     */
    @RequiresPermissions("cms:pv:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Pv pv) {
        startPage();
        List<Pv> list = pvService.selectPvList(pv);
        return getDataTable(list);
    }

    /**
     * 新增PV
     */
    @GetMapping("/add")
    public String add() {
        return prefix + "/add";
    }

    /**
     * 新增保存PV
     */
    @RequiresPermissions("cms:pv:add")
    @Log(title = "PV", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Pv pv) {
        return toAjax(pvService.insertPv(pv));
    }

    /**
     * 修改PV
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap) {
        Pv pv = pvService.selectPvById(id);
        mmap.put("pv", pv);
        return prefix + "/edit";
    }

    /**
     * 修改保存PV
     */
    @RequiresPermissions("cms:pv:edit")
    @Log(title = "PV", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Pv pv) {
        return toAjax(pvService.updatePv(pv));
    }

    /**
     * 删除PV
     */
    @RequiresPermissions("cms:pv:remove")
    @Log(title = "PV", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(pvService.deletePvByIds(ids));
    }
}
