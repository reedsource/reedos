package top.reed.websocket.config;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;
import top.reed.core.Auto;
import top.reed.websocket.server.WebSocketEditorServer;

/**
 * websocket配置类
 *
 * @author reedsource
 * @version 1.0
 * date 2022/9/12
 * @since 1.0
 */
@Configuration
public class WebSocketConfig {

	/**
	 * ServerEndpointExporter会自动注册使用了@ServerEndpoint注解声明的Websocket endpoint
	 *
	 * @return
	 */
	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return new ServerEndpointExporter();
	}


	/**
	 * information信息获取模块 websocket 功能注册
	 *
	 * @param auto Spider爬虫
	 */
	@Autowired
	public void setSpider(Auto auto) {
		WebSocketEditorServer.auto = auto;
	}
}