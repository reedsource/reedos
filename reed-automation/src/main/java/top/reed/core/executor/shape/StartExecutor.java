package top.reed.core.executor.shape;

import org.springframework.stereotype.Component;
import top.reed.api.context.SpiderContext;
import top.reed.api.executor.ShapeExecutor;
import top.reed.api.model.SpiderNode;

import java.util.Map;

/**
 * 开始执行器
 *
 * @author reedsource
 */
@Component
public class StartExecutor implements ShapeExecutor {

	@Override
	public void execute(SpiderNode node, SpiderContext context, Map<String, Object> variables) {

	}

	@Override
	public String supportShape() {
		return "start";
	}

}
