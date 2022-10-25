package top.reed.web.controller.system;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.reed.common.annotation.Log;
import top.reed.common.constant.UserConstants;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.domain.Ztree;
import top.reed.common.core.domain.entity.SysDept;
import top.reed.common.core.domain.entity.SysRole;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.core.text.Convert;
import top.reed.common.enums.BusinessType;
import top.reed.common.utils.ShiroUtils;
import top.reed.common.utils.StringUtils;
import top.reed.common.utils.poi.ExcelUtil;
import top.reed.framework.shiro.service.SysPasswordService;
import top.reed.framework.shiro.util.AuthorizationUtils;
import top.reed.system.service.ISysDeptService;
import top.reed.system.service.ISysPostService;
import top.reed.system.service.ISysRoleService;
import top.reed.system.service.ISysUserService;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户信息
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/system/user")
public class SysUserController extends BaseController {

	@Autowired
	private ISysUserService userService;

	@Autowired
	private ISysRoleService roleService;

	@Autowired
	private ISysDeptService deptService;

	@Autowired
	private ISysPostService postService;

	@Autowired
	private SysPasswordService passwordService;

	@RequiresPermissions("system:user:view")
	@GetMapping()
	public String user() {
		return "system/user/user";
	}

	@RequiresPermissions("system:user:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(SysUser user) {
		startPage();
		List<SysUser> list = userService.selectUserList(user);
		return getDataTable(list);
	}

	@Log(title = "用户管理", businessType = BusinessType.EXPORT)
	@RequiresPermissions("system:user:export")
	@PostMapping("/export")
	@ResponseBody
	public AjaxResult export(SysUser user) {
		List<SysUser> list = userService.selectUserList(user);
		ExcelUtil<SysUser> util = new ExcelUtil<>(SysUser.class);
		return util.exportExcel(list, "用户数据");
	}

