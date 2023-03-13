package top.reed.cms.service;

import top.reed.cms.domain.SiteMsg;

import java.util.List;

/**
 * 站内消息Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface ISiteMsgService {
    /**
     * 查询站内消息
     *
     * @param id 站内消息ID
     * @return 站内消息
     */
    SiteMsg selectSiteMsgById(Long id);

    /**
     * 查询站内消息列表
     *
     * @param siteMsg 站内消息
     * @return 站内消息集合
     */
    List<SiteMsg> selectSiteMsgList(SiteMsg siteMsg);

    /**
     * 新增站内消息
     *
     * @param siteMsg 站内消息
     * @return 结果
     */
    int insertSiteMsg(SiteMsg siteMsg);

    /**
     * 修改站内消息
     *
     * @param siteMsg 站内消息
     * @return 结果
     */
    int updateSiteMsg(SiteMsg siteMsg);

    /**
     * 批量删除站内消息
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteSiteMsgByIds(String ids);

    /**
     * 删除站内消息信息
     *
     * @param id 站内消息ID
     * @return 结果
     */
    int deleteSiteMsgById(Long id);
}
