drop table if exists reedos.sys_user_online;
create table reedos.sys_user_online
(
    sessionId        varchar(50)  default '' not null comment '用户会话id'
        primary key,
    login_name       varchar(50)  default '' null comment '登录账号',
    dept_name        varchar(50)  default '' null comment '部门名称',
    ipaddr           varchar(128) default '' null comment '登录IP地址',
    login_location   varchar(255) default '' null comment '登录地点',
    browser          varchar(50)  default '' null comment '浏览器类型',
    os               varchar(50)  default '' null comment '操作系统',
    status           varchar(10)  default '' null comment '在线状态on_line在线off_line离线',
    start_timestamp  datetime                null comment 'session创建时间',
    last_access_time datetime                null comment 'session最后访问时间',
    expire_time      int(5)       default 0  null comment '超时时间，单位为分钟'
)
    comment '在线用户记录';

