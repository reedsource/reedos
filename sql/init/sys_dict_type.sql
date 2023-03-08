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
values (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-03-07 17:10:32', '', null, '用户性别列表'),
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
       (12, '任务类型', 'auto_job_type', '0', 'admin', '2023-03-07 17:10:32', '', null, '定时任务类型'),
       (13, '审核状态', 'audit_state', '0', 'admin', '2022-09-16 11:33:00', 'ry', '2022-09-16 11:33:00', '登录状态列表'),
       (100, '人工智能识别类型', 'ai_type', '0', 'admin', '2022-09-12 17:55:24', 'ry', '2022-09-28 20:05:34', null),
       (101, '文章专区', 'article_region', '0', 'admin', '2022-09-12 17:55:24', 'ry', '2022-09-28 20:05:31', ''),
       (102, '标签类型', 'tags_type', '0', 'admin', '2022-09-12 17:55:24', 'ry', '2022-09-28 20:05:31', ''),
       (103, '文章模型', 'article_model', '0', 'admin', '2022-09-12 17:55:24', 'ry', '2022-09-28 20:05:31', ''),
       (104, '发送标志', 'send_flag', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (105, '发送类型', 'send_type', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (106, '文章状态', 'sys_available_status', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (107, '使用状态', 'use_state', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (108, '素材类型', 'material_type', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (109, '百度推送类型', 'baidu_push_type', '0', 'admin', '2022-09-12 17:55:24', 'admin', '2022-09-12 17:55:24', null),
       (110, '相册类型', 'album_type', '0', 'admin', '2019-11-08 10:41:04', '', null, '相册类型'),
       (111, '爬虫任务状态', 'spider_mission_status', '0', 'admin', '2019-11-11 14:22:40', '', null, null),
       (112, '爬虫退出方式', 'spider_exit_way', '0', 'admin', '2019-11-11 15:01:27', '', null, null),
       (113, '爬虫内容提取类型', 'spider_extract_type', '0', 'admin', '2019-11-12 10:13:40', '', null, null),
       (114, '爬虫值处理规则', 'field_value_process_type', '0', 'admin', '2019-11-14 17:01:07', '', null, '爬虫字段值处理规则'),
       (115, '模板分类', 'template_type', '0', 'admin', '2019-11-17 12:33:38', '', null, null),
       (116, '站内消息类型', 'site_msg_type', '0', 'admin', '2019-11-17 20:01:30', '', null, null),
       (117, '评论类型', 'cms_comment_type', '0', 'admin', '2019-11-19 16:35:02', '', null, null),
       (118, '收/免费标志', 'cms_free', '0', 'admin', '2019-11-23 16:16:43', '', null, null),
       (119, '资源下载类型', 'cms_download_type', '0', 'admin', '2019-11-23 16:17:59', '', null, null),
       (120, '支付类型', 'cms_pay_type', '0', 'admin', '2019-11-23 16:20:42', '', null, null),
       (121, '资源类型', 'cms_resource_type', '0', 'admin', '2019-11-23 17:14:36', '', null, null),
       (122, '客户端设备类型', 'client_device_type', '0', 'admin', '2019-11-29 08:41:28', '', null, null),
       (123, '共享类型', 'share_type', '0', 'admin', '2019-12-31 08:43:40', '', null, null);