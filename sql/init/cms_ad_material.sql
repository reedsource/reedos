drop table if exists reedos.cms_ad_material;
create table reedos.cms_ad_material
(
    id          bigint(11) auto_increment
        primary key,
    ad_id       varchar(50)          null comment '广告位ID',
    material_id varchar(50)          null comment '广告素材ID',
    link        varchar(255)         null comment '链接',
    sort        smallint default 255 null comment '排序',
    hit         int      default 0   null comment '点击数',
    start_time  datetime             null comment '开始时间',
    end_time    datetime             null comment '结束时间',
    status      smallint             null comment '状态',
    use_his_id  int                  null comment '使用记录表ID'
);

