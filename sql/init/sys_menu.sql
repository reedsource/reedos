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
values (1000000, '系统管理', 0, 1, '#', '', 'M', '0', '1', '', 'fa fa-gear', 'admin', sysdate(), '', null, '系统管理目录'),
       (1010000, '用户管理', 1000000, 1, '/system/user', '', 'C', '0', '1', 'system:user:view', 'fa fa-user-o', 'admin', sysdate(), '', null, '用户管理菜单'),
       (1010100, '用户查询', 1010000, 1, '#', '', 'F', '0', '1', 'system:user:list', '#', 'admin', sysdate(), '', null, ''),
       (1010200, '用户新增', 1010000, 2, '#', '', 'F', '0', '1', 'system:user:add', '#', 'admin', sysdate(), '', null, ''),
       (1010300, '用户修改', 1010000, 3, '#', '', 'F', '0', '1', 'system:user:edit', '#', 'admin', sysdate(), '', null, ''),
       (1010400, '用户删除', 1010000, 4, '#', '', 'F', '0', '1', 'system:user:remove', '#', 'admin', sysdate(), '', null, ''),
       (1010500, '用户导出', 1010000, 5, '#', '', 'F', '0', '1', 'system:user:export', '#', 'admin', sysdate(), '', null, ''),
       (1010600, '用户导入', 1010000, 6, '#', '', 'F', '0', '1', 'system:user:import', '#', 'admin', sysdate(), '', null, ''),
       (1010700, '重置密码', 1010000, 7, '#', '', 'F', '0', '1', 'system:user:resetPwd', '#', 'admin', sysdate(), '', null, ''),
       (1020000, '角色管理', 1000000, 2, '/system/role', '', 'C', '0', '1', 'system:role:view', 'fa fa-user-secret', 'admin', sysdate(), '', null, '角色管理菜单'),
       (1020100, '角色查询', 1020000, 1, '#', '', 'F', '0', '1', 'system:role:list', '#', 'admin', sysdate(), '', null, ''),
       (1020200, '角色新增', 1020000, 2, '#', '', 'F', '0', '1', 'system:role:add', '#', 'admin', sysdate(), '', null, ''),
       (1020300, '角色修改', 1020000, 3, '#', '', 'F', '0', '1', 'system:role:edit', '#', 'admin', sysdate(), '', null, ''),
       (1020400, '角色删除', 1020000, 4, '#', '', 'F', '0', '1', 'system:role:remove', '#', 'admin', sysdate(), '', null, ''),
       (1020500, '角色导出', 1020000, 5, '#', '', 'F', '0', '1', 'system:role:export', '#', 'admin', sysdate(), '', null, ''),
       (1030000, '菜单管理', 1000000, 3, '/system/menu', '', 'C', '0', '1', 'system:menu:view', 'fa fa-th-list', 'admin', sysdate(), '', null, '菜单管理菜单'),
       (1030100, '菜单查询', 1030000, 1, '#', '', 'F', '0', '1', 'system:menu:list', '#', 'admin', sysdate(), '', null, ''),
       (1030200, '菜单新增', 1030000, 2, '#', '', 'F', '0', '1', 'system:menu:add', '#', 'admin', sysdate(), '', null, ''),
       (1030300, '菜单修改', 1030000, 3, '#', '', 'F', '0', '1', 'system:menu:edit', '#', 'admin', sysdate(), '', null, ''),
       (1030400, '菜单删除', 1030000, 4, '#', '', 'F', '0', '1', 'system:menu:remove', '#', 'admin', sysdate(), '', null, ''),
       (1040000, '部门管理', 1000000, 4, '/system/dept', '', 'C', '0', '1', 'system:dept:view', 'fa fa-outdent', 'admin', sysdate(), '', null, '部门管理菜单'),
       (1040100, '部门查询', 1040000, 1, '#', '', 'F', '0', '1', 'system:dept:list', '#', 'admin', sysdate(), '', null, ''),
       (1040200, '部门新增', 1040000, 2, '#', '', 'F', '0', '1', 'system:dept:add', '#', 'admin', sysdate(), '', null, ''),
       (1040300, '部门修改', 1040000, 3, '#', '', 'F', '0', '1', 'system:dept:edit', '#', 'admin', sysdate(), '', null, ''),
       (1040400, '部门删除', 1040000, 4, '#', '', 'F', '0', '1', 'system:dept:remove', '#', 'admin', sysdate(), '', null, ''),
       (1050000, '岗位管理', 1000000, 5, '/system/post', '', 'C', '0', '1', 'system:post:view', 'fa fa-address-card-o', 'admin', sysdate(), '', null, '岗位管理菜单'),
       (1050100, '岗位查询', 1050000, 1, '#', '', 'F', '0', '1', 'system:post:list', '#', 'admin', sysdate(), '', null, ''),
       (1050200, '岗位新增', 1050000, 2, '#', '', 'F', '0', '1', 'system:post:add', '#', 'admin', sysdate(), '', null, ''),
       (1050300, '岗位修改', 1050000, 3, '#', '', 'F', '0', '1', 'system:post:edit', '#', 'admin', sysdate(), '', null, ''),
       (1050400, '岗位删除', 1050000, 4, '#', '', 'F', '0', '1', 'system:post:remove', '#', 'admin', sysdate(), '', null, ''),
       (1050500, '岗位导出', 1050000, 5, '#', '', 'F', '0', '1', 'system:post:export', '#', 'admin', sysdate(), '', null, ''),
       (1060000, '字典管理', 1000000, 6, '/system/dict', '', 'C', '0', '1', 'system:dict:view', 'fa fa-bookmark-o', 'admin', sysdate(), '', null, '字典管理菜单'),
       (1060100, '字典查询', 1060000, 1, '#', '', 'F', '0', '1', 'system:dict:list', '#', 'admin', sysdate(), '', null, ''),
       (1060200, '字典新增', 1060000, 2, '#', '', 'F', '0', '1', 'system:dict:add', '#', 'admin', sysdate(), '', null, ''),
       (1060300, '字典修改', 1060000, 3, '#', '', 'F', '0', '1', 'system:dict:edit', '#', 'admin', sysdate(), '', null, ''),
       (1060400, '字典删除', 1060000, 4, '#', '', 'F', '0', '1', 'system:dict:remove', '#', 'admin', sysdate(), '', null, ''),
       (1060500, '字典导出', 1060000, 5, '#', '', 'F', '0', '1', 'system:dict:export', '#', 'admin', sysdate(), '', null, ''),
       (1070000, '参数设置', 1000000, 7, '/system/config', '', 'C', '0', '1', 'system:config:view', 'fa fa-sun-o', 'admin', sysdate(), '', null, '参数设置菜单'),
       (1070100, '参数查询', 1070000, 1, '#', '', 'F', '0', '1', 'system:config:list', '#', 'admin', sysdate(), '', null, ''),
       (1070200, '参数新增', 1070000, 2, '#', '', 'F', '0', '1', 'system:config:add', '#', 'admin', sysdate(), '', null, ''),
       (1070300, '参数修改', 1070000, 3, '#', '', 'F', '0', '1', 'system:config:edit', '#', 'admin', sysdate(), '', null, ''),
       (1070400, '参数删除', 1070000, 4, '#', '', 'F', '0', '1', 'system:config:remove', '#', 'admin', sysdate(), '', null, ''),
       (1070500, '参数导出', 1070000, 5, '#', '', 'F', '0', '1', 'system:config:export', '#', 'admin', sysdate(), '', null, ''),
       (1080000, '通知公告', 1000000, 8, '/system/notice', '', 'C', '0', '1', 'system:notice:view', 'fa fa-bullhorn', 'admin', sysdate(), '', null, '通知公告菜单'),
       (1080100, '公告查询', 1080000, 1, '#', '', 'F', '0', '1', 'system:notice:list', '#', 'admin', sysdate(), '', null, ''),
       (1080200, '公告新增', 1080000, 2, '#', '', 'F', '0', '1', 'system:notice:add', '#', 'admin', sysdate(), '', null, ''),
       (1080300, '公告修改', 1080000, 3, '#', '', 'F', '0', '1', 'system:notice:edit', '#', 'admin', sysdate(), '', null, ''),
       (1080400, '公告删除', 1080000, 4, '#', '', 'F', '0', '1', 'system:notice:remove', '#', 'admin', sysdate(), '', null, ''),
       (1090000, '日志管理', 1000000, 9, '#', '', 'M', '0', '1', '', 'fa fa-pencil-square-o', 'admin', sysdate(), '', null, '日志管理菜单'),
       (1090100, '操作日志', 1090000, 1, '/monitor/operlog', '', 'C', '0', '1', 'monitor:operlog:view', 'fa fa-address-book', 'admin', sysdate(), '', null, '操作日志菜单'),
       (1090101, '操作查询', 1090100, 1, '#', '', 'F', '0', '1', 'monitor:operlog:list', '#', 'admin', sysdate(), '', null, ''),
       (1090102, '操作删除', 1090100, 2, '#', '', 'F', '0', '1', 'monitor:operlog:remove', '#', 'admin', sysdate(), '', null, ''),
       (1090103, '详细信息', 1090100, 3, '#', '', 'F', '0', '1', 'monitor:operlog:detail', '#', 'admin', sysdate(), '', null, ''),
       (1090104, '日志导出', 1090100, 4, '#', '', 'F', '0', '1', 'monitor:operlog:export', '#', 'admin', sysdate(), '', null, ''),
       (1090200, '登录日志', 1090000, 2, '/monitor/logininfor', '', 'C', '0', '1', 'monitor:logininfor:view', 'fa fa-file-image-o', 'admin', sysdate(), '', null, '登录日志菜单'),
       (1090201, '登录查询', 1090200, 1, '#', '', 'F', '0', '1', 'monitor:logininfor:list', '#', 'admin', sysdate(), '', null, ''),
       (1090202, '登录删除', 1090200, 2, '#', '', 'F', '0', '1', 'monitor:logininfor:remove', '#', 'admin', sysdate(), '', null, ''),
       (1090203, '日志导出', 1090200, 3, '#', '', 'F', '0', '1', 'monitor:logininfor:export', '#', 'admin', sysdate(), '', null, ''),
       (1090204, '账户解锁', 1090200, 4, '#', '', 'F', '0', '1', 'monitor:logininfor:unlock', '#', 'admin', sysdate(), '', null, '');

