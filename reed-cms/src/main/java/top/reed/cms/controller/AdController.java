package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Ad;
import top.reed.cms.domain.AdMaterial;
import top.reed.cms.service.IAdService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 广告位Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/ad")
public class AdController extends BaseController {

    @Autowired
    private IAdService adService;

    @RequiresPermissions("cms:ad:view")
    @GetMapping()
    public String ad() {
        return "cms/ad/ad";
    }

    /**
     * 查询广告位列表
     */
    @RequiresPermissions("cms:ad:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Ad ad) {
        startPage();
        List<Ad> list = adService.selectAdList(ad);
        return getDataTable(list);
    }

    /**
     * 导出广告位列表
     */
    @RequiresPermissions("cms:ad:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Ad ad) {
        List<Ad> list = adService.selectAdList(ad);
        ExcelUtil<Ad> util = new ExcelUtil<>(Ad.class);
        return util.exportExcel(list, "ad");
    }

    /**
     * 新增广告位
     */
    @GetMapping("/add")
    public String add() {
        return "cms/ad/add";
    }

    /**
     * 新增保存广告位
     */
    @RequiresPermissions("cms:ad:add")
    @Log(title = "广告位", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Ad ad) {
        return toAjax(adService.insertAd(ad));
    }

    /**
     * 修改广告位
     */
    @GetMapping("/edit/{adId}")
    public String edit(@PathVariable("adId") Long adId, ModelMap modelMap) {
        Ad ad = adService.selectAdById(adId);
        modelMap.put("ad", ad);
        return "cms/ad/edit";
    }

    /**
     * 修改保存广告位
     */
    @RequiresPermissions("cms:ad:edit")
    @Log(title = "广告位", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Ad ad) {
        return toAjax(adService.updateAd(ad));
    }

    /**
     * 删除广告位
     */
    @RequiresPermissions("cms:ad:remove")
    @Log(title = "广告位", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(adService.deleteAdByIds(ids));
    }


    /**
     * 跳转配置广告页面
     */
    @GetMapping("/adMaterial/{adId}")
    public String adMaterial(@PathVariable("adId") String adId, ModelMap modelMap) {
        modelMap.put("adId", adId);
        return "cms/ad/adMaterial";
    }

    /**
     * 查询广告位绑定的素材列表
     */
    @PostMapping("/adMaterialList")
    @ResponseBody
    public TableDataInfo adMaterialList(AdMaterial adMaterial) {
        List<AdMaterial> list = adService.selectAdMaterialList(adMaterial);
        return getDataTable(list);
    }

    /**
     * 跳转新增广告素材页面
     */
    @GetMapping("/addAdMaterial/{adId}")
    public String addAdMaterial(@PathVariable("adId") String adId, ModelMap modelMap) {
        modelMap.put("adId", adId);
        return "cms/ad/addAdMaterial";
    }

    /**
     * 新增保存广告位
     */

    @PostMapping("/addAdMaterialSave")
    @ResponseBody
    public AjaxResult addAdMaterialSave(AdMaterial adMaterial) {
        return toAjax(adService.insertAdMaterial(adMaterial));
    }

    /**
     * 跳转编辑广告素材页面
     */
    @GetMapping("/editAdMaterial/{id}")
    public String editAdMaterial(@PathVariable("id") Long id, ModelMap modelMap) {
        AdMaterial adMaterial = adService.selectAdMaterialById(id);

        modelMap.put("adMaterial", adMaterial);
        return "cms/ad/editAdMaterial";
    }

    /**
     * 修改保存广告位素材
     */
    @PostMapping("/editAdMaterialSave")
    @ResponseBody
    public AjaxResult editAdMaterialSave(AdMaterial adMaterial) {
        return toAjax(adService.updateAdMaterial(adMaterial));
    }

    /**
     * 删除广告位素材
     */
    @PostMapping("/removeAdMaterial")
    @ResponseBody
    public AjaxResult removeAdMaterial(String ids) {
        return toAjax(adService.deleteAdMaterialByIds(ids));
    }


    /**
     * 打开广告素材选择界面
     *
     */
    @GetMapping("/selectAdMaterial/{adId}")
    public String selectAdMaterial(@PathVariable("adId") String adId, ModelMap modelMap) {
        modelMap.put("adId", adId);
        return "cms/ad/selectAdMaterial";
    }

    /**
     * 查询未配置的素材
     *
     * @param adMaterial 广告素材
     */
    @PostMapping("/unMaterialList")
    @ResponseBody
    public TableDataInfo unMaterialList(AdMaterial adMaterial) {
        startPage();
        List<AdMaterial> list = adService.selectAdUnMaterialList(adMaterial);
        return getDataTable(list);
    }


}
