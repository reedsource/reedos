drop table if exists reedos.sys_dict_type;
create table reedos.sys_dict_type
(
    dict_id     bigint auto_increment comment '字典主键'
        primary key,
    dict_name   varchar(100) default ''  null comment '字典名称',
    dict_type   varchar(100) default ''  null comment '字典类型',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注',
    constraint dict_type
        unique (dict_type)
)
    comment '字典类型表';

insert into reedos.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
values  (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-03-07 17:10:32', '', null, '用户性别列表'),
        (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-03-07 17:10:32', '', null, '菜单状态列表'),
        (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-03-07 17:10:32', '', null, '系统开关列表'),
        (4, '系统是否', 'sys_yes_no', '0', 'admin', '2023-03-07 17:10:32', '', null, '系统是否列表'),
        (5, '通知类型', 'sys_notice_type', '0', 'admin', '2023-03-07 17:10:32', '', null, '通知类型列表'),
        (6, '通知状态', 'sys_notice_status', '0', 'admin', '2023-03-07 17:10:32', '', null, '通知状态列表'),
        (7, '操作类型', 'sys_oper_type', '0', 'admin', '2023-03-07 17:10:32', '', null, '操作类型列表'),
        (8, '系统状态', 'sys_common_status', '0', 'admin', '2023-03-07 17:10:32', '', null, '登录状态列表'),
        (9, '任务状态', 'auto_job_status', '0', 'admin', '2023-03-07 17:10:32', '', null, '任务状态列表'),
        (10, '任务分组', 'auto_job_group', '0', 'admin', '2023-03-07 17:10:32', '', null, '任务分组列表'),
        (11, '数据源驱动', 'auto_datasource_driver', '0', 'admin', '2023-03-07 17:10:32', '', null, null),
        (12, '任务类型', 'auto_job_type', '0', 'admin', '2023-03-07 17:10:32', '', null, '定时任务类型');