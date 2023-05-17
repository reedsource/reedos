package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 登录页面对象 cms_login_page
 *
 * @author reedsource
 * date 2019-12-24
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class LoginPage extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 登录主题名称
     */
    @Excel(name = "登录主题名称")
    private String name;

    /**
     * 页面代码
     */
    @Excel(name = "页面代码")
    private String code;

    /**
     * 封面图片
     */
    @Excel(name = "封面图片")
    private String coverImg;

}
