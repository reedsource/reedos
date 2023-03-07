drop table if exists reedos.sys_dict_data;
create table reedos.sys_dict_data
(
    dict_code   bigint auto_increment comment '字典编码'
        primary key,
    dict_sort   int(4)       default 0   null comment '字典排序',
    dict_label  varchar(100) default ''  null comment '字典标签',
    dict_value  varchar(100) default ''  null comment '字典键值',
    dict_type   varchar(100) default ''  null comment '字典类型',
    css_class   varchar(100)             null comment '样式属性（其他样式扩展）',
    list_class  varchar(100)             null comment '表格回显样式',
    is_default  char         default 'N' null comment '是否默认（Y是 N否）',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注'
)
    comment '字典数据表';

insert into reedos.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
values  (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '性别男'),
        (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '性别女'),
        (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '性别未知'),
        (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '显示菜单'),
        (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '隐藏菜单'),
        (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '正常状态'),
        (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '停用状态'),
        (8, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '系统默认是'),
        (9, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '系统默认否'),
        (10, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '通知'),
        (11, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '公告'),
        (12, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '正常状态'),
        (13, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '关闭状态'),
        (14, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '其他操作'),
        (15, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '新增操作'),
        (16, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '修改操作'),
        (17, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '删除操作'),
        (18, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '授权操作'),
        (19, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '导出操作'),
        (20, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '导入操作'),
        (21, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '强退操作'),
        (22, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '生成操作'),
        (23, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '清空操作'),
        (24, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '正常状态'),
        (25, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '停用状态'),
        (26, 1, '正常', '0', 'auto_job_status', '', 'primary', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '正常状态'),
        (27, 2, '暂停', '1', 'auto_job_status', '', 'danger', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '停用状态'),
        (28, 1, '默认', 'DEFAULT', 'auto_job_group', '', '', 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, '默认分组'),
        (29, 2, '系统', 'SYSTEM', 'auto_job_group', '', '', 'N', '0', 'admin', '2023-03-07 17:10:32', '', null, '系统分组'),
        (30, 1, 'mysql', 'com.mysql.cj.jdbc.Driver', 'auto_datasource_driver', null, null, 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, null),
        (31, 1, '自动化任务', '0', 'auto_job_type', null, null, 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, null),
        (32, 2, '已注册类方法调用', '1', 'auto_job_type', null, null, 'Y', '0', 'admin', '2023-03-07 17:10:32', '', null, null);