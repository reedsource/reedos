drop table if exists reedos.cms_album;
create table reedos.cms_album
(
    album_id    varchar(50)        not null comment '相册ID'
        primary key,
    album_name  varchar(150)       null comment '相册名称',
    user_id     varchar(50)        null comment '创建人ID',
    dept_id     varchar(50)        null comment '部门ID',
    album_type  varchar(50)        null comment '相册类型',
    description varchar(255)       null comment '描述',
    create_by   varchar(50)        null comment '创建人',
    create_time datetime           null on update CURRENT_TIMESTAMP comment '创建时间',
    audit_state smallint default 0 null comment '审核状态',
    code        varchar(50)        null comment '编码',
    width       smallint           null comment '宽度',
    height      smallint           null comment '高度'
)
    comment '素材表';

INSERT INTO reedos.cms_album (album_id, album_name, user_id, dept_id, album_type, description, create_by, create_time, audit_state, code, width, height)
VALUES ('2019111014175065994146', '首页banner', '3', '103', 'banner', null, 'yf', sysdate(), 1, 'main', 960, 320),
       ('2019111014175065994147', '博客首页banner', '3', '103', 'banner', null, 'yf', sysdate(), 1, 'blog_index', 798, 256);
