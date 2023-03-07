drop table if exists reedos.sys_logininfor;
create table reedos.sys_logininfor
(
    info_id        bigint auto_increment comment '访问ID'
        primary key,
    login_name     varchar(50)  default ''  null comment '登录账号',
    ipaddr         varchar(128) default ''  null comment '登录IP地址',
    login_location varchar(255) default ''  null comment '登录地点',
    browser        varchar(50)  default ''  null comment '浏览器类型',
    os             varchar(50)  default ''  null comment '操作系统',
    status         char         default '0' null comment '登录状态（0成功 1失败）',
    msg            varchar(255) default ''  null comment '提示消息',
    login_time     datetime                 null comment '访问时间'
)
    comment '系统访问记录';

