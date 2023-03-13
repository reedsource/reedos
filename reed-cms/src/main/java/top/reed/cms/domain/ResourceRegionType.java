package top.reed.cms.domain;

/**
 * 资源所属推荐专区的专区类型。置顶、热门、精选推荐、最新
 *
 * @author reedsource
 */
public enum ResourceRegionType {
    REGION_TOP("top", "置顶"),
    REGION_HOT("hot", "热门"),
    REGION_RECOMMEND("recommend", "精选推荐"),
    REGION_NEW("new", "最新");

    private final String val;
    private final String desc;

    ResourceRegionType(String v, String desc) {
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
