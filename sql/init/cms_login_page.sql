drop table if exists reedos.cms_login_page;
create table reedos.cms_login_page
(
    id          int auto_increment
        primary key,
    name        varchar(100) null comment '登录主题名称',
    code        varchar(50)  null comment '页面代码',
    cover_img   varchar(255) null comment '封面图片',
    create_time datetime     null comment '创建时间',
    create_by   varchar(50)  null
);

INSERT INTO reedos.cms_login_page (id, name, code, cover_img, create_time, create_by)
VALUES (1, '默认', 'default', '/img/loginPage/default.jpg', sysdate(), 'ry'),
       (2, 'process', 'process', '/img/loginPage/process.jpg', sysdate(), 'ry');
