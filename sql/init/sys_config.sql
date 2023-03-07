drop table if exists reedos.sys_config;
create table reedos.sys_config
(
    config_id    int(5) auto_increment comment '参数主键'
        primary key,
    config_name  varchar(100) default ''  null comment '参数名称',
    config_key   varchar(100) default ''  null comment '参数键名',
    config_value varchar(500) default ''  null comment '参数键值',
    config_type  char         default 'N' null comment '系统内置（Y是 N否）',
    create_by    varchar(64)  default ''  null comment '创建者',
    create_time  datetime                 null comment '创建时间',
    update_by    varchar(64)  default ''  null comment '更新者',
    update_time  datetime                 null comment '更新时间',
    remark       varchar(500)             null comment '备注'
)
    comment '参数配置表';

insert into reedos.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark)
values  (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-green', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
        (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '初始化密码 123456'),
        (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '深黑主题theme-dark，浅色主题theme-light，深蓝主题theme-blue'),
        (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '是否开启注册用户功能（true开启，false关闭）'),
        (5, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）'),
        (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '0', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),
        (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框'),
        (8, '主框架页-菜单导航显示风格', 'sys.index.menuStyle', 'default', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）'),
        (9, '主框架页-是否开启页脚', 'sys.index.footer', 'true', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '是否开启底部页脚显示（true显示，false隐藏）'),
        (10, '主框架页-是否开启页签', 'sys.index.tagsView', 'true', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '是否开启菜单多页签显示（true显示，false隐藏）'),
        (11, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2023-03-07 17:10:32', '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');