package top.reed.cms.service;

import top.reed.cms.domain.LoginPage;

import java.util.List;

/**
 * 登录页面Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ILoginPageService {
	/**
	 * 查询登录页面
	 *
	 * @param id 登录页面ID
	 * @return 登录页面
	 */
	LoginPage selectLoginPageById(Long id);

	/**
	 * 查询登录页面列表
	 *
	 * @param loginPage 登录页面
	 * @return 登录页面集合
	 */
	List<LoginPage> selectLoginPageList(LoginPage loginPage);

	/**
	 * 新增登录页面
	 *
	 * @param loginPage 登录页面
	 * @return 结果
	 */
	int insertLoginPage(LoginPage loginPage);

	/**
	 * 修改登录页面
	 *
	 * @param loginPage 登录页面
	 * @return 结果
	 */
	int updateLoginPage(LoginPage loginPage);

	/**
	 * 批量删除登录页面
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	int deleteLoginPageByIds(String ids);

	/**
	 * 删除登录页面信息
	 *
	 * @param id 登录页面ID
	 * @return 结果
	 */
	int deleteLoginPageById(Long id);
}
