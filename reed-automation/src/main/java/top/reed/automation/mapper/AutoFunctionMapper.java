package top.reed.automation.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import top.reed.automation.domain.AutoFunction;

/**
 * 自定义函数Mapper接口
 * 
 * @author reedsource
 * date 2022-09-29
 */
@Mapper
public interface AutoFunctionMapper {
    /**
     * 查询自定义函数
     * 
     * @param id 自定义函数主键
     * @return 自定义函数
     */
     AutoFunction selectAutoFunctionById(Long id);

    /**
     * 查询自定义函数列表
     * 
     * @param autoFunction 自定义函数
     * @return 自定义函数集合
     */
	List<AutoFunction> selectAutoFunctionList(AutoFunction autoFunction);

    /**
     * 新增自定义函数
     * 
     * @param autoFunction 自定义函数
     * @return 结果
     */
	int insertAutoFunction(AutoFunction autoFunction);

    /**
     * 修改自定义函数
     * 
     * @param autoFunction 自定义函数
     * @return 结果
     */
    int updateAutoFunction(AutoFunction autoFunction);

    /**
     * 删除自定义函数
     * 
     * @param id 自定义函数主键
     * @return 结果
     */
    int deleteAutoFunctionById(Long id);

    /**
     * 批量删除自定义函数
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteAutoFunctionByIds(String[] ids);
}
