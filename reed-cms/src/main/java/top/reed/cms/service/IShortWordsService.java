package top.reed.cms.service;

import top.reed.cms.domain.ShortWords;

import java.util.List;

/**
 * 励志短语Service接口
 *
 * @author reedsource
 * date 2022/9/12
 */
public interface IShortWordsService {
    /**
     * 查询励志短语
     *
     * @param id 励志短语ID
     * @return 励志短语
     */
    ShortWords selectShortWordsById(Long id);

    /**
     * 查询励志短语列表
     *
     * @param shortWords 励志短语
     * @return 励志短语集合
     */
    List<ShortWords> selectShortWordsList(ShortWords shortWords);

    /**
     * 新增励志短语
     *
     * @param shortWords 励志短语
     * @return 结果
     */
    int insertShortWords(ShortWords shortWords);

    /**
     * 修改励志短语
     *
     * @param shortWords 励志短语
     * @return 结果
     */
    int updateShortWords(ShortWords shortWords);

    /**
     * 批量删除励志短语
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteShortWordsByIds(String ids);

    /**
     * 删除励志短语信息
     *
     * @param id 励志短语ID
     * @return 结果
     */
    int deleteShortWordsById(Long id);
}
