drop table if exists reedos.cms_pv;
create table reedos.cms_pv
(
    id          int auto_increment comment '主键'
        primary key,
    uid         varchar(50)  null comment '用户ID',
    module      varchar(50)  null comment '模块',
    browser     varchar(50)  null comment '浏览器',
    referer     varchar(255) null comment 'referer',
    os          varchar(50)  null comment '操作系统',
    page_id     varchar(255) null comment '页面内容ID',
    url         varchar(255) null,
    device_type varchar(50)  null,
    time_zone   varchar(10)  null comment '时区',
    ip          varchar(20)  null comment 'ip地址',
    location    varchar(255) null comment '地址',
    create_time datetime     null
)
    comment '内容管理-页面被浏览记录表';

INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (3, null, null, 'Chrome', 'http://localhost/blog/article/2019111809345847875233', 'Win32', null, 'http://localhost/blog/article/2019111809345847875233', 'Computer', '-8', '127.0.0.1', null, '2019-11-29 10:52:08');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (4, null, null, 'Chrome 10', 'http://localhost/blog', 'Win32', null, 'http://localhost/blog', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 14:47:19');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (5, null, null, 'Chrome 10', 'http://localhost/blog', 'Win32', null, 'http://localhost/blog', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 15:33:36');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (6, null, null, 'Chrome 10', 'http://localhost/blog/category', 'Win32', null, 'http://localhost/blog/category', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 16:41:56');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (7, null, null, 'Chrome 10', 'http://localhost/blog/resource/list?pageSize=6', 'Win32', null, 'http://localhost/blog/resource/list?pageSize=6', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 16:41:56');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (8, null, null, 'Chrome 10', 'http://localhost/blog/nav', 'Win32', null, 'http://localhost/blog/nav', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 16:41:56');
INSERT INTO reedos.cms_pv (id, uid, module, browser, referer, os, page_id, url, device_type, time_zone, ip, location, create_time) VALUES (9, null, null, 'Chrome 10', 'http://localhost/blog', 'Win32', null, 'http://localhost/blog', 'Computer', '-8', '127.0.0.1', null, '2022-09-15 16:41:56');
