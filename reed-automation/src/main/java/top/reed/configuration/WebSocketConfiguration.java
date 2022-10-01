package top.reed.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;
import top.reed.core.Spider;
import top.reed.websocket.WebSocketEditorServer;

/**
 * 配置WebSocket
 *
 * @author reedsource
 */
@Configuration
public class WebSocketConfiguration {

	@Bean
	public ServerEndpointExporter endpointExporter() {
		return new ServerEndpointExporter();
	}

	@Autowired
	public void setSpider(Spider spider) {
		WebSocketEditorServer.spider = spider;
	}

}
