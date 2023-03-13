drop table if exists reedos.cms_album_material;
create table reedos.cms_album_material
(
    id          bigint(11) auto_increment
        primary key,
    album_id    varchar(50)  null comment '专辑ID',
    material_id varchar(50)  null comment '素材ID',
    link        varchar(255) null comment '链接',
    sort        smallint     null comment '排序'
)
    comment '素材资料表';

INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (57, '2019111014175065994146', '2019111009322629296151', null, 1);
INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (58, '2019111014175065994146', '2019111009381073394848', null, 2);
INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (63, '2019111014175065994147', '2019111009322629296151', null, 1);
INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (64, '2019111014175065994147', '2019111009381073394848', null, 2);
INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (67, '2019111014175065994147', '2019111009382058929539', null, 1);
INSERT INTO reedos.cms_album_material (id, album_id, material_id, link, sort) VALUES (68, '2019111014175065994146', '2019111009382058929539', null, 1);
