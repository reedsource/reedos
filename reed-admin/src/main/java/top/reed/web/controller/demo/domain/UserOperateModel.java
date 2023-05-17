package top.reed.web.controller.demo.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.annotation.Excel.Type;
import top.reed.common.core.domain.BaseEntity;
import top.reed.common.utils.DateUtils;

import java.io.Serial;
import java.util.Date;

@EqualsAndHashCode(callSuper = true)
@Data
public class UserOperateModel extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    private int userId;

    @Excel(name = "用户编号")
    private String userCode;

    @Excel(name = "用户姓名")
    private String userName;

    @Excel(name = "用户性别", readConverterExp = "0=男,1=女,2=未知")
    private String userSex;

    @Excel(name = "用户手机")
    private String userPhone;

    @Excel(name = "用户邮箱")
    private String userEmail;

    @Excel(name = "用户余额")
    private double userBalance;

    @Excel(name = "用户状态", readConverterExp = "0=正常,1=停用")
    private String status;

    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Type.EXPORT)
    private Date createTime;

    public UserOperateModel() {

    }

    public UserOperateModel(int userId, String userCode, String userName, String userSex, String userPhone,
                            String userEmail, double userBalance, String status) {
        this.userId = userId;
        this.userCode = userCode;
        this.userName = userName;
        this.userSex = userSex;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.userBalance = userBalance;
        this.status = status;
        this.createTime = DateUtils.getNowDate();
    }

}