insert into reedos.sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
values (2000000, '系统监控', 0, 2, '#', '', 'M', '0', '1', '', 'fa fa-video-camera', 'admin', sysdate(), '', null, '系统监控目录'),
       (2010000, '在线用户', 2000000, 1, '/monitor/online', '', 'C', '0', '1', 'monitor:online:view', 'fa fa-user-circle', 'admin', sysdate(), '', null, '在线用户菜单'),
       (2010100, '在线查询', 2010000, 1, '#', '', 'F', '0', '1', 'monitor:online:list', '#', 'admin', sysdate(), '', null, ''),
       (2010200, '批量强退', 2010000, 2, '#', '', 'F', '0', '1', 'monitor:online:batchForceLogout', '#', 'admin', sysdate(), '', null, ''),
       (2010300, '单条强退', 2010000, 3, '#', '', 'F', '0', '1', 'monitor:online:forceLogout', '#', 'admin', sysdate(), '', null, ''),
       (2020000, '数据监控', 2000000, 2, '/monitor/data', '', 'C', '0', '1', 'monitor:data:view', 'fa fa-bug', 'admin', sysdate(), '', null, '数据监控菜单'),
       (2030000, '服务监控', 2000000, 3, '/monitor/server', '', 'C', '0', '1', 'monitor:server:view', 'fa fa-server', 'admin', sysdate(), '', null, '服务监控菜单'),
       (2040000, '缓存监控', 2000000, 4, '/monitor/cache', '', 'C', '0', '1', 'monitor:cache:view', 'fa fa-cube', 'admin', sysdate(), '', null, '缓存监控菜单');

