package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 素材使用记录实体类
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class MaterialUse extends Material {
    /*主键ID*/
    private String id;
    /*素材在那张表中使用*/
    private String useTable;
    /*比如cms_album_material表的album_id字段的列名“album_id”*/
    private String useColumn;
    /*比如cms_album_material表的album_id字段*/
    private String useId;
    /*创建人ID*/
    private String userId;

    private String ids;//扩展字段

}
