package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Pv;
import top.reed.cms.mapper.PvMapper;
import top.reed.cms.service.IPvService;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;

import java.util.List;

/**
 * PVService业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class PvServiceImpl implements IPvService {
    @Autowired
    private PvMapper pvMapper;

    /**
     * 查询PV
     *
     * @param id PVID
     * @return PV
     */
    @Override
    public Pv selectPvById(Long id) {
        return pvMapper.selectPvById(id);
    }

    /**
     * 查询PV列表
     *
     * @param pv PV
     * @return PV
     */
    @Override
    public List<Pv> selectPvList(Pv pv) {
        return pvMapper.selectPvList(pv);
    }

    /**
     * 新增PV
     *
     * @param pv PV
     * @return 结果
     */
    @Override
    public int insertPv(Pv pv) {
        pv.setCreateTime(DateUtils.getNowDate());
        return pvMapper.insertPv(pv);
    }

    @Override
    public int insertPvBatch(List<Pv> pvs) {
        return pvMapper.insertPvBatch(pvs);
    }

    /**
     * 修改PV
     *
     * @param pv PV
     * @return 结果
     */
    @Override
    public int updatePv(Pv pv) {
        pv.setUpdateTime(DateUtils.getNowDate());
        return pvMapper.updatePv(pv);
    }

    /**
     * 删除PV对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deletePvByIds(String ids) {
        return pvMapper.deletePvByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除PV信息
     *
     * @param id PVID
     * @return 结果
     */
    @Override
    public int deletePvById(Long id) {
        return pvMapper.deletePvById(id);
    }
}
