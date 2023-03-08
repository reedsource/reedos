drop table if exists reedos.cms_material_use;
create table reedos.cms_material_use
(
    id          int auto_increment comment 'ID'
        primary key,
    material_id varchar(50) null comment '素材ID',
    use_table   varchar(50) null comment '表名',
    use_id      varchar(50) null comment '比如cms_album_material表的album_id字段',
    use_column  varchar(50) null comment '比如cms_album_material表的album_id字段的列名“album_id”',
    user_id     varchar(50) null comment '创建人ID',
    create_by   varchar(50) null comment '创建人名称',
    create_time datetime    null comment '创建时间'
);

INSERT INTO reedos.cms_material_use (id, material_id, use_table, use_id, use_column, user_id, create_by, create_time) VALUES (50, '2019111009322629296151', 'cms_album_material', '2019111014175065994146', 'album_id', null, 'markbro', '2019-11-17 16:56:17');
INSERT INTO reedos.cms_material_use (id, material_id, use_table, use_id, use_column, user_id, create_by, create_time) VALUES (51, '2019111009381073394848', 'cms_album_material', '2019111014175065994146', 'album_id', null, 'markbro', '2019-11-17 16:56:17');
INSERT INTO reedos.cms_material_use (id, material_id, use_table, use_id, use_column, user_id, create_by, create_time) VALUES (57, '2019111009382058929539', 'cms_album_material', '2019111014175065994147', 'album_id', null, 'markbro', '2019-11-19 10:42:53');
INSERT INTO reedos.cms_material_use (id, material_id, use_table, use_id, use_column, user_id, create_by, create_time) VALUES (58, '2019111009382058929539', 'cms_album_material', '2019111014175065994146', 'album_id', null, 'markbro', '2019-11-20 15:45:35');
