package top.reed;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 *
 * @author reedsource
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class ReedApplication {
	public static void main(String[] args) {
		SpringApplication.run(ReedApplication.class, args);
		System.out.println("后台主页 http://localhost/login");
	}
}