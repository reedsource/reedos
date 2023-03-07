drop table if exists reedos.sys_menu;
create table reedos.sys_menu
(
    menu_id     bigint auto_increment comment '菜单ID'
        primary key,
    menu_name   varchar(50)              not null comment '菜单名称',
    parent_id   bigint       default 0   null comment '父菜单ID',
    order_num   int(4)       default 0   null comment '显示顺序',
    url         varchar(200) default '#' null comment '请求地址',
    target      varchar(20)  default ''  null comment '打开方式（menuItem页签 menuBlank新窗口）',
    menu_type   char         default ''  null comment '菜单类型（M目录 C菜单 F按钮）',
    visible     char         default '0' null comment '菜单状态（0显示 1隐藏）',
    is_refresh  char         default '1' null comment '是否刷新（0刷新 1不刷新）',
    perms       varchar(100)             null comment '权限标识',
    icon        varchar(100) default '#' null comment '菜单图标',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500) default ''  null comment '备注'
)
    comment '菜单权限表';

insert into reedos.sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
values  (1, '系统管理', 0, 1, '#', '', 'M', '0', '1', '', 'fa fa-gear', 'admin', '2023-03-07 17:10:31', '', null, '系统管理目录'),
        (2, '系统监控', 0, 2, '#', '', 'M', '0', '1', '', 'fa fa-video-camera', 'admin', '2023-03-07 17:10:31', '', null, '系统监控目录'),
        (3, '系统工具', 0, 3, '#', '', 'M', '0', '1', '', 'fa fa-bars', 'admin', '2023-03-07 17:10:31', '', null, '系统工具目录'),
        (4, '信息管理', 0, 4, '#', '', 'M', '0', '1', '', 'fa fa-at', 'admin', '2023-03-07 17:10:31', '', null, '信息管理目录'),
        (5, '自动化管理', 0, 5, '#', '', 'M', '0', '1', '', 'fa fa-refresh', 'admin', '2023-03-07 17:10:32', '', null, '自动化工具目录'),
        (100, '用户管理', 1, 1, '/system/user', '', 'C', '0', '1', 'system:user:view', 'fa fa-user-o', 'admin', '2023-03-07 17:10:31', '', null, '用户管理菜单'),
        (101, '角色管理', 1, 2, '/system/role', '', 'C', '0', '1', 'system:role:view', 'fa fa-user-secret', 'admin', '2023-03-07 17:10:31', '', null, '角色管理菜单'),
        (102, '菜单管理', 1, 3, '/system/menu', '', 'C', '0', '1', 'system:menu:view', 'fa fa-th-list', 'admin', '2023-03-07 17:10:31', '', null, '菜单管理菜单'),
        (103, '部门管理', 1, 4, '/system/dept', '', 'C', '0', '1', 'system:dept:view', 'fa fa-outdent', 'admin', '2023-03-07 17:10:31', '', null, '部门管理菜单'),
        (104, '岗位管理', 1, 5, '/system/post', '', 'C', '0', '1', 'system:post:view', 'fa fa-address-card-o', 'admin', '2023-03-07 17:10:31', '', null, '岗位管理菜单'),
        (105, '字典管理', 1, 6, '/system/dict', '', 'C', '0', '1', 'system:dict:view', 'fa fa-bookmark-o', 'admin', '2023-03-07 17:10:31', '', null, '字典管理菜单'),
        (106, '参数设置', 1, 7, '/system/config', '', 'C', '0', '1', 'system:config:view', 'fa fa-sun-o', 'admin', '2023-03-07 17:10:31', '', null, '参数设置菜单'),
        (107, '通知公告', 1, 8, '/system/notice', '', 'C', '0', '1', 'system:notice:view', 'fa fa-bullhorn', 'admin', '2023-03-07 17:10:31', '', null, '通知公告菜单'),
        (108, '日志管理', 1, 9, '#', '', 'M', '0', '1', '', 'fa fa-pencil-square-o', 'admin', '2023-03-07 17:10:31', '', null, '日志管理菜单'),
        (109, '在线用户', 2, 1, '/monitor/online', '', 'C', '0', '1', 'monitor:online:view', 'fa fa-user-circle', 'admin', '2023-03-07 17:10:31', '', null, '在线用户菜单'),
        (110, '定时任务', 5, 1, '/quartz/job', '', 'C', '0', '1', 'quartz:job:view', 'fa fa-tasks', 'admin', '2023-03-07 17:10:32', '', null, '定时任务菜单'),
        (111, '数据监控', 2, 3, '/monitor/data', '', 'C', '0', '1', 'monitor:data:view', 'fa fa-bug', 'admin', '2023-03-07 17:10:31', '', null, '数据监控菜单'),
        (112, '服务监控', 2, 4, '/monitor/server', '', 'C', '0', '1', 'monitor:server:view', 'fa fa-server', 'admin', '2023-03-07 17:10:31', '', null, '服务监控菜单'),
        (113, '缓存监控', 2, 5, '/monitor/cache', '', 'C', '0', '1', 'monitor:cache:view', 'fa fa-cube', 'admin', '2023-03-07 17:10:31', '', null, '缓存监控菜单'),
        (114, '表单构建', 3, 1, '/tool/build', '', 'C', '0', '1', 'tool:build:view', 'fa fa-wpforms', 'admin', '2023-03-07 17:10:31', '', null, '表单构建菜单'),
        (115, '代码生成', 3, 2, '/tool/gen', '', 'C', '0', '1', 'tool:gen:view', 'fa fa-code', 'admin', '2023-03-07 17:10:31', '', null, '代码生成菜单'),
        (116, '系统接口', 3, 3, '/tool/swagger', '', 'C', '0', '1', 'tool:swagger:view', 'fa fa-gg', 'admin', '2023-03-07 17:10:31', '', null, '系统接口菜单'),
        (200, '自动化任务', 5, 2, '/automation/autoflow', '', 'C', '0', '1', 'automation:autoflow:view', '#', 'admin', '2023-03-07 17:10:32', '', null, '自动化任务菜单'),
        (201, '自定义函数', 5, 3, '/automation/autofunction', '', 'C', '0', '1', 'automation:autofunction:view', '#', 'admin', '2023-03-07 17:10:32', '', null, '自定义函数菜单'),
        (202, '自动化数据源', 5, 4, '/automation/autodatasource', '', 'C', '0', '1', 'automation:autodatasource:view', '#', 'admin', '2023-03-07 17:10:32', '', null, '自动化数据源菜单'),
        (203, 'WebSocket', 5, 5, '/automation/notice', '', 'C', '0', '1', 'automation:websocket:view', '#', 'admin', '2023-03-07 17:10:32', '', null, 'WebSocket'),
        (500, '操作日志', 108, 1, '/monitor/operlog', '', 'C', '0', '1', 'monitor:operlog:view', 'fa fa-address-book', 'admin', '2023-03-07 17:10:31', '', null, '操作日志菜单'),
        (501, '登录日志', 108, 2, '/monitor/logininfor', '', 'C', '0', '1', 'monitor:logininfor:view', 'fa fa-file-image-o', 'admin', '2023-03-07 17:10:31', '', null, '登录日志菜单'),
        (1000, '用户查询', 100, 1, '#', '', 'F', '0', '1', 'system:user:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1001, '用户新增', 100, 2, '#', '', 'F', '0', '1', 'system:user:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1002, '用户修改', 100, 3, '#', '', 'F', '0', '1', 'system:user:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1003, '用户删除', 100, 4, '#', '', 'F', '0', '1', 'system:user:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1004, '用户导出', 100, 5, '#', '', 'F', '0', '1', 'system:user:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1005, '用户导入', 100, 6, '#', '', 'F', '0', '1', 'system:user:import', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1006, '重置密码', 100, 7, '#', '', 'F', '0', '1', 'system:user:resetPwd', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1007, '角色查询', 101, 1, '#', '', 'F', '0', '1', 'system:role:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1008, '角色新增', 101, 2, '#', '', 'F', '0', '1', 'system:role:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1009, '角色修改', 101, 3, '#', '', 'F', '0', '1', 'system:role:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1010, '角色删除', 101, 4, '#', '', 'F', '0', '1', 'system:role:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1011, '角色导出', 101, 5, '#', '', 'F', '0', '1', 'system:role:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1012, '菜单查询', 102, 1, '#', '', 'F', '0', '1', 'system:menu:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1013, '菜单新增', 102, 2, '#', '', 'F', '0', '1', 'system:menu:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1014, '菜单修改', 102, 3, '#', '', 'F', '0', '1', 'system:menu:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1015, '菜单删除', 102, 4, '#', '', 'F', '0', '1', 'system:menu:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1016, '部门查询', 103, 1, '#', '', 'F', '0', '1', 'system:dept:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1017, '部门新增', 103, 2, '#', '', 'F', '0', '1', 'system:dept:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1018, '部门修改', 103, 3, '#', '', 'F', '0', '1', 'system:dept:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1019, '部门删除', 103, 4, '#', '', 'F', '0', '1', 'system:dept:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1020, '岗位查询', 104, 1, '#', '', 'F', '0', '1', 'system:post:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1021, '岗位新增', 104, 2, '#', '', 'F', '0', '1', 'system:post:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1022, '岗位修改', 104, 3, '#', '', 'F', '0', '1', 'system:post:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1023, '岗位删除', 104, 4, '#', '', 'F', '0', '1', 'system:post:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1024, '岗位导出', 104, 5, '#', '', 'F', '0', '1', 'system:post:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1025, '字典查询', 105, 1, '#', '', 'F', '0', '1', 'system:dict:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1026, '字典新增', 105, 2, '#', '', 'F', '0', '1', 'system:dict:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1027, '字典修改', 105, 3, '#', '', 'F', '0', '1', 'system:dict:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1028, '字典删除', 105, 4, '#', '', 'F', '0', '1', 'system:dict:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1029, '字典导出', 105, 5, '#', '', 'F', '0', '1', 'system:dict:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1030, '参数查询', 106, 1, '#', '', 'F', '0', '1', 'system:config:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1031, '参数新增', 106, 2, '#', '', 'F', '0', '1', 'system:config:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1032, '参数修改', 106, 3, '#', '', 'F', '0', '1', 'system:config:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1033, '参数删除', 106, 4, '#', '', 'F', '0', '1', 'system:config:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1034, '参数导出', 106, 5, '#', '', 'F', '0', '1', 'system:config:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1035, '公告查询', 107, 1, '#', '', 'F', '0', '1', 'system:notice:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1036, '公告新增', 107, 2, '#', '', 'F', '0', '1', 'system:notice:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1037, '公告修改', 107, 3, '#', '', 'F', '0', '1', 'system:notice:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1038, '公告删除', 107, 4, '#', '', 'F', '0', '1', 'system:notice:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1039, '操作查询', 500, 1, '#', '', 'F', '0', '1', 'monitor:operlog:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1040, '操作删除', 500, 2, '#', '', 'F', '0', '1', 'monitor:operlog:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1041, '详细信息', 500, 3, '#', '', 'F', '0', '1', 'monitor:operlog:detail', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1042, '日志导出', 500, 4, '#', '', 'F', '0', '1', 'monitor:operlog:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1043, '登录查询', 501, 1, '#', '', 'F', '0', '1', 'monitor:logininfor:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1044, '登录删除', 501, 2, '#', '', 'F', '0', '1', 'monitor:logininfor:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1045, '日志导出', 501, 3, '#', '', 'F', '0', '1', 'monitor:logininfor:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1046, '账户解锁', 501, 4, '#', '', 'F', '0', '1', 'monitor:logininfor:unlock', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1047, '在线查询', 109, 1, '#', '', 'F', '0', '1', 'monitor:online:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1048, '批量强退', 109, 2, '#', '', 'F', '0', '1', 'monitor:online:batchForceLogout', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1049, '单条强退', 109, 3, '#', '', 'F', '0', '1', 'monitor:online:forceLogout', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1050, '任务查询', 110, 1, '#', '', 'F', '0', '1', 'quartz:job:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1051, '任务新增', 110, 2, '#', '', 'F', '0', '1', 'quartz:job:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1052, '任务修改', 110, 3, '#', '', 'F', '0', '1', 'quartz:job:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1053, '任务删除', 110, 4, '#', '', 'F', '0', '1', 'quartz:job:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1054, '状态修改', 110, 5, '#', '', 'F', '0', '1', 'quartz:job:changeStatus', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1055, '任务详细', 110, 6, '#', '', 'F', '0', '1', 'quartz:job:detail', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1056, '任务导出', 110, 7, '#', '', 'F', '0', '1', 'quartz:job:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1057, '生成查询', 115, 1, '#', '', 'F', '0', '1', 'tool:gen:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1058, '生成修改', 115, 2, '#', '', 'F', '0', '1', 'tool:gen:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1059, '生成删除', 115, 3, '#', '', 'F', '0', '1', 'tool:gen:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1060, '预览代码', 115, 4, '#', '', 'F', '0', '1', 'tool:gen:preview', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (1061, '生成代码', 115, 5, '#', '', 'F', '0', '1', 'tool:gen:code', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2001, '自动化任务查询', 200, 1, '#', '', 'F', '0', '1', 'automation:autoflow:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2002, '自动化任务新增', 200, 2, '#', '', 'F', '0', '1', 'automation:autoflow:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2003, '自动化任务修改', 200, 3, '#', '', 'F', '0', '1', 'automation:autoflow:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2004, '自动化任务删除', 200, 4, '#', '', 'F', '0', '1', 'automation:autoflow:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2005, '自动化任务导出', 200, 5, '#', '', 'F', '0', '1', 'automation:autoflow:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2011, '自定义函数查询', 201, 1, '#', '', 'F', '0', '1', 'automation:autofunction:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2012, '自定义函数新增', 201, 2, '#', '', 'F', '0', '1', 'automation:autofunction:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2013, '自定义函数修改', 201, 3, '#', '', 'F', '0', '1', 'automation:autofunction:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2014, '自定义函数删除', 201, 4, '#', '', 'F', '0', '1', 'automation:autofunction:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2015, '自定义函数导出', 201, 5, '#', '', 'F', '0', '1', 'automation:autofunction:export', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2021, '自动化数据源查询', 202, 1, '#', '', 'F', '0', '1', 'automation:autodatasource:list', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2022, '自动化数据源新增', 202, 2, '#', '', 'F', '0', '1', 'automation:autodatasource:add', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2023, '自动化数据源修改', 202, 3, '#', '', 'F', '0', '1', 'automation:autodatasource:edit', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2024, '自动化数据源删除', 202, 4, '#', '', 'F', '0', '1', 'automation:autodatasource:remove', '#', 'admin', '2023-03-07 17:10:32', '', null, ''),
        (2025, '自动化数据源导出', 202, 5, '#', '', 'F', '0', '1', 'automation:autodatasource:export', '#', 'admin', '2023-03-07 17:10:32', '', null, '');