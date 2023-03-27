package top.reed.automation.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.automation.domain.AutoFlow;

import java.util.List;

/**
 * 自动化任务Mapper接口
 *
 * @author reedsource
 * date 2022-09-29
 */
@Mapper
public interface AutoFlowMapper {
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
     * 删除自动化任务
     *
     * @param id 自动化任务主键
     * @return 结果
     */
    int deleteAutoFlowById(Long id);

    /**
     * 批量删除自动化任务
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteAutoFlowByIds(String[] ids);
}
