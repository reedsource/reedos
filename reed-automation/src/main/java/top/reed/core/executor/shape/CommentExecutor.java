package top.reed.core.executor.shape;

import org.springframework.stereotype.Component;
import top.reed.api.context.SpiderContext;
import top.reed.api.executor.ShapeExecutor;
import top.reed.api.model.SpiderNode;

import java.util.Map;

@Component
public class CommentExecutor implements ShapeExecutor {

	@Override
	public void execute(SpiderNode node, SpiderContext context, Map<String, Object> variables) {

	}

	@Override
	public String supportShape() {
		return "comment";
	}

}
