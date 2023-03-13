package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Link;
import top.reed.cms.service.ILinkService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 链接Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/link")
public class LinkController extends BaseController {
    private final String prefix = "cms/link";

    @Autowired
    private ILinkService linkService;

    @RequiresPermissions("cms:link:view")
    @GetMapping()
    public String link() {
        return prefix + "/link";
    }

    /**
     * 查询链接列表
     */
    @RequiresPermissions("cms:link:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Link link) {
        startPage();
        List<Link> list = linkService.selectLinkList(link);
        return getDataTable(list);
    }

    /**
     * 导出链接列表
     */
    @RequiresPermissions("cms:link:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Link link) {
        List<Link> list = linkService.selectLinkList(link);
        ExcelUtil<Link> util = new ExcelUtil<>(Link.class);
        return util.exportExcel(list, "link");
    }

    /**
     * 新增链接
     */
    @GetMapping("/add")
    public String add() {
        return prefix + "/add";
    }

    /**
     * 新增保存链接
     */
    @RequiresPermissions("cms:link:add")
    @Log(title = "链接", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Link link) {
        return toAjax(linkService.insertLink(link));
    }

    /**
     * 修改链接
     */
    @GetMapping("/edit/{linkId}")
    public String edit(@PathVariable("linkId") Long linkId, ModelMap mmap) {
        Link link = linkService.selectLinkById(linkId);
        mmap.put("link", link);
        return prefix + "/edit";
    }

    /**
     * 修改保存链接
     */
    @RequiresPermissions("cms:link:edit")
    @Log(title = "链接", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Link link) {
        return toAjax(linkService.updateLink(link));
    }

    /**
     * 删除链接
     */
    @RequiresPermissions("cms:link:remove")
    @Log(title = "链接", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(linkService.deleteLinkByIds(ids));
    }
}
