package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

/**
 * 友情链接对象 cms_friend_link
 *
 * @author reedsource
 * date 2019-11-16
 */
@Getter
@Setter
public class FriendLink extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 友情链接ID
     */
    private Long id;

    /**
     * 友链名称
     */
    @Excel(name = "友链名称")
    private String name;

    /**
     * 链接
     */
    @Excel(name = "链接")
    private String link;
    @Excel(name = "站点描述")
    /** description*/
    private String description;
    /**
     * logo
     */
    private String logo;

    /**
     * 状态
     */
    @Excel(name = "状态")
    private Integer auditState;

    @Override
    public String toString() {
        return "FriendLink{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", link='" + link + '\'' +
                ", description='" + description + '\'' +
                ", logo='" + logo + '\'' +
                ", auditState=" + auditState +
                '}';
    }
}
