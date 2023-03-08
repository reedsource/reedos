drop table if exists reedos.cms_article;
create table reedos.cms_article
(
    id                varchar(50) not null comment '主键，文章ID'
        primary key,
    yhid              varchar(50) null comment '作者',
    article_region    varchar(50) default '1' null comment '推荐到哪个专区。比如：头条、精选、最新、热门、评论最多等',
    author            varchar(50) null comment '原文作者',
    publish_time      varchar(50) null comment '发布时间',
    title             varchar(255) null comment '文章标题',
    keywords          varchar(255) null comment '关键词',
    description       varchar(255) null comment '摘要',
    cover_image       varchar(255) null comment '封面图片',
    article_model     varchar(50) null comment '文章模型',
    copy_flag         smallint    default 0 null comment '转载标志',
    category_id       varchar(50) null comment '频道栏目ID',
    personal_category varchar(255) null comment '个人分类，多个用逗号分隔',
    link              varchar(255) null comment '原始链接',
    static_url        varchar(255) null comment '静态化后url',
    tags              varchar(100) null comment '标签',
    hit               int         default 0 null comment '点击数',
    reply_num         int         default 0 null comment '回复数',
    up_vote           int         default 0 null comment '点赞数',
    down_vote         int         default 0 null comment '差评数',
    hot_flag          smallint    default 0 null comment '热点标志',
    new_flag          smallint    default 0 null comment '新增标志',
    comment_flag      smallint    default 0 null comment '是否开启评论',
    top_flag          smallint    default 0 null comment '置顶标志',
    favourite         int         default 0 null comment '收藏数',
    mission_id        varchar(50) null comment '趴取任务的ID',
    template_name     varchar(50) null comment '生成静态页面的模板(cms_template表中的name)',
    create_time       datetime null comment '创建时间',
    update_time       datetime null comment '更新时间',
    available         smallint    default 1 null comment '状态标志',
    deleted           smallint    default 0 null comment '删除标志',
    extra1            varchar(255) null comment '附加字段1',
    extra2            varchar(255) null comment '附加字段2',
    extra3            varchar(255) null comment '附加字段3'
) comment '文章管理对象';

create index index_title
    on cms_article (title);

