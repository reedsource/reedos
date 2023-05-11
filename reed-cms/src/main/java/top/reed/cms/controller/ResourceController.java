package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.reed.cms.domain.Resource;
import top.reed.cms.service.IResourceService;
import top.reed.common.annotation.Log;
import top.reed.common.config.ReedConfig;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.file.FileUploadUtils;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 资源Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/resource")
public class ResourceController extends BaseController {

    @Autowired
    private IResourceService resourceService;

    @RequiresPermissions("cms:resource:view")
    @GetMapping()
    public String resource() {
        return "cms/resource/resource";
    }

    /**
     * 查询资源列表
     */
    @RequiresPermissions("cms:resource:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Resource resource) {
        startPage();
        List<Resource> list = resourceService.selectResourceList(resource);
        return getDataTable(list);
    }

    /**
     * 导出资源列表
     */
    @RequiresPermissions("cms:resource:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Resource resource) {
        List<Resource> list = resourceService.selectResourceList(resource);
        ExcelUtil<Resource> util = new ExcelUtil<>(Resource.class);
        return util.exportExcel(list, "resource");
    }

    /**
     * 新增资源
     */
    @GetMapping("/add")
    public String add() {
        return "cms/resource/add";
    }

    /**
     * 新增保存资源
     */
    @RequiresPermissions("cms:resource:add")
    @Log(title = "资源", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Resource resource) {
        return toAjax(resourceService.insertResource(resource));
    }

    /**
     * 修改资源
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") String id, ModelMap modelMap) {
        Resource resource = resourceService.selectResourceById(id);
        modelMap.put("resource", resource);
        return "cms/resource/edit";
    }

    /**
     * 修改保存资源
     */
    @RequiresPermissions("cms:resource:edit")
    @Log(title = "资源", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Resource resource) {
        return toAjax(resourceService.updateResource(resource));
    }

    /**
     * 删除资源
     */
    @RequiresPermissions("cms:resource:remove")
    @Log(title = "资源", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(resourceService.deleteResourceByIds(ids));
    }


    /**
     * 上传资源请求
     */
    @PostMapping("/uploadResource")
    @ResponseBody
    public AjaxResult uploadResource(MultipartFile file) {
        try {
            // 上传并返回新文件名称
            String path = FileUploadUtils.upload(ReedConfig.getResourcePath(), file);
            Map map = new HashMap();
            map.put("path", path);
            map.put("size", file.getSize());
            map.put("name", file.getOriginalFilename());
            return AjaxResult.success(map);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
}
