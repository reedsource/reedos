package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.Tags;
import top.reed.cms.service.ITagsService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 标签管理Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/tags")
public class TagsController extends BaseController {
	private final String prefix = "cms/tags";

	@Autowired
	private ITagsService tagsService;

	@RequiresPermissions("cms:tags:view")
	@GetMapping()
	public String tags() {
		return prefix + "/tags";
	}

	/**
	 * 查询标签管理列表
	 */
	@RequiresPermissions("cms:tags:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(Tags tags) {
		startPage();
		List<Tags> list = tagsService.selectTagsList(tags);
		return getDataTable(list);
	}

	/**
	 * 导出标签管理列表
	 */
	@RequiresPermissions("cms:tags:export")
	@PostMapping("/export")
	@ResponseBody
	public AjaxResult export(Tags tags) {
		List<Tags> list = tagsService.selectTagsList(tags);
		ExcelUtil<Tags> util = new ExcelUtil<>(Tags.class);
		return util.exportExcel(list, "tags");
	}

	/**
	 * 新增标签管理
	 */
	@GetMapping("/add")
	public String add() {
		return prefix + "/add";
	}

	/**
	 * 新增保存标签管理
	 */
	@RequiresPermissions("cms:tags:add")
	@Log(title = "标签管理", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(Tags tags) {
		return toAjax(tagsService.insertTags(tags));
	}

	/**
	 * 修改标签管理
	 */
	@GetMapping("/edit/{tagId}")
	public String edit(@PathVariable("tagId") Long tagId, ModelMap mmap) {
		Tags tags = tagsService.selectTagsById(tagId);
		mmap.put("tags", tags);
		return prefix + "/edit";
	}

	/**
	 * 修改保存标签管理
	 */
	@RequiresPermissions("cms:tags:edit")
	@Log(title = "标签管理", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(Tags tags) {
		return toAjax(tagsService.updateTags(tags));
	}

	/**
	 * 删除标签管理
	 */
	@RequiresPermissions("cms:tags:remove")
	@Log(title = "标签管理", businessType = BusinessType.DELETE)
	@PostMapping("/remove")
	@ResponseBody
	public AjaxResult remove(String ids) {
		return toAjax(tagsService.deleteTagsByIds(ids));
	}
}
