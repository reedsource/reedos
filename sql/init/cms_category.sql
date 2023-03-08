drop table if exists reedos.cms_category;
create table reedos.cms_category
(
    category_id   bigint(50) auto_increment comment '分类ID'
        primary key,
    category_name varchar(50)       null comment '分类名称',
    parent_id     bigint(50)        null comment '父ID',
    ancestors     varchar(50)       null comment 'ids',
    sort          smallint          null comment '排序',
    description   varchar(200)      null comment '分类描述',
    create_time   datetime          null comment '创建时间',
    update_time   datetime          null comment '更新时间',
    create_by     varchar(50)       null comment '创建人',
    update_by     varchar(50)       null comment '更新人',
    status        tinyint default 0 null comment '状态（0正常 1停用）',
    del_flag      tinyint           null comment '删除标志'
)
    comment '导航栏目表';

INSERT INTO reedos.cms_category (category_id, category_name, parent_id, ancestors, sort, description, create_time, update_time, create_by, update_by, status, del_flag) VALUES (1, '其它', null, '1,', 3, '1', '2022-09-28 16:14:32', '2022-09-28 20:01:44', '1', '1', 0, null);
INSERT INTO reedos.cms_category (category_id, category_name, parent_id, ancestors, sort, description, create_time, update_time, create_by, update_by, status, del_flag) VALUES (2, '资讯', 1, '1,2,', 1, '1', '2022-09-28 16:15:11', '2022-09-28 20:01:44', '1', '1', 0, null);
INSERT INTO reedos.cms_category (category_id, category_name, parent_id, ancestors, sort, description, create_time, update_time, create_by, update_by, status, del_flag) VALUES (3, '后端技术', null, '3,', 2, '1', '2022-09-28 16:15:24', '2022-09-28 20:01:44', '1', '1', 0, null);
INSERT INTO reedos.cms_category (category_id, category_name, parent_id, ancestors, sort, description, create_time, update_time, create_by, update_by, status, del_flag) VALUES (4, '前端技术', null, null, 1, null, '2022-09-28 16:15:24', '2022-09-28 16:15:24', '1', '1', 0, null);
