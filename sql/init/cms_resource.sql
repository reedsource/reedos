drop table if exists reedos.cms_resource;
create table reedos.cms_resource
(
    id              varchar(64)             not null comment '资源ID'
        primary key,
    resource_region varchar(50)             null comment '资源专区',
    title           varchar(100)            not null comment '资源名称',
    type            varchar(10)             not null comment '资源类型',
    description     varchar(255)            null comment '资源描述',
    detail          longtext                null comment '详情',
    size            varchar(20)             null comment '资源大小',
    save_path       varchar(255)            null comment '保存路径',
    cover_image     varchar(255)            null comment '缩略图',
    audit_state     varchar(20) default '0' null comment '审核状态 0待审批2未通过1通过',
    score           smallint                null comment '评分 1-5',
    download_type   varchar(20) default '0' null comment '下载类型 0直接下载 1登录后下载 2关注下载',
    favourite_count int         default 0   null comment '收藏数',
    download_count  int         default 0   null comment '下载次数',
    hit             int         default 0   null comment '点击数',
    up_vote         int         default 0   null comment '点赞数',
    free            smallint                null comment '付费 0免费 1收费',
    pay_type        varchar(50)             null comment '付费类型 1 积分 2扫码支付',
    cost            int         default 0   null comment '花费多少积分',
    tag_ids         varchar(255)            null comment '标签',
    user_id         varchar(50)             null comment '上传人用户ID',
    user_name       varchar(255)            null comment '上传人',
    create_time     datetime                null comment '上传日期',
    update_time     datetime                null comment '上传者 id',
    status          smallint    default 0   null comment '状态 0 正常 1停用',
    remark          varchar(255)            null comment '备注'
)
    comment '资源对象';

