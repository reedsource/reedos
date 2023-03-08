drop table if exists reedos.cms_material;
create table reedos.cms_material
(
    material_id   varchar(64)             not null
        primary key,
    group_id      varchar(64) default '0' not null comment '分组id',
    material_name varchar(100)            not null comment '素材名称',
    material_type varchar(10)             not null comment '素材类型 字典 1图片2视频3文本',
    description   varchar(255)            null comment '素材描述',
    material_size varchar(20)             null comment '素材大小',
    save_path     varchar(255)            null comment '保存路径',
    thumbnail     longtext                null comment '缩略图',
    audit_state   varchar(20) default '0' null comment '审核状态 0待审批2未通过1通过',
    audit_reason  varchar(255)            null comment '审核意见',
    use_state     varchar(20) default '1' null comment '可用状态 0停用1启用',
    width         varchar(255)            null comment '分辨率 宽',
    height        varchar(255)            null comment '分辨率 高',
    uploader_id   varchar(64)             null comment '上传者 id',
    upload_time   datetime                null comment '上传日期',
    remark        varchar(255)            null comment '备注'
);

INSERT INTO reedos.cms_material (material_id, group_id, material_name, material_type, description, material_size, save_path, thumbnail, audit_state, audit_reason, use_state, width, height, uploader_id, upload_time, remark) VALUES ('2019111009322629296151', '1', '180828012300500.jpg', '1', null, '211753', '/profile/material/2022/09/10/9b155fd8d237dc02380965143e67fd28.jpg', null, '1', '同意', '1', '960', '320', '1', '2019-11-10 09:32:26', null);
INSERT INTO reedos.cms_material (material_id, group_id, material_name, material_type, description, material_size, save_path, thumbnail, audit_state, audit_reason, use_state, width, height, uploader_id, upload_time, remark) VALUES ('2019111009381073394848', '1', '180828105347992.jpg', '1', null, '99552', '/profile/material/2022/09/10/1af5f3fc7abbfa2ac7d7ebe5ece0aa87.jpg', null, '1', '同意', '1', '960', '320', '1', '2019-11-10 09:38:11', null);
INSERT INTO reedos.cms_material (material_id, group_id, material_name, material_type, description, material_size, save_path, thumbnail, audit_state, audit_reason, use_state, width, height, uploader_id, upload_time, remark) VALUES ('2019111009382058929539', '1', '180829122443368.jpg', '1', null, '185844', '/profile/material/2022/09/10/159943c9310fae5b8c4e1da79e5ad3da.jpg', null, '1', '同意', '1', '960', '320', '1', '2019-11-10 09:38:21', null);
INSERT INTO reedos.cms_material (material_id, group_id, material_name, material_type, description, material_size, save_path, thumbnail, audit_state, audit_reason, use_state, width, height, uploader_id, upload_time, remark) VALUES ('2019111009383084394915', '1', '180909053041227.jpg', '1', null, '72684', '/profile/material/2022/09/10/e6bd3afbc4975df0ac6f20a25718fcb1.jpg', null, '1', '同意', '0', '960', '320', '1', '2019-11-10 09:38:31', null);
