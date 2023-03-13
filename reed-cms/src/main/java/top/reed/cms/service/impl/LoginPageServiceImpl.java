package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.LoginPage;
import top.reed.cms.mapper.LoginPageMapper;
import top.reed.cms.service.ILoginPageService;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;

import java.util.List;

/**
 * 登录页面Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class LoginPageServiceImpl implements ILoginPageService {
    @Autowired
    private LoginPageMapper loginPageMapper;

    /**
     * 查询登录页面
     *
     * @param id 登录页面ID
     * @return 登录页面
     */
    @Override
    public LoginPage selectLoginPageById(Long id) {
        return loginPageMapper.selectLoginPageById(id);
    }

    /**
     * 查询登录页面列表
     *
     * @param loginPage 登录页面
     * @return 登录页面
     */
    @Override
    public List<LoginPage> selectLoginPageList(LoginPage loginPage) {
        return loginPageMapper.selectLoginPageList(loginPage);
    }

    /**
     * 新增登录页面
     *
     * @param loginPage 登录页面
     * @return 结果
     */
    @Override
    public int insertLoginPage(LoginPage loginPage) {
        loginPage.setCreateTime(DateUtils.getNowDate());
        return loginPageMapper.insertLoginPage(loginPage);
    }

    /**
     * 修改登录页面
     *
     * @param loginPage 登录页面
     * @return 结果
     */
    @Override
    public int updateLoginPage(LoginPage loginPage) {
        return loginPageMapper.updateLoginPage(loginPage);
    }

    /**
     * 删除登录页面对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteLoginPageByIds(String ids) {
        return loginPageMapper.deleteLoginPageByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除登录页面信息
     *
     * @param id 登录页面ID
     * @return 结果
     */
    @Override
    public int deleteLoginPageById(Long id) {
        return loginPageMapper.deleteLoginPageById(id);
    }
}
