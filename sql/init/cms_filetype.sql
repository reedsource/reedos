drop table if exists reedos.cms_filetype;
create table reedos.cms_filetype
(
    id     int auto_increment
        primary key,
    suffix varchar(50) charset utf8  null comment '后缀',
    name   varchar(50) charset utf8  null comment '中文名称',
    icon   varchar(255) charset utf8 null comment '图标',
    constraint unique_suffix
        unique (suffix)
)
    charset = latin1;

INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (1, '.3gp', '视频', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (2, '.doc', 'word文档', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (3, '.docx', 'word文档', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (4, '.xls', 'Excel表格', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (5, '.xlsx', 'Excel表格', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (6, '.exe', 'Exe可执行文件', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (7, '.gif', 'Gif图片', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (8, '.html', 'HTML', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (9, '.jar', 'Jar包', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (10, '.jpeg', '图片', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (11, '.jpg', '图片', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (12, '.js', 'JS文件', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (13, '.mp4', '视频', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (14, '.pdf', 'PDF', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (15, '.png', '图片', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (16, '.ppt', 'PPT', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (17, '.wav', '视频', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (18, '.wma', '视频', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (19, '.wmv', '视频', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (20, '.wps', 'WPS', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (21, '.xml', 'XML', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (22, '.zip', 'ZIP压缩包', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (23, '.rar', 'RAR压缩包', null);
INSERT INTO reedos.cms_filetype (id, suffix, name, icon) VALUES (24, '.java', 'Java文件', null);
