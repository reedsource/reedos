package top.reed.cms.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.LoginPage;
import top.reed.cms.service.ILoginPageService;
import top.reed.common.annotation.Log;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.poi.ExcelUtil;

import java.util.List;

/**
 * 登录页面Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/loginPage")
public class LoginPageController extends BaseController {

    @Autowired
    private ILoginPageService loginPageService;

    @RequiresPermissions("cms:loginPage:view")
    @GetMapping()
    public String loginPage() {
        return "cms/loginPage/loginPage";
    }

    /**
     * 查询登录页面列表
     */
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(LoginPage loginPage) {
        startPage();
        List<LoginPage> list = loginPageService.selectLoginPageList(loginPage);
        return getDataTable(list);
    }

    /**
     * 导出登录页面列表
     */
    @Log(title = "登录页面", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(LoginPage loginPage) {
        List<LoginPage> list = loginPageService.selectLoginPageList(loginPage);
        ExcelUtil<LoginPage> util = new ExcelUtil<>(LoginPage.class);
        return util.exportExcel(list, "loginPage");
    }

    /**
     * 新增登录页面
     */
    @GetMapping("/add")
    public String add() {
        return "cms/loginPage/add";
    }

    /**
     * 新增保存登录页面
     */
    @Log(title = "登录页面", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(LoginPage loginPage) {
        return toAjax(loginPageService.insertLoginPage(loginPage));
    }

    /**
     * 修改登录页面
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap) {
        LoginPage loginPage = loginPageService.selectLoginPageById(id);
        mmap.put("loginPage", loginPage);
        return "cms/loginPage/edit";
    }

    /**
     * 修改保存登录页面
     */
    @Log(title = "登录页面", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(LoginPage loginPage) {
        return toAjax(loginPageService.updateLoginPage(loginPage));
    }

    /**
     * 删除登录页面
     */
    @Log(title = "登录页面", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(loginPageService.deleteLoginPageByIds(ids));
    }
}
