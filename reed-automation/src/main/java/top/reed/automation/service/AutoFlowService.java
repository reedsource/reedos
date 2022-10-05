package top.reed.automation.service;

import top.reed.automation.domain.AutoFlow;

import java.util.List;

/**
 * 自动化任务Service接口
 *
 * @author reedsource
 * date 2022-09-29
 */
public interface AutoFlowService {
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
	 * 保存自动化任务
	 *
	 * @param autoFlow 自动化任务
	 * @return 结果
	 */
	int saveAutoFlow(AutoFlow autoFlow);


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

	String readHistory(String id, String timestamp);

	List<Long> historyList(String id);
}
