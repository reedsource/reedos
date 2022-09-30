package top.reed.automation.service;

import java.util.List;
import top.reed.automation.domain.AutoFlow;

/**
 * 自动化任务Service接口
 * 
 * @author reedsource
 * date 2022-09-29
 */
public interface AutooFlowService {
    /**
     * 查询自动化任务
     * 
     * @param id 自动化任务主键
     * @return 自动化任务
     */
    AutoFlow selectAutoFlowById(Long id);

    /**
     * 查询自动化任务列表
     * 
     * @param autoFlow 自动化任务
     * @return 自动化任务集合
     */
    List<AutoFlow> selectAutoFlowList(AutoFlow autoFlow);

    /**
     * 新增自动化任务
     * 
     * @param autoFlow 自动化任务
     * @return 结果
     */
    int insertAutoFlow(AutoFlow autoFlow);

    /**
     * 修改自动化任务
     * 
     * @param autoFlow 自动化任务
     * @return 结果
     */
    int updateAutoFlow(AutoFlow autoFlow);

    /**
     * 批量删除自动化任务
     * 
     * @param ids 需要删除的自动化任务主键集合
     * @return 结果
     */
    int deleteAutoFlowByIds(String ids);

    /**
     * 删除自动化任务信息
     * 
     * @param id 自动化任务主键
     * @return 结果
     */
    int deleteAutoFlowById(Long id);

    void run(Long id);
}
