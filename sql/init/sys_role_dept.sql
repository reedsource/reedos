drop table if exists reedos.sys_role_dept;
create table reedos.sys_role_dept
(
    role_id bigint not null comment '角色ID',
    dept_id bigint not null comment '部门ID',
    primary key (role_id, dept_id)
)
    comment '角色和部门关联表';

insert into reedos.sys_role_dept (role_id, dept_id)
values (2, 100),
       (2, 110),
       (2, 111),
       (3, 100),
       (3, 120),
       (3, 121),
       (4, 100),
       (4, 120),
       (4, 122);