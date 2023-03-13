package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.MaterialGroup;
import top.reed.cms.service.IMaterialGroupService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.domain.Ztree;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.RStringUtils;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 素材分组Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/materialGroup")
public class MaterialGroupController extends BaseController {

    @Autowired
    private IMaterialGroupService materialGroupService;

    @RequiresPermissions("cms:materialGroup:view")
    @GetMapping()
    public String materialGroup() {
        return "cms/materialGroup/materialGroup";
    }

    /**
     * 查询素材分组树列表
     */
    @RequiresPermissions("cms:materialGroup:list")
    @PostMapping("/list")
    @ResponseBody
    public List<MaterialGroup> list(MaterialGroup materialGroup) {
        return materialGroupService.selectMaterialGroupList(materialGroup);
    }

    /**
     * 导出素材分组列表
     */
    @RequiresPermissions("cms:materialGroup:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(MaterialGroup materialGroup) {
        List<MaterialGroup> list = materialGroupService.selectMaterialGroupList(materialGroup);
        ExcelUtil<MaterialGroup> util = new ExcelUtil<>(MaterialGroup.class);
        return util.exportExcel(list, "materialGroup");
    }

    /**
     * 新增素材分组
     */
    @GetMapping(value = {"/add/{groupId}", "/add/"})
    public String add(@PathVariable(value = "groupId", required = false) Long groupId, ModelMap mmap) {
        if (RStringUtils.isNotNull(groupId)) {
            mmap.put("materialGroup", materialGroupService.selectMaterialGroupById(groupId));
        }
        return "cms/materialGroup/add";
    }

    /**
     * 新增保存素材分组
     */
    @RequiresPermissions("cms:materialGroup:add")
    @Log(title = "素材分组", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(MaterialGroup materialGroup) {
        return toAjax(materialGroupService.insertMaterialGroup(materialGroup));
    }

    /**
     * 修改素材分组
     */
    @GetMapping("/edit/{groupId}")
    public String edit(@PathVariable("groupId") Long groupId, ModelMap mmap) {
        MaterialGroup materialGroup = materialGroupService.selectMaterialGroupById(groupId);
        mmap.put("materialGroup", materialGroup);
        return "cms/materialGroup/edit";
    }

    /**
     * 修改保存素材分组
     */
    @RequiresPermissions("cms:materialGroup:edit")
    @Log(title = "素材分组", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(MaterialGroup materialGroup) {
        return toAjax(materialGroupService.updateMaterialGroup(materialGroup));
    }

    /**
     * 删除
     */
    @RequiresPermissions("cms:materialGroup:remove")
    @Log(title = "素材分组", businessType = BusinessType.DELETE)
    @GetMapping("/remove/{groupId}")
    @ResponseBody
    public AjaxResult remove(@PathVariable("groupId") Long groupId) {
        return toAjax(materialGroupService.deleteMaterialGroupById(groupId));
    }

    /**
     * 选择素材分组树
     */
    @GetMapping(value = {"/selectMaterialGroupTree/{groupId}", "/selectMaterialGroupTree/"})
    public String selectMaterialGroupTree(@PathVariable(value = "groupId", required = false) Long groupId, ModelMap mmap) {
        if (RStringUtils.isNotNull(groupId)) {
            mmap.put("materialGroup", materialGroupService.selectMaterialGroupById(groupId));
        }
        return "cms/materialGroup/tree";
    }

    /**
     * 加载素材分组树列表
     */
    @GetMapping("/treeData")
    @ResponseBody
    public List<Ztree> treeData() {
        return materialGroupService.selectMaterialGroupTree();
    }
}