insert into reedos.sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
values (3000000, '系统工具', 0, 3, '#', '', 'M', '0', '1', '', 'fa fa-bars', 'admin', sysdate(), '', null, '系统工具目录'),
       (3010000, '表单构建', 3000000, 1, '/tool/build', '', 'C', '0', '1', 'tool:build:view', 'fa fa-wpforms', 'admin', sysdate(), '', null, '表单构建菜单'),
       (3020000, '代码生成', 3000000, 2, '/tool/gen', '', 'C', '0', '1', 'tool:gen:view', 'fa fa-code', 'admin', sysdate(), '', null, '代码生成菜单'),
       (3020100, '生成查询', 3020000, 1, '#', '', 'F', '0', '1', 'tool:gen:list', '#', 'admin', sysdate(), '', null, ''),
       (3020200, '生成修改', 3020000, 2, '#', '', 'F', '0', '1', 'tool:gen:edit', '#', 'admin', sysdate(), '', null, ''),
       (3020300, '生成删除', 3020000, 3, '#', '', 'F', '0', '1', 'tool:gen:remove', '#', 'admin', sysdate(), '', null, ''),
       (3020400, '预览代码', 3020000, 4, '#', '', 'F', '0', '1', 'tool:gen:preview', '#', 'admin', sysdate(), '', null, ''),
       (3020500, '生成代码', 3020000, 5, '#', '', 'F', '0', '1', 'tool:gen:code', '#', 'admin', sysdate(), '', null, ''),
       (3030000, '系统接口', 3000000, 3, '/tool/swagger', '', 'C', '0', '1', 'tool:swagger:view', 'fa fa-gg', 'admin', sysdate(), '', null, '系统接口菜单');

