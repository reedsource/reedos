package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Attachment;
import top.reed.cms.service.IAttachmentService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 附件Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/attachment")
public class AttachmentController extends BaseController {

    @Autowired
    private IAttachmentService attachmentService;

    @RequiresPermissions("cms:attachment:view")
    @GetMapping()
    public String attachment() {
        return "cms/attachment/attachment" ;
    }

    /**
     * 查询附件列表
     */
    @RequiresPermissions("cms:attachment:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Attachment attachment) {
        startPage();
        List<Attachment> list = attachmentService.selectAttachmentList(attachment);
        return getDataTable(list);
    }

    /**
     * 导出附件列表
     */
    @RequiresPermissions("cms:attachment:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Attachment attachment) {
        List<Attachment> list = attachmentService.selectAttachmentList(attachment);
        ExcelUtil<Attachment> util = new ExcelUtil<>(Attachment.class);
        return util.exportExcel(list, "attachment");
    }

    /**
     * 新增附件
     */
    @GetMapping("/add")
    public String add() {
        return "cms/attachment/add" ;
    }

    /**
     * 新增保存附件
     */
    @RequiresPermissions("cms:attachment:add")
    @Log(title = "附件", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Attachment attachment) {
        return toAjax(attachmentService.insertAttachment(attachment));
    }

    /**
     * 修改附件
     */
    @GetMapping("/edit/{attachId}")
    public String edit(@PathVariable("attachId") String attachId, ModelMap modelMap) {
        Attachment attachment = attachmentService.selectAttachmentById(attachId);
        modelMap.put("attachment", attachment);
        return "cms/attachment/edit" ;
    }

    /**
     * 修改保存附件
     */
    @RequiresPermissions("cms:attachment:edit")
    @Log(title = "附件", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Attachment attachment) {
        return toAjax(attachmentService.updateAttachment(attachment));
    }

    /**
     * 删除附件
     */
    @RequiresPermissions("cms:attachment:remove")
    @Log(title = "附件", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(attachmentService.deleteAttachmentByIds(ids));
    }


}
