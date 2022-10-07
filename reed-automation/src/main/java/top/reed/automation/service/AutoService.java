package top.reed.automation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.automation.domain.AutoFlow;

import java.util.List;

/**
 * html调用 thymeleaf 实现读取自动化任务列表
 *
 * @author reedsource
 */
@Service("auto")
public class AutoService {
	@Autowired
	private AutoFlowService autoFlowService;

	/**
	 * 自动化任务列表
	 *
	 * @return 参数键值
	 */
	public List<AutoFlow> getAuto() {

		return autoFlowService.selectAutoFlowList(new AutoFlow());
	}

}