insert into reedos.sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
values (4000000, '内容管理', 0, 4, '#', 'menuItem', 'M', '0', '1', null, 'fa fa-address-card-o', 'admin', sysdate(), '', null, ''),
       (4010000, '文章管理', 4000000, 1, '/cms/article', 'menuItem', 'C', '0', '1', 'cms:article:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4010100, '文章列表', 4010000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:article:list', '#', 'admin', sysdate(), '', null, ''),
       (4010200, '文章新增', 4010000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:article:add', '#', 'admin', sysdate(), '', null, ''),
       (4010300, '文章修改', 4010000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:article:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4020000, '栏目分类', 4000000, 2, '/cms/category', 'menuItem', 'C', '0', '1', 'cms:category:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4020100, '栏目列表', 4020000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:category:list', '#', 'admin', sysdate(), '', null, ''),
       (4020200, '栏目添加', 4020000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:category:add', '#', 'admin', sysdate(), '', null, ''),
       (4020300, '栏目编辑', 4020000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:category:edit', '#', 'admin', sysdate(), '', null, ''),
       (4020400, '栏目删除', 4020000, 4, '#', 'menuItem', 'F', '0', '1', 'cms:category:remove', '#', 'admin', sysdate(), '', null, ''),
       (4030000, '标签管理', 4000000, 3, '/cms/tags', 'menuItem', 'C', '0', '1', 'cms:tags:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4030100, '标签列表', 4030000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:tags:list', '#', 'admin', sysdate(), '', null, ''),
       (4030200, '标签新增', 4030000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:tags:add', '#', 'admin', sysdate(), '', null, ''),
       (4030300, '标签编辑', 4030000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:tags:edit', '#', 'admin', sysdate(), '', null, ''),
       (4030400, '标签删除', 4030000, 4, '#', 'menuItem', 'F', '0', '1', 'cms:tags:remove', '#', 'admin', sysdate(), '', null, ''),
       (4040000, '附件管理', 4000000, 4, '/cms/attachment', 'menuItem', 'C', '0', '1', 'cms:attachment', '#', 'admin', sysdate(), '', null, ''),
       (4050000, '邮件管理', 4000000, 5, '/cms/email', 'menuItem', 'C', '0', '1', 'cms:email:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4050100, '邮件列表', 4050000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:email:list', '#', 'admin', sysdate(), '', null, ''),
       (4050200, '邮件删除', 4050000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:email:remove', '#', 'admin', sysdate(), '', null, ''),
       (4060000, '素材管理', 4000000, 6, '/cms/material', 'menuItem', 'C', '0', '1', 'cms:material:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4060100, '素材列表', 4060000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:material:list', '#', 'admin', sysdate(), '', null, ''),
       (4060200, '素材新增', 4060000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:material:add', '#', 'admin', sysdate(), '', null, ''),
       (4060300, '素材编辑', 4060000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:material:edit', '#', 'admin', sysdate(), '', null, ''),
       (4060400, '素材审核', 4060000, 4, '#', 'menuItem', 'F', '0', '1', 'cms:material:audit', '#', 'admin', sysdate(), '', null, ''),
       (4060500, '素材使用记录', 4060000, 4, '#', 'menuItem', 'F', '0', '1', 'cms:material:materialUse', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4070000, '素材分组管理', 4000000, 7, '/cms/materialGroup', 'menuItem', 'C', '0', '1', 'cms:materialGroup:view', '#', 'yf', sysdate(), '', null, ''),
       (4070100, '素材分组列表', 4070000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:materialGroup:list', '#', 'admin', sysdate(), '', null, ''),
       (4070200, '素材分组新增', 4070000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:materialGroup:add', '#', 'admin', sysdate(), '', null, ''),
       (4070300, '素材分组编辑', 4070000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:materialGroup:edit', '#', 'admin', sysdate(), '', null, ''),
       (4080000, '相册管理', 4000000, 8, '/cms/album', 'menuItem', 'C', '0', '1', 'cms:album:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4080100, '相册列表', 4080000, 1, '#', 'menuItem', 'F', '0', '1', 'cms:album:list', '#', 'admin', sysdate(), '', null, ''),
       (4080200, '相册编辑', 4080000, 2, '#', 'menuItem', 'F', '0', '1', 'cms:album:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4080300, '相册删除', 4080000, 3, '#', 'menuItem', 'F', '0', '1', 'cms:album:remove', '#', 'admin', sysdate(), '', null, ''),
       (4080400, '添加图片', 4080000, 4, '#', 'menuItem', 'F', '0', '1', 'cms:album:addMaterial', '#', 'admin', sysdate(), '', null, ''),
       (4090000, 'PV页面浏览量', 4000000, 9, '/cms/pv', '', 'C', '0', '1', 'cms:pv:view', '#', 'admin', sysdate(), 'ry', sysdate(), 'PV菜单'),
       (4090100, 'PV列表', 4090000, 1, '#', '', 'F', '0', '1', 'cms:pv:list', '#', 'admin', sysdate(), 'ry', sysdate(), ''),
       (4090200, 'PV新增', 4090000, 2, '#', '', 'F', '0', '1', 'cms:pv:add', '#', 'admin', sysdate(), 'ry', sysdate(), ''),
       (4090300, 'PV修改', 4090000, 3, '#', '', 'F', '0', '1', 'cms:pv:edit', '#', 'admin', sysdate(), 'ry', sysdate(), ''),
       (4090400, 'PV删除', 4090000, 4, '#', '', 'F', '0', '1', 'cms:pv:remove', '#', 'admin', sysdate(), 'ry', sysdate(), ''),
       (4100000, '其他管理', 4000000, 10, '#', '', 'M', '0', '1', '', 'fa fa-video-camera', 'admin', sysdate(), '', null, '系统监控目录'),
       (4100100, '博客主题', 4100000, 1, '/cms/blogTheme', 'menuItem', 'C', '0', '1', 'cms:blogTheme:view', '#', 'admin', sysdate(), '', null, ''),
       (4100101, '博客主题列表', 4100100, 1, '#', '', 'F', '0', '1', 'cms:blogTheme:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100102, '博客主题添加', 4100100, 2, '#', '', 'F', '0', '1', 'cms:blogTheme:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100103, '博客主题修改', 4100100, 3, '#', '', 'F', '0', '1', 'cms:blogTheme:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100104, '博客主题删除', 4100100, 4, '#', '', 'F', '0', '1', 'cms:blogTheme:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100105, '博客主题导出', 4100100, 5, '#', '', 'F', '0', '1', 'cms:blogTheme:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100200, '登录页面列表', 4100000, 2, '/cms/loginPage', 'menuItem', 'C', '0', '1', 'cms:loginPage:view', '#', 'admin', sysdate(), '', null, ''),
       (4100201, '登录页面添加', 4100200, 1, '#', '', 'F', '0', '1', 'cms:loginPage:add', '#', 'admin', sysdate(), '', null, ''),
       (4100202, '登录页面修改', 4100200, 2, '#', '', 'F', '0', '1', 'cms:loginPage:edit', '#', 'admin', sysdate(), '', null, ''),
       (4100203, '登录页面删除', 4100200, 3, '#', '', 'F', '0', '1', 'cms:loginPage:remove', '#', 'admin', sysdate(), '', null, ''),
       (4100204, '登录页面导出', 4100200, 4, '#', '', 'F', '0', '1', 'cms:loginPage:export', '#', 'admin', sysdate(), '', null, ''),
       (4100300, '文章模板管理', 4100000, 3, '/cms/articleTemplate', 'menuItem', 'C', '0', '1', 'cms:articleTemplate:view', '#', 'admin', sysdate(), '', null, ''),
       (4100301, '文章模板列表', 4100300, 1, '#', '', 'F', '0', '1', 'cms:articleTemplate:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100302, '文章模板列表', 4100300, 2, '#', '', 'F', '0', '1', 'cms:articleTemplate:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100303, '文章模板列表', 4100300, 3, '#', '', 'F', '0', '1', 'cms:articleTemplate:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100304, '文章模板列表', 4100300, 4, '#', '', 'F', '0', '1', 'cms:articleTemplate:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100305, '文章模板审核', 4100300, 5, '#', '', 'F', '0', '1', 'cms:articleTemplate:audit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100400, '广告位管理', 4100000, 4, '/cms/ad', 'menuItem', 'C', '0', '1', 'cms:ad:view', '#', 'admin', sysdate(), '', null, ''),
       (4100401, '广告位列表', 4100400, 1, '#', '', 'F', '0', '1', 'cms:ad:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100402, '广告位添加', 4100400, 2, '#', '', 'F', '0', '1', 'cms:ad:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100403, '广告位修改', 4100400, 3, '#', '', 'F', '0', '1', 'cms:ad:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100404, '广告位删除', 4100400, 4, '#', '', 'F', '0', '1', 'cms:ad:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100500, '友链管理', 4100000, 5, '/cms/friendLink', 'menuItem', 'C', '0', '1', 'cms:friendLink:view', '#', 'admin', sysdate(), '', null, ''),
       (4100501, '友链列表', 4100500, 1, '#', '', 'F', '0', '1', 'cms:friendLink:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100502, '友链添加', 4100500, 2, '#', '', 'F', '0', '1', 'cms:friendLink:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100503, '友链修改', 4100500, 3, '#', '', 'F', '0', '1', 'cms:friendLink:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100504, '友链删除', 4100500, 4, '#', '', 'F', '0', '1', 'cms:friendLink:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100600, '模板管理', 4100000, 6, '/cms/template', 'menuItem', 'C', '0', '1', 'cms:template:view', '#', 'admin', sysdate(), '', null, ''),
       (4100601, '模板列表', 4100600, 1, '#', '', 'F', '0', '1', 'cms:template:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100602, '模板添加', 4100600, 2, '#', '', 'F', '0', '1', 'cms:template:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100603, '模板修改', 4100600, 3, '#', '', 'F', '0', '1', 'cms:template:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100604, '模板删除', 4100600, 4, '#', '', 'F', '0', '1', 'cms:template:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100605, '模板导出', 4100600, 5, '#', '', 'F', '0', '1', 'cms:template:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100700, '站内消息', 4100000, 7, '/cms/siteMsg', 'menuItem', 'C', '0', '1', 'cms:siteMsg:view', '#', 'admin', sysdate(), '', null, ''),
       (4100701, '站内消息列表', 4100700, 1, '#', '', 'F', '0', '1', 'cms:siteMsg:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100702, '站内消息添加', 4100700, 2, '#', '', 'F', '0', '1', 'cms:siteMsg:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100703, '站内消息修改', 4100700, 3, '#', '', 'F', '0', '1', 'cms:siteMsg:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100704, '站内消息删除', 4100700, 4, '#', '', 'F', '0', '1', 'cms:siteMsg:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100800, '评论管理', 4100000, 8, '/cms/comment', 'menuItem', 'C', '0', '1', 'cms:comment:view', '#', 'admin', sysdate(), '', null, ''),
       (4100801, '评论列表', 4100800, 1, '#', '', 'F', '0', '1', 'cms:comment:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100802, '评论添加', 4100800, 2, '#', '', 'F', '0', '1', 'cms:comment:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100803, '评论修改', 4100800, 3, '#', '', 'F', '0', '1', 'cms:comment:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100804, '评论删除', 4100800, 4, '#', '', 'F', '0', '1', 'cms:comment:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100805, '评论导出', 4100800, 5, '#', '', 'F', '0', '1', 'cms:comment:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100900, '励志短语', 4100000, 9, '/cms/shortWords', 'menuItem', 'C', '0', '1', 'cms:shortWords:view', '#', 'admin', sysdate(), '', null, ''),
       (4100901, '励志短语列表', 4100900, 1, '#', '', 'F', '0', '1', 'cms:shortWords:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100902, '励志短语添加', 4100900, 2, '#', '', 'F', '0', '1', 'cms:shortWords:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100903, '励志短语修改', 4100900, 3, '#', '', 'F', '0', '1', 'cms:shortWords:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100904, '励志短语删除', 4100900, 4, '#', '', 'F', '0', '1', 'cms:shortWords:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4100905, '励志短语导出', 4100900, 5, '#', '', 'F', '0', '1', 'cms:shortWords:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101000, '资源管理', 4100000, 10, '/cms/resource', 'menuItem', 'C', '0', '1', 'cms:resource:view', '#', 'admin', sysdate(), '', null, ''),
       (4101001, '资源列表', 4101000, 1, '#', '', 'F', '0', '1', 'cms:resource:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101002, '资源添加', 4101000, 2, '#', '', 'F', '0', '1', 'cms:resource:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101003, '资源修改', 4101000, 3, '#', '', 'F', '0', '1', 'cms:resource:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101004, '资源删除', 4101000, 4, '#', '', 'F', '0', '1', 'cms:resource:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101005, '资源导出', 4101000, 5, '#', '', 'F', '0', '1', 'cms:resource:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101100, '链接分类管理', 4100000, 11, '/cms/linkType', 'menuItem', 'C', '0', '1', 'cms:linkType:view', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101101, '链接分类列表', 4101100, 1, '#', '', 'F', '0', '1', 'cms:linkType:list', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101102, '链接分类添加', 4101100, 2, '#', '', 'F', '0', '1', 'cms:linkType:add', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101103, '链接分类修改', 4101100, 3, '#', '', 'F', '0', '1', 'cms:linkType:edit', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101104, '链接分类删除', 4101100, 4, '#', '', 'F', '0', '1', 'cms:linkType:remove', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101105, '链接分类导出', 4101100, 5, '#', '', 'F', '0', '1', 'cms:linkType:export', '#', 'admin', sysdate(), 'admin', sysdate(), ''),
       (4101200, '链接管理', 4100000, 12, '/cms/link', 'menuItem', 'C', '0', '1', 'cms:link:view', '#', 'admin', sysdate(), '', null, ''),
       (4101201, '链接列表', 4101200, 1, '#', '', 'F', '0', '1', 'cms:link:list', '#', 'admin', sysdate(), 'admin', sysdate(), '');

insert into reedos.sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
values (5000000, '自动化管理', 0, 5, '#', '', 'M', '0', '1', '', 'fa fa-refresh', 'admin', sysdate(), '', null, '自动化工具目录'),
       (5010000, '定时任务', 5000000, 1, '/quartz/job', '', 'C', '0', '1', 'quartz:job:view', 'fa fa-tasks', 'admin', sysdate(), '', null, '定时任务菜单'),
       (5010100, '任务查询', 5010000, 1, '#', '', 'F', '0', '1', 'quartz:job:list', '#', 'admin', sysdate(), '', null, ''),
       (5010200, '任务新增', 5010000, 2, '#', '', 'F', '0', '1', 'quartz:job:add', '#', 'admin', sysdate(), '', null, ''),
       (5010300, '任务修改', 5010000, 3, '#', '', 'F', '0', '1', 'quartz:job:edit', '#', 'admin', sysdate(), '', null, ''),
       (5010400, '任务删除', 5010000, 4, '#', '', 'F', '0', '1', 'quartz:job:remove', '#', 'admin', sysdate(), '', null, ''),
       (5010500, '状态修改', 5010000, 5, '#', '', 'F', '0', '1', 'quartz:job:changeStatus', '#', 'admin', sysdate(), '', null, ''),
       (5010600, '任务详细', 5010000, 6, '#', '', 'F', '0', '1', 'quartz:job:detail', '#', 'admin', sysdate(), '', null, ''),
       (5010700, '任务导出', 5010000, 7, '#', '', 'F', '0', '1', 'quartz:job:export', '#', 'admin', sysdate(), '', null, ''),
       (5020000, '自动化任务', 5000000, 2, '/automation/autoflow', '', 'C', '0', '1', 'automation:autoflow:view', '#', 'admin', sysdate(), '', null, '自动化任务菜单'),
       (5020100, '自动化任务查询', 5020000, 1, '#', '', 'F', '0', '1', 'automation:autoflow:list', '#', 'admin', sysdate(), '', null, ''),
       (5020200, '自动化任务新增', 5020000, 2, '#', '', 'F', '0', '1', 'automation:autoflow:add', '#', 'admin', sysdate(), '', null, ''),
       (5020300, '自动化任务修改', 5020000, 3, '#', '', 'F', '0', '1', 'automation:autoflow:edit', '#', 'admin', sysdate(), '', null, ''),
       (5020400, '自动化任务删除', 5020000, 4, '#', '', 'F', '0', '1', 'automation:autoflow:remove', '#', 'admin', sysdate(), '', null, ''),
       (5020500, '自动化任务导出', 5020000, 5, '#', '', 'F', '0', '1', 'automation:autoflow:export', '#', 'admin', sysdate(), '', null, ''),
       (5030000, '自定义函数', 5000000, 3, '/automation/autofunction', '', 'C', '0', '1', 'automation:autofunction:view', '#', 'admin', sysdate(), '', null, '自定义函数菜单'),
       (5030100, '自定义函数查询', 5030000, 1, '#', '', 'F', '0', '1', 'automation:autofunction:list', '#', 'admin', sysdate(), '', null, ''),
       (5030200, '自定义函数新增', 5030000, 2, '#', '', 'F', '0', '1', 'automation:autofunction:add', '#', 'admin', sysdate(), '', null, ''),
       (5030300, '自定义函数修改', 5030000, 3, '#', '', 'F', '0', '1', 'automation:autofunction:edit', '#', 'admin', sysdate(), '', null, ''),
       (5030400, '自定义函数删除', 5030000, 4, '#', '', 'F', '0', '1', 'automation:autofunction:remove', '#', 'admin', sysdate(), '', null, ''),
       (5030500, '自定义函数导出', 5030000, 5, '#', '', 'F', '0', '1', 'automation:autofunction:export', '#', 'admin', sysdate(), '', null, ''),
       (5040000, '自动化数据源', 5000000, 4, '/automation/autodatasource', '', 'C', '0', '1', 'automation:autodatasource:view', '#', 'admin', sysdate(), '', null, '自动化数据源菜单'),
       (5040100, '自动化数据源查询', 5040000, 1, '#', '', 'F', '0', '1', 'automation:autodatasource:list', '#', 'admin', sysdate(), '', null, ''),
       (5040200, '自动化数据源新增', 5040000, 2, '#', '', 'F', '0', '1', 'automation:autodatasource:add', '#', 'admin', sysdate(), '', null, ''),
       (5040300, '自动化数据源修改', 5040000, 3, '#', '', 'F', '0', '1', 'automation:autodatasource:edit', '#', 'admin', sysdate(), '', null, ''),
       (5040400, '自动化数据源删除', 5040000, 4, '#', '', 'F', '0', '1', 'automation:autodatasource:remove', '#', 'admin', sysdate(), '', null, ''),
       (5040500, '自动化数据源导出', 5040000, 5, '#', '', 'F', '0', '1', 'automation:autodatasource:export', '#', 'admin', sysdate(), '', null, ''),
       (5050000, 'WebSocket', 5000000, 5, '/automation/notice', '', 'C', '0', '1', 'automation:websocket:view', '#', 'admin', sysdate(), '', null, 'WebSocket');