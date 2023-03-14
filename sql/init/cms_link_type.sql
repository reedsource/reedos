drop table if exists reedos.cms_link_type;
create table reedos.cms_link_type
(
    id             int auto_increment comment 'ID'
        primary key,
    link_type      varchar(100)       null comment '链接分类',
    link_type_name varchar(100)       null comment '链接分类名称',
    description    varchar(255)       null comment '描述',
    cover_image    varchar(255)       null comment '封面图片',
    sort           smallint default 0 null comment '排序',
    status         smallint default 0 null comment '状态 0正常 1停用'
);

INSERT INTO reedos.cms_link_type (id, link_type, link_type_name, description, cover_image, sort, status)
VALUES (1, 'news', '垂直资讯', '聚焦互联网一手资讯信息，不错过互联网时代的每个消息。', '/images/cover/news.jpg', 1, 0),
       (2, 'inspiration', '灵感创意', '捕捉那一霎那间的闪念，借鉴设计的精髓理念。', '/images/cover/inspiration.jpg', 2, 0),
       (3, 'material', '素材资源 ', '聚合互联网上优秀的设计资源，提供一个快速获取设计素材资源的平台。', '/images/cover/material.jpg', 3, 0),
       (4, 'tools', '效率开发', '为互联网从业者，尤其是程序猿、攻城狮们提供一个可快速开发、阅读或格式化的辅助在线小工具。', '/images/cover/tools.jpg', 4, 0),
       (5, 'nice', '小众精选 ', '信息过载时代的一片净土，这里是属于小众爱好者的自留地。', '/images/cover/nice.jpg', 5, 0),
       (6, 'discovery', '发现', '在众多的网站里，总有一些优秀且独特的网站被埋没在互联网世界里，而在这里，我们要把它们挖掘出来。', '/images/cover/discovery.jpg', 6, 0);
