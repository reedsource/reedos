package top.reed.cms.domain;

/**
 * 标签类型
 *
 * @author reedsource
 */
public enum TagsType {

    SYSTEM("s", "系统"),
    PERSONAL("p", "个人"),
    REGION_NEW("blogTab", "博客首页");

    private final String val;
    private final String desc;

    TagsType(String v, String desc) {
        this.val = v;
        this.desc = desc;
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
