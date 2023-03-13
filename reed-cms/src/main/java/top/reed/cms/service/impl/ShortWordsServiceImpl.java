package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.domain.ShortWords;
import top.reed.cms.mapper.ShortWordsMapper;
import top.reed.cms.service.IShortWordsService;
import top.reed.common.core.domain.entity.SysUser;
import top.reed.common.core.text.Convert;
import top.reed.common.utils.ShiroUtils;

import java.util.List;

/**
 * 励志短语Service业务层处理
 *
 * @author reedsource
 * date 2022/9/12
 */
@Service
public class ShortWordsServiceImpl implements IShortWordsService {
    @Autowired
    private ShortWordsMapper shortWordsMapper;

    /**
     * 查询励志短语
     *
     * @param id 励志短语ID
     * @return 励志短语
     */
    @Override
    public ShortWords selectShortWordsById(Long id) {
        return shortWordsMapper.selectShortWordsById(id);
    }

    /**
     * 查询励志短语列表
     *
     * @param shortWords 励志短语
     * @return 励志短语
     */
    @Override
    public List<ShortWords> selectShortWordsList(ShortWords shortWords) {
        return shortWordsMapper.selectShortWordsList(shortWords);
    }

    /**
     * 新增励志短语
     *
     * @param shortWords 励志短语
     * @return 结果
     */
    @Override
    public int insertShortWords(ShortWords shortWords) {
        SysUser user = ShiroUtils.getSysUser();
        shortWords.setUserId(user.getUserId().toString());
        shortWords.setWordsCount((long) shortWords.getShortWords().length());
        return shortWordsMapper.insertShortWords(shortWords);
    }

    /**
     * 修改励志短语
     *
     * @param shortWords 励志短语
     * @return 结果
     */
    @Override
    public int updateShortWords(ShortWords shortWords) {
        shortWords.setWordsCount((long) shortWords.getShortWords().length());
        return shortWordsMapper.updateShortWords(shortWords);
    }

    /**
     * 删除励志短语对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteShortWordsByIds(String ids) {
        return shortWordsMapper.deleteShortWordsByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除励志短语信息
     *
     * @param id 励志短语ID
     * @return 结果
     */
    @Override
    public int deleteShortWordsById(Long id) {
        return shortWordsMapper.deleteShortWordsById(id);
    }
}
