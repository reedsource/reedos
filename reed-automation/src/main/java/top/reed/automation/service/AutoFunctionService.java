package top.reed.automation.service;

import java.util.List;
import top.reed.automation.domain.AutoFunction;

/**
 * 自定义函数Service接口
 * 
 * @author reedsource
 * date 2022-09-29
 */
public interface AutoFunctionService {
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
     * 批量删除自定义函数
     * 
     * @param ids 需要删除的自定义函数主键集合
     * @return 结果
     */
    int deleteAutoFunctionByIds(String ids);

    /**
     * 删除自定义函数信息
     * 
     * @param id 自定义函数主键
     * @return 结果
     */
    int deleteAutoFunctionById(Long id);
}