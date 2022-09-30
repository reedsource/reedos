package top.reed.automation.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import top.reed.api.context.SpiderContextHolder;
import top.reed.automation.mapper.AutooFlowMapper;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.service.AutooFlowService;
import top.reed.common.core.text.Convert;
import top.reed.core.Spider;
import top.reed.core.job.SpiderJobContext;
import top.reed.core.service.AutoFlowService;

/**
 * 自动化任务Service业务层处理
 * 
 * @author reedsource
 * date 2022-09-29
 */
@Service
public class AutooFlowServiceImpl implements AutooFlowService {
    private static Logger logger = LoggerFactory.getLogger(AutooFlowServiceImpl.class);

    /**
     * 日志路径
     */
    private final String workspace = "/data/spider";

    @Autowired
    private Spider spider;

	private final AutooFlowMapper autooFlowMapper;

	public AutooFlowServiceImpl(AutooFlowMapper autooFlowMapper) {
		this.autooFlowMapper = autooFlowMapper;
	}

    /**
     * 查询自动化任务
     * 
     * @param id 自动化任务主键
     * @return 自动化任务
     */
    @Override
    public AutoFlow selectAutoFlowById(Long id) {
        return autooFlowMapper.selectAutoFlowById(id);
    }

    /**
     * 查询自动化任务列表
     * 
     * @param autoFlow 自动化任务
     * @return 自动化任务
     */
    @Override
    public List<AutoFlow> selectAutoFlowList(AutoFlow autoFlow) {
        return autooFlowMapper.selectAutoFlowList(autoFlow);
    }

    /**
     * 新增自动化任务
     * 
     * @param autoFlow 自动化任务
     * @return 结果
     */
    @Override
    public int insertAutoFlow(AutoFlow autoFlow) {
        return autooFlowMapper.insertAutoFlow(autoFlow);
    }

    /**
     * 修改自动化任务
     * 
     * @param autoFlow 自动化任务
     * @return 结果
     */
    @Override
    public int updateAutoFlow(AutoFlow autoFlow) {
        return autooFlowMapper.updateAutoFlow(autoFlow);
    }

    /**
     * 批量删除自动化任务
     * 
     * @param ids 需要删除的自动化任务主键
     * @return 结果
     */
    @Override
    public int deleteAutoFlowByIds(String ids) {
        return autooFlowMapper.deleteAutoFlowByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除自动化任务信息
     * 
     * @param id 自动化任务主键
     * @return 结果
     */
    @Override
    public int deleteAutoFlowById(Long id) {
        return autooFlowMapper.deleteAutoFlowById(id);
    }

    /**
     * 执行一次流程
     * @param id 自动化流程id
     */
    @Override
    public void run(Long id){
        Spider.executorInstance.submit(()->{
            run(selectAutoFlowById(id));
        });
    }

    /**
     * 执行一次流程
     * @param autoFlow 自动化流程
     */
    public void run(AutoFlow autoFlow) {
        SpiderJobContext context = null;
        try {
            context = SpiderJobContext.create(this.workspace, autoFlow.getId().toString(),false);
            SpiderContextHolder.set(context);
            logger.info("开始执行任务{}", autoFlow.getName());
            spider.run(autoFlow, context);
            logger.info("执行任务{}完毕", autoFlow.getName());
        } catch (Exception e) {
            logger.error("执行任务{}出错", autoFlow.getName(), e);
        } finally {
            if (context != null) {
                context.close();
            }
            SpiderContextHolder.remove();
        }
    }

}