	@Log(title = "用户管理", businessType = BusinessType.IMPORT)
	@RequiresPermissions("system:user:import")
	@PostMapping("/importData")
	@ResponseBody
	public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
		ExcelUtil<SysUser> util = new ExcelUtil<>(SysUser.class);
		List<SysUser> userList = util.importExcel(file.getInputStream());
		String message = userService.importUser(userList, updateSupport, getLoginName());
		return AjaxResult.success(message);
	}

	@RequiresPermissions("system:user:view")
	@GetMapping("/importTemplate")
	@ResponseBody
	public AjaxResult importTemplate() {
		ExcelUtil<SysUser> util = new ExcelUtil<>(SysUser.class);
		return util.importTemplateExcel("用户数据");
	}

	/**
	 * 新增用户
	 */
	@GetMapping("/add")
	public String add(ModelMap mmap) {
		mmap.put("roles", roleService.selectRoleAll().stream().filter(r -> !r.isSuper()).collect(Collectors.toList()));
		mmap.put("posts", postService.selectPostAll());
		return "system/user/add";
	}

	/**
	 * 新增保存用户
	 */
	@RequiresPermissions("system:user:add")
	@Log(title = "用户管理", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(@Validated SysUser user) {
		if (UserConstants.USER_NAME_NOT_UNIQUE.equals(userService.checkLoginNameUnique(user))) {
			return error("新增用户'" + user.getLoginName() + "'失败，登录账号已存在");
		} else if (StringUtils.isNotEmpty(user.getPhonenumber())
				&& UserConstants.USER_PHONE_NOT_UNIQUE.equals(userService.checkPhoneUnique(user))) {
			return error("新增用户'" + user.getLoginName() + "'失败，手机号码已存在");
		} else if (StringUtils.isNotEmpty(user.getEmail())
				&& UserConstants.USER_EMAIL_NOT_UNIQUE.equals(userService.checkEmailUnique(user))) {
			return error("新增用户'" + user.getLoginName() + "'失败，邮箱账号已存在");
		}
		user.setSalt(ShiroUtils.randomSalt());
		user.setPassword(passwordService.encryptPassword(user.getPassword(), user.getSalt()));
		user.setCreateBy(getLoginName());
		return toAjax(userService.insertUser(user));
	}

	/**
	 * 修改用户
	 */
	@RequiresPermissions("system:user:edit")
	@GetMapping("/edit/{userId}")
	public String edit(@PathVariable("userId") Long userId, ModelMap mmap) {
		userService.checkUserDataScope(userId);
		List<SysRole> roles = roleService.selectRolesByUserId(userId);
		mmap.put("user", userService.selectUserById(userId));
		mmap.put("roles", SysUser.isSuper(userId) ? roles : roles.stream().filter(r -> !r.isSuper()).collect(Collectors.toList()));
		mmap.put("posts", postService.selectPostsByUserId(userId));
		return "system/user/edit";
	}

	/**
	 * 修改保存用户
	 */
	@RequiresPermissions("system:user:edit")
	@Log(title = "用户管理", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(@Validated SysUser user) {
		userService.checkUserAllowed(user);
		userService.checkUserDataScope(user.getUserId());
		if (UserConstants.USER_NAME_NOT_UNIQUE.equals(userService.checkLoginNameUnique(user))) {
			return error("修改用户'" + user.getLoginName() + "'失败，登录账号已存在");
		} else if (StringUtils.isNotEmpty(user.getPhonenumber())
				&& UserConstants.USER_PHONE_NOT_UNIQUE.equals(userService.checkPhoneUnique(user))) {
			return error("修改用户'" + user.getLoginName() + "'失败，手机号码已存在");
		} else if (StringUtils.isNotEmpty(user.getEmail())
				&& UserConstants.USER_EMAIL_NOT_UNIQUE.equals(userService.checkEmailUnique(user))) {
			return error("修改用户'" + user.getLoginName() + "'失败，邮箱账号已存在");
		}
		user.setUpdateBy(getLoginName());
		AuthorizationUtils.clearAllCachedAuthorizationInfo();
		return toAjax(userService.updateUser(user));
	}

	@RequiresPermissions("system:user:resetPwd")
	@GetMapping("/resetPwd/{userId}")
	public String resetPwd(@PathVariable("userId") Long userId, ModelMap mmap) {
		mmap.put("user", userService.selectUserById(userId));
		return "system/user/resetPwd";
	}

	@RequiresPermissions("system:user:resetPwd")
	@Log(title = "重置密码", businessType = BusinessType.UPDATE)
	@PostMapping("/resetPwd")
	@ResponseBody
	public AjaxResult resetPwdSave(SysUser user) {
		userService.checkUserAllowed(user);
		userService.checkUserDataScope(user.getUserId());
		user.setSalt(ShiroUtils.randomSalt());
		user.setPassword(passwordService.encryptPassword(user.getPassword(), user.getSalt()));
		if (userService.resetUserPwd(user) > 0) {
			if (ShiroUtils.getUserId().longValue() == user.getUserId().longValue()) {
				setSysUser(userService.selectUserById(user.getUserId()));
			}
			return success();
		}
		return error();
	}

	/**
	 * 进入授权角色页
	 */
	@GetMapping("/authRole/{userId}")
	public String authRole(@PathVariable("userId") Long userId, ModelMap mmap) {
		SysUser user = userService.selectUserById(userId);
		// 获取用户所属的角色列表
		List<SysRole> roles = roleService.selectRolesByUserId(userId);
		mmap.put("user", user);
		mmap.put("roles", SysUser.isSuper(userId) ? roles : roles.stream().filter(r -> !r.isSuper()).collect(Collectors.toList()));
		return "system/user/authRole";
	}

	/**
	 * 用户授权角色
	 */
	@RequiresPermissions("system:user:edit")
	@Log(title = "用户管理", businessType = BusinessType.GRANT)
	@PostMapping("/authRole/insertAuthRole")
	@ResponseBody
	public AjaxResult insertAuthRole(Long userId, Long[] roleIds) {
		userService.checkUserDataScope(userId);
		userService.insertUserAuth(userId, roleIds);
		AuthorizationUtils.clearAllCachedAuthorizationInfo();
		return success();
	}

	@RequiresPermissions("system:user:remove")
	@Log(title = "用户管理", businessType = BusinessType.DELETE)
	@PostMapping("/remove")
	@ResponseBody
	public AjaxResult remove(String ids) {
		if (ArrayUtils.contains(Convert.toLongArray(ids), getUserId())) {
			return error("当前用户不能删除");
		}
		return toAjax(userService.deleteUserByIds(ids));
	}

	/**
	 * 校验用户名
	 */
	@PostMapping("/checkLoginNameUnique")
	@ResponseBody
	public String checkLoginNameUnique(SysUser user) {
		return userService.checkLoginNameUnique(user);
	}

	/**
	 * 校验手机号码
	 */
	@PostMapping("/checkPhoneUnique")
	@ResponseBody
	public String checkPhoneUnique(SysUser user) {
		return userService.checkPhoneUnique(user);
	}

	/**
	 * 校验email邮箱
	 */
	@PostMapping("/checkEmailUnique")
	@ResponseBody
	public String checkEmailUnique(SysUser user) {
		return userService.checkEmailUnique(user);
	}

	/**
	 * 用户状态修改
	 */
	@Log(title = "用户管理", businessType = BusinessType.UPDATE)
	@RequiresPermissions("system:user:edit")
	@PostMapping("/changeStatus")
	@ResponseBody
	public AjaxResult changeStatus(SysUser user) {
		userService.checkUserAllowed(user);
		userService.checkUserDataScope(user.getUserId());
		return toAjax(userService.changeStatus(user));
	}

	/**
	 * 加载部门列表树
	 */
	@RequiresPermissions("system:user:list")
	@GetMapping("/deptTreeData")
	@ResponseBody
	public List<Ztree> deptTreeData() {
		List<Ztree> ztrees = deptService.selectDeptTree(new SysDept());
		return ztrees;
	}

	/**
	 * 选择部门树
	 *
	 * @param deptId 部门ID
	 */
	@RequiresPermissions("system:user:list")
	@GetMapping("/selectDeptTree/{deptId}")
	public String selectDeptTree(@PathVariable("deptId") Long deptId, ModelMap mmap) {
		mmap.put("dept", deptService.selectDeptById(deptId));
		return "system/user/deptTree";
	}
}