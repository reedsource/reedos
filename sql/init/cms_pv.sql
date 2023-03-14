drop table if exists reedos.cms_pv;
create table reedos.cms_pv
(
    id          int auto_increment comment '主键'
        primary key,
    uid         varchar(50)  null comment '用户ID',
    module      varchar(50)  null comment '模块',
    browser     varchar(50)  null comment '浏览器',
    referer     varchar(255) null comment 'referer',
    os          varchar(50)  null comment '操作系统',
    page_id     varchar(255) null comment '页面内容ID',
    url         varchar(255) null,
    device_type varchar(50)  null,
    time_zone   varchar(10)  null comment '时区',
    ip          varchar(20)  null comment 'ip地址',
    location    varchar(255) null comment '地址',
    create_time datetime     null
)
    comment '内容管理-页面被浏览记录表';
