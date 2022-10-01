package top.reed.automation.service.impl;

import org.springframework.stereotype.Service;
import top.reed.automation.domain.AutoDataSource;
import top.reed.automation.mapper.AutoDataSourceMapper;
import top.reed.automation.service.AutoDataSourceService;
import top.reed.common.core.text.Convert;

import java.util.List;

/**
 * 自动化数据源Service业务层处理
 *
 * @author reedsource
 * date 2022-09-28
 */
@Service
public class AutoDataSourceServiceImpl implements AutoDataSourceService {

	private final AutoDataSourceMapper autoDataSourceMapper;

	public AutoDataSourceServiceImpl(AutoDataSourceMapper autoDataSourceMapper) {
		this.autoDataSourceMapper = autoDataSourceMapper;
	}

	/**
	 * 查询自动化数据源
	 *
	 * @param id 自动化数据源主键
	 * @return 自动化数据源
	 */
	@Override
	public AutoDataSource selectAutoDataSourceById(String id) {
		return autoDataSourceMapper.selectAutoDataSourceById(id);
	}

	/**
	 * 查询自动化数据源列表
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 自动化数据源
	 */
	@Override
	public List<AutoDataSource> selectAutoDataSourceList(AutoDataSource autoDataSource) {
		return autoDataSourceMapper.selectAutoDataSourceList(autoDataSource);
	}

	/**
	 * 新增自动化数据源
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 结果
	 */
	@Override
	public int insertAutoDataSource(AutoDataSource autoDataSource) {
		return autoDataSourceMapper.insertAutoDataSource(autoDataSource);
	}

	/**
	 * 修改自动化数据源
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 结果
	 */
	@Override
	public int updateAutoDataSource(AutoDataSource autoDataSource) {
		return autoDataSourceMapper.updateAutoDataSource(autoDataSource);
	}

	/**
	 * 批量删除自动化数据源
	 *
	 * @param ids 需要删除的自动化数据源主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoDataSourceByIds(String ids) {
		return autoDataSourceMapper.deleteAutoDataSourceByIds(Convert.toStrArray(ids));
	}

	/**
	 * 删除自动化数据源信息
	 *
	 * @param id 自动化数据源主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoDataSourceById(String id) {
		return autoDataSourceMapper.deleteAutoDataSourceById(id);
	}
}
