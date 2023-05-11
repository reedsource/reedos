package top.reed.automation.controller;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.automation.domain.AutoDataSource;
import top.reed.automation.service.AutoDataSourceService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

/**
 * 自动化数据源Controller
 *
 * @author reedsource
 * date 2022-09-28
 */
@Controller
@RequestMapping("/automation/autodatasource")
public class AutoDataSourceController extends BaseController {

    private final AutoDataSourceService autoDataSourceService;

    public AutoDataSourceController(AutoDataSourceService autoDataSourceService) {
        this.autoDataSourceService = autoDataSourceService;
    }

    @RequiresPermissions("automation:autodatasource:view")
    @GetMapping()
    public String autodatasource() {
        return "automation/autodatasource/autodatasource";
    }

    /**
     * 查询自动化数据源列表
     */
    @RequiresPermissions("automation:autodatasource:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(AutoDataSource autoDataSource) {
        startPage();
        List<AutoDataSource> list = autoDataSourceService.selectAutoDataSourceList(autoDataSource);
        return getDataTable(list);
    }

    /**
     * 已知使用位置
     * 自动化流程output.html
     *
     * @return 全部数据源
     */
    @PostMapping("/all")
    @ResponseBody
    public List<AutoDataSource> all() {
        return autoDataSourceService.selectAutoDataSourceList(new AutoDataSource());
    }

    /**
     * 导出自动化数据源列表
     */
    @RequiresPermissions("automation:autodatasource:export")
    @Log(title = "自动化数据源", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(AutoDataSource autoDataSource) {
        List<AutoDataSource> list = autoDataSourceService.selectAutoDataSourceList(autoDataSource);
        ExcelUtil<AutoDataSource> util = new ExcelUtil<>(AutoDataSource.class);
        return util.exportExcel(list, "自动化数据源数据");
    }

    /**
     * @param autoDataSource 自动化数据源
     * @return 数据源是否可以连接成功
     */
    @RequestMapping("/test")
    @ResponseBody
    public AjaxResult test(AutoDataSource autoDataSource) {
        return autoDataSourceIsTrue(autoDataSource);
    }

    /**
     * @param autoDataSource 自动化数据源
     * @return 数据源是否能连接成功
     */
    public AjaxResult autoDataSourceIsTrue(AutoDataSource autoDataSource) {
        Connection connection = null;
        try {
            Class.forName(autoDataSource.getDriverClassName());
            String url = autoDataSource.getJdbcUrl();
            String username = autoDataSource.getUsername();
            String password = autoDataSource.getPassword();
            if (StringUtils.isNotBlank(username)) {
                connection = DriverManager.getConnection(url, username, password);
            } else {
                connection = DriverManager.getConnection(url);
            }
            return success();
        } catch (ClassNotFoundException e) {
            return error("找不到驱动包：" + autoDataSource.getDriverClassName());
        } catch (Exception e) {
            return error("连接失败，" + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                }
            }
        }
    }

    /**
     * 新增自动化数据源
     */
    @GetMapping("/add")
    public String add() {
        return "automation/autodatasource/add";
    }

    /**
     * 新增保存自动化数据源
     */
    @RequiresPermissions("automation:autodatasource:add")
    @Log(title = "自动化数据源", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(AutoDataSource autoDataSource) {
        //数据源尝试连接
        AjaxResult ajaxResult = autoDataSourceIsTrue(autoDataSource);
        if ("0".equals(ajaxResult.get("code").toString())) {
            return toAjax(autoDataSourceService.insertAutoDataSource(autoDataSource));
        }
        return ajaxResult;
    }

    /**
     * 修改自动化数据源
     */
    @RequiresPermissions("automation:autodatasource:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") String id, ModelMap modelMap) {
        AutoDataSource autoDataSource = autoDataSourceService.selectAutoDataSourceById(id);
        modelMap.put("autoDataSource", autoDataSource);
        return "automation/autodatasource/edit";
    }

    /**
     * 修改保存自动化数据源
     */
    @RequiresPermissions("automation:autodatasource:edit")
    @Log(title = "自动化数据源", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(AutoDataSource autoDataSource) {
        //数据源尝试连接
        AjaxResult ajaxResult = autoDataSourceIsTrue(autoDataSource);
        if ("0".equals(ajaxResult.get("code").toString())) {
            return toAjax(autoDataSourceService.updateAutoDataSource(autoDataSource));
        }
        return ajaxResult;
    }

    /**
     * 删除自动化数据源
     */
    @RequiresPermissions("automation:autodatasource:remove")
    @Log(title = "自动化数据源", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(autoDataSourceService.deleteAutoDataSourceByIds(ids));
    }
}
