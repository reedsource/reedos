drop table if exists reedos.cms_attachment;
create table reedos.cms_attachment
(
    attach_id   varchar(50)  not null comment 'id'
        primary key,
    zid         varchar(50)  not null comment '组ID',
    user_id     varchar(50)  null,
    file_type   varchar(50)  not null comment '文件类型，引用cms_filetype表ID',
    file_name   varchar(500) null comment '文件名称',
    file_path   varchar(500) null comment '相对路径',
    file_url    varchar(500) null comment 'url',
    size        int          null comment '文件空间',
    create_by   varchar(50)  null comment '用户ID',
    create_time datetime     null,
    sort        smallint     null comment '排序'
);

