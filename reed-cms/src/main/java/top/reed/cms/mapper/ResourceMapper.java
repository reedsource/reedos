package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;
import top.reed.cms.domain.Resource;

import java.util.List;

/**
 * 资源Mapper接口
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface ResourceMapper {
    /**
     * 查询资源
     *
     * @param id 资源ID
     * @return 资源
     */
    Resource selectResourceById(String id);

    /**
     * 查询资源列表
     *
     * @param resource 资源
     * @return 资源集合
     */
    List<Resource> selectResourceList(Resource resource);

    /**
     * 新增资源
     *
     * @param resource 资源
     * @return 结果
     */
    int insertResource(Resource resource);

    /**
     * 修改资源
     *
     * @param resource 资源
     * @return 结果
     */
    int updateResource(Resource resource);

    /**
     * 删除资源
     *
     * @param id 资源ID
     * @return 结果
     */
    int deleteResourceById(String id);

    /**
     * 批量删除资源
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteResourceByIds(String[] ids);

    /**
     * 点赞+1
     *
     */
    int upVote(String id);

    /**
     * 点击数+1
     *
     */
    int resourceLook(String id);

}
