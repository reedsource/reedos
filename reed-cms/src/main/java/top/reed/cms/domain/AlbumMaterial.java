package top.reed.cms.domain;

import lombok.Getter;
import lombok.Setter;

/**
 * 相册素材实体类
 */
@Getter
@Setter
public class AlbumMaterial extends Material {

    private Long id;

    /**
     * link
     */
    private String link;
    /**
     * sort
     */
    private String sort;


}
