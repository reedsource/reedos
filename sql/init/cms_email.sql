drop table if exists reedos.cms_email;
create table reedos.cms_email
(
    id             varchar(50)            not null comment 'ID'
        primary key,
    email_type     smallint     default 0 null comment '邮件类型',
    user_id        varchar(50)            null comment '用户ID',
    create_by      varchar(50)            null,
    create_time    datetime               not null on update CURRENT_TIMESTAMP,
    from_email     varchar(50)            null comment '发送者邮箱',
    from_email_pwd varchar(50)            null comment '发送者邮箱密码',
    to_email       varchar(50)            null comment '接收者邮箱',
    subject        varchar(255)           null comment '主题',
    content        text                   null comment '内容',
    send_flag      smallint(1)  default 0 null comment '是否发送',
    send_time      datetime               null comment '发送时间',
    send_type      smallint(10) default 0 null comment '发送类型 0立即 1定时',
    plan_time      datetime               null comment '定时时间',
    copy_to        varchar(255)           null comment '抄送用户',
    attachfiles    varchar(255)           null comment '附件'
)
    comment '邮件记录表';

