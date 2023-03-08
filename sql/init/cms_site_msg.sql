drop table if exists reedos.cms_site_msg;
create table reedos.cms_site_msg
(
    id          bigint auto_increment comment 'ID'
        primary key,
    from_id     varchar(50) null comment '发送者ID',
    from_name   varchar(50) null comment '发送者名称',
    to_id       varchar(50) null comment '接受者ID',
    to_name     varchar(50) null comment '接受者名称',
    msg_type    varchar(50) null comment '消息类别',
    content     text        null comment '消息内容',
    create_time datetime    null comment '消息时间'
);

INSERT INTO reedos.cms_site_msg (id, from_id, from_name, to_id, to_name, msg_type, content, create_time) VALUES (1, '1', '系统', '1', '测试', 'system', '测试系统通知', '2019-11-17 20:15:08');
