drop table if exists reedos.sys_user;
create table reedos.sys_user
(
    user_id         bigint auto_increment comment '用户ID'
        primary key,
    dept_id         bigint                    null comment '部门ID',
    login_name      varchar(30)               not null comment '登录账号',
    user_name       varchar(30)  default ''   null comment '用户昵称',
    user_type       varchar(2)   default '00' null comment '用户类型（00系统用户 01注册用户）',
    email           varchar(50)  default ''   null comment '用户邮箱',
    phonenumber     varchar(11)  default ''   null comment '手机号码',
    sex             char         default '0'  null comment '用户性别（0男 1女 2未知）',
    avatar          varchar(100) default ''   null comment '头像路径',
    password        varchar(50)  default ''   null comment '密码',
    salt            varchar(20)  default ''   null comment '盐加密',
    status          char         default '0'  null comment '帐号状态（0正常 1停用）',
    del_flag        char         default '0'  null comment '删除标志（0代表存在 2代表删除）',
    login_ip        varchar(128) default ''   null comment '最后登录IP',
    login_date      datetime                  null comment '最后登录时间',
    pwd_update_date datetime                  null comment '密码最后更新时间',
    create_by       varchar(64)  default ''   null comment '创建者',
    create_time     datetime                  null comment '创建时间',
    update_by       varchar(64)  default ''   null comment '更新者',
    update_time     datetime                  null comment '更新时间',
    remark          varchar(500)              null comment '备注'
)
    comment '用户信息表';

insert into reedos.sys_user (user_id, dept_id, login_name, user_name, user_type, email, phonenumber, sex, avatar, password, salt, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark)
values  (1, 111, 'super', '超级管理员', '00', 'reedsource@189.cn', '18101351078', '1', '', 'f58217d6f1c6f130019f183424468eb2', 'e09ee2', '0', '0', '127.0.0.1', '2023-03-07 17:10:31', '2023-03-07 17:10:31', 'admin', '2023-03-07 17:10:31', '', null, '管理员'),
        (2, 111, 'admin', '系统管理', '00', 'reedsource@189.cn', '18101351078', '1', '', 'f58217d6f1c6f130019f183424468eb2', 'e09ee2', '0', '0', '127.0.0.1', '2023-03-07 17:10:31', '2023-03-07 17:10:31', 'admin', '2023-03-07 17:10:31', '', null, '系统管理'),
        (3, 121, 'reed', '会员', '00', 'reedsource@189.cn', '18101351078', '1', '', 'f58217d6f1c6f130019f183424468eb2', 'e09ee2', '0', '0', '127.0.0.1', '2023-03-07 17:10:31', '2023-03-07 17:10:31', 'admin', '2023-03-07 17:10:31', '', null, '系统会员'),
        (4, 122, 'default', '默认用户', '00', 'reedsource@189.cn', '18101351078', '1', '', 'f58217d6f1c6f130019f183424468eb2', 'e09ee2', '0', '0', '127.0.0.1', '2023-03-07 17:10:31', '2023-03-07 17:10:31', 'admin', '2023-03-07 17:10:31', '', null, '默认用户');