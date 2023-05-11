package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Comment;
import top.reed.cms.service.ICommentService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 评论Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/comment")
public class CommentController extends BaseController {

    @Autowired
    private ICommentService commentService;

    @RequiresPermissions("cms:comment:view")
    @GetMapping()
    public String comment() {
        return "cms/comment/comment";
    }

    /**
     * 查询评论列表
     */
    @RequiresPermissions("cms:comment:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Comment comment) {
        startPage();
        List<Comment> list = commentService.selectCommentList(comment);
        return getDataTable(list);
    }

    /**
     * 导出评论列表
     */
    @RequiresPermissions("cms:comment:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Comment comment) {
        List<Comment> list = commentService.selectCommentList(comment);
        ExcelUtil<Comment> util = new ExcelUtil<>(Comment.class);
        return util.exportExcel(list, "comment");
    }

    /**
     * 新增评论
     */
    @GetMapping("/add")
    public String add() {
        return "cms/comment/add";
    }

    /**
     * 新增保存评论
     */
    @RequiresPermissions("cms:comment:add")
    @Log(title = "评论", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Comment comment) {
        return toAjax(commentService.insertComment(comment));
    }

    /**
     * 修改评论
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap modelMap) {
        Comment comment = commentService.selectCommentById(id);
        modelMap.put("comment", comment);
        return "cms/comment/edit";
    }

    /**
     * 修改保存评论
     */
    @RequiresPermissions("cms:comment:edit")
    @Log(title = "评论", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Comment comment) {
        return toAjax(commentService.updateComment(comment));
    }

    /**
     * 删除评论
     */
    @RequiresPermissions("cms:comment:remove")
    @Log(title = "评论", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(commentService.deleteCommentByIds(ids));
    }
}
