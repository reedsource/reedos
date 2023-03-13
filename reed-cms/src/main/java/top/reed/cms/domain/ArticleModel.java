package top.reed.cms.domain;


import org.apache.commons.lang3.StringUtils;

/**
 * 文章模型。文章，书籍，书籍章节，链接，图集。
 *
 * @author reedsource
 */
public enum ArticleModel {
    DUOGUYU("duoguyu", "多骨鱼"),
    OTHER("other", "其它");

    private final String val;
    private final String desc;

    ArticleModel(String v, String desc) {
        this.val = v;
        this.desc = desc;
    }

    /**
     * 根据val获取去desc
     *
     * @param val
     * @return
     */
    public static String getDescByVal(String val) {
        if (StringUtils.isEmpty(val)) {
            return "其它";
        }
        for (ArticleModel articleModel : ArticleModel.values()) {
            if (val.equals(articleModel.getVal())) {
                return articleModel.getDesc();
            }
        }
        return "";
    }

    public String getDesc() {
        return desc;
    }

    public String getVal() {
        return val;
    }

    @Override
    public String toString() {
        return val;
    }

}
