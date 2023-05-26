drop table if exists reedos.cms_friend_link;
create table reedos.cms_friend_link
(
    id          int auto_increment comment '友情链接ID'
        primary key,
    name        varchar(50)        null comment '友链名称',
    link        varchar(255)       null comment '链接',
    description varchar(255)       null comment '站点描述',
    logo        varchar(255)       null comment 'logo素材',
    audit_state smallint default 0 null comment '状态 0待审核 1通过 2未通过',
    status      smallint default 0 null comment '状态 0正常 1停用'
)
    comment '友情链接对象';

INSERT INTO reedos.cms_friend_link (id, name, link, description, logo, audit_state, status)
VALUES (1, '百度', 'https://www.baidu.com', null, null, 0, 0),
       (2, 'UXDtime', 'http://www.uxdtime.com', '中国UXD设计互动平台，深耕交互设计领域，创造极致用户体验。', '/img/logo/logo_yhsg.png', 1, 0),
       (3, '杨青博客', 'https://www.yangqq.com', '80后草根女站长，独立网页设计师。', '/img/logo/logo_girl.jpg', 1, 0);
