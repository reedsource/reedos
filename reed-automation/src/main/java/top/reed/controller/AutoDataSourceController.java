package top.reed.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.reed.api.model.JsonBean;
import top.reed.core.model.AutoDataSource;
import top.reed.core.service.AutoDataSourceService;
import top.reed.core.utils.AutoDataSourceUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@RestController
@RequestMapping("/datasource")
public class AutoDataSourceController {
	
	@Autowired
	private AutoDataSourceService autoDataSourceService;
	
	@RequestMapping("/list")
	public IPage<AutoDataSource> list(@RequestParam(name = "page",defaultValue = "1")Integer page, @RequestParam(name = "limit",defaultValue = "1")Integer size) {
		return autoDataSourceService.page(new Page<AutoDataSource>(page, size), new QueryWrapper<AutoDataSource>().select("id", "name", "driver_class_name", "create_date").orderByDesc("create_date"));
	}
	
	@RequestMapping("/all")
	public List<AutoDataSource> all(){
		return autoDataSourceService.list();
	}
	
	@RequestMapping("/save")
	public String save(AutoDataSource autoDataSource){
		if(StringUtils.isNotBlank(autoDataSource.getId())){
			AutoDataSourceUtils.remove(autoDataSource.getId());
		}
		autoDataSourceService.saveOrUpdate(autoDataSource);
		return autoDataSource.getId();
	}
	
	@RequestMapping("/get")
	public AutoDataSource get(String id){
		AutoDataSource autoDataSource = autoDataSourceService.getById(id);
		autoDataSource.setPassword(null);
		return autoDataSource;
	}
	
	@RequestMapping("/remove")
	public void remove(String id){
		AutoDataSourceUtils.remove(id);
		autoDataSourceService.removeById(id);
	}
	
	@RequestMapping("/test")
	public JsonBean<Void> test(AutoDataSource autoDataSource){
		if(StringUtils.isBlank(autoDataSource.getDriverClassName())){
			return new JsonBean<>(0, "DriverClassName不能为空！");
		}
		if(StringUtils.isBlank(autoDataSource.getJdbcUrl())){
			return new JsonBean<>(0, "jdbcUrl不能为空！");
		}
		Connection connection = null;
		try {
			Class.forName(autoDataSource.getDriverClassName());
			String url = autoDataSource.getJdbcUrl();
			String username = autoDataSource.getUsername();
			String password = autoDataSource.getPassword();
			if(StringUtils.isNotBlank(username)){
				connection = DriverManager.getConnection(url,username,password);
			}else{
				connection = DriverManager.getConnection(url);
			}
			return new JsonBean<>(1, "测试连接成功");
		} catch (ClassNotFoundException e) {
			return new JsonBean<>(0, "找不到驱动包：" + autoDataSource.getDriverClassName());
		} catch (Exception e){
			return new JsonBean<>(0, "连接失败，"+ e.getMessage());
		} finally{
			if(connection != null){
				try {
					connection.close();
				} catch (Exception e) {
				}
			}
		}
	}

}
