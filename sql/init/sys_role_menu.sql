drop table if exists reedos.sys_role_menu;
create table reedos.sys_role_menu
(
    role_id bigint not null comment '角色ID',
    menu_id bigint not null comment '菜单ID',
    primary key (role_id, menu_id)
)
    comment '角色和菜单关联表';

insert into reedos.sys_role_menu (role_id, menu_id)
values (2, 1000000),
       (2, 1010000),
       (2, 1010100),
       (2, 1010200),
       (2, 1010300),
       (2, 1010400),
       (2, 1010500),
       (2, 1010600),
       (2, 1010700),
       (2, 1020000),
       (2, 1020100),
       (2, 1020200),
       (2, 1020300),
       (2, 1020400),
       (2, 1020500),
       (2, 1030000),
       (2, 1030100),
       (2, 1030200),
       (2, 1030300),
       (2, 1030400),
       (2, 1040000),
       (2, 1040100),
       (2, 1040200),
       (2, 1040300),
       (2, 1040400),
       (2, 1050000),
       (2, 1050100),
       (2, 1050200),
       (2, 1050300),
       (2, 1050400),
       (2, 1050500),
       (2, 1060000),
       (2, 1060100),
       (2, 1060200),
       (2, 1060300),
       (2, 1060400),
       (2, 1060500),
       (2, 1070000),
       (2, 1070100),
       (2, 1070200),
       (2, 1070300),
       (2, 1070400),
       (2, 1070500),
       (2, 1080000),
       (2, 1080100),
       (2, 1080200),
       (2, 1080300),
       (2, 1080400),
       (2, 1090000),
       (2, 1090100),
       (2, 1090101),
       (2, 1090102),
       (2, 1090103),
       (2, 1090104),
       (2, 1090200),
       (2, 1090201),
       (2, 1090202),
       (2, 1090203),
       (2, 1090204),
       (2, 2000000),
       (2, 2010000),
       (2, 2010100),
       (2, 2010200),
       (2, 2010300),
       (2, 2020000),
       (2, 2030000),
       (2, 2040000),
       (2, 3000000),
       (2, 3010000),
       (2, 3020000),
       (2, 3020100),
       (2, 3020200),
       (2, 3020300),
       (2, 3020400),
       (2, 3020500),
       (2, 3030000),
       (2, 4000000),
       (2, 4010000),
       (2, 4010100),
       (2, 4010200),
       (2, 4010300),
       (2, 4020000),
       (2, 4020100),
       (2, 4020200),
       (2, 4020300),
       (2, 4020400),
       (2, 4030000),
       (2, 4030100),
       (2, 4030200),
       (2, 4030300),
       (2, 4030400),
       (2, 4040000),
       (2, 4050000),
       (2, 4050100),
       (2, 4050200),
       (2, 4060000),
       (2, 4060100),
       (2, 4060200),
       (2, 4060300),
       (2, 4060400),
       (2, 4060500),
       (2, 4070000),
       (2, 4070100),
       (2, 4070200),
       (2, 4070300),
       (2, 4080000),
       (2, 4080100),
       (2, 4080200),
       (2, 4080300),
       (2, 4080400),
       (2, 4090000),
       (2, 4090100),
       (2, 4090200),
       (2, 4090300),
       (2, 4090400),
       (2, 4100000),
       (2, 4100100),
       (2, 4100101),
       (2, 4100102),
       (2, 4100103),
       (2, 4100104),
       (2, 4100105),
       (2, 4100200),
       (2, 4100201),
       (2, 4100202),
       (2, 4100203),
       (2, 4100204),
       (2, 4100300),
       (2, 4100301),
       (2, 4100302),
       (2, 4100303),
       (2, 4100304),
       (2, 4100305),
       (2, 4100400),
       (2, 4100401),
       (2, 4100500),
       (2, 4100501),
       (2, 4100600),
       (2, 4100601),
       (2, 4100700),
       (2, 4100800),
       (2, 4100801),
       (2, 4100900),
       (2, 4100901),
       (2, 4101000),
       (2, 4101001),
       (2, 4101100),
       (2, 4101101),
       (2, 4101200),
       (2, 4101201),
       (2, 5000000),
       (2, 5010000),
       (2, 5010100),
       (2, 5010200),
       (2, 5010300),
       (2, 5010400),
       (2, 5010500),
       (2, 5010600),
       (2, 5010700),
       (2, 5020000),
       (2, 5020100),
       (2, 5020200),
       (2, 5020300),
       (2, 5020400),
       (2, 5020500),
       (2, 5030000),
       (2, 5030100),
       (2, 5030200),
       (2, 5030300),
       (2, 5030400),
       (2, 5030500),
       (2, 5040000),
       (2, 5040100),
       (2, 5040200),
       (2, 5040300),
       (2, 5040400),
       (2, 5040500),
       (2, 5050000);
insert into reedos.sys_role_menu (role_id, menu_id)
values (3, 2000000),
       (3, 2010000),
       (3, 2010100),
       (3, 2010200),
       (3, 2010300),
       (3, 2020000),
       (3, 2030000),
       (3, 2040000);
insert into reedos.sys_role_menu (role_id, menu_id)
values (4, 2000000),
       (4, 2010000),
       (4, 2010100),
       (4, 2010200),
       (4, 2010300),
       (4, 2020000),
       (4, 2030000),
       (4, 2040000);