package top.reed.cms.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

/**
 * 站点相关
 *
 * @author reedsource
 * date 2022/9/12
 */
@Mapper
public interface WebSiteMapper {
	/**
	 * 获得站点相关数据
	 *
	 * @return
	 */
	Map getSiteInfo();
}
