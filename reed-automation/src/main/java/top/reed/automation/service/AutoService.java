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
     * 自动化任务列表 状态正常
     *
     * @return 参数键值
     */
    public List<AutoFlow> getAuto() {
        AutoFlow autoFlow = new AutoFlow();
        //只查询状态正常的自动化任务
        autoFlow.setStatus("0");
        return autoFlowService.selectAutoFlowList(autoFlow);
    }

}
