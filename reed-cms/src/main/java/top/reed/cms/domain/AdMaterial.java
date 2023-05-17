package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * 广告素材
 */
@Getter
@Setter
public class AdMaterial extends Material {
    /*主键*/
    private Integer id;
    /*广告位ID*/
    private Integer adId;
    /*链接*/
    private String link;
    /*排序*/
    private int sort;
    /*点击数*/
    private int hit;
    /*开始时间*/
    private Date startTime;
    /*结束时间*/
    private Date endTime;
    /*状态*/
    private int status;
    private int useHisId;
}
