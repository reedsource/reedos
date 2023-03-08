drop table if exists reedos.cms_comment;
create table reedos.cms_comment
(
    id          int auto_increment comment '主键'
        primary key,
    pid         int                           null comment '父ID',
    tid         varchar(50)                   null comment '目标ID',
    num_pei     smallint    default 0         null comment '呸数',
    num_penzi   smallint    default 0         null comment '喷子数',
    num_dou     smallint    default 0         null comment '逗个数',
    num_geili   smallint    default 0         null comment '给力数',
    type        varchar(50) default 'article' null comment '评论类型',
    user_id     varchar(50)                   null comment '用户id',
    user_name   varchar(50)                   null comment '用户名称',
    avatar      varchar(255)                  null comment '用户头像',
    content     varchar(255)                  null comment '评论内容',
    up_vote     int         default 0         null comment '点赞数',
    down_vote   int         default 0         null comment '反对数',
    qq          varchar(20)                   null comment 'QQ',
    email       varchar(30)                   null comment '邮箱',
    ip          varchar(20)                   null comment 'IP',
    address     varchar(255)                  null comment '地址',
    create_time datetime                      null comment '创建时间',
    status      smallint    default 0         null comment '状态0正常'
)
    comment '评论留言表';

