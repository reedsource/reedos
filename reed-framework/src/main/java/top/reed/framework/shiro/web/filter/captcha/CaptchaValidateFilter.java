package top.reed.framework.shiro.web.filter.captcha;

import com.anji.captcha.model.vo.CaptchaVO;
import com.anji.captcha.service.CaptchaService;
import org.apache.shiro.web.filter.AccessControlFilter;
import top.reed.common.constant.ShiroConstants;
import top.reed.common.utils.StringUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * 验证码过滤器
 *
 * @author reedsource
 */
public class CaptchaValidateFilter extends AccessControlFilter {
    /**
     * 是否开启验证码
     */
    private boolean captchaEnabled = true;

    /**
     * 验证码实现
     */
    private CaptchaService captchaService;

    public void setCaptchaEnabled(boolean captchaEnabled) {
        this.captchaEnabled = captchaEnabled;
    }

    @Override
    public boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        //设置验证码开关
        request.setAttribute(ShiroConstants.CURRENT_ENABLED, captchaEnabled);
        return super.onPreHandle(request, response, mappedValue);
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        // 验证码禁用 或不是表单提交 允许访问
        if (!captchaEnabled || !"post".equalsIgnoreCase(httpServletRequest.getMethod())) {
            return true;
        }
        //获取后台二次校验参数并验证
        return validateResponse(httpServletRequest.getParameter("__captchaVerification"));
    }

    /**
     * 验证响应
     *
     * @param captchaVerification 后台二次校验参数
     */
    public boolean validateResponse(String captchaVerification) {
        CaptchaVO captchaVO = new CaptchaVO();
        captchaVO.setCaptchaVerification(captchaVerification);
        return !StringUtils.isEmpty(captchaVerification) && captchaService.verification(captchaVO).isSuccess();
    }

    /**
     * 拒绝访问时
     *
     * @param request  request
     * @param response response
     */
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) {
        //设置 验证码key 为 验证码错误
        request.setAttribute(ShiroConstants.CURRENT_CAPTCHA, ShiroConstants.CAPTCHA_ERROR);
        return true;
    }

    /**
     * 设置Captcha服务
     *
     * @param captchaService Captcha服务
     */
    public void setCaptchaService(CaptchaService captchaService) {
        this.captchaService = captchaService;
    }
}