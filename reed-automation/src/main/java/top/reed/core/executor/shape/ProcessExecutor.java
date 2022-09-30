package top.reed.core.executor.shape;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.api.context.SpiderContext;
import top.reed.api.executor.ShapeExecutor;
import top.reed.api.model.SpiderNode;
import top.reed.core.Spider;
import top.reed.automation.domain.AutoFlow;
import top.reed.core.service.AutoFlowService;
import top.reed.core.utils.AutoFlowUtils;

import java.util.Map;

/**
 * 子流程执行器
 * @author reedsource
 *
 */
@Component
public class ProcessExecutor implements ShapeExecutor{
	
	public static final String FLOW_ID = "flowId";

	private static Logger logger = LoggerFactory.getLogger(ProcessExecutor.class);
	
	@Autowired
	private AutoFlowService autoFlowService;
	
	@Autowired
	private Spider spider;
	
	@Override
	public void execute(SpiderNode node, SpiderContext context, Map<String,Object> variables) {
		String flowId = node.getStringJsonValue("flowId");
		AutoFlow autoFlow = autoFlowService.getById(flowId);
		if(autoFlow != null){
			logger.info("执行子流程:{}", autoFlow.getName());
			SpiderNode root = AutoFlowUtils.loadXMLFromString(autoFlow.getXml());
			spider.executeNode(null,root,context,variables);
		}else{
			logger.info("执行子流程:{}失败，找不到该子流程", flowId);
		}
	}

	@Override
	public String supportShape() {
		return "process";
	}

}
