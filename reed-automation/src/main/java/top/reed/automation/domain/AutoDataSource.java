package top.reed.automation.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serial;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 自动化数据源对象 auto_datasource
 * 
 * @author reedsource
 * date 2022-09-28
 */
public class AutoDataSource extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**  */
    private String id;

    /** 数据源名称 */
    @Excel(name = "数据源名称")
    private String name;

    /** 驱动名称 */
    @Excel(name = "驱动名称")
    private String driverClassName;

    /** 链接 */
    @Excel(name = "链接")
    private String jdbcUrl;

    /** 账号 */
    @Excel(name = "账号")
    private String username;

    /** 密码 */
    private String password;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createDate;

    public void setId(String id){
        this.id = id;
    }

    public String getId(){
        return id;
    }
    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }
    public void setDriverClassName(String driverClassName){
        this.driverClassName = driverClassName;
    }

    public String getDriverClassName(){
        return driverClassName;
    }
    public void setJdbcUrl(String jdbcUrl){
        this.jdbcUrl = jdbcUrl;
    }

    public String getJdbcUrl(){
        return jdbcUrl;
    }
    public void setUsername(String username){
        this.username = username;
    }

    public String getUsername(){
        return username;
    }
    public void setPassword(String password){
        this.password = password;
    }

    public String getPassword(){
        return password;
    }
    public void setCreateDate(Date createDate){
        this.createDate = createDate;
    }

    public Date getCreateDate(){
        return createDate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("driverClassName", getDriverClassName())
            .append("jdbcUrl", getJdbcUrl())
            .append("username", getUsername())
            .append("password", getPassword())
            .append("createDate", getCreateDate())
            .toString();
    }
}
