package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.ShortWords;
import top.reed.cms.service.IShortWordsService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 励志短语Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/shortWords")
public class ShortWordsController extends BaseController {

    @Autowired
    private IShortWordsService shortWordsService;

    @RequiresPermissions("cms:shortWords:view")
    @GetMapping()
    public String shortWords() {
        return "cms/shortWords/shortWords";
    }

    /**
     * 查询励志短语列表
     */
    @RequiresPermissions("cms:shortWords:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(ShortWords shortWords) {
        startPage();
        List<ShortWords> list = shortWordsService.selectShortWordsList(shortWords);
        return getDataTable(list);
    }

    /**
     * 导出励志短语列表
     */
    @RequiresPermissions("cms:shortWords:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ShortWords shortWords) {
        List<ShortWords> list = shortWordsService.selectShortWordsList(shortWords);
        ExcelUtil<ShortWords> util = new ExcelUtil<>(ShortWords.class);
        return util.exportExcel(list, "shortWords");
    }

    /**
     * 新增励志短语
     */
    @GetMapping("/add")
    public String add() {
        return "cms/shortWords/add";
    }

    /**
     * 新增保存励志短语
     */
    @RequiresPermissions("cms:shortWords:add")
    @Log(title = "励志短语", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(ShortWords shortWords) {
        return toAjax(shortWordsService.insertShortWords(shortWords));
    }

    /**
     * 修改励志短语
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap modelMap) {
        ShortWords shortWords = shortWordsService.selectShortWordsById(id);
        modelMap.put("shortWords", shortWords);
        return "cms/shortWords/edit";
    }

    /**
     * 修改保存励志短语
     */
    @RequiresPermissions("cms:shortWords:edit")
    @Log(title = "励志短语", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(ShortWords shortWords) {
        return toAjax(shortWordsService.updateShortWords(shortWords));
    }

    /**
     * 删除励志短语
     */
    @RequiresPermissions("cms:shortWords:remove")
    @Log(title = "励志短语", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(shortWordsService.deleteShortWordsByIds(ids));
    }
}
