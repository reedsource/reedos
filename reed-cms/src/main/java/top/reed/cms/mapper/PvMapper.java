package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Pv;

import java.util.List;

/**
 * PVMapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface PvMapper {
    /**
     * 查询PV
     *
     * @param id PVID
     * @return PV
     */
    Pv selectPvById(Long id);

    /**
     * 查询PV列表
     *
     * @param pv PV
     * @return PV集合
     */
    List<Pv> selectPvList(Pv pv);

    /**
     * 新增PV
     *
     * @param pv PV
     * @return 结果
     */
    int insertPv(Pv pv);

    /**
     * 批量新增PV
     *
     * @param pvs PV
     * @return 结果
     */
    int insertPvBatch(List<Pv> pvs);

    /**
     * 修改PV
     *
     * @param pv PV
     * @return 结果
     */
    int updatePv(Pv pv);

    /**
     * 删除PV
     *
     * @param id PVID
     * @return 结果
     */
    int deletePvById(Long id);

    /**
     * 批量删除PV
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deletePvByIds(String[] ids);
}
