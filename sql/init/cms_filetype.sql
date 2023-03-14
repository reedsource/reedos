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

INSERT INTO reedos.cms_filetype (id, suffix, name, icon)
VALUES (1, '.3gp', '视频', null),
       (2, '.doc', 'word文档', null),
       (3, '.docx', 'word文档', null),
       (4, '.xls', 'Excel表格', null),
       (5, '.xlsx', 'Excel表格', null),
       (6, '.exe', 'Exe可执行文件', null),
       (7, '.gif', 'Gif图片', null),
       (8, '.html', 'HTML', null),
       (9, '.jar', 'Jar包', null),
       (10, '.jpeg', '图片', null),
       (11, '.jpg', '图片', null),
       (12, '.js', 'JS文件', null),
       (13, '.mp4', '视频', null),
       (14, '.pdf', 'PDF', null),
       (15, '.png', '图片', null),
       (16, '.ppt', 'PPT', null),
       (17, '.wav', '视频', null),
       (18, '.wma', '视频', null),
       (19, '.wmv', '视频', null),
       (20, '.wps', 'WPS', null),
       (21, '.xml', 'XML', null),
       (22, '.zip', 'ZIP压缩包', null),
       (23, '.rar', 'RAR压缩包', null),
       (24, '.java', 'Java文件', null);
