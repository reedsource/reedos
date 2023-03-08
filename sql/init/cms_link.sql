drop table if exists reedos.cms_link;
create table reedos.cms_link
(
    link_id      int auto_increment comment '链接ID'
        primary key,
    link_type    varchar(50)        null comment '链接分类',
    link_name    varchar(255)       null comment '链接名称',
    keywords     varchar(100)       null comment '关键词',
    link         varchar(255)       null comment '链接',
    description  varchar(255)       null comment '描述',
    logo         varchar(255)       null comment 'Logo',
    audit_state  smallint default 0 null comment '审核状态',
    detail       longtext           null comment '详情',
    sort         int      default 0 null comment '排序',
    up_vote      int      default 0 null comment '点赞数',
    comment_flag smallint default 1 null comment '允许评论',
    status       smallint default 0 null comment '状态 0正常 1停用'
);

INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (1, 'news', '极客公园', '内容资讯,科技,生活', 'http://www.geekpark.net/', '123', '/images/logo/geekpark.png', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (2, 'news', '果壳', '内容资讯,科技,灵感,美图', 'https://www.guokr.com/', '123', '/images/logo/logo_guoke.png', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (3, 'news', '好奇心日报', '内容资讯,科技,游戏,美图', 'https://www.qdaily.com/', '123', '/images/logo/logo_haoqixin.png', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (4, 'inspiration', '稿定设计', '内容资讯,灵感,设计,素材,软件', 'https://www.gaoding.com/', '123', '/images/logo/logo_gdsj.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (5, 'inspiration', '
花瓣网', '灵感,设计,摄影,美图,漫画', 'https://huaban.com/', '123', '/images/logo/logo_hb.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (6, 'inspiration', '站酷', '灵感,社交,设计,酷站', 'https://www.zcool.com.cn/', '123', '/images/logo/logo_zhanku.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (7, 'material', 'pexels', '素材,摄影,美图', 'https://www.pexels.com/', '123', '/images/logo/logo_pexels.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (8, 'material', 'pixabay', '素材,酷站,摄影,美图', 'https://pixabay.com/zh/', '123', '/images/logo/logo_pixabay.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (9, 'material', 'unsplash', '素材,摄影,美图', 'https://unsplash.com/', '123', '/images/logo/logo_unsplash.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (10, 'tools', '
墨刀', '软件,实用工具,其它', 'https://org.modao.cc/', '123', '/images/logo/logo_modao.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (11, 'tools', '智图', '设计,软件,实用工具', 'https://zhitu.isux.us/', '123', '/images/logo/logo_zhitu.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (12, 'tools', '倍洽', '科技,实用工具,代码开发', 'https://bearychat.com/', '123', '/images/logo/logo_beiqia.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (13, 'nice', '熊掌记', '设计,生活,实用工具,其它', 'https://bear.app/cn/', '123', '/images/logo/logo_xiongzhangji.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (14, 'nice', '真实故事计划', '内容资讯,社交,生活', 'http://www.zhenshigushi.net/', '123', '/images/logo/logo_zsgsjh.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (15, 'nice', '​唯艺互动', '设计,酷站,其它', 'http://www.topve.com/', '123', '/images/logo/logo_wyhd.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (16, 'discovery', '凹凸实验室', '内容资讯,社交,代码开发,其它', 'https://aotu.io/', '123', '/images/logo/logo_atsys.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (17, 'discovery', '知晓程序', '内容资讯,社交,设计,素材', 'https://minapp.com/miniapp/', '123', '/images/logo/logo_zxcx.jpg', 1, null, 0, 0, 1, 0);
INSERT INTO reedos.cms_link (link_id, link_type, link_name, keywords, link, description, logo, audit_state, detail, sort, up_vote, comment_flag, status) VALUES (18, 'discovery', '
Element', '设计,实用工具,代码开发', 'https://element.eleme.cn/', '123', '/images/logo/logo_element.jpg', 1, null, 0, 0, 1, 0);
