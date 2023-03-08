drop table if exists reedos.sys_user_post;
create table reedos.sys_user_post
(
    user_id bigint not null comment '用户ID',
    post_id bigint not null comment '岗位ID',
    primary key (user_id, post_id)
)
    comment '用户与岗位关联表';

insert into reedos.sys_user_post (user_id, post_id)
values (1, 1),
       (2, 1),
       (3, 2),
       (4, 3);