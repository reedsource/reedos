package top.reed.core.executor.shape;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.api.context.SpiderContext;
import top.reed.api.executor.ShapeExecutor;
import top.reed.api.model.SpiderNode;
import top.reed.core.Spider;
import top.reed.core.model.SpiderFlow;
import top.reed.core.service.SpiderFlowService;
import top.reed.core.utils.SpiderFlowUtils;

import java.util.Map;

/**
 * 子流程执行器
 * @author Administrator
 *
 */
@Component
public class ProcessExecutor implements ShapeExecutor{
	
	public static final String FLOW_ID = "flowId";

	private static Logger logger = LoggerFactory.getLogger(ProcessExecutor.class);
	
	@Autowired
	private SpiderFlowService spiderFlowService;
	
	@Autowired
	private Spider spider;
	
	@Override
	public void execute(SpiderNode node, SpiderContext context, Map<String,Object> variables) {
		String flowId = node.getStringJsonValue("flowId");
		SpiderFlow spiderFlow = spiderFlowService.getById(flowId);
		if(spiderFlow != null){
			logger.info("执行子流程:{}", spiderFlow.getName());
			SpiderNode root = SpiderFlowUtils.loadXMLFromString(spiderFlow.getXml());
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