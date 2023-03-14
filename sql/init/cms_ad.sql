drop table if exists reedos.cms_ad;
create table reedos.cms_ad
(
    ad_id       int auto_increment comment '广告位ID'
        primary key,
    ad_code     varchar(50)  null comment '广告位编码',
    ad_name     varchar(150) null comment '广告位名称',
    width       smallint     null comment '宽度',
    height      smallint     null comment '高度',
    status      smallint     null comment '状态',
    user_id     varchar(50)  null comment '创建人ID',
    dept_id     varchar(50)  null comment '部门ID',
    description varchar(255) null comment '描述',
    create_by   varchar(50)  null comment '创建人',
    create_time datetime     null comment '创建时间'
);

INSERT INTO reedos.cms_ad (ad_id, ad_code, ad_name, width, height, status, user_id, dept_id, description, create_by, create_time)
VALUES (1, 'main', '首页顶部', 1280, 38, 0, '1', '103', '测试', null, sysdate());
