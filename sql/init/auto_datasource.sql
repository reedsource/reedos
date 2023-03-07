drop table if exists reedos.auto_datasource;
create table reedos.auto_datasource
(
    id                bigint auto_increment comment 'ID'
        primary key,
    name              varchar(255)                       null comment '数据源名称',
    driver_class_name varchar(255)                       null comment '驱动名称',
    jdbc_url          varchar(255)                       null comment '链接',
    username          varchar(64)                        null comment '账号',
    password          varchar(32)                        null comment '密码',
    create_date       datetime default CURRENT_TIMESTAMP not null comment '创建时间'
)
    comment '自动化数据源表';

