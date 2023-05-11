package top.reed.cms.controller;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Material;
import top.reed.cms.domain.MaterialUse;
import top.reed.cms.service.IMaterialService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 素材Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/material")
public class MaterialController extends BaseController {

    @Autowired
    private IMaterialService materialService;

    @RequiresPermissions("cms:material:view")
    @GetMapping()
    public String material() {
        return  "cms/material/material";
    }

    /**
     * 查询素材列表
     */
    @RequiresPermissions("cms:material:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Material material) {
        startPage();
        List<Material> list = materialService.selectMaterialList(material);
        return getDataTable(list);
    }

    /**
     * 导出素材列表
     */
    @RequiresPermissions("cms:material:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Material material) {
        List<Material> list = materialService.selectMaterialList(material);
        ExcelUtil<Material> util = new ExcelUtil<>(Material.class);
        return util.exportExcel(list, "material");
    }

    /**
     * 新增素材
     */
    @GetMapping("/add")
    public String add(ModelMap modelMap) {
        Material material = new Material();
        material.setGroupId("1");
        material.setGroupName("默认分组");
        modelMap.put("material", material);
        return  "cms/material/add";
    }

    /**
     * 新增保存素材
     */
    @RequiresPermissions("cms:material:add")
    @Log(title = "素材", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Material material) {
        return toAjax(materialService.insertMaterial(material));
    }

    /**
     * 修改素材
     */
    @GetMapping("/edit/{materialId}")
    public String edit(@PathVariable("materialId") String materialId, ModelMap modelMap) {
        Material material = materialService.selectMaterialById(materialId);
        modelMap.put("material", material);
        return  "cms/material/edit";
    }

    /**
     * 修改保存素材
     */
    @RequiresPermissions("cms:material:edit")
    @Log(title = "素材", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Material material) {
        return toAjax(materialService.updateMaterial(material));
    }

    /**
     * 删除素材
     */
    @RequiresPermissions("cms:material:remove")
    @Log(title = "素材", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        int n = materialService.deleteMaterialByIds(ids);
        if (n == -1) {
            return error("当前素材有正在使用中的,无法删除!");
        }
        return success();
    }


    /**
     * 删除素材
     */
    @RequiresPermissions("cms:material:audit")
    @Log(title = "素材审核", businessType = BusinessType.OTHER)
    @PostMapping("/audit")
    @ResponseBody
    public AjaxResult audit(String ids) {
        return toAjax(materialService.auditMaterialByIds(ids));
    }


    /**
     * 跳转使用记录页面
     */
    @RequiresPermissions("cms:material:materialUse")
    @GetMapping("/toUseList/{materialId}")
    public String toUseList(@PathVariable("materialId") String materialId, ModelMap modelMap) {
        modelMap.put("materialId", materialId);
        return  "cms/material/materialUse";
    }

    /**
     * 查询使用记录列表
     */
    @PostMapping("/selectMaterialUseList")
    @ResponseBody
    public TableDataInfo selectMaterialUseList(MaterialUse materialUse) {
        startPage();
        List<MaterialUse> list = materialService.selectMaterialUseList(materialUse);
        return getDataTable(list);
    }

    /**
     * 删除素材使用记录
     *
     * @param materialUse 素材使用记录
     * @return data
     */
    @PostMapping("/deleteMaterialUseBatch")
    @ResponseBody
    public AjaxResult deleteMaterialUseBatch(MaterialUse materialUse) {
        materialService.deleteMaterialUseBatch(materialUse);
        return success();
    }

    /**
     * 打开素材选择界面
     *
     * @return  data
     */
    @GetMapping("/selectMaterialWithGroup")
    public String selectMaterialWithGroup(HttpServletRequest request, ModelMap modelMap) {
        String materialId = request.getParameter("materialId");
        String materialName = request.getParameter("materialName");
        String materialPath = request.getParameter("materialPath");
        modelMap.put("materialId", StringUtils.isNotEmpty(materialId) ? materialId : "");
        modelMap.put("materialName", StringUtils.isNotEmpty(materialName) ? materialName : "");
        modelMap.put("materialPath", StringUtils.isNotEmpty(materialPath) ? materialPath : "");
        return  "cms/material/selectMaterialWithGroup";
    }

}
