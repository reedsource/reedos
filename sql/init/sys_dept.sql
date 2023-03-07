drop table if exists reedos.sys_dept;
create table reedos.sys_dept
(
    dept_id     bigint auto_increment comment '部门id'
        primary key,
    parent_id   bigint      default 0   null comment '父部门id',
    ancestors   varchar(50) default ''  null comment '祖级列表',
    dept_name   varchar(30) default ''  null comment '部门名称',
    order_num   int(4)      default 0   null comment '显示顺序',
    leader      varchar(20)             null comment '负责人',
    phone       varchar(11)             null comment '联系电话',
    email       varchar(50)             null comment '邮箱',
    status      char        default '0' null comment '部门状态（0正常 1停用）',
    del_flag    char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) default ''  null comment '创建者',
    create_time datetime                null comment '创建时间',
    update_by   varchar(64) default ''  null comment '更新者',
    update_time datetime                null comment '更新时间'
)
    comment '部门表';

insert into reedos.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time)
values  (100, 0, '0', 'ReedOS', 0, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null),
        (110, 100, '0,100', '管理部', 1, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null),
        (111, 110, '0,100,110', '系统管理', 1, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null),
        (120, 100, '0,100', '市场部', 1, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null),
        (121, 120, '0,100,120', '会员', 1, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null),
        (122, 120, '0,100,120', '默认用户', 1, 'reed', '18101351078', 'reedsource@189.cn', '0', '0', 'admin', '2023-03-07 17:10:31', '', null);