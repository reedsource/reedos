package top.reed.automation.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.automation.domain.AutoDataSource;

import java.util.List;

/**
 * 自动化数据源Mapper接口
 *
 * @author reedsource
 * date 2022-09-28
 */
@Mapper
public interface AutoDataSourceMapper {
	/**
	 * 查询自动化数据源
	 *
	 * @param id 自动化数据源主键
	 * @return 自动化数据源
	 */
	AutoDataSource selectAutoDataSourceById(String id);

	/**
	 * 查询自动化数据源列表
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 自动化数据源集合
	 */
	List<AutoDataSource> selectAutoDataSourceList(AutoDataSource autoDataSource);

	/**
	 * 新增自动化数据源
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 结果
	 */
	int insertAutoDataSource(AutoDataSource autoDataSource);

	/**
	 * 修改自动化数据源
	 *
	 * @param autoDataSource 自动化数据源
	 * @return 结果
	 */
	int updateAutoDataSource(AutoDataSource autoDataSource);

	/**
	 * 删除自动化数据源
	 *
	 * @param id 自动化数据源主键
	 * @return 结果
	 */
	int deleteAutoDataSourceById(String id);

	/**
	 * 批量删除自动化数据源
	 *
	 * @param ids 需要删除的数据主键集合
	 * @return 结果
	 */
	int deleteAutoDataSourceByIds(String[] ids);
}
