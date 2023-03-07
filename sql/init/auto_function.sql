drop table if exists reedos.auto_function;
create table reedos.auto_function
(
    id          bigint auto_increment comment 'ID'
        primary key,
    name        varchar(255)                       null comment '函数名',
    parameter   varchar(512)                       null comment '参数',
    script      text                               null comment 'js脚本',
    create_date datetime default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '自定义函数表';

