package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Filetype;

import java.util.List;
import java.util.Map;

/**
 * 文件类型Mapper接口
 *
 * @author reedsource
 * date 2019-11-01
 */
@Mapper
public interface FiletypeMapper {
    /**
     * 查询文件类型
     *
     * @param id 文件类型ID
     * @return 文件类型
     */
    Filetype selectFiletypeById(Long id);

    /**
     * 查询文件类型
     *
     * @param suffix 后缀
     * @return 文件类型
     */
    Filetype selectFiletypeBySuffix(String suffix);

    /**
     * 查询文件类型列表
     *
     * @param filetype 文件类型
     * @return 文件类型集合
     */
    List<Filetype> selectFiletypeList(Filetype filetype);

    /**
     * 新增文件类型
     *
     * @param filetype 文件类型
     * @return 结果
     */
    int insertFiletype(Filetype filetype);

    /**
     * 修改文件类型
     *
     * @param filetype 文件类型
     * @return 结果
     */
    int updateFiletype(Filetype filetype);

    /**
     * 删除文件类型
     *
     * @param id 文件类型ID
     * @return 结果
     */
    int deleteFiletypeById(Long id);

    /**
     * 批量删除文件类型
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteFiletypeByIds(String[] ids);

    /**
     * 查询字典格式的数据
     * dictValue,dictLabel
     */
    List<Map<String, Object>> selectDictData();
}
