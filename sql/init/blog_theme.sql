drop table if exists reedos.blog_theme;
create table reedos.blog_theme
(
    id          int auto_increment
        primary key,
    name        varchar(100) null comment '主题名称',
    code        varchar(50)  null comment '主题代码',
    cover_img   varchar(255) null comment '封面图片',
    create_time datetime     null comment '创建时间',
    create_by   varchar(50)  null
);

INSERT INTO reedos.blog_theme (id, name, code, cover_img, create_time, create_by)
VALUES (1, 'Avatar响应式博客模版主题', 'avatar', '/img/cover/1561132050443308.jpg', sysdate(), 'ry');
INSERT INTO reedos.blog_theme (id, name, code, cover_img, create_time, create_by)
VALUES (2, '葡萄资讯模板主题，葡萄内容管理系统模板主题', 'pnews', '/img/cover/201903051436106979.jpg', sysdate(), 'ry');
INSERT INTO reedos.blog_theme (id, name, code, cover_img, create_time, create_by)
VALUES (3, '“pblog”个性博客模版主题，PT-CMS模版主题，免费下载', 'pblog', '/img/cover/pblog.jpg', sysdate(), 'ry');
