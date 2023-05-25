package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Album;
import top.reed.cms.domain.AlbumMaterial;
import top.reed.cms.domain.Material;
import top.reed.cms.service.IAlbumService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * 素材相册Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/album")
public class AlbumController extends BaseController {

    @Autowired
    private IAlbumService albumService;

    @RequiresPermissions("cms:album:view")
    @GetMapping()
    public String album() {
        return "cms/album/album";
    }

    /**
     * 查询素材专辑列表
     */
    @RequiresPermissions("cms:album:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Album album) {
        startPage();
        List<Album> list = albumService.selectAlbumList(album);
        return getDataTable(list);
    }

    /**
     * 新增素材专辑
     */
    @GetMapping("/add")
    public String add() {
        return "cms/album/add";
    }

    /**
     * 新增保存素材专辑
     */
    @RequiresPermissions("cms:album:add")
    @Log(title = "素材专辑", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Album album) {
        return toAjax(albumService.insertAlbum(album));
    }

    /**
     * 修改素材专辑
     */
    @GetMapping("/edit/{albumId}")
    public String edit(@PathVariable("albumId") String albumId, ModelMap modelMap) {
        Album album = albumService.selectAlbumById(albumId);
        modelMap.put("album", album);
        return "cms/album/edit";
    }

    /**
     * 修改保存素材专辑
     */
    @RequiresPermissions("cms:album:edit")
    @Log(title = "素材专辑", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Album album) {
        return toAjax(albumService.updateAlbum(album));
    }

    /**
     * 删除素材专辑
     */
    @RequiresPermissions("cms:album:remove")
    @Log(title = "素材专辑", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(albumService.deleteAlbumByIds(ids));
    }


    /**
     * 跳转分配素材页面
     */
    @RequiresPermissions("cms:album:addMaterial")
    @GetMapping("/toAddMaterial/{albumId}")
    public String toAddMaterial(@PathVariable("albumId") String albumId, ModelMap modelMap) {
        modelMap.put("albumId", albumId);
        return "cms/album/addMaterial";
    }

    /**
     * 查询相册绑定的素材图片列表
     */
    @PostMapping("/materialList")
    @ResponseBody
    public TableDataInfo materialList(Material material) {
        List<AlbumMaterial> list = albumService.selectAlbumMaterialList(material);
        return getDataTable(list);
    }


    /**
     * 跳转选择未分配素材页面
     */
    @GetMapping("/selectMaterial/{albumId}")
    public String selectMaterial(@PathVariable("albumId") String albumId, ModelMap modelMap) {
        modelMap.put("albumId", albumId);
        return "cms/album/selectMaterial";
    }


    /**
     * 查询未配置的素材
     */
    @PostMapping("/unMaterialList")
    @ResponseBody
    public TableDataInfo unMaterialList(Material material) {
        startPage();
        List<Material> list = albumService.selectAlbumUnMaterialList(material);
        return getDataTable(list);
    }

    /**
     * 保存素材
     */
    @PostMapping("/saveMaterial")
    @ResponseBody
    public AjaxResult saveMaterial(String albumId, String materialIds) {
        if (StringUtils.isEmpty(albumId) || StringUtils.isEmpty(materialIds)) {
            return AjaxResult.error("参数传递错误!");
        }
        albumService.saveMaterial(albumId, materialIds);
        return success();
    }

    /**
     * 删除专辑关联的素材
     */
    @PostMapping("/deleteMaterialBatch")
    @ResponseBody
    public AjaxResult deleteMaterialBatch(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return AjaxResult.error("参数传递错误!");
        }
        albumService.deleteMaterialBatch(ids);
        return success();
    }

    /**
     * 获取一个专辑以及其关联的素材
     */
    @PostMapping("/getAlbum")
    @ResponseBody
    public AjaxResult getAlbum(String code) {
        if (StringUtils.isEmpty(code)) {
            return AjaxResult.error("参数code不能为空!");
        }
        Map data = albumService.getAlbum(code);
        return AjaxResult.success(data);
    }


}
