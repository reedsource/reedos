package top.reed.cms.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import top.reed.common.annotation.Excel;
import top.reed.common.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 资源对象 cms_resource
 *
 * @author reedsource
 * date 2019-11-23
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Resource extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 资源ID
     */
    private String id;

    private String resourceRegion;
    /**
     * 资源名称
     */
    @Excel(name = "资源名称")
    private String title;

    /**
     * 资源类型
     */
    @Excel(name = "资源类型")
    private String type;

    /**
     * 资源描述
     */
    private String description;

    /**
     * 详情
     */
    private String detail;

    /**
     * 资源大小
     */
    @Excel(name = "资源大小")
    private String size;

    /**
     * 保存路径
     */
    private String savePath;

    /**
     * 缩略图
     */
    @Excel(name = "缩略图")
    private String coverImage;

    /**
     * 审核状态
     */
    @Excel(name = "审核状态")
    private String auditState;

    /**
     * 评分
     */
    @Excel(name = "评分")
    private Integer score;

    /**
     * 下载类型
     */
    @Excel(name = "下载类型")
    private String downloadType;

    /**
     * 收藏数
     */
    @Excel(name = "收藏数")
    private Long favouriteCount;

    /**
     * 下载次数
     */
    @Excel(name = "下载次数")
    private Long downloadCount;
    /**
     * 点击次数
     */
    @Excel(name = "点击次数")
    private Long hit;
    /**
     * 点赞数
     */
    @Excel(name = "点赞数")
    private Long upVote;

    /**
     * 付费
     */
    @Excel(name = "付费")
    private Integer free;

    /**
     * 付费类型
     */
    @Excel(name = "付费类型")
    private String payType;

    /**
     * 花费
     */
    @Excel(name = "花费")
    private Long cost;

    /**
     * 标签
     */
    @Excel(name = "标签")
    private String tagIds;

    /**
     * 上传人用户ID
     */
    private String userId;

    /**
     * 上传人
     */
    private String userName;

    /**
     * 状态
     */
    @Excel(name = "状态")
    private Integer status;
    private String extraName;//扩展字段

}
