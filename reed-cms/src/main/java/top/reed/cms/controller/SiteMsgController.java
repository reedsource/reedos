package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.SiteMsg;
import top.reed.cms.service.ISiteMsgService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;

import java.util.List;

/**
 * 站内消息Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/siteMsg")
public class SiteMsgController extends BaseController {

    @Autowired
    private ISiteMsgService siteMsgService;

    @RequiresPermissions("cms:siteMsg:view")
    @GetMapping()
    public String siteMsg() {
        return "cms/siteMsg/siteMsg" ;
    }

    /**
     * 查询站内消息列表
     */
    @RequiresPermissions("cms:siteMsg:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(SiteMsg siteMsg) {
        startPage();
        List<SiteMsg> list = siteMsgService.selectSiteMsgList(siteMsg);
        return getDataTable(list);
    }

    /**
     * 新增站内消息
     */
    @GetMapping("/add")
    public String add() {
        return "cms/siteMsg/add" ;
    }

    /**
     * 新增保存站内消息
     */
    @RequiresPermissions("cms:siteMsg:add")
    @Log(title = "站内消息", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(SiteMsg siteMsg) {
        return toAjax(siteMsgService.insertSiteMsg(siteMsg));
    }

    /**
     * 修改站内消息
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap modelMap) {
        SiteMsg siteMsg = siteMsgService.selectSiteMsgById(id);
        modelMap.put("siteMsg", siteMsg);
        return "cms/siteMsg/edit" ;
    }

    /**
     * 修改保存站内消息
     */
    @RequiresPermissions("cms:siteMsg:edit")
    @Log(title = "站内消息", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(SiteMsg siteMsg) {
        return toAjax(siteMsgService.updateSiteMsg(siteMsg));
    }

    /**
     * 删除站内消息
     */
    @RequiresPermissions("cms:siteMsg:remove")
    @Log(title = "站内消息", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(siteMsgService.deleteSiteMsgByIds(ids));
    }
}
