package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.Resource;
import top.reed.cms.mapper.ResourceMapper;
import top.reed.cms.service.IResourceService;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.DateUtils;
import top.reed.common.utils.Guid;
import top.reed.common.utils.ShiroUtils;

import java.util.List;

/**
 * 资源Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class ResourceServiceImpl implements IResourceService {
	@Autowired
	private ResourceMapper resourceMapper;

	/**
	 * 查询资源
	 *
	 * @param id 资源ID
	 * @return 资源
	 */
	@Override
	public Resource selectResourceById(String id) {
		return resourceMapper.selectResourceById(id);
	}

	/**
	 * 查询资源列表
	 *
	 * @param resource 资源
	 * @return 资源
	 */
	@Override
	public List<Resource> selectResourceList(Resource resource) {
		return resourceMapper.selectResourceList(resource);
	}

	/**
	 * 新增资源
	 *
	 * @param resource 资源
	 * @return 结果
	 */
	@Override
	public int insertResource(Resource resource) {
		resource.setId(Guid.get());
		SysUser user = ShiroUtils.getSysUser();
		resource.setUserId(user.getUserId().toString());
		resource.setUserName(user.getUserName());

		resource.setCreateTime(DateUtils.getNowDate());
		return resourceMapper.insertResource(resource);
	}

	/**
	 * 修改资源
	 *
	 * @param resource 资源
	 * @return 结果
	 */
	@Override
	public int updateResource(Resource resource) {
		resource.setUpdateTime(DateUtils.getNowDate());
		return resourceMapper.updateResource(resource);
	}

	/**
	 * 删除资源对象
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	@Override
	public int deleteResourceByIds(String ids) {
		return resourceMapper.deleteResourceByIds(Convert.toStrArray(ids));
	}

	/**
	 * 删除资源信息
	 *
	 * @param id 资源ID
	 * @return 结果
	 */
	@Override
	public int deleteResourceById(String id) {
		return resourceMapper.deleteResourceById(id);
	}

	@Override
	public int upVote(String id) {
		return resourceMapper.upVote(id);
	}

	@Override
	public int resourceLook(String id) {
		return resourceMapper.resourceLook(id);
	}
}
