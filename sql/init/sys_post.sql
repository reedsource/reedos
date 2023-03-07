drop table if exists reedos.sys_post;
create table reedos.sys_post
(
    post_id     bigint auto_increment comment '岗位ID'
        primary key,
    post_code   varchar(64)            not null comment '岗位编码',
    post_name   varchar(50)            not null comment '岗位名称',
    post_sort   int(4)                 not null comment '显示顺序',
    status      char                   not null comment '状态（0正常 1停用）',
    create_by   varchar(64) default '' null comment '创建者',
    create_time datetime               null comment '创建时间',
    update_by   varchar(64) default '' null comment '更新者',
    update_time datetime               null comment '更新时间',
    remark      varchar(500)           null comment '备注'
)
    comment '岗位信息表';

insert into reedos.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark)
values  (1, 'ceo', '系统管理', 1, '0', 'admin', '2023-03-07 17:10:31', '', null, ''),
        (2, 'vip', '系统会员', 2, '0', 'admin', '2023-03-07 17:10:31', '', null, ''),
        (3, 'de', '默认用户', 3, '0', 'admin', '2023-03-07 17:10:31', '', null, '');