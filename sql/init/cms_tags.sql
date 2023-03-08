drop table if exists reedos.cms_tags;
create table reedos.cms_tags
(
    tag_id   int auto_increment comment 'ID'
        primary key,
    tag_type varchar(50)        null comment '标签类型，如s系统标签，p个人标签',
    user_id  varchar(50)        null comment '谁增加的该标签',
    tag_name varchar(50)        null comment '分类名称',
    sort     int                null comment '排序',
    status   smallint default 0 null comment '状态 0正常 1停用',
    url      varchar(255)       null
);

INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (1, 'p', '1', 'Java', 11, 1, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (2, 'p', '1', '精美散文', 12, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (26, 'p', '1', '美女图片', 13, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (27, 'p', '1', '读史', 14, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (28, 'p', '1', '开发', 15, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (29, 's', '1', '漫威', 16, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (30, 'blogTab', '1', '漫谈', 1, 0, '/front/static/search/tag/id/30/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (31, 'blogTab', '1', '故事', 2, 0, '/front/static/search/tag/id/31/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (32, 'blogTab', '1', '情怀', 3, 0, '/front/static/search/tag/id/32/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (33, 'blogTab', '1', '插画', 4, 0, '/front/static/search/tag/id/33/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (34, 'blogTab', '1', '科技', 5, 0, '/front/static/search/tag/id/34/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (35, 'blogTab', '1', '创意', 6, 0, '/front/static/search/tag/id/35/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (36, 'blogTab', '1', '娱乐', 7, 0, '/front/static/search/tag/id/36/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (37, 'blogTab', '1', '设计', 8, 0, '/front/static/search/tag/id/37/1.html');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (38, 's', '1', '恐怖漫画', 9, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (39, 's', '1', '生活百态', 10, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (40, 's', '1', '故事', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (41, 's', '1', '插画', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (42, 's', '1', '漫谈', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (43, 's', '1', '情怀', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (44, 's', '1', '创意', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (45, 's', '1', '娱乐', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (46, 's', '1', '设计', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (47, 's', '1', '科技', 1, 0, null);
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (48, 'articleTemplate', '1', '标题', 1, 0, '');
INSERT INTO reedos.cms_tags (tag_id, tag_type, user_id, tag_name, sort, status, url) VALUES (49, 'articleTemplate', '1', '内容', 1, 0, '');
