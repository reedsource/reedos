drop table if exists reedos.cms_article_content;
create table reedos.cms_article_content
(
    id                      varchar(50) charset latin1 not null
        primary key,
    content                 longtext                   null,
    content_markdown_source longtext                   null
)
    comment '文章信息表';

