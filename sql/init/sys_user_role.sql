drop table if exists reedos.sys_user_role;
create table reedos.sys_user_role
(
    user_id bigint not null comment '用户ID',
    role_id bigint not null comment '角色ID',
    primary key (user_id, role_id)
)
    comment '用户和角色关联表';

insert into reedos.sys_user_role (user_id, role_id)
values (1, 1),
       (2, 2),
       (3, 3),
       (4, 4);