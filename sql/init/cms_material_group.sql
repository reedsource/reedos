drop table if exists reedos.cms_material_group;
create table reedos.cms_material_group
(
    group_id    bigint(50) auto_increment comment 'ID'
        primary key,
    parent_id   bigint(50)   null comment '父ID',
    dept_id     varchar(50)  null comment '部门ID',
    group_name  varchar(50)  null comment '分组名称',
    description varchar(255) null comment '描述',
    sort        smallint     null comment '排序',
    user_id     varchar(50)  null comment '创建人用户ID',
    create_by   varchar(50)  null comment '创建人',
    create_time datetime     null on update CURRENT_TIMESTAMP comment '创建时间'
);

INSERT INTO reedos.cms_material_group (group_id, parent_id, dept_id, group_name, description, sort, user_id, create_by, create_time) VALUES (1, null, '100', '默认分组', '默认', 1, '1', 'admin', '2019-11-09 20:28:58');
INSERT INTO reedos.cms_material_group (group_id, parent_id, dept_id, group_name, description, sort, user_id, create_by, create_time) VALUES (2, null, '103', '研发分组', '研发', 2, '1', 'admin', '2019-11-09 20:28:56');
INSERT INTO reedos.cms_material_group (group_id, parent_id, dept_id, group_name, description, sort, user_id, create_by, create_time) VALUES (3, null, '105', '测试分组', '测试部门', 3, '1', 'admin', '2019-11-09 20:28:55');
