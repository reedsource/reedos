/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : db_hcc_flow

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-06-30 20:18:12
*/

drop database if exists `db_hcc_flow`;
create database `db_hcc_flow` character set utf8mb4 collate utf8mb4_general_ci;

use `db_hcc_flow`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ad_content
-- ----------------------------
DROP TABLE IF EXISTS `ad_content`;
CREATE TABLE `ad_content` (
  `ad_id` varchar(32) NOT NULL COMMENT '素材ID(业务)',
  `index_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '素材ID(页面展示)',
  `ad_type_id` int(11) DEFAULT NULL COMMENT '素材类型ID',
  `ad_name` varchar(128) NOT NULL COMMENT '素材名称',
  `ad_size` int(11) DEFAULT NULL COMMENT '素材大小Kb',
  `ad_second` int(11) DEFAULT NULL COMMENT '素材时长',
  `resolution` varchar(32) DEFAULT NULL COMMENT '素材分辨率',
  `file_type` varchar(32) DEFAULT NULL COMMENT '素材文件后缀',
  `status` char(1) NOT NULL COMMENT '素材状态',
  `md5` varchar(64) DEFAULT NULL COMMENT 'MD5',
  `ad_url` varchar(256) DEFAULT NULL COMMENT '素材文件地址',
  `ad_content` varchar(1024) DEFAULT NULL COMMENT '文字素材内容',
  `create_user_id` varchar(32) DEFAULT NULL COMMENT '创建用户ID',
  `create_org_id` varchar(32) DEFAULT NULL COMMENT '创建机构ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `submitter_id` varchar(32) DEFAULT NULL COMMENT '提交审核人',
  `verify_user_id` varchar(32) DEFAULT NULL COMMENT '终审人',
  `verify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '终审时间',
  PRIMARY KEY (`index_id`,`ad_id`),
  UNIQUE KEY `ad_content_pk` (`ad_id`) USING BTREE,
  KEY `idx_md5` (`md5`) USING BTREE,
  KEY `idx_ad_type_id` (`ad_type_id`) USING BTREE,
  KEY `idx_brand_id` (`create_org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1035 DEFAULT CHARSET=utf8mb4 COMMENT='素材表';

-- ----------------------------
-- Records of ad_content
-- ----------------------------
INSERT INTO `ad_content` VALUES ('c2dc1b3ab48911eaabbb28d244a5fdf0', '1031', '1', 'timg', '56415', '0', '1024*1080', 'image/gif', '4', 'c309814487d722a49b05392a9a95a3c9', '/2020/6/22/c309814487d722a49b05392a9a95a3c9.gif', null, '10', '1', '2020-06-22 21:09:48', '10', '1', '2020-06-29 21:16:17');
INSERT INTO `ad_content` VALUES ('1581d8fcb48b11eaabbb28d244a5fdf0', '1032', '2', 'test', '654891', '9', '544*960', 'video/mp4', '4', 'f829e98775e30d06b17b947d80857c29', '/2020/6/22/f829e98775e30d06b17b947d80857c29.mp4', null, '10', '1', '2020-06-22 21:19:16', '10', '10', '2020-06-24 00:58:16');
INSERT INTO `ad_content` VALUES ('64fc1879b48b11eaabbb28d244a5fdf0', '1034', '1', 'timg-1', '14812', '0', '650*487', 'image/jpeg', '2', 'a6e594e79c9342d9a2651d3a3ea98d09', '/2020/6/22/a6e594e79c9342d9a2651d3a3ea98d09.jpg', null, '10', '1', '2020-06-22 21:21:30', '10', null, '2020-06-29 12:47:42');

-- ----------------------------
-- Table structure for ad_type
-- ----------------------------
DROP TABLE IF EXISTS `ad_type`;
CREATE TABLE `ad_type` (
  `ad_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_type_name` varchar(32) NOT NULL,
  `status` char(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ad_type_id`),
  UNIQUE KEY `ad_type_pk` (`ad_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='广告类型表';

-- ----------------------------
-- Records of ad_type
-- ----------------------------
INSERT INTO `ad_type` VALUES ('1', '图片', 'C', '2018-10-17 14:39:06', '1');
INSERT INTO `ad_type` VALUES ('2', '视频', 'C', '2018-10-17 14:40:22', '1');
INSERT INTO `ad_type` VALUES ('3', '静态文字', 'D', '2018-10-17 14:40:50', '1');
INSERT INTO `ad_type` VALUES ('4', '文档', 'C', '2018-10-17 14:41:08', '1');
INSERT INTO `ad_type` VALUES ('5', '网页压缩包', 'C', '2018-10-17 14:41:26', '1');
INSERT INTO `ad_type` VALUES ('6', '其他', 'C', '2018-10-31 10:02:16', '1');

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `area_id` mediumint(12) NOT NULL,
  `parent_id` int(12) NOT NULL,
  `area_name` varchar(180) NOT NULL,
  `area_type` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `show` int(1) DEFAULT '0' COMMENT '前端是否显示(0显示，1不显示)',
  PRIMARY KEY (`area_id`),
  UNIQUE KEY `area_pk` (`area_id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `area_type` (`area_type`) USING BTREE,
  KEY `area_id` (`area_id`,`show`) USING BTREE,
  KEY `area_type_2` (`area_type`,`show`) USING BTREE,
  KEY `parent_id_2` (`parent_id`,`show`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('1', '0', '华东区', '0', '2', '0');
INSERT INTO `area` VALUES ('2', '0', '华南区', '0', '4', '0');
INSERT INTO `area` VALUES ('3', '0', '华中区', '0', '5', '0');
INSERT INTO `area` VALUES ('4', '0', '华北区', '0', '3', '0');
INSERT INTO `area` VALUES ('5', '0', '西北区', '0', '6', '1');
INSERT INTO `area` VALUES ('6', '0', '西南区', '0', '1', '0');
INSERT INTO `area` VALUES ('7', '0', '东北区', '0', '7', '1');
INSERT INTO `area` VALUES ('8', '0', '台港澳区', '0', '8', '1');
INSERT INTO `area` VALUES ('11', '4', '北京', '1', '4', '0');
INSERT INTO `area` VALUES ('12', '4', '天津', '1', '8', '1');
INSERT INTO `area` VALUES ('13', '4', '河北', '1', '14', '1');
INSERT INTO `area` VALUES ('14', '4', '山西', '1', '12', '1');
INSERT INTO `area` VALUES ('15', '4', '内蒙古', '1', '26', '1');
INSERT INTO `area` VALUES ('21', '7', '辽宁', '1', '15', '1');
INSERT INTO `area` VALUES ('22', '7', '吉林', '1', '16', '1');
INSERT INTO `area` VALUES ('23', '7', '黑龙江', '1', '27', '1');
INSERT INTO `area` VALUES ('31', '1', '上海', '1', '5', '1');
INSERT INTO `area` VALUES ('32', '1', '江苏', '1', '2', '1');
INSERT INTO `area` VALUES ('33', '1', '浙江', '1', '19', '1');
INSERT INTO `area` VALUES ('34', '1', '安徽', '1', '18', '1');
INSERT INTO `area` VALUES ('35', '1', '福建', '1', '3', '0');
INSERT INTO `area` VALUES ('36', '3', '江西', '1', '20', '1');
INSERT INTO `area` VALUES ('37', '1', '山东', '1', '13', '1');
INSERT INTO `area` VALUES ('41', '3', '河南', '1', '11', '1');
INSERT INTO `area` VALUES ('42', '3', '湖北', '1', '10', '1');
INSERT INTO `area` VALUES ('43', '3', '湖南', '1', '9', '0');
INSERT INTO `area` VALUES ('44', '2', '广东', '1', '6', '0');
INSERT INTO `area` VALUES ('45', '2', '广西', '1', '21', '1');
INSERT INTO `area` VALUES ('46', '2', '海南', '1', '17', '1');
INSERT INTO `area` VALUES ('50', '6', '重庆', '1', '1', '0');
INSERT INTO `area` VALUES ('51', '6', '四川', '1', '7', '1');
INSERT INTO `area` VALUES ('52', '6', '贵州', '1', '25', '1');
INSERT INTO `area` VALUES ('53', '6', '云南', '1', '22', '1');
INSERT INTO `area` VALUES ('54', '6', '西藏', '1', '29', '1');
INSERT INTO `area` VALUES ('61', '5', '陕西', '1', '24', '1');
INSERT INTO `area` VALUES ('62', '5', '甘肃', '1', '23', '1');
INSERT INTO `area` VALUES ('63', '5', '青海', '1', '28', '1');
INSERT INTO `area` VALUES ('64', '5', '宁夏回族自治区', '1', '30', '1');
INSERT INTO `area` VALUES ('65', '5', '新疆维吾尔自治区', '1', '31', '1');
INSERT INTO `area` VALUES ('71', '8', '台湾', '1', '34', '1');
INSERT INTO `area` VALUES ('81', '8', '香港', '1', '33', '1');
INSERT INTO `area` VALUES ('91', '8', '澳门', '1', '32', '1');
INSERT INTO `area` VALUES ('1101', '11', '北京市辖', '2', '24', '0');
INSERT INTO `area` VALUES ('1102', '11', '北京县辖', '2', '25', '0');
INSERT INTO `area` VALUES ('1201', '12', '天津市辖', '2', '45', '1');
INSERT INTO `area` VALUES ('1202', '12', '天津县辖', '2', '46', '1');
INSERT INTO `area` VALUES ('1301', '13', '石家庄', '2', '47', '1');
INSERT INTO `area` VALUES ('1302', '13', '唐山', '2', '48', '1');
INSERT INTO `area` VALUES ('1303', '13', '秦皇岛', '2', '49', '1');
INSERT INTO `area` VALUES ('1304', '13', '邯郸', '2', '50', '1');
INSERT INTO `area` VALUES ('1305', '13', '邢台', '2', '51', '1');
INSERT INTO `area` VALUES ('1306', '13', '保定', '2', '52', '1');
INSERT INTO `area` VALUES ('1307', '13', '张家口', '2', '53', '1');
INSERT INTO `area` VALUES ('1308', '13', '承德', '2', '54', '1');
INSERT INTO `area` VALUES ('1309', '13', '沧州', '2', '55', '1');
INSERT INTO `area` VALUES ('1310', '13', '廊坊', '2', '56', '1');
INSERT INTO `area` VALUES ('1311', '13', '衡水', '2', '57', '1');
INSERT INTO `area` VALUES ('1401', '14', '太原', '2', '58', '1');
INSERT INTO `area` VALUES ('1402', '14', '大同', '2', '59', '1');
INSERT INTO `area` VALUES ('1403', '14', '阳泉', '2', '60', '1');
INSERT INTO `area` VALUES ('1404', '14', '长治', '2', '61', '1');
INSERT INTO `area` VALUES ('1405', '14', '晋城', '2', '62', '1');
INSERT INTO `area` VALUES ('1406', '14', '朔州', '2', '63', '1');
INSERT INTO `area` VALUES ('1407', '14', '晋中', '2', '64', '1');
INSERT INTO `area` VALUES ('1408', '14', '运城', '2', '65', '1');
INSERT INTO `area` VALUES ('1409', '14', '忻州', '2', '66', '1');
INSERT INTO `area` VALUES ('1410', '14', '临汾', '2', '67', '1');
INSERT INTO `area` VALUES ('1423', '14', '吕梁地区', '2', '68', '1');
INSERT INTO `area` VALUES ('1501', '15', '呼和浩特', '2', '69', '1');
INSERT INTO `area` VALUES ('1502', '15', '包头', '2', '70', '1');
INSERT INTO `area` VALUES ('1503', '15', '乌海', '2', '71', '1');
INSERT INTO `area` VALUES ('1504', '15', '赤峰', '2', '72', '1');
INSERT INTO `area` VALUES ('1505', '15', '通辽', '2', '73', '1');
INSERT INTO `area` VALUES ('1521', '15', '呼伦贝尔盟', '2', '74', '1');
INSERT INTO `area` VALUES ('1522', '15', '兴安盟', '2', '75', '1');
INSERT INTO `area` VALUES ('1525', '15', '锡林郭勒盟', '2', '76', '1');
INSERT INTO `area` VALUES ('1526', '15', '乌兰察布盟', '2', '77', '1');
INSERT INTO `area` VALUES ('1527', '15', '伊克昭盟', '2', '78', '1');
INSERT INTO `area` VALUES ('1528', '15', '巴彦淖尔盟', '2', '79', '1');
INSERT INTO `area` VALUES ('1529', '15', '阿拉善盟', '2', '80', '1');
INSERT INTO `area` VALUES ('2101', '21', '沈阳', '2', '81', '1');
INSERT INTO `area` VALUES ('2102', '21', '大连', '2', '82', '1');
INSERT INTO `area` VALUES ('2103', '21', '鞍山', '2', '83', '1');
INSERT INTO `area` VALUES ('2104', '21', '抚顺', '2', '84', '1');
INSERT INTO `area` VALUES ('2105', '21', '本溪', '2', '85', '1');
INSERT INTO `area` VALUES ('2106', '21', '丹东', '2', '86', '1');
INSERT INTO `area` VALUES ('2107', '21', '锦州', '2', '87', '1');
INSERT INTO `area` VALUES ('2108', '21', '营口', '2', '88', '1');
INSERT INTO `area` VALUES ('2109', '21', '阜新', '2', '89', '1');
INSERT INTO `area` VALUES ('2110', '21', '辽阳', '2', '90', '1');
INSERT INTO `area` VALUES ('2111', '21', '盘锦', '2', '91', '1');
INSERT INTO `area` VALUES ('2112', '21', '铁岭', '2', '92', '1');
INSERT INTO `area` VALUES ('2113', '21', '朝阳', '2', '93', '1');
INSERT INTO `area` VALUES ('2114', '21', '葫芦岛', '2', '94', '1');
INSERT INTO `area` VALUES ('2201', '22', '长春', '2', '95', '1');
INSERT INTO `area` VALUES ('2202', '22', '吉林', '2', '96', '1');
INSERT INTO `area` VALUES ('2203', '22', '四平', '2', '97', '1');
INSERT INTO `area` VALUES ('2204', '22', '辽源', '2', '98', '1');
INSERT INTO `area` VALUES ('2205', '22', '通化', '2', '99', '1');
INSERT INTO `area` VALUES ('2206', '22', '白山', '2', '100', '1');
INSERT INTO `area` VALUES ('2207', '22', '松原', '2', '101', '1');
INSERT INTO `area` VALUES ('2208', '22', '白城', '2', '102', '1');
INSERT INTO `area` VALUES ('2224', '22', '延边朝鲜族自治州', '2', '103', '1');
INSERT INTO `area` VALUES ('2301', '23', '哈尔滨', '2', '104', '1');
INSERT INTO `area` VALUES ('2302', '23', '齐齐哈尔', '2', '105', '1');
INSERT INTO `area` VALUES ('2303', '23', '鸡西', '2', '106', '1');
INSERT INTO `area` VALUES ('2304', '23', '鹤岗', '2', '107', '1');
INSERT INTO `area` VALUES ('2305', '23', '双鸭山', '2', '108', '1');
INSERT INTO `area` VALUES ('2306', '23', '大庆', '2', '109', '1');
INSERT INTO `area` VALUES ('2307', '23', '伊春', '2', '110', '1');
INSERT INTO `area` VALUES ('2308', '23', '佳木斯', '2', '111', '1');
INSERT INTO `area` VALUES ('2309', '23', '七台河', '2', '112', '1');
INSERT INTO `area` VALUES ('2310', '23', '牡丹江', '2', '113', '1');
INSERT INTO `area` VALUES ('2311', '23', '黑河', '2', '114', '1');
INSERT INTO `area` VALUES ('2312', '23', '绥化', '2', '115', '1');
INSERT INTO `area` VALUES ('2327', '23', '大兴安岭地区', '2', '116', '1');
INSERT INTO `area` VALUES ('3101', '31', '上海市辖', '2', '26', '1');
INSERT INTO `area` VALUES ('3102', '31', '上海县辖', '2', '27', '1');
INSERT INTO `area` VALUES ('3201', '32', '南京', '2', '2', '1');
INSERT INTO `area` VALUES ('3202', '32', '无锡', '2', '3', '1');
INSERT INTO `area` VALUES ('3203', '32', '徐州', '2', '4', '1');
INSERT INTO `area` VALUES ('3204', '32', '常州', '2', '5', '1');
INSERT INTO `area` VALUES ('3205', '32', '苏州', '2', '6', '1');
INSERT INTO `area` VALUES ('3206', '32', '南通', '2', '7', '1');
INSERT INTO `area` VALUES ('3207', '32', '连云港', '2', '8', '1');
INSERT INTO `area` VALUES ('3208', '32', '淮安', '2', '9', '1');
INSERT INTO `area` VALUES ('3209', '32', '盐城', '2', '10', '1');
INSERT INTO `area` VALUES ('3210', '32', '扬州', '2', '11', '1');
INSERT INTO `area` VALUES ('3211', '32', '镇江', '2', '12', '1');
INSERT INTO `area` VALUES ('3212', '32', '泰州', '2', '13', '1');
INSERT INTO `area` VALUES ('3213', '32', '宿迁', '2', '14', '1');
INSERT INTO `area` VALUES ('3301', '33', '杭州', '2', '132', '1');
INSERT INTO `area` VALUES ('3302', '33', '宁波', '2', '133', '1');
INSERT INTO `area` VALUES ('3303', '33', '温州', '2', '134', '1');
INSERT INTO `area` VALUES ('3304', '33', '嘉兴', '2', '135', '1');
INSERT INTO `area` VALUES ('3305', '33', '湖州', '2', '136', '1');
INSERT INTO `area` VALUES ('3306', '33', '绍兴', '2', '137', '1');
INSERT INTO `area` VALUES ('3307', '33', '金华', '2', '138', '1');
INSERT INTO `area` VALUES ('3308', '33', '衢州', '2', '139', '1');
INSERT INTO `area` VALUES ('3309', '33', '舟山', '2', '140', '1');
INSERT INTO `area` VALUES ('3310', '33', '台州', '2', '141', '1');
INSERT INTO `area` VALUES ('3311', '33', '丽水', '2', '142', '1');
INSERT INTO `area` VALUES ('3401', '34', '合肥', '2', '143', '1');
INSERT INTO `area` VALUES ('3402', '34', '芜湖', '2', '144', '1');
INSERT INTO `area` VALUES ('3403', '34', '蚌埠', '2', '145', '1');
INSERT INTO `area` VALUES ('3404', '34', '淮南', '2', '146', '1');
INSERT INTO `area` VALUES ('3405', '34', '马鞍山', '2', '147', '1');
INSERT INTO `area` VALUES ('3406', '34', '淮北', '2', '148', '1');
INSERT INTO `area` VALUES ('3407', '34', '铜陵', '2', '149', '1');
INSERT INTO `area` VALUES ('3408', '34', '安庆', '2', '150', '1');
INSERT INTO `area` VALUES ('3410', '34', '黄山', '2', '151', '1');
INSERT INTO `area` VALUES ('3411', '34', '滁州', '2', '152', '1');
INSERT INTO `area` VALUES ('3412', '34', '阜阳', '2', '153', '1');
INSERT INTO `area` VALUES ('3413', '34', '宿州', '2', '154', '1');
INSERT INTO `area` VALUES ('3414', '34', '巢湖', '2', '155', '1');
INSERT INTO `area` VALUES ('3415', '34', '六安', '2', '156', '1');
INSERT INTO `area` VALUES ('3416', '34', '亳州', '2', '157', '1');
INSERT INTO `area` VALUES ('3417', '34', '池州', '2', '158', '1');
INSERT INTO `area` VALUES ('3418', '34', '宣城', '2', '159', '1');
INSERT INTO `area` VALUES ('3501', '35', '福州', '2', '15', '0');
INSERT INTO `area` VALUES ('3502', '35', '厦门', '2', '16', '0');
INSERT INTO `area` VALUES ('3503', '35', '莆田', '2', '17', '0');
INSERT INTO `area` VALUES ('3504', '35', '三明', '2', '18', '0');
INSERT INTO `area` VALUES ('3505', '35', '泉州', '2', '19', '0');
INSERT INTO `area` VALUES ('3506', '35', '漳州', '2', '20', '0');
INSERT INTO `area` VALUES ('3507', '35', '南平', '2', '21', '0');
INSERT INTO `area` VALUES ('3508', '35', '龙岩', '2', '22', '0');
INSERT INTO `area` VALUES ('3509', '35', '宁德', '2', '23', '0');
INSERT INTO `area` VALUES ('3601', '36', '南昌', '2', '169', '1');
INSERT INTO `area` VALUES ('3602', '36', '景德镇', '2', '170', '1');
INSERT INTO `area` VALUES ('3603', '36', '萍乡', '2', '171', '1');
INSERT INTO `area` VALUES ('3604', '36', '九江', '2', '172', '1');
INSERT INTO `area` VALUES ('3605', '36', '新余', '2', '173', '1');
INSERT INTO `area` VALUES ('3606', '36', '鹰潭', '2', '174', '1');
INSERT INTO `area` VALUES ('3607', '36', '赣州', '2', '175', '1');
INSERT INTO `area` VALUES ('3608', '36', '吉安', '2', '176', '1');
INSERT INTO `area` VALUES ('3609', '36', '宜春', '2', '177', '1');
INSERT INTO `area` VALUES ('3610', '36', '抚州', '2', '178', '1');
INSERT INTO `area` VALUES ('3611', '36', '上饶', '2', '179', '1');
INSERT INTO `area` VALUES ('3701', '37', '济南', '2', '180', '1');
INSERT INTO `area` VALUES ('3702', '37', '青岛', '2', '181', '1');
INSERT INTO `area` VALUES ('3703', '37', '淄博', '2', '182', '1');
INSERT INTO `area` VALUES ('3704', '37', '枣庄', '2', '183', '1');
INSERT INTO `area` VALUES ('3705', '37', '东营', '2', '184', '1');
INSERT INTO `area` VALUES ('3706', '37', '烟台', '2', '185', '1');
INSERT INTO `area` VALUES ('3707', '37', '潍坊', '2', '186', '1');
INSERT INTO `area` VALUES ('3708', '37', '济宁', '2', '187', '1');
INSERT INTO `area` VALUES ('3709', '37', '泰安', '2', '188', '1');
INSERT INTO `area` VALUES ('3710', '37', '威海', '2', '189', '1');
INSERT INTO `area` VALUES ('3711', '37', '日照', '2', '190', '1');
INSERT INTO `area` VALUES ('3712', '37', '莱芜', '2', '191', '1');
INSERT INTO `area` VALUES ('3713', '37', '临沂', '2', '192', '1');
INSERT INTO `area` VALUES ('3714', '37', '德州', '2', '193', '1');
INSERT INTO `area` VALUES ('3715', '37', '聊城', '2', '194', '1');
INSERT INTO `area` VALUES ('3716', '37', '滨州', '2', '195', '1');
INSERT INTO `area` VALUES ('3717', '37', '菏泽', '2', '196', '1');
INSERT INTO `area` VALUES ('4101', '41', '郑州', '2', '197', '1');
INSERT INTO `area` VALUES ('4102', '41', '开封', '2', '198', '1');
INSERT INTO `area` VALUES ('4103', '41', '洛阳', '2', '199', '1');
INSERT INTO `area` VALUES ('4104', '41', '平顶山', '2', '200', '1');
INSERT INTO `area` VALUES ('4105', '41', '安阳', '2', '201', '1');
INSERT INTO `area` VALUES ('4106', '41', '鹤壁', '2', '202', '1');
INSERT INTO `area` VALUES ('4107', '41', '新乡', '2', '203', '1');
INSERT INTO `area` VALUES ('4108', '41', '焦作', '2', '204', '1');
INSERT INTO `area` VALUES ('4109', '41', '濮阳', '2', '205', '1');
INSERT INTO `area` VALUES ('4110', '41', '许昌', '2', '206', '1');
INSERT INTO `area` VALUES ('4111', '41', '漯河', '2', '207', '1');
INSERT INTO `area` VALUES ('4112', '41', '三门峡', '2', '208', '1');
INSERT INTO `area` VALUES ('4113', '41', '南阳', '2', '209', '1');
INSERT INTO `area` VALUES ('4114', '41', '商丘', '2', '210', '1');
INSERT INTO `area` VALUES ('4115', '41', '信阳', '2', '211', '1');
INSERT INTO `area` VALUES ('4116', '41', '周口', '2', '212', '1');
INSERT INTO `area` VALUES ('4117', '41', '驻马店', '2', '213', '1');
INSERT INTO `area` VALUES ('4201', '42', '武汉', '2', '214', '1');
INSERT INTO `area` VALUES ('4202', '42', '黄石', '2', '215', '1');
INSERT INTO `area` VALUES ('4203', '42', '十堰', '2', '216', '1');
INSERT INTO `area` VALUES ('4205', '42', '宜昌', '2', '217', '1');
INSERT INTO `area` VALUES ('4206', '42', '襄樊', '2', '218', '1');
INSERT INTO `area` VALUES ('4207', '42', '鄂州', '2', '219', '1');
INSERT INTO `area` VALUES ('4208', '42', '荆门', '2', '220', '1');
INSERT INTO `area` VALUES ('4209', '42', '孝感', '2', '221', '1');
INSERT INTO `area` VALUES ('4210', '42', '荆州', '2', '222', '1');
INSERT INTO `area` VALUES ('4211', '42', '黄冈', '2', '223', '1');
INSERT INTO `area` VALUES ('4212', '42', '咸宁', '2', '224', '1');
INSERT INTO `area` VALUES ('4213', '42', '随州', '2', '225', '1');
INSERT INTO `area` VALUES ('4228', '42', '恩施土家族苗族自治州', '2', '226', '1');
INSERT INTO `area` VALUES ('4290', '42', '省直辖行政单位', '2', '227', '1');
INSERT INTO `area` VALUES ('4301', '43', '长沙', '2', '228', '0');
INSERT INTO `area` VALUES ('4302', '43', '株洲', '2', '229', '0');
INSERT INTO `area` VALUES ('4303', '43', '湘潭', '2', '230', '0');
INSERT INTO `area` VALUES ('4304', '43', '衡阳', '2', '231', '0');
INSERT INTO `area` VALUES ('4305', '43', '邵阳', '2', '232', '0');
INSERT INTO `area` VALUES ('4306', '43', '岳阳', '2', '233', '0');
INSERT INTO `area` VALUES ('4307', '43', '常德', '2', '234', '0');
INSERT INTO `area` VALUES ('4308', '43', '张家界', '2', '235', '0');
INSERT INTO `area` VALUES ('4309', '43', '益阳', '2', '236', '0');
INSERT INTO `area` VALUES ('4310', '43', '郴州', '2', '237', '0');
INSERT INTO `area` VALUES ('4311', '43', '永州', '2', '238', '0');
INSERT INTO `area` VALUES ('4312', '43', '怀化', '2', '239', '0');
INSERT INTO `area` VALUES ('4313', '43', '娄底', '2', '240', '0');
INSERT INTO `area` VALUES ('4331', '43', '湘西土家族苗族自治州', '2', '241', '0');
INSERT INTO `area` VALUES ('4401', '44', '广州', '2', '28', '0');
INSERT INTO `area` VALUES ('4402', '44', '韶关', '2', '32', '0');
INSERT INTO `area` VALUES ('4403', '44', '深圳', '2', '29', '0');
INSERT INTO `area` VALUES ('4404', '44', '珠海', '2', '30', '0');
INSERT INTO `area` VALUES ('4405', '44', '汕头', '2', '31', '0');
INSERT INTO `area` VALUES ('4406', '44', '佛山', '2', '33', '0');
INSERT INTO `area` VALUES ('4407', '44', '江门', '2', '34', '0');
INSERT INTO `area` VALUES ('4408', '44', '湛江', '2', '35', '0');
INSERT INTO `area` VALUES ('4409', '44', '茂名', '2', '36', '0');
INSERT INTO `area` VALUES ('4412', '44', '肇庆', '2', '37', '0');
INSERT INTO `area` VALUES ('4413', '44', '惠州', '2', '38', '0');
INSERT INTO `area` VALUES ('4414', '44', '梅州', '2', '39', '0');
INSERT INTO `area` VALUES ('4415', '44', '汕尾', '2', '40', '0');
INSERT INTO `area` VALUES ('4416', '44', '河源', '2', '41', '0');
INSERT INTO `area` VALUES ('4417', '44', '阳江', '2', '42', '0');
INSERT INTO `area` VALUES ('4418', '44', '清远', '2', '43', '0');
INSERT INTO `area` VALUES ('4419', '44', '东莞', '2', '44', '0');
INSERT INTO `area` VALUES ('4420', '44', '中山', '2', '45', '0');
INSERT INTO `area` VALUES ('4451', '44', '潮州', '2', '46', '0');
INSERT INTO `area` VALUES ('4452', '44', '揭阳', '2', '47', '0');
INSERT INTO `area` VALUES ('4453', '44', '云浮', '2', '48', '0');
INSERT INTO `area` VALUES ('4501', '45', '南宁', '2', '263', '1');
INSERT INTO `area` VALUES ('4502', '45', '柳州', '2', '264', '1');
INSERT INTO `area` VALUES ('4503', '45', '桂林', '2', '265', '1');
INSERT INTO `area` VALUES ('4504', '45', '梧州', '2', '266', '1');
INSERT INTO `area` VALUES ('4505', '45', '北海', '2', '267', '1');
INSERT INTO `area` VALUES ('4506', '45', '防城港', '2', '268', '1');
INSERT INTO `area` VALUES ('4507', '45', '钦州', '2', '269', '1');
INSERT INTO `area` VALUES ('4508', '45', '贵港', '2', '270', '1');
INSERT INTO `area` VALUES ('4509', '45', '玉林', '2', '271', '1');
INSERT INTO `area` VALUES ('4521', '45', '南宁地区', '2', '272', '1');
INSERT INTO `area` VALUES ('4522', '45', '柳州地区', '2', '273', '1');
INSERT INTO `area` VALUES ('4524', '45', '贺州地区', '2', '274', '1');
INSERT INTO `area` VALUES ('4526', '45', '百色地区', '2', '275', '1');
INSERT INTO `area` VALUES ('4527', '45', '河池地区', '2', '276', '1');
INSERT INTO `area` VALUES ('4601', '46', '海南', '2', '277', '1');
INSERT INTO `area` VALUES ('4602', '46', '海口', '2', '278', '1');
INSERT INTO `area` VALUES ('4603', '46', '三亚', '2', '279', '1');
INSERT INTO `area` VALUES ('5001', '50', '重庆市', '2', '1', '0');
INSERT INTO `area` VALUES ('5101', '51', '成都', '2', '281', '1');
INSERT INTO `area` VALUES ('5103', '51', '自贡', '2', '282', '1');
INSERT INTO `area` VALUES ('5104', '51', '攀枝花', '2', '283', '1');
INSERT INTO `area` VALUES ('5105', '51', '泸州', '2', '284', '1');
INSERT INTO `area` VALUES ('5106', '51', '德阳', '2', '285', '1');
INSERT INTO `area` VALUES ('5107', '51', '绵阳', '2', '286', '1');
INSERT INTO `area` VALUES ('5108', '51', '广元', '2', '287', '1');
INSERT INTO `area` VALUES ('5109', '51', '遂宁', '2', '288', '1');
INSERT INTO `area` VALUES ('5110', '51', '内江', '2', '289', '1');
INSERT INTO `area` VALUES ('5111', '51', '乐山', '2', '290', '1');
INSERT INTO `area` VALUES ('5113', '51', '南充', '2', '291', '1');
INSERT INTO `area` VALUES ('5114', '51', '眉山', '2', '292', '1');
INSERT INTO `area` VALUES ('5115', '51', '宜宾', '2', '293', '1');
INSERT INTO `area` VALUES ('5116', '51', '广安', '2', '294', '1');
INSERT INTO `area` VALUES ('5117', '51', '达州', '2', '295', '1');
INSERT INTO `area` VALUES ('5118', '51', '雅安', '2', '296', '1');
INSERT INTO `area` VALUES ('5119', '51', '巴中', '2', '297', '1');
INSERT INTO `area` VALUES ('5120', '51', '资阳', '2', '298', '1');
INSERT INTO `area` VALUES ('5132', '51', '阿坝藏族羌族自治州', '2', '299', '1');
INSERT INTO `area` VALUES ('5133', '51', '甘孜藏族自治州', '2', '300', '1');
INSERT INTO `area` VALUES ('5134', '51', '凉山彝族自治州', '2', '301', '1');
INSERT INTO `area` VALUES ('5201', '52', '贵阳', '2', '302', '1');
INSERT INTO `area` VALUES ('5202', '52', '六盘水', '2', '303', '1');
INSERT INTO `area` VALUES ('5203', '52', '遵义', '2', '304', '1');
INSERT INTO `area` VALUES ('5204', '52', '安顺', '2', '305', '1');
INSERT INTO `area` VALUES ('5222', '52', '铜仁地区', '2', '306', '1');
INSERT INTO `area` VALUES ('5223', '52', '黔西南布依族苗族自治', '2', '307', '1');
INSERT INTO `area` VALUES ('5224', '52', '毕节地区', '2', '308', '1');
INSERT INTO `area` VALUES ('5226', '52', '黔东南苗族侗族自治州', '2', '309', '1');
INSERT INTO `area` VALUES ('5227', '52', '黔南布依族苗族自治州', '2', '310', '1');
INSERT INTO `area` VALUES ('5301', '53', '昆明', '2', '311', '1');
INSERT INTO `area` VALUES ('5303', '53', '曲靖', '2', '312', '1');
INSERT INTO `area` VALUES ('5304', '53', '玉溪', '2', '313', '1');
INSERT INTO `area` VALUES ('5305', '53', '保山', '2', '314', '1');
INSERT INTO `area` VALUES ('5321', '53', '昭通地区', '2', '315', '1');
INSERT INTO `area` VALUES ('5323', '53', '楚雄彝族自治州', '2', '316', '1');
INSERT INTO `area` VALUES ('5325', '53', '红河哈尼族彝族自治州', '2', '317', '1');
INSERT INTO `area` VALUES ('5326', '53', '文山壮族苗族自治州', '2', '318', '1');
INSERT INTO `area` VALUES ('5327', '53', '思茅地区', '2', '319', '1');
INSERT INTO `area` VALUES ('5328', '53', '西双版纳傣族自治州', '2', '320', '1');
INSERT INTO `area` VALUES ('5329', '53', '大理白族自治州', '2', '321', '1');
INSERT INTO `area` VALUES ('5331', '53', '德宏傣族景颇族自治州', '2', '322', '1');
INSERT INTO `area` VALUES ('5332', '53', '丽江地区', '2', '323', '1');
INSERT INTO `area` VALUES ('5333', '53', '怒江傈僳族自治州', '2', '324', '1');
INSERT INTO `area` VALUES ('5334', '53', '迪庆藏族自治州', '2', '325', '1');
INSERT INTO `area` VALUES ('5335', '53', '临沧地区', '2', '326', '1');
INSERT INTO `area` VALUES ('5401', '54', '拉萨', '2', '327', '1');
INSERT INTO `area` VALUES ('5421', '54', '昌都地区', '2', '328', '1');
INSERT INTO `area` VALUES ('5422', '54', '山南地区', '2', '329', '1');
INSERT INTO `area` VALUES ('5423', '54', '日喀则地区', '2', '330', '1');
INSERT INTO `area` VALUES ('5424', '54', '那曲地区', '2', '331', '1');
INSERT INTO `area` VALUES ('5425', '54', '阿里地区', '2', '332', '1');
INSERT INTO `area` VALUES ('5426', '54', '林芝地区', '2', '333', '1');
INSERT INTO `area` VALUES ('6101', '61', '西安', '2', '334', '1');
INSERT INTO `area` VALUES ('6102', '61', '铜川', '2', '335', '1');
INSERT INTO `area` VALUES ('6103', '61', '宝鸡', '2', '336', '1');
INSERT INTO `area` VALUES ('6104', '61', '咸阳', '2', '337', '1');
INSERT INTO `area` VALUES ('6105', '61', '渭南', '2', '338', '1');
INSERT INTO `area` VALUES ('6106', '61', '延安', '2', '339', '1');
INSERT INTO `area` VALUES ('6107', '61', '汉中', '2', '340', '1');
INSERT INTO `area` VALUES ('6108', '61', '榆林', '2', '341', '1');
INSERT INTO `area` VALUES ('6109', '61', '安康', '2', '342', '1');
INSERT INTO `area` VALUES ('6125', '61', '商洛地区', '2', '343', '1');
INSERT INTO `area` VALUES ('6201', '62', '兰州', '2', '344', '1');
INSERT INTO `area` VALUES ('6202', '62', '嘉峪关', '2', '345', '1');
INSERT INTO `area` VALUES ('6203', '62', '金昌', '2', '346', '1');
INSERT INTO `area` VALUES ('6204', '62', '白银', '2', '347', '1');
INSERT INTO `area` VALUES ('6205', '62', '天水', '2', '348', '1');
INSERT INTO `area` VALUES ('6221', '62', '酒泉地区', '2', '349', '1');
INSERT INTO `area` VALUES ('6222', '62', '张掖地区', '2', '350', '1');
INSERT INTO `area` VALUES ('6223', '62', '武威地区', '2', '351', '1');
INSERT INTO `area` VALUES ('6224', '62', '定西地区', '2', '352', '1');
INSERT INTO `area` VALUES ('6226', '62', '陇南地区', '2', '353', '1');
INSERT INTO `area` VALUES ('6227', '62', '平凉地区', '2', '354', '1');
INSERT INTO `area` VALUES ('6228', '62', '庆阳地区', '2', '355', '1');
INSERT INTO `area` VALUES ('6229', '62', '临夏回族自治州', '2', '356', '1');
INSERT INTO `area` VALUES ('6230', '62', '甘南藏族自治州', '2', '357', '1');
INSERT INTO `area` VALUES ('6301', '63', '西宁', '2', '358', '1');
INSERT INTO `area` VALUES ('6321', '63', '海东地区', '2', '359', '1');
INSERT INTO `area` VALUES ('6322', '63', '海北藏族自治州', '2', '360', '1');
INSERT INTO `area` VALUES ('6323', '63', '黄南藏族自治州', '2', '361', '1');
INSERT INTO `area` VALUES ('6325', '63', '海南藏族自治州', '2', '362', '1');
INSERT INTO `area` VALUES ('6326', '63', '果洛藏族自治州', '2', '363', '1');
INSERT INTO `area` VALUES ('6327', '63', '玉树藏族自治州', '2', '364', '1');
INSERT INTO `area` VALUES ('6328', '63', '海西蒙古族藏族自治州', '2', '365', '1');
INSERT INTO `area` VALUES ('6401', '64', '银川', '2', '366', '1');
INSERT INTO `area` VALUES ('6402', '64', '石嘴山', '2', '367', '1');
INSERT INTO `area` VALUES ('6403', '64', '吴忠', '2', '368', '1');
INSERT INTO `area` VALUES ('6422', '64', '固原地区', '2', '369', '1');
INSERT INTO `area` VALUES ('6501', '65', '乌鲁木齐', '2', '370', '1');
INSERT INTO `area` VALUES ('6502', '65', '克拉玛依', '2', '371', '1');
INSERT INTO `area` VALUES ('6521', '65', '吐鲁番地区', '2', '372', '1');
INSERT INTO `area` VALUES ('6522', '65', '哈密地区', '2', '373', '1');
INSERT INTO `area` VALUES ('6523', '65', '昌吉回族自治州', '2', '374', '1');
INSERT INTO `area` VALUES ('6527', '65', '博尔塔拉蒙古自治州', '2', '375', '1');
INSERT INTO `area` VALUES ('6528', '65', '巴音郭楞蒙古自治州', '2', '376', '1');
INSERT INTO `area` VALUES ('6529', '65', '阿克苏地区', '2', '377', '1');
INSERT INTO `area` VALUES ('6530', '65', '克孜勒苏柯尔克孜自治', '2', '378', '1');
INSERT INTO `area` VALUES ('6531', '65', '喀什地区', '2', '379', '1');
INSERT INTO `area` VALUES ('6532', '65', '和田地区', '2', '380', '1');
INSERT INTO `area` VALUES ('6540', '65', '伊犁哈萨克自治州', '2', '381', '1');
INSERT INTO `area` VALUES ('6541', '65', '伊犁地区', '2', '382', '1');
INSERT INTO `area` VALUES ('6542', '65', '塔城地区', '2', '383', '1');
INSERT INTO `area` VALUES ('6543', '65', '阿勒泰地区', '2', '384', '1');
INSERT INTO `area` VALUES ('6590', '65', '省直辖行政单位', '2', '385', '1');
INSERT INTO `area` VALUES ('7101', '71', '台湾市辖', '2', '386', '1');
INSERT INTO `area` VALUES ('8101', '81', '香港特区', '2', '387', '1');
INSERT INTO `area` VALUES ('9101', '91', '澳门特区', '2', '388', '1');
INSERT INTO `area` VALUES ('110101', '1101', '东城区', '3', '389', '0');
INSERT INTO `area` VALUES ('110102', '1101', '西城区', '3', '390', '0');
INSERT INTO `area` VALUES ('110103', '1101', '崇文区', '3', '391', '0');
INSERT INTO `area` VALUES ('110104', '1101', '宣武区', '3', '392', '0');
INSERT INTO `area` VALUES ('110105', '1101', '朝阳区', '3', '393', '0');
INSERT INTO `area` VALUES ('110106', '1101', '丰台区', '3', '394', '0');
INSERT INTO `area` VALUES ('110107', '1101', '石景山区', '3', '395', '0');
INSERT INTO `area` VALUES ('110108', '1101', '海淀区', '3', '396', '0');
INSERT INTO `area` VALUES ('110109', '1101', '门头沟区', '3', '397', '0');
INSERT INTO `area` VALUES ('110111', '1101', '房山区', '3', '398', '0');
INSERT INTO `area` VALUES ('110112', '1101', '通州区', '3', '399', '0');
INSERT INTO `area` VALUES ('110113', '1101', '顺义区', '3', '400', '0');
INSERT INTO `area` VALUES ('110114', '1101', '昌平区', '3', '401', '0');
INSERT INTO `area` VALUES ('110224', '1102', '大兴县', '3', '402', '0');
INSERT INTO `area` VALUES ('110226', '1102', '平谷县', '3', '403', '0');
INSERT INTO `area` VALUES ('110227', '1102', '怀柔县', '3', '404', '0');
INSERT INTO `area` VALUES ('110228', '1102', '密云县', '3', '405', '0');
INSERT INTO `area` VALUES ('110229', '1102', '延庆县', '3', '406', '0');
INSERT INTO `area` VALUES ('120101', '1201', '和平区', '3', '407', '1');
INSERT INTO `area` VALUES ('120102', '1201', '河东区', '3', '408', '1');
INSERT INTO `area` VALUES ('120103', '1201', '河西区', '3', '409', '1');
INSERT INTO `area` VALUES ('120104', '1201', '南开区', '3', '410', '1');
INSERT INTO `area` VALUES ('120105', '1201', '河北区', '3', '411', '1');
INSERT INTO `area` VALUES ('120106', '1201', '红桥区', '3', '412', '1');
INSERT INTO `area` VALUES ('120107', '1201', '塘沽区', '3', '413', '1');
INSERT INTO `area` VALUES ('120108', '1201', '汉沽区', '3', '414', '1');
INSERT INTO `area` VALUES ('120109', '1201', '大港区', '3', '415', '1');
INSERT INTO `area` VALUES ('120110', '1201', '东丽区', '3', '416', '1');
INSERT INTO `area` VALUES ('120111', '1201', '西青区', '3', '417', '1');
INSERT INTO `area` VALUES ('120112', '1201', '津南区', '3', '418', '1');
INSERT INTO `area` VALUES ('120113', '1201', '北辰区', '3', '419', '1');
INSERT INTO `area` VALUES ('120114', '1201', '武清区', '3', '420', '1');
INSERT INTO `area` VALUES ('120221', '1202', '宁河县', '3', '421', '1');
INSERT INTO `area` VALUES ('120223', '1202', '静海县', '3', '422', '1');
INSERT INTO `area` VALUES ('120224', '1202', '宝坻县', '3', '423', '1');
INSERT INTO `area` VALUES ('120225', '1202', '蓟  县', '3', '424', '1');
INSERT INTO `area` VALUES ('130101', '1301', '市辖区', '3', '425', '1');
INSERT INTO `area` VALUES ('130102', '1301', '长安区', '3', '426', '1');
INSERT INTO `area` VALUES ('130103', '1301', '桥东区', '3', '427', '1');
INSERT INTO `area` VALUES ('130104', '1301', '桥西区', '3', '428', '1');
INSERT INTO `area` VALUES ('130105', '1301', '新华区', '3', '429', '1');
INSERT INTO `area` VALUES ('130106', '1301', '郊  区', '3', '430', '1');
INSERT INTO `area` VALUES ('130107', '1301', '井陉矿区', '3', '431', '1');
INSERT INTO `area` VALUES ('130121', '1301', '井陉县', '3', '432', '1');
INSERT INTO `area` VALUES ('130123', '1301', '正定县', '3', '433', '1');
INSERT INTO `area` VALUES ('130124', '1301', '栾城县', '3', '434', '1');
INSERT INTO `area` VALUES ('130125', '1301', '行唐县', '3', '435', '1');
INSERT INTO `area` VALUES ('130126', '1301', '灵寿县', '3', '436', '1');
INSERT INTO `area` VALUES ('130127', '1301', '高邑县', '3', '437', '1');
INSERT INTO `area` VALUES ('130128', '1301', '深泽县', '3', '438', '1');
INSERT INTO `area` VALUES ('130129', '1301', '赞皇县', '3', '439', '1');
INSERT INTO `area` VALUES ('130130', '1301', '无极县', '3', '440', '1');
INSERT INTO `area` VALUES ('130131', '1301', '平山县', '3', '441', '1');
INSERT INTO `area` VALUES ('130132', '1301', '元氏县', '3', '442', '1');
INSERT INTO `area` VALUES ('130133', '1301', '赵  县', '3', '443', '1');
INSERT INTO `area` VALUES ('130181', '1301', '辛集市', '3', '444', '1');
INSERT INTO `area` VALUES ('130182', '1301', '藁城市', '3', '445', '1');
INSERT INTO `area` VALUES ('130183', '1301', '晋州市', '3', '446', '1');
INSERT INTO `area` VALUES ('130184', '1301', '新乐市', '3', '447', '1');
INSERT INTO `area` VALUES ('130185', '1301', '鹿泉市', '3', '448', '1');
INSERT INTO `area` VALUES ('130201', '1302', '市辖区', '3', '449', '1');
INSERT INTO `area` VALUES ('130202', '1302', '路南区', '3', '450', '1');
INSERT INTO `area` VALUES ('130203', '1302', '路北区', '3', '451', '1');
INSERT INTO `area` VALUES ('130204', '1302', '古冶区', '3', '452', '1');
INSERT INTO `area` VALUES ('130205', '1302', '开平区', '3', '453', '1');
INSERT INTO `area` VALUES ('130206', '1302', '新  区', '3', '454', '1');
INSERT INTO `area` VALUES ('130221', '1302', '丰润县', '3', '455', '1');
INSERT INTO `area` VALUES ('130223', '1302', '滦  县', '3', '456', '1');
INSERT INTO `area` VALUES ('130224', '1302', '滦南县', '3', '457', '1');
INSERT INTO `area` VALUES ('130225', '1302', '乐亭县', '3', '458', '1');
INSERT INTO `area` VALUES ('130227', '1302', '迁西县', '3', '459', '1');
INSERT INTO `area` VALUES ('130229', '1302', '玉田县', '3', '460', '1');
INSERT INTO `area` VALUES ('130230', '1302', '唐海县', '3', '461', '1');
INSERT INTO `area` VALUES ('130281', '1302', '遵化市', '3', '462', '1');
INSERT INTO `area` VALUES ('130282', '1302', '丰南市', '3', '463', '1');
INSERT INTO `area` VALUES ('130283', '1302', '迁安市', '3', '464', '1');
INSERT INTO `area` VALUES ('130301', '1303', '市辖区', '3', '465', '1');
INSERT INTO `area` VALUES ('130302', '1303', '海港区', '3', '466', '1');
INSERT INTO `area` VALUES ('130303', '1303', '山海关区', '3', '467', '1');
INSERT INTO `area` VALUES ('130304', '1303', '北戴河区', '3', '468', '1');
INSERT INTO `area` VALUES ('130321', '1303', '青龙满族自治县', '3', '469', '1');
INSERT INTO `area` VALUES ('130322', '1303', '昌黎县', '3', '470', '1');
INSERT INTO `area` VALUES ('130323', '1303', '抚宁县', '3', '471', '1');
INSERT INTO `area` VALUES ('130324', '1303', '卢龙县', '3', '472', '1');
INSERT INTO `area` VALUES ('130401', '1304', '市辖区', '3', '473', '1');
INSERT INTO `area` VALUES ('130402', '1304', '邯山区', '3', '474', '1');
INSERT INTO `area` VALUES ('130403', '1304', '丛台区', '3', '475', '1');
INSERT INTO `area` VALUES ('130404', '1304', '复兴区', '3', '476', '1');
INSERT INTO `area` VALUES ('130406', '1304', '峰峰矿区', '3', '477', '1');
INSERT INTO `area` VALUES ('130421', '1304', '邯郸县', '3', '478', '1');
INSERT INTO `area` VALUES ('130423', '1304', '临漳县', '3', '479', '1');
INSERT INTO `area` VALUES ('130424', '1304', '成安县', '3', '480', '1');
INSERT INTO `area` VALUES ('130425', '1304', '大名县', '3', '481', '1');
INSERT INTO `area` VALUES ('130426', '1304', '涉  县', '3', '482', '1');
INSERT INTO `area` VALUES ('130427', '1304', '磁  县', '3', '483', '1');
INSERT INTO `area` VALUES ('130428', '1304', '肥乡县', '3', '484', '1');
INSERT INTO `area` VALUES ('130429', '1304', '永年县', '3', '485', '1');
INSERT INTO `area` VALUES ('130430', '1304', '邱  县', '3', '486', '1');
INSERT INTO `area` VALUES ('130431', '1304', '鸡泽县', '3', '487', '1');
INSERT INTO `area` VALUES ('130432', '1304', '广平县', '3', '488', '1');
INSERT INTO `area` VALUES ('130433', '1304', '馆陶县', '3', '489', '1');
INSERT INTO `area` VALUES ('130434', '1304', '魏  县', '3', '490', '1');
INSERT INTO `area` VALUES ('130435', '1304', '曲周县', '3', '491', '1');
INSERT INTO `area` VALUES ('130481', '1304', '武安市', '3', '492', '1');
INSERT INTO `area` VALUES ('130501', '1305', '市辖区', '3', '493', '1');
INSERT INTO `area` VALUES ('130502', '1305', '桥东区', '3', '494', '1');
INSERT INTO `area` VALUES ('130503', '1305', '桥西区', '3', '495', '1');
INSERT INTO `area` VALUES ('130521', '1305', '邢台县', '3', '496', '1');
INSERT INTO `area` VALUES ('130522', '1305', '临城县', '3', '497', '1');
INSERT INTO `area` VALUES ('130523', '1305', '内丘县', '3', '498', '1');
INSERT INTO `area` VALUES ('130524', '1305', '柏乡县', '3', '499', '1');
INSERT INTO `area` VALUES ('130525', '1305', '隆尧县', '3', '500', '1');
INSERT INTO `area` VALUES ('130526', '1305', '任  县', '3', '501', '1');
INSERT INTO `area` VALUES ('130527', '1305', '南和县', '3', '502', '1');
INSERT INTO `area` VALUES ('130528', '1305', '宁晋县', '3', '503', '1');
INSERT INTO `area` VALUES ('130529', '1305', '巨鹿县', '3', '504', '1');
INSERT INTO `area` VALUES ('130530', '1305', '新河县', '3', '505', '1');
INSERT INTO `area` VALUES ('130531', '1305', '广宗县', '3', '506', '1');
INSERT INTO `area` VALUES ('130532', '1305', '平乡县', '3', '507', '1');
INSERT INTO `area` VALUES ('130533', '1305', '威  县', '3', '508', '1');
INSERT INTO `area` VALUES ('130534', '1305', '清河县', '3', '509', '1');
INSERT INTO `area` VALUES ('130535', '1305', '临西县', '3', '510', '1');
INSERT INTO `area` VALUES ('130581', '1305', '南宫市', '3', '511', '1');
INSERT INTO `area` VALUES ('130582', '1305', '沙河市', '3', '512', '1');
INSERT INTO `area` VALUES ('130601', '1306', '市辖区', '3', '513', '1');
INSERT INTO `area` VALUES ('130602', '1306', '新市区', '3', '514', '1');
INSERT INTO `area` VALUES ('130603', '1306', '北市区', '3', '515', '1');
INSERT INTO `area` VALUES ('130604', '1306', '南市区', '3', '516', '1');
INSERT INTO `area` VALUES ('130621', '1306', '满城县', '3', '517', '1');
INSERT INTO `area` VALUES ('130622', '1306', '清苑县', '3', '518', '1');
INSERT INTO `area` VALUES ('130623', '1306', '涞水县', '3', '519', '1');
INSERT INTO `area` VALUES ('130624', '1306', '阜平县', '3', '520', '1');
INSERT INTO `area` VALUES ('130625', '1306', '徐水县', '3', '521', '1');
INSERT INTO `area` VALUES ('130626', '1306', '定兴县', '3', '522', '1');
INSERT INTO `area` VALUES ('130627', '1306', '唐  县', '3', '523', '1');
INSERT INTO `area` VALUES ('130628', '1306', '高阳县', '3', '524', '1');
INSERT INTO `area` VALUES ('130629', '1306', '容城县', '3', '525', '1');
INSERT INTO `area` VALUES ('130630', '1306', '涞源县', '3', '526', '1');
INSERT INTO `area` VALUES ('130631', '1306', '望都县', '3', '527', '1');
INSERT INTO `area` VALUES ('130632', '1306', '安新县', '3', '528', '1');
INSERT INTO `area` VALUES ('130633', '1306', '易  县', '3', '529', '1');
INSERT INTO `area` VALUES ('130634', '1306', '曲阳县', '3', '530', '1');
INSERT INTO `area` VALUES ('130635', '1306', '蠡  县', '3', '531', '1');
INSERT INTO `area` VALUES ('130636', '1306', '顺平县', '3', '532', '1');
INSERT INTO `area` VALUES ('130637', '1306', '博野县', '3', '533', '1');
INSERT INTO `area` VALUES ('130638', '1306', '雄  县', '3', '534', '1');
INSERT INTO `area` VALUES ('130681', '1306', '涿州市', '3', '535', '1');
INSERT INTO `area` VALUES ('130682', '1306', '定州市', '3', '536', '1');
INSERT INTO `area` VALUES ('130683', '1306', '安国市', '3', '537', '1');
INSERT INTO `area` VALUES ('130684', '1306', '高碑店市', '3', '538', '1');
INSERT INTO `area` VALUES ('130701', '1307', '市辖区', '3', '539', '1');
INSERT INTO `area` VALUES ('130702', '1307', '桥东区', '3', '540', '1');
INSERT INTO `area` VALUES ('130703', '1307', '桥西区', '3', '541', '1');
INSERT INTO `area` VALUES ('130705', '1307', '宣化区', '3', '542', '1');
INSERT INTO `area` VALUES ('130706', '1307', '下花园区', '3', '543', '1');
INSERT INTO `area` VALUES ('130721', '1307', '宣化县', '3', '544', '1');
INSERT INTO `area` VALUES ('130722', '1307', '张北县', '3', '545', '1');
INSERT INTO `area` VALUES ('130723', '1307', '康保县', '3', '546', '1');
INSERT INTO `area` VALUES ('130724', '1307', '沽源县', '3', '547', '1');
INSERT INTO `area` VALUES ('130725', '1307', '尚义县', '3', '548', '1');
INSERT INTO `area` VALUES ('130726', '1307', '蔚  县', '3', '549', '1');
INSERT INTO `area` VALUES ('130727', '1307', '阳原县', '3', '550', '1');
INSERT INTO `area` VALUES ('130728', '1307', '怀安县', '3', '551', '1');
INSERT INTO `area` VALUES ('130729', '1307', '万全县', '3', '552', '1');
INSERT INTO `area` VALUES ('130730', '1307', '怀来县', '3', '553', '1');
INSERT INTO `area` VALUES ('130731', '1307', '涿鹿县', '3', '554', '1');
INSERT INTO `area` VALUES ('130732', '1307', '赤城县', '3', '555', '1');
INSERT INTO `area` VALUES ('130733', '1307', '崇礼县', '3', '556', '1');
INSERT INTO `area` VALUES ('130801', '1308', '市辖区', '3', '557', '1');
INSERT INTO `area` VALUES ('130802', '1308', '双桥区', '3', '558', '1');
INSERT INTO `area` VALUES ('130803', '1308', '双滦区', '3', '559', '1');
INSERT INTO `area` VALUES ('130804', '1308', '鹰手营子矿区', '3', '560', '1');
INSERT INTO `area` VALUES ('130821', '1308', '承德县', '3', '561', '1');
INSERT INTO `area` VALUES ('130822', '1308', '兴隆县', '3', '562', '1');
INSERT INTO `area` VALUES ('130823', '1308', '平泉县', '3', '563', '1');
INSERT INTO `area` VALUES ('130824', '1308', '滦平县', '3', '564', '1');
INSERT INTO `area` VALUES ('130825', '1308', '隆化县', '3', '565', '1');
INSERT INTO `area` VALUES ('130826', '1308', '丰宁满族自治县', '3', '566', '1');
INSERT INTO `area` VALUES ('130827', '1308', '宽城满族自治县', '3', '567', '1');
INSERT INTO `area` VALUES ('130828', '1308', '围场满族蒙古族自治县', '3', '568', '1');
INSERT INTO `area` VALUES ('130901', '1309', '市辖区', '3', '569', '1');
INSERT INTO `area` VALUES ('130902', '1309', '新华区', '3', '570', '1');
INSERT INTO `area` VALUES ('130903', '1309', '运河区', '3', '571', '1');
INSERT INTO `area` VALUES ('130921', '1309', '沧  县', '3', '572', '1');
INSERT INTO `area` VALUES ('130922', '1309', '青  县', '3', '573', '1');
INSERT INTO `area` VALUES ('130923', '1309', '东光县', '3', '574', '1');
INSERT INTO `area` VALUES ('130924', '1309', '海兴县', '3', '575', '1');
INSERT INTO `area` VALUES ('130925', '1309', '盐山县', '3', '576', '1');
INSERT INTO `area` VALUES ('130926', '1309', '肃宁县', '3', '577', '1');
INSERT INTO `area` VALUES ('130927', '1309', '南皮县', '3', '578', '1');
INSERT INTO `area` VALUES ('130928', '1309', '吴桥县', '3', '579', '1');
INSERT INTO `area` VALUES ('130929', '1309', '献  县', '3', '580', '1');
INSERT INTO `area` VALUES ('130930', '1309', '孟村回族自治县', '3', '581', '1');
INSERT INTO `area` VALUES ('130981', '1309', '泊头市', '3', '582', '1');
INSERT INTO `area` VALUES ('130982', '1309', '任丘市', '3', '583', '1');
INSERT INTO `area` VALUES ('130983', '1309', '黄骅市', '3', '584', '1');
INSERT INTO `area` VALUES ('130984', '1309', '河间市', '3', '585', '1');
INSERT INTO `area` VALUES ('131001', '1310', '市辖区', '3', '586', '1');
INSERT INTO `area` VALUES ('131002', '1310', '安次区', '3', '587', '1');
INSERT INTO `area` VALUES ('131003', '1310', '廊坊市广阳区', '3', '588', '1');
INSERT INTO `area` VALUES ('131022', '1310', '固安县', '3', '589', '1');
INSERT INTO `area` VALUES ('131023', '1310', '永清县', '3', '590', '1');
INSERT INTO `area` VALUES ('131024', '1310', '香河县', '3', '591', '1');
INSERT INTO `area` VALUES ('131025', '1310', '大城县', '3', '592', '1');
INSERT INTO `area` VALUES ('131026', '1310', '文安县', '3', '593', '1');
INSERT INTO `area` VALUES ('131028', '1310', '大厂回族自治县', '3', '594', '1');
INSERT INTO `area` VALUES ('131081', '1310', '霸州市', '3', '595', '1');
INSERT INTO `area` VALUES ('131082', '1310', '三河市', '3', '596', '1');
INSERT INTO `area` VALUES ('131101', '1311', '市辖区', '3', '597', '1');
INSERT INTO `area` VALUES ('131102', '1311', '桃城区', '3', '598', '1');
INSERT INTO `area` VALUES ('131121', '1311', '枣强县', '3', '599', '1');
INSERT INTO `area` VALUES ('131122', '1311', '武邑县', '3', '600', '1');
INSERT INTO `area` VALUES ('131123', '1311', '武强县', '3', '601', '1');
INSERT INTO `area` VALUES ('131124', '1311', '饶阳县', '3', '602', '1');
INSERT INTO `area` VALUES ('131125', '1311', '安平县', '3', '603', '1');
INSERT INTO `area` VALUES ('131126', '1311', '故城县', '3', '604', '1');
INSERT INTO `area` VALUES ('131127', '1311', '景  县', '3', '605', '1');
INSERT INTO `area` VALUES ('131128', '1311', '阜城县', '3', '606', '1');
INSERT INTO `area` VALUES ('131181', '1311', '冀州市', '3', '607', '1');
INSERT INTO `area` VALUES ('131182', '1311', '深州市', '3', '608', '1');
INSERT INTO `area` VALUES ('140101', '1401', '市辖区', '3', '609', '1');
INSERT INTO `area` VALUES ('140105', '1401', '小店区', '3', '610', '1');
INSERT INTO `area` VALUES ('140106', '1401', '迎泽区', '3', '611', '1');
INSERT INTO `area` VALUES ('140107', '1401', '杏花岭区', '3', '612', '1');
INSERT INTO `area` VALUES ('140108', '1401', '尖草坪区', '3', '613', '1');
INSERT INTO `area` VALUES ('140109', '1401', '万柏林区', '3', '614', '1');
INSERT INTO `area` VALUES ('140110', '1401', '晋源区', '3', '615', '1');
INSERT INTO `area` VALUES ('140121', '1401', '清徐县', '3', '616', '1');
INSERT INTO `area` VALUES ('140122', '1401', '阳曲县', '3', '617', '1');
INSERT INTO `area` VALUES ('140123', '1401', '娄烦县', '3', '618', '1');
INSERT INTO `area` VALUES ('140181', '1401', '古交市', '3', '619', '1');
INSERT INTO `area` VALUES ('140201', '1402', '市辖区', '3', '620', '1');
INSERT INTO `area` VALUES ('140202', '1402', '城  区', '3', '621', '1');
INSERT INTO `area` VALUES ('140203', '1402', '矿  区', '3', '622', '1');
INSERT INTO `area` VALUES ('140211', '1402', '南郊区', '3', '623', '1');
INSERT INTO `area` VALUES ('140212', '1402', '新荣区', '3', '624', '1');
INSERT INTO `area` VALUES ('140221', '1402', '阳高县', '3', '625', '1');
INSERT INTO `area` VALUES ('140222', '1402', '天镇县', '3', '626', '1');
INSERT INTO `area` VALUES ('140223', '1402', '广灵县', '3', '627', '1');
INSERT INTO `area` VALUES ('140224', '1402', '灵丘县', '3', '628', '1');
INSERT INTO `area` VALUES ('140225', '1402', '浑源县', '3', '629', '1');
INSERT INTO `area` VALUES ('140226', '1402', '左云县', '3', '630', '1');
INSERT INTO `area` VALUES ('140227', '1402', '大同县', '3', '631', '1');
INSERT INTO `area` VALUES ('140301', '1403', '市辖区', '3', '632', '1');
INSERT INTO `area` VALUES ('140302', '1403', '城  区', '3', '633', '1');
INSERT INTO `area` VALUES ('140303', '1403', '矿  区', '3', '634', '1');
INSERT INTO `area` VALUES ('140311', '1403', '郊  区', '3', '635', '1');
INSERT INTO `area` VALUES ('140321', '1403', '平定县', '3', '636', '1');
INSERT INTO `area` VALUES ('140322', '1403', '盂  县', '3', '637', '1');
INSERT INTO `area` VALUES ('140401', '1404', '市辖区', '3', '638', '1');
INSERT INTO `area` VALUES ('140402', '1404', '城  区', '3', '639', '1');
INSERT INTO `area` VALUES ('140411', '1404', '郊  区', '3', '640', '1');
INSERT INTO `area` VALUES ('140421', '1404', '长治县', '3', '641', '1');
INSERT INTO `area` VALUES ('140423', '1404', '襄垣县', '3', '642', '1');
INSERT INTO `area` VALUES ('140424', '1404', '屯留县', '3', '643', '1');
INSERT INTO `area` VALUES ('140425', '1404', '平顺县', '3', '644', '1');
INSERT INTO `area` VALUES ('140426', '1404', '黎城县', '3', '645', '1');
INSERT INTO `area` VALUES ('140427', '1404', '壶关县', '3', '646', '1');
INSERT INTO `area` VALUES ('140428', '1404', '长子县', '3', '647', '1');
INSERT INTO `area` VALUES ('140429', '1404', '武乡县', '3', '648', '1');
INSERT INTO `area` VALUES ('140430', '1404', '沁  县', '3', '649', '1');
INSERT INTO `area` VALUES ('140431', '1404', '沁源县', '3', '650', '1');
INSERT INTO `area` VALUES ('140481', '1404', '潞城市', '3', '651', '1');
INSERT INTO `area` VALUES ('140501', '1405', '市辖区', '3', '652', '1');
INSERT INTO `area` VALUES ('140502', '1405', '城  区', '3', '653', '1');
INSERT INTO `area` VALUES ('140521', '1405', '沁水县', '3', '654', '1');
INSERT INTO `area` VALUES ('140522', '1405', '阳城县', '3', '655', '1');
INSERT INTO `area` VALUES ('140524', '1405', '陵川县', '3', '656', '1');
INSERT INTO `area` VALUES ('140525', '1405', '泽州县', '3', '657', '1');
INSERT INTO `area` VALUES ('140581', '1405', '高平市', '3', '658', '1');
INSERT INTO `area` VALUES ('140601', '1406', '市辖区', '3', '659', '1');
INSERT INTO `area` VALUES ('140602', '1406', '朔城区', '3', '660', '1');
INSERT INTO `area` VALUES ('140603', '1406', '平鲁区', '3', '661', '1');
INSERT INTO `area` VALUES ('140621', '1406', '山阴县', '3', '662', '1');
INSERT INTO `area` VALUES ('140622', '1406', '应  县', '3', '663', '1');
INSERT INTO `area` VALUES ('140623', '1406', '右玉县', '3', '664', '1');
INSERT INTO `area` VALUES ('140624', '1406', '怀仁县', '3', '665', '1');
INSERT INTO `area` VALUES ('140701', '1407', '市辖区', '3', '666', '1');
INSERT INTO `area` VALUES ('140702', '1407', '榆次区', '3', '667', '1');
INSERT INTO `area` VALUES ('140721', '1407', '榆社县', '3', '668', '1');
INSERT INTO `area` VALUES ('140722', '1407', '左权县', '3', '669', '1');
INSERT INTO `area` VALUES ('140723', '1407', '和顺县', '3', '670', '1');
INSERT INTO `area` VALUES ('140724', '1407', '昔阳县', '3', '671', '1');
INSERT INTO `area` VALUES ('140725', '1407', '寿阳县', '3', '672', '1');
INSERT INTO `area` VALUES ('140726', '1407', '太谷县', '3', '673', '1');
INSERT INTO `area` VALUES ('140727', '1407', '祁  县', '3', '674', '1');
INSERT INTO `area` VALUES ('140728', '1407', '平遥县', '3', '675', '1');
INSERT INTO `area` VALUES ('140729', '1407', '灵石县', '3', '676', '1');
INSERT INTO `area` VALUES ('140781', '1407', '介休市', '3', '677', '1');
INSERT INTO `area` VALUES ('140801', '1408', '市辖区', '3', '678', '1');
INSERT INTO `area` VALUES ('140802', '1408', '盐湖区', '3', '679', '1');
INSERT INTO `area` VALUES ('140821', '1408', '临猗县', '3', '680', '1');
INSERT INTO `area` VALUES ('140822', '1408', '万荣县', '3', '681', '1');
INSERT INTO `area` VALUES ('140823', '1408', '闻喜县', '3', '682', '1');
INSERT INTO `area` VALUES ('140824', '1408', '稷山县', '3', '683', '1');
INSERT INTO `area` VALUES ('140825', '1408', '新绛县', '3', '684', '1');
INSERT INTO `area` VALUES ('140826', '1408', '绛  县', '3', '685', '1');
INSERT INTO `area` VALUES ('140827', '1408', '垣曲县', '3', '686', '1');
INSERT INTO `area` VALUES ('140828', '1408', '夏  县', '3', '687', '1');
INSERT INTO `area` VALUES ('140829', '1408', '平陆县', '3', '688', '1');
INSERT INTO `area` VALUES ('140830', '1408', '芮城县', '3', '689', '1');
INSERT INTO `area` VALUES ('140881', '1408', '永济市', '3', '690', '1');
INSERT INTO `area` VALUES ('140882', '1408', '河津市', '3', '691', '1');
INSERT INTO `area` VALUES ('140901', '1409', '市辖区', '3', '692', '1');
INSERT INTO `area` VALUES ('140902', '1409', '忻府区', '3', '693', '1');
INSERT INTO `area` VALUES ('140921', '1409', '定襄县', '3', '694', '1');
INSERT INTO `area` VALUES ('140922', '1409', '五台县', '3', '695', '1');
INSERT INTO `area` VALUES ('140923', '1409', '代  县', '3', '696', '1');
INSERT INTO `area` VALUES ('140924', '1409', '繁峙县', '3', '697', '1');
INSERT INTO `area` VALUES ('140925', '1409', '宁武县', '3', '698', '1');
INSERT INTO `area` VALUES ('140926', '1409', '静乐县', '3', '699', '1');
INSERT INTO `area` VALUES ('140927', '1409', '神池县', '3', '700', '1');
INSERT INTO `area` VALUES ('140928', '1409', '五寨县', '3', '701', '1');
INSERT INTO `area` VALUES ('140929', '1409', '岢岚县', '3', '702', '1');
INSERT INTO `area` VALUES ('140930', '1409', '河曲县', '3', '703', '1');
INSERT INTO `area` VALUES ('140931', '1409', '保德县', '3', '704', '1');
INSERT INTO `area` VALUES ('140932', '1409', '偏关县', '3', '705', '1');
INSERT INTO `area` VALUES ('140981', '1409', '原平市', '3', '706', '1');
INSERT INTO `area` VALUES ('141001', '1410', '市辖区', '3', '707', '1');
INSERT INTO `area` VALUES ('141002', '1410', '尧都区', '3', '708', '1');
INSERT INTO `area` VALUES ('141021', '1410', '曲沃县', '3', '709', '1');
INSERT INTO `area` VALUES ('141022', '1410', '翼城县', '3', '710', '1');
INSERT INTO `area` VALUES ('141023', '1410', '襄汾县', '3', '711', '1');
INSERT INTO `area` VALUES ('141024', '1410', '洪洞县', '3', '712', '1');
INSERT INTO `area` VALUES ('141025', '1410', '古  县', '3', '713', '1');
INSERT INTO `area` VALUES ('141026', '1410', '安泽县', '3', '714', '1');
INSERT INTO `area` VALUES ('141027', '1410', '浮山县', '3', '715', '1');
INSERT INTO `area` VALUES ('141028', '1410', '吉  县', '3', '716', '1');
INSERT INTO `area` VALUES ('141029', '1410', '乡宁县', '3', '717', '1');
INSERT INTO `area` VALUES ('141030', '1410', '大宁县', '3', '718', '1');
INSERT INTO `area` VALUES ('141031', '1410', '隰  县', '3', '719', '1');
INSERT INTO `area` VALUES ('141032', '1410', '永和县', '3', '720', '1');
INSERT INTO `area` VALUES ('141033', '1410', '蒲  县', '3', '721', '1');
INSERT INTO `area` VALUES ('141034', '1410', '汾西县', '3', '722', '1');
INSERT INTO `area` VALUES ('141081', '1410', '侯马市', '3', '723', '1');
INSERT INTO `area` VALUES ('141082', '1410', '霍州市', '3', '724', '1');
INSERT INTO `area` VALUES ('142301', '1423', '孝义市', '3', '725', '1');
INSERT INTO `area` VALUES ('142302', '1423', '离石市', '3', '726', '1');
INSERT INTO `area` VALUES ('142303', '1423', '汾阳市', '3', '727', '1');
INSERT INTO `area` VALUES ('142322', '1423', '文水县', '3', '728', '1');
INSERT INTO `area` VALUES ('142323', '1423', '交城县', '3', '729', '1');
INSERT INTO `area` VALUES ('142325', '1423', '兴  县', '3', '730', '1');
INSERT INTO `area` VALUES ('142326', '1423', '临  县', '3', '731', '1');
INSERT INTO `area` VALUES ('142327', '1423', '柳林县', '3', '732', '1');
INSERT INTO `area` VALUES ('142328', '1423', '石楼县', '3', '733', '1');
INSERT INTO `area` VALUES ('142329', '1423', '岚  县', '3', '734', '1');
INSERT INTO `area` VALUES ('142330', '1423', '方山县', '3', '735', '1');
INSERT INTO `area` VALUES ('142332', '1423', '中阳县', '3', '736', '1');
INSERT INTO `area` VALUES ('142333', '1423', '交口县', '3', '737', '1');
INSERT INTO `area` VALUES ('150101', '1501', '市辖区', '3', '738', '1');
INSERT INTO `area` VALUES ('150102', '1501', '新城区', '3', '739', '1');
INSERT INTO `area` VALUES ('150103', '1501', '回民区', '3', '740', '1');
INSERT INTO `area` VALUES ('150104', '1501', '玉泉区', '3', '741', '1');
INSERT INTO `area` VALUES ('150105', '1501', '赛罕区', '3', '742', '1');
INSERT INTO `area` VALUES ('150121', '1501', '土默特左旗', '3', '743', '1');
INSERT INTO `area` VALUES ('150122', '1501', '托克托县', '3', '744', '1');
INSERT INTO `area` VALUES ('150123', '1501', '和林格尔县', '3', '745', '1');
INSERT INTO `area` VALUES ('150124', '1501', '清水河县', '3', '746', '1');
INSERT INTO `area` VALUES ('150125', '1501', '武川县', '3', '747', '1');
INSERT INTO `area` VALUES ('150201', '1502', '市辖区', '3', '748', '1');
INSERT INTO `area` VALUES ('150202', '1502', '东河区', '3', '749', '1');
INSERT INTO `area` VALUES ('150203', '1502', '昆都伦区', '3', '750', '1');
INSERT INTO `area` VALUES ('150204', '1502', '青山区', '3', '751', '1');
INSERT INTO `area` VALUES ('150205', '1502', '石拐区', '3', '752', '1');
INSERT INTO `area` VALUES ('150206', '1502', '白云矿区', '3', '753', '1');
INSERT INTO `area` VALUES ('150207', '1502', '九原区', '3', '754', '1');
INSERT INTO `area` VALUES ('150221', '1502', '土默特右旗', '3', '755', '1');
INSERT INTO `area` VALUES ('150222', '1502', '固阳县', '3', '756', '1');
INSERT INTO `area` VALUES ('150223', '1502', '达尔罕茂明安联合旗', '3', '757', '1');
INSERT INTO `area` VALUES ('150301', '1503', '市辖区', '3', '758', '1');
INSERT INTO `area` VALUES ('150302', '1503', '海勃湾区', '3', '759', '1');
INSERT INTO `area` VALUES ('150303', '1503', '海南区', '3', '760', '1');
INSERT INTO `area` VALUES ('150304', '1503', '乌达区', '3', '761', '1');
INSERT INTO `area` VALUES ('150401', '1504', '市辖区', '3', '762', '1');
INSERT INTO `area` VALUES ('150402', '1504', '红山区', '3', '763', '1');
INSERT INTO `area` VALUES ('150403', '1504', '元宝山区', '3', '764', '1');
INSERT INTO `area` VALUES ('150404', '1504', '松山区', '3', '765', '1');
INSERT INTO `area` VALUES ('150421', '1504', '阿鲁科尔沁旗', '3', '766', '1');
INSERT INTO `area` VALUES ('150422', '1504', '巴林左旗', '3', '767', '1');
INSERT INTO `area` VALUES ('150423', '1504', '巴林右旗', '3', '768', '1');
INSERT INTO `area` VALUES ('150424', '1504', '林西县', '3', '769', '1');
INSERT INTO `area` VALUES ('150425', '1504', '克什克腾旗', '3', '770', '1');
INSERT INTO `area` VALUES ('150426', '1504', '翁牛特旗', '3', '771', '1');
INSERT INTO `area` VALUES ('150428', '1504', '喀喇沁旗', '3', '772', '1');
INSERT INTO `area` VALUES ('150429', '1504', '宁城县', '3', '773', '1');
INSERT INTO `area` VALUES ('150430', '1504', '敖汉旗', '3', '774', '1');
INSERT INTO `area` VALUES ('150501', '1505', '市辖区', '3', '775', '1');
INSERT INTO `area` VALUES ('150502', '1505', '科尔沁区', '3', '776', '1');
INSERT INTO `area` VALUES ('150521', '1505', '科尔沁左翼中旗', '3', '777', '1');
INSERT INTO `area` VALUES ('150522', '1505', '科尔沁左翼后旗', '3', '778', '1');
INSERT INTO `area` VALUES ('150523', '1505', '开鲁县', '3', '779', '1');
INSERT INTO `area` VALUES ('150524', '1505', '库伦旗', '3', '780', '1');
INSERT INTO `area` VALUES ('150525', '1505', '奈曼旗', '3', '781', '1');
INSERT INTO `area` VALUES ('150526', '1505', '扎鲁特旗', '3', '782', '1');
INSERT INTO `area` VALUES ('150581', '1505', '霍林郭勒市', '3', '783', '1');
INSERT INTO `area` VALUES ('152101', '1521', '海拉尔市', '3', '784', '1');
INSERT INTO `area` VALUES ('152102', '1521', '满洲里市', '3', '785', '1');
INSERT INTO `area` VALUES ('152103', '1521', '扎兰屯市', '3', '786', '1');
INSERT INTO `area` VALUES ('152104', '1521', '牙克石市', '3', '787', '1');
INSERT INTO `area` VALUES ('152105', '1521', '根河市', '3', '788', '1');
INSERT INTO `area` VALUES ('152106', '1521', '额尔古纳市', '3', '789', '1');
INSERT INTO `area` VALUES ('152122', '1521', '阿荣旗', '3', '790', '1');
INSERT INTO `area` VALUES ('152123', '1521', '莫力达瓦达斡尔族自治', '3', '791', '1');
INSERT INTO `area` VALUES ('152127', '1521', '鄂伦春自治旗', '3', '792', '1');
INSERT INTO `area` VALUES ('152128', '1521', '鄂温克族自治旗', '3', '793', '1');
INSERT INTO `area` VALUES ('152129', '1521', '新巴尔虎右旗', '3', '794', '1');
INSERT INTO `area` VALUES ('152130', '1521', '新巴尔虎左旗', '3', '795', '1');
INSERT INTO `area` VALUES ('152131', '1521', '陈巴尔虎旗', '3', '796', '1');
INSERT INTO `area` VALUES ('152201', '1522', '乌兰浩特市', '3', '797', '1');
INSERT INTO `area` VALUES ('152202', '1522', '阿尔山市', '3', '798', '1');
INSERT INTO `area` VALUES ('152221', '1522', '科尔沁右翼前旗', '3', '799', '1');
INSERT INTO `area` VALUES ('152222', '1522', '科尔沁右翼中旗', '3', '800', '1');
INSERT INTO `area` VALUES ('152223', '1522', '扎赉特旗', '3', '801', '1');
INSERT INTO `area` VALUES ('152224', '1522', '突泉县', '3', '802', '1');
INSERT INTO `area` VALUES ('152501', '1525', '二连浩特市', '3', '803', '1');
INSERT INTO `area` VALUES ('152502', '1525', '锡林浩特市', '3', '804', '1');
INSERT INTO `area` VALUES ('152522', '1525', '阿巴嘎旗', '3', '805', '1');
INSERT INTO `area` VALUES ('152523', '1525', '苏尼特左旗', '3', '806', '1');
INSERT INTO `area` VALUES ('152524', '1525', '苏尼特右旗', '3', '807', '1');
INSERT INTO `area` VALUES ('152525', '1525', '东乌珠穆沁旗', '3', '808', '1');
INSERT INTO `area` VALUES ('152526', '1525', '西乌珠穆沁旗', '3', '809', '1');
INSERT INTO `area` VALUES ('152527', '1525', '太仆寺旗', '3', '810', '1');
INSERT INTO `area` VALUES ('152528', '1525', '镶黄旗', '3', '811', '1');
INSERT INTO `area` VALUES ('152529', '1525', '正镶白旗', '3', '812', '1');
INSERT INTO `area` VALUES ('152530', '1525', '正蓝旗', '3', '813', '1');
INSERT INTO `area` VALUES ('152531', '1525', '多伦县', '3', '814', '1');
INSERT INTO `area` VALUES ('152601', '1526', '集宁市', '3', '815', '1');
INSERT INTO `area` VALUES ('152602', '1526', '丰镇市', '3', '816', '1');
INSERT INTO `area` VALUES ('152624', '1526', '卓资县', '3', '817', '1');
INSERT INTO `area` VALUES ('152625', '1526', '化德县', '3', '818', '1');
INSERT INTO `area` VALUES ('152626', '1526', '商都县', '3', '819', '1');
INSERT INTO `area` VALUES ('152627', '1526', '兴和县', '3', '820', '1');
INSERT INTO `area` VALUES ('152629', '1526', '凉城县', '3', '821', '1');
INSERT INTO `area` VALUES ('152630', '1526', '察哈尔右翼前旗', '3', '822', '1');
INSERT INTO `area` VALUES ('152631', '1526', '察哈尔右翼中旗', '3', '823', '1');
INSERT INTO `area` VALUES ('152632', '1526', '察哈尔右翼后旗', '3', '824', '1');
INSERT INTO `area` VALUES ('152634', '1526', '四子王旗', '3', '825', '1');
INSERT INTO `area` VALUES ('152701', '1527', '东胜市', '3', '826', '1');
INSERT INTO `area` VALUES ('152722', '1527', '达拉特旗', '3', '827', '1');
INSERT INTO `area` VALUES ('152723', '1527', '准格尔旗', '3', '828', '1');
INSERT INTO `area` VALUES ('152724', '1527', '鄂托克前旗', '3', '829', '1');
INSERT INTO `area` VALUES ('152725', '1527', '鄂托克旗', '3', '830', '1');
INSERT INTO `area` VALUES ('152726', '1527', '杭锦旗', '3', '831', '1');
INSERT INTO `area` VALUES ('152727', '1527', '乌审旗', '3', '832', '1');
INSERT INTO `area` VALUES ('152728', '1527', '伊金霍洛旗', '3', '833', '1');
INSERT INTO `area` VALUES ('152801', '1528', '临河市', '3', '834', '1');
INSERT INTO `area` VALUES ('152822', '1528', '五原县', '3', '835', '1');
INSERT INTO `area` VALUES ('152823', '1528', '磴口县', '3', '836', '1');
INSERT INTO `area` VALUES ('152824', '1528', '乌拉特前旗', '3', '837', '1');
INSERT INTO `area` VALUES ('152825', '1528', '乌拉特中旗', '3', '838', '1');
INSERT INTO `area` VALUES ('152826', '1528', '乌拉特后旗', '3', '839', '1');
INSERT INTO `area` VALUES ('152827', '1528', '杭锦后旗', '3', '840', '1');
INSERT INTO `area` VALUES ('152921', '1529', '阿拉善左旗', '3', '841', '1');
INSERT INTO `area` VALUES ('152922', '1529', '阿拉善右旗', '3', '842', '1');
INSERT INTO `area` VALUES ('152923', '1529', '额济纳旗', '3', '843', '1');
INSERT INTO `area` VALUES ('210101', '2101', '市辖区', '3', '844', '1');
INSERT INTO `area` VALUES ('210102', '2101', '和平区', '3', '845', '1');
INSERT INTO `area` VALUES ('210103', '2101', '沈河区', '3', '846', '1');
INSERT INTO `area` VALUES ('210104', '2101', '大东区', '3', '847', '1');
INSERT INTO `area` VALUES ('210105', '2101', '皇姑区', '3', '848', '1');
INSERT INTO `area` VALUES ('210106', '2101', '铁西区', '3', '849', '1');
INSERT INTO `area` VALUES ('210111', '2101', '苏家屯区', '3', '850', '1');
INSERT INTO `area` VALUES ('210112', '2101', '东陵区', '3', '851', '1');
INSERT INTO `area` VALUES ('210113', '2101', '新城子区', '3', '852', '1');
INSERT INTO `area` VALUES ('210114', '2101', '于洪区', '3', '853', '1');
INSERT INTO `area` VALUES ('210122', '2101', '辽中县', '3', '854', '1');
INSERT INTO `area` VALUES ('210123', '2101', '康平县', '3', '855', '1');
INSERT INTO `area` VALUES ('210124', '2101', '法库县', '3', '856', '1');
INSERT INTO `area` VALUES ('210181', '2101', '新民市', '3', '857', '1');
INSERT INTO `area` VALUES ('210201', '2102', '市辖区', '3', '858', '1');
INSERT INTO `area` VALUES ('210202', '2102', '中山区', '3', '859', '1');
INSERT INTO `area` VALUES ('210203', '2102', '西岗区', '3', '860', '1');
INSERT INTO `area` VALUES ('210204', '2102', '沙河口区', '3', '861', '1');
INSERT INTO `area` VALUES ('210211', '2102', '甘井子区', '3', '862', '1');
INSERT INTO `area` VALUES ('210212', '2102', '旅顺口区', '3', '863', '1');
INSERT INTO `area` VALUES ('210213', '2102', '金州区', '3', '864', '1');
INSERT INTO `area` VALUES ('210224', '2102', '长海县', '3', '865', '1');
INSERT INTO `area` VALUES ('210281', '2102', '瓦房店市', '3', '866', '1');
INSERT INTO `area` VALUES ('210282', '2102', '普兰店市', '3', '867', '1');
INSERT INTO `area` VALUES ('210283', '2102', '庄河市', '3', '868', '1');
INSERT INTO `area` VALUES ('210301', '2103', '市辖区', '3', '869', '1');
INSERT INTO `area` VALUES ('210302', '2103', '铁东区', '3', '870', '1');
INSERT INTO `area` VALUES ('210303', '2103', '铁西区', '3', '871', '1');
INSERT INTO `area` VALUES ('210304', '2103', '立山区', '3', '872', '1');
INSERT INTO `area` VALUES ('210311', '2103', '千山区', '3', '873', '1');
INSERT INTO `area` VALUES ('210321', '2103', '台安县', '3', '874', '1');
INSERT INTO `area` VALUES ('210323', '2103', '岫岩满族自治县', '3', '875', '1');
INSERT INTO `area` VALUES ('210381', '2103', '海城市', '3', '876', '1');
INSERT INTO `area` VALUES ('210401', '2104', '市辖区', '3', '877', '1');
INSERT INTO `area` VALUES ('210402', '2104', '新抚区', '3', '878', '1');
INSERT INTO `area` VALUES ('210403', '2104', '东洲区', '3', '879', '1');
INSERT INTO `area` VALUES ('210404', '2104', '望花区', '3', '880', '1');
INSERT INTO `area` VALUES ('210411', '2104', '顺城区', '3', '881', '1');
INSERT INTO `area` VALUES ('210421', '2104', '抚顺县', '3', '882', '1');
INSERT INTO `area` VALUES ('210422', '2104', '新宾满族自治县', '3', '883', '1');
INSERT INTO `area` VALUES ('210423', '2104', '清原满族自治县', '3', '884', '1');
INSERT INTO `area` VALUES ('210501', '2105', '市辖区', '3', '885', '1');
INSERT INTO `area` VALUES ('210502', '2105', '平山区', '3', '886', '1');
INSERT INTO `area` VALUES ('210503', '2105', '溪湖区', '3', '887', '1');
INSERT INTO `area` VALUES ('210504', '2105', '明山区', '3', '888', '1');
INSERT INTO `area` VALUES ('210505', '2105', '南芬区', '3', '889', '1');
INSERT INTO `area` VALUES ('210521', '2105', '本溪满族自治县', '3', '890', '1');
INSERT INTO `area` VALUES ('210522', '2105', '桓仁满族自治县', '3', '891', '1');
INSERT INTO `area` VALUES ('210601', '2106', '市辖区', '3', '892', '1');
INSERT INTO `area` VALUES ('210602', '2106', '元宝区', '3', '893', '1');
INSERT INTO `area` VALUES ('210603', '2106', '振兴区', '3', '894', '1');
INSERT INTO `area` VALUES ('210604', '2106', '振安区', '3', '895', '1');
INSERT INTO `area` VALUES ('210624', '2106', '宽甸满族自治县', '3', '896', '1');
INSERT INTO `area` VALUES ('210681', '2106', '东港市', '3', '897', '1');
INSERT INTO `area` VALUES ('210682', '2106', '凤城市', '3', '898', '1');
INSERT INTO `area` VALUES ('210701', '2107', '市辖区', '3', '899', '1');
INSERT INTO `area` VALUES ('210702', '2107', '古塔区', '3', '900', '1');
INSERT INTO `area` VALUES ('210703', '2107', '凌河区', '3', '901', '1');
INSERT INTO `area` VALUES ('210711', '2107', '太和区', '3', '902', '1');
INSERT INTO `area` VALUES ('210726', '2107', '黑山县', '3', '903', '1');
INSERT INTO `area` VALUES ('210727', '2107', '义  县', '3', '904', '1');
INSERT INTO `area` VALUES ('210781', '2107', '凌海市', '3', '905', '1');
INSERT INTO `area` VALUES ('210782', '2107', '北宁市', '3', '906', '1');
INSERT INTO `area` VALUES ('210801', '2108', '市辖区', '3', '907', '1');
INSERT INTO `area` VALUES ('210802', '2108', '站前区', '3', '908', '1');
INSERT INTO `area` VALUES ('210803', '2108', '西市区', '3', '909', '1');
INSERT INTO `area` VALUES ('210804', '2108', '鲅鱼圈区', '3', '910', '1');
INSERT INTO `area` VALUES ('210811', '2108', '老边区', '3', '911', '1');
INSERT INTO `area` VALUES ('210881', '2108', '盖州市', '3', '912', '1');
INSERT INTO `area` VALUES ('210882', '2108', '大石桥市', '3', '913', '1');
INSERT INTO `area` VALUES ('210901', '2109', '市辖区', '3', '914', '1');
INSERT INTO `area` VALUES ('210902', '2109', '海州区', '3', '915', '1');
INSERT INTO `area` VALUES ('210903', '2109', '新邱区', '3', '916', '1');
INSERT INTO `area` VALUES ('210904', '2109', '太平区', '3', '917', '1');
INSERT INTO `area` VALUES ('210905', '2109', '清河门区', '3', '918', '1');
INSERT INTO `area` VALUES ('210911', '2109', '细河区', '3', '919', '1');
INSERT INTO `area` VALUES ('210921', '2109', '阜新蒙古族自治县', '3', '920', '1');
INSERT INTO `area` VALUES ('210922', '2109', '彰武县', '3', '921', '1');
INSERT INTO `area` VALUES ('211001', '2110', '市辖区', '3', '922', '1');
INSERT INTO `area` VALUES ('211002', '2110', '白塔区', '3', '923', '1');
INSERT INTO `area` VALUES ('211003', '2110', '文圣区', '3', '924', '1');
INSERT INTO `area` VALUES ('211004', '2110', '宏伟区', '3', '925', '1');
INSERT INTO `area` VALUES ('211005', '2110', '弓长岭区', '3', '926', '1');
INSERT INTO `area` VALUES ('211011', '2110', '太子河区', '3', '927', '1');
INSERT INTO `area` VALUES ('211021', '2110', '辽阳县', '3', '928', '1');
INSERT INTO `area` VALUES ('211081', '2110', '灯塔市', '3', '929', '1');
INSERT INTO `area` VALUES ('211101', '2111', '市辖区', '3', '930', '1');
INSERT INTO `area` VALUES ('211102', '2111', '双台子区', '3', '931', '1');
INSERT INTO `area` VALUES ('211103', '2111', '兴隆台区', '3', '932', '1');
INSERT INTO `area` VALUES ('211121', '2111', '大洼县', '3', '933', '1');
INSERT INTO `area` VALUES ('211122', '2111', '盘山县', '3', '934', '1');
INSERT INTO `area` VALUES ('211201', '2112', '市辖区', '3', '935', '1');
INSERT INTO `area` VALUES ('211202', '2112', '银州区', '3', '936', '1');
INSERT INTO `area` VALUES ('211204', '2112', '清河区', '3', '937', '1');
INSERT INTO `area` VALUES ('211221', '2112', '铁岭县', '3', '938', '1');
INSERT INTO `area` VALUES ('211223', '2112', '西丰县', '3', '939', '1');
INSERT INTO `area` VALUES ('211224', '2112', '昌图县', '3', '940', '1');
INSERT INTO `area` VALUES ('211281', '2112', '铁法市', '3', '941', '1');
INSERT INTO `area` VALUES ('211282', '2112', '开原市', '3', '942', '1');
INSERT INTO `area` VALUES ('211301', '2113', '市辖区', '3', '943', '1');
INSERT INTO `area` VALUES ('211302', '2113', '双塔区', '3', '944', '1');
INSERT INTO `area` VALUES ('211303', '2113', '龙城区', '3', '945', '1');
INSERT INTO `area` VALUES ('211321', '2113', '朝阳县', '3', '946', '1');
INSERT INTO `area` VALUES ('211322', '2113', '建平县', '3', '947', '1');
INSERT INTO `area` VALUES ('211324', '2113', '喀喇沁左翼蒙古族自治', '3', '948', '1');
INSERT INTO `area` VALUES ('211381', '2113', '北票市', '3', '949', '1');
INSERT INTO `area` VALUES ('211382', '2113', '凌源市', '3', '950', '1');
INSERT INTO `area` VALUES ('211401', '2114', '市辖区', '3', '951', '1');
INSERT INTO `area` VALUES ('211402', '2114', '连山区', '3', '952', '1');
INSERT INTO `area` VALUES ('211403', '2114', '龙港区', '3', '953', '1');
INSERT INTO `area` VALUES ('211404', '2114', '南票区', '3', '954', '1');
INSERT INTO `area` VALUES ('211421', '2114', '绥中县', '3', '955', '1');
INSERT INTO `area` VALUES ('211422', '2114', '建昌县', '3', '956', '1');
INSERT INTO `area` VALUES ('211481', '2114', '兴城市', '3', '957', '1');
INSERT INTO `area` VALUES ('220101', '2201', '市辖区', '3', '958', '1');
INSERT INTO `area` VALUES ('220102', '2201', '南关区', '3', '959', '1');
INSERT INTO `area` VALUES ('220103', '2201', '宽城区', '3', '960', '1');
INSERT INTO `area` VALUES ('220104', '2201', '朝阳区', '3', '961', '1');
INSERT INTO `area` VALUES ('220105', '2201', '二道区', '3', '962', '1');
INSERT INTO `area` VALUES ('220106', '2201', '绿园区', '3', '963', '1');
INSERT INTO `area` VALUES ('220112', '2201', '双阳区', '3', '964', '1');
INSERT INTO `area` VALUES ('220122', '2201', '农安县', '3', '965', '1');
INSERT INTO `area` VALUES ('220181', '2201', '九台市', '3', '966', '1');
INSERT INTO `area` VALUES ('220182', '2201', '榆树市', '3', '967', '1');
INSERT INTO `area` VALUES ('220183', '2201', '德惠市', '3', '968', '1');
INSERT INTO `area` VALUES ('220201', '2202', '市辖区', '3', '969', '1');
INSERT INTO `area` VALUES ('220202', '2202', '昌邑区', '3', '970', '1');
INSERT INTO `area` VALUES ('220203', '2202', '龙潭区', '3', '971', '1');
INSERT INTO `area` VALUES ('220204', '2202', '船营区', '3', '972', '1');
INSERT INTO `area` VALUES ('220211', '2202', '丰满区', '3', '973', '1');
INSERT INTO `area` VALUES ('220221', '2202', '永吉县', '3', '974', '1');
INSERT INTO `area` VALUES ('220281', '2202', '蛟河市', '3', '975', '1');
INSERT INTO `area` VALUES ('220282', '2202', '桦甸市', '3', '976', '1');
INSERT INTO `area` VALUES ('220283', '2202', '舒兰市', '3', '977', '1');
INSERT INTO `area` VALUES ('220284', '2202', '磐石市', '3', '978', '1');
INSERT INTO `area` VALUES ('220301', '2203', '市辖区', '3', '979', '1');
INSERT INTO `area` VALUES ('220302', '2203', '铁西区', '3', '980', '1');
INSERT INTO `area` VALUES ('220303', '2203', '铁东区', '3', '981', '1');
INSERT INTO `area` VALUES ('220322', '2203', '梨树县', '3', '982', '1');
INSERT INTO `area` VALUES ('220323', '2203', '伊通满族自治县', '3', '983', '1');
INSERT INTO `area` VALUES ('220381', '2203', '公主岭市', '3', '984', '1');
INSERT INTO `area` VALUES ('220382', '2203', '双辽市', '3', '985', '1');
INSERT INTO `area` VALUES ('220401', '2204', '市辖区', '3', '986', '1');
INSERT INTO `area` VALUES ('220402', '2204', '龙山区', '3', '987', '1');
INSERT INTO `area` VALUES ('220403', '2204', '西安区', '3', '988', '1');
INSERT INTO `area` VALUES ('220421', '2204', '东丰县', '3', '989', '1');
INSERT INTO `area` VALUES ('220422', '2204', '东辽县', '3', '990', '1');
INSERT INTO `area` VALUES ('220501', '2205', '市辖区', '3', '991', '1');
INSERT INTO `area` VALUES ('220502', '2205', '东昌区', '3', '992', '1');
INSERT INTO `area` VALUES ('220503', '2205', '二道江区', '3', '993', '1');
INSERT INTO `area` VALUES ('220521', '2205', '通化县', '3', '994', '1');
INSERT INTO `area` VALUES ('220523', '2205', '辉南县', '3', '995', '1');
INSERT INTO `area` VALUES ('220524', '2205', '柳河县', '3', '996', '1');
INSERT INTO `area` VALUES ('220581', '2205', '梅河口市', '3', '997', '1');
INSERT INTO `area` VALUES ('220582', '2205', '集安市', '3', '998', '1');
INSERT INTO `area` VALUES ('220601', '2206', '市辖区', '3', '999', '1');
INSERT INTO `area` VALUES ('220602', '2206', '八道江区', '3', '1000', '1');
INSERT INTO `area` VALUES ('220621', '2206', '抚松县', '3', '1001', '1');
INSERT INTO `area` VALUES ('220622', '2206', '靖宇县', '3', '1002', '1');
INSERT INTO `area` VALUES ('220623', '2206', '长白朝鲜族自治县', '3', '1003', '1');
INSERT INTO `area` VALUES ('220625', '2206', '江源县', '3', '1004', '1');
INSERT INTO `area` VALUES ('220681', '2206', '临江市', '3', '1005', '1');
INSERT INTO `area` VALUES ('220701', '2207', '市辖区', '3', '1006', '1');
INSERT INTO `area` VALUES ('220702', '2207', '宁江区', '3', '1007', '1');
INSERT INTO `area` VALUES ('220721', '2207', '前郭尔罗斯蒙古族自治', '3', '1008', '1');
INSERT INTO `area` VALUES ('220722', '2207', '长岭县', '3', '1009', '1');
INSERT INTO `area` VALUES ('220723', '2207', '乾安县', '3', '1010', '1');
INSERT INTO `area` VALUES ('220724', '2207', '扶余县', '3', '1011', '1');
INSERT INTO `area` VALUES ('220801', '2208', '市辖区', '3', '1012', '1');
INSERT INTO `area` VALUES ('220802', '2208', '洮北区', '3', '1013', '1');
INSERT INTO `area` VALUES ('220821', '2208', '镇赉县', '3', '1014', '1');
INSERT INTO `area` VALUES ('220822', '2208', '通榆县', '3', '1015', '1');
INSERT INTO `area` VALUES ('220881', '2208', '洮南市', '3', '1016', '1');
INSERT INTO `area` VALUES ('220882', '2208', '大安市', '3', '1017', '1');
INSERT INTO `area` VALUES ('222401', '2224', '延吉市', '3', '1018', '1');
INSERT INTO `area` VALUES ('222402', '2224', '图们市', '3', '1019', '1');
INSERT INTO `area` VALUES ('222403', '2224', '敦化市', '3', '1020', '1');
INSERT INTO `area` VALUES ('222404', '2224', '珲春市', '3', '1021', '1');
INSERT INTO `area` VALUES ('222405', '2224', '龙井市', '3', '1022', '1');
INSERT INTO `area` VALUES ('222406', '2224', '和龙市', '3', '1023', '1');
INSERT INTO `area` VALUES ('222424', '2224', '汪清县', '3', '1024', '1');
INSERT INTO `area` VALUES ('222426', '2224', '安图县', '3', '1025', '1');
INSERT INTO `area` VALUES ('230101', '2301', '市辖区', '3', '1026', '1');
INSERT INTO `area` VALUES ('230102', '2301', '道里区', '3', '1027', '1');
INSERT INTO `area` VALUES ('230103', '2301', '南岗区', '3', '1028', '1');
INSERT INTO `area` VALUES ('230104', '2301', '道外区', '3', '1029', '1');
INSERT INTO `area` VALUES ('230105', '2301', '太平区', '3', '1030', '1');
INSERT INTO `area` VALUES ('230106', '2301', '香坊区', '3', '1031', '1');
INSERT INTO `area` VALUES ('230107', '2301', '动力区', '3', '1032', '1');
INSERT INTO `area` VALUES ('230108', '2301', '平房区', '3', '1033', '1');
INSERT INTO `area` VALUES ('230121', '2301', '呼兰县', '3', '1034', '1');
INSERT INTO `area` VALUES ('230123', '2301', '依兰县', '3', '1035', '1');
INSERT INTO `area` VALUES ('230124', '2301', '方正县', '3', '1036', '1');
INSERT INTO `area` VALUES ('230125', '2301', '宾  县', '3', '1037', '1');
INSERT INTO `area` VALUES ('230126', '2301', '巴彦县', '3', '1038', '1');
INSERT INTO `area` VALUES ('230127', '2301', '木兰县', '3', '1039', '1');
INSERT INTO `area` VALUES ('230128', '2301', '通河县', '3', '1040', '1');
INSERT INTO `area` VALUES ('230129', '2301', '延寿县', '3', '1041', '1');
INSERT INTO `area` VALUES ('230181', '2301', '阿城市', '3', '1042', '1');
INSERT INTO `area` VALUES ('230182', '2301', '双城市', '3', '1043', '1');
INSERT INTO `area` VALUES ('230183', '2301', '尚志市', '3', '1044', '1');
INSERT INTO `area` VALUES ('230184', '2301', '五常市', '3', '1045', '1');
INSERT INTO `area` VALUES ('230201', '2302', '市辖区', '3', '1046', '1');
INSERT INTO `area` VALUES ('230202', '2302', '龙沙区', '3', '1047', '1');
INSERT INTO `area` VALUES ('230203', '2302', '建华区', '3', '1048', '1');
INSERT INTO `area` VALUES ('230204', '2302', '铁锋区', '3', '1049', '1');
INSERT INTO `area` VALUES ('230205', '2302', '昂昂溪区', '3', '1050', '1');
INSERT INTO `area` VALUES ('230206', '2302', '富拉尔基区', '3', '1051', '1');
INSERT INTO `area` VALUES ('230207', '2302', '碾子山区', '3', '1052', '1');
INSERT INTO `area` VALUES ('230208', '2302', '梅里斯达斡尔族区', '3', '1053', '1');
INSERT INTO `area` VALUES ('230221', '2302', '龙江县', '3', '1054', '1');
INSERT INTO `area` VALUES ('230223', '2302', '依安县', '3', '1055', '1');
INSERT INTO `area` VALUES ('230224', '2302', '泰来县', '3', '1056', '1');
INSERT INTO `area` VALUES ('230225', '2302', '甘南县', '3', '1057', '1');
INSERT INTO `area` VALUES ('230227', '2302', '富裕县', '3', '1058', '1');
INSERT INTO `area` VALUES ('230229', '2302', '克山县', '3', '1059', '1');
INSERT INTO `area` VALUES ('230230', '2302', '克东县', '3', '1060', '1');
INSERT INTO `area` VALUES ('230231', '2302', '拜泉县', '3', '1061', '1');
INSERT INTO `area` VALUES ('230281', '2302', '讷河市', '3', '1062', '1');
INSERT INTO `area` VALUES ('230301', '2303', '市辖区', '3', '1063', '1');
INSERT INTO `area` VALUES ('230302', '2303', '鸡冠区', '3', '1064', '1');
INSERT INTO `area` VALUES ('230303', '2303', '恒山区', '3', '1065', '1');
INSERT INTO `area` VALUES ('230304', '2303', '滴道区', '3', '1066', '1');
INSERT INTO `area` VALUES ('230305', '2303', '梨树区', '3', '1067', '1');
INSERT INTO `area` VALUES ('230306', '2303', '城子河区', '3', '1068', '1');
INSERT INTO `area` VALUES ('230307', '2303', '麻山区', '3', '1069', '1');
INSERT INTO `area` VALUES ('230321', '2303', '鸡东县', '3', '1070', '1');
INSERT INTO `area` VALUES ('230381', '2303', '虎林市', '3', '1071', '1');
INSERT INTO `area` VALUES ('230382', '2303', '密山市', '3', '1072', '1');
INSERT INTO `area` VALUES ('230401', '2304', '市辖区', '3', '1073', '1');
INSERT INTO `area` VALUES ('230402', '2304', '向阳区', '3', '1074', '1');
INSERT INTO `area` VALUES ('230403', '2304', '工农区', '3', '1075', '1');
INSERT INTO `area` VALUES ('230404', '2304', '南山区', '3', '1076', '1');
INSERT INTO `area` VALUES ('230405', '2304', '兴安区', '3', '1077', '1');
INSERT INTO `area` VALUES ('230406', '2304', '东山区', '3', '1078', '1');
INSERT INTO `area` VALUES ('230407', '2304', '兴山区', '3', '1079', '1');
INSERT INTO `area` VALUES ('230421', '2304', '萝北县', '3', '1080', '1');
INSERT INTO `area` VALUES ('230422', '2304', '绥滨县', '3', '1081', '1');
INSERT INTO `area` VALUES ('230501', '2305', '市辖区', '3', '1082', '1');
INSERT INTO `area` VALUES ('230502', '2305', '尖山区', '3', '1083', '1');
INSERT INTO `area` VALUES ('230503', '2305', '岭东区', '3', '1084', '1');
INSERT INTO `area` VALUES ('230505', '2305', '四方台区', '3', '1085', '1');
INSERT INTO `area` VALUES ('230506', '2305', '宝山区', '3', '1086', '1');
INSERT INTO `area` VALUES ('230521', '2305', '集贤县', '3', '1087', '1');
INSERT INTO `area` VALUES ('230522', '2305', '友谊县', '3', '1088', '1');
INSERT INTO `area` VALUES ('230523', '2305', '宝清县', '3', '1089', '1');
INSERT INTO `area` VALUES ('230524', '2305', '饶河县', '3', '1090', '1');
INSERT INTO `area` VALUES ('230601', '2306', '市辖区', '3', '1091', '1');
INSERT INTO `area` VALUES ('230602', '2306', '萨尔图区', '3', '1092', '1');
INSERT INTO `area` VALUES ('230603', '2306', '龙凤区', '3', '1093', '1');
INSERT INTO `area` VALUES ('230604', '2306', '让胡路区', '3', '1094', '1');
INSERT INTO `area` VALUES ('230605', '2306', '红岗区', '3', '1095', '1');
INSERT INTO `area` VALUES ('230606', '2306', '大同区', '3', '1096', '1');
INSERT INTO `area` VALUES ('230621', '2306', '肇州县', '3', '1097', '1');
INSERT INTO `area` VALUES ('230622', '2306', '肇源县', '3', '1098', '1');
INSERT INTO `area` VALUES ('230623', '2306', '林甸县', '3', '1099', '1');
INSERT INTO `area` VALUES ('230624', '2306', '杜尔伯特蒙古族自治县', '3', '1100', '1');
INSERT INTO `area` VALUES ('230701', '2307', '市辖区', '3', '1101', '1');
INSERT INTO `area` VALUES ('230702', '2307', '伊春区', '3', '1102', '1');
INSERT INTO `area` VALUES ('230703', '2307', '南岔区', '3', '1103', '1');
INSERT INTO `area` VALUES ('230704', '2307', '友好区', '3', '1104', '1');
INSERT INTO `area` VALUES ('230705', '2307', '西林区', '3', '1105', '1');
INSERT INTO `area` VALUES ('230706', '2307', '翠峦区', '3', '1106', '1');
INSERT INTO `area` VALUES ('230707', '2307', '新青区', '3', '1107', '1');
INSERT INTO `area` VALUES ('230708', '2307', '美溪区', '3', '1108', '1');
INSERT INTO `area` VALUES ('230709', '2307', '金山屯区', '3', '1109', '1');
INSERT INTO `area` VALUES ('230710', '2307', '五营区', '3', '1110', '1');
INSERT INTO `area` VALUES ('230711', '2307', '乌马河区', '3', '1111', '1');
INSERT INTO `area` VALUES ('230712', '2307', '汤旺河区', '3', '1112', '1');
INSERT INTO `area` VALUES ('230713', '2307', '带岭区', '3', '1113', '1');
INSERT INTO `area` VALUES ('230714', '2307', '乌伊岭区', '3', '1114', '1');
INSERT INTO `area` VALUES ('230715', '2307', '红星区', '3', '1115', '1');
INSERT INTO `area` VALUES ('230716', '2307', '上甘岭区', '3', '1116', '1');
INSERT INTO `area` VALUES ('230722', '2307', '嘉荫县', '3', '1117', '1');
INSERT INTO `area` VALUES ('230781', '2307', '铁力市', '3', '1118', '1');
INSERT INTO `area` VALUES ('230801', '2308', '市辖区', '3', '1119', '1');
INSERT INTO `area` VALUES ('230802', '2308', '永红区', '3', '1120', '1');
INSERT INTO `area` VALUES ('230803', '2308', '向阳区', '3', '1121', '1');
INSERT INTO `area` VALUES ('230804', '2308', '前进区', '3', '1122', '1');
INSERT INTO `area` VALUES ('230805', '2308', '东风区', '3', '1123', '1');
INSERT INTO `area` VALUES ('230811', '2308', '郊  区', '3', '1124', '1');
INSERT INTO `area` VALUES ('230822', '2308', '桦南县', '3', '1125', '1');
INSERT INTO `area` VALUES ('230826', '2308', '桦川县', '3', '1126', '1');
INSERT INTO `area` VALUES ('230828', '2308', '汤原县', '3', '1127', '1');
INSERT INTO `area` VALUES ('230833', '2308', '抚远县', '3', '1128', '1');
INSERT INTO `area` VALUES ('230881', '2308', '同江市', '3', '1129', '1');
INSERT INTO `area` VALUES ('230882', '2308', '富锦市', '3', '1130', '1');
INSERT INTO `area` VALUES ('230901', '2309', '市辖区', '3', '1131', '1');
INSERT INTO `area` VALUES ('230902', '2309', '新兴区', '3', '1132', '1');
INSERT INTO `area` VALUES ('230903', '2309', '桃山区', '3', '1133', '1');
INSERT INTO `area` VALUES ('230904', '2309', '茄子河区', '3', '1134', '1');
INSERT INTO `area` VALUES ('230921', '2309', '勃利县', '3', '1135', '1');
INSERT INTO `area` VALUES ('231001', '2310', '市辖区', '3', '1136', '1');
INSERT INTO `area` VALUES ('231002', '2310', '东安区', '3', '1137', '1');
INSERT INTO `area` VALUES ('231003', '2310', '阳明区', '3', '1138', '1');
INSERT INTO `area` VALUES ('231004', '2310', '爱民区', '3', '1139', '1');
INSERT INTO `area` VALUES ('231005', '2310', '西安区', '3', '1140', '1');
INSERT INTO `area` VALUES ('231024', '2310', '东宁县', '3', '1141', '1');
INSERT INTO `area` VALUES ('231025', '2310', '林口县', '3', '1142', '1');
INSERT INTO `area` VALUES ('231081', '2310', '绥芬河市', '3', '1143', '1');
INSERT INTO `area` VALUES ('231083', '2310', '海林市', '3', '1144', '1');
INSERT INTO `area` VALUES ('231084', '2310', '宁安市', '3', '1145', '1');
INSERT INTO `area` VALUES ('231085', '2310', '穆棱市', '3', '1146', '1');
INSERT INTO `area` VALUES ('231101', '2311', '市辖区', '3', '1147', '1');
INSERT INTO `area` VALUES ('231102', '2311', '爱辉区', '3', '1148', '1');
INSERT INTO `area` VALUES ('231121', '2311', '嫩江县', '3', '1149', '1');
INSERT INTO `area` VALUES ('231123', '2311', '逊克县', '3', '1150', '1');
INSERT INTO `area` VALUES ('231124', '2311', '孙吴县', '3', '1151', '1');
INSERT INTO `area` VALUES ('231181', '2311', '北安市', '3', '1152', '1');
INSERT INTO `area` VALUES ('231182', '2311', '五大连池市', '3', '1153', '1');
INSERT INTO `area` VALUES ('231201', '2312', '市辖区', '3', '1154', '1');
INSERT INTO `area` VALUES ('231202', '2312', '北林区', '3', '1155', '1');
INSERT INTO `area` VALUES ('231221', '2312', '望奎县', '3', '1156', '1');
INSERT INTO `area` VALUES ('231222', '2312', '兰西县', '3', '1157', '1');
INSERT INTO `area` VALUES ('231223', '2312', '青冈县', '3', '1158', '1');
INSERT INTO `area` VALUES ('231224', '2312', '庆安县', '3', '1159', '1');
INSERT INTO `area` VALUES ('231225', '2312', '明水县', '3', '1160', '1');
INSERT INTO `area` VALUES ('231226', '2312', '绥棱县', '3', '1161', '1');
INSERT INTO `area` VALUES ('231281', '2312', '安达市', '3', '1162', '1');
INSERT INTO `area` VALUES ('231282', '2312', '肇东市', '3', '1163', '1');
INSERT INTO `area` VALUES ('231283', '2312', '海伦市', '3', '1164', '1');
INSERT INTO `area` VALUES ('232721', '2327', '呼玛县', '3', '1165', '1');
INSERT INTO `area` VALUES ('232722', '2327', '塔河县', '3', '1166', '1');
INSERT INTO `area` VALUES ('232723', '2327', '漠河县', '3', '1167', '1');
INSERT INTO `area` VALUES ('310101', '3101', '黄浦区', '3', '1168', '1');
INSERT INTO `area` VALUES ('310103', '3101', '卢湾区', '3', '1169', '1');
INSERT INTO `area` VALUES ('310104', '3101', '徐汇区', '3', '1170', '1');
INSERT INTO `area` VALUES ('310105', '3101', '长宁区', '3', '1171', '1');
INSERT INTO `area` VALUES ('310106', '3101', '静安区', '3', '1172', '1');
INSERT INTO `area` VALUES ('310107', '3101', '普陀区', '3', '1173', '1');
INSERT INTO `area` VALUES ('310108', '3101', '闸北区', '3', '1174', '1');
INSERT INTO `area` VALUES ('310109', '3101', '虹口区', '3', '1175', '1');
INSERT INTO `area` VALUES ('310110', '3101', '杨浦区', '3', '1176', '1');
INSERT INTO `area` VALUES ('310112', '3101', '闵行区', '3', '1177', '1');
INSERT INTO `area` VALUES ('310113', '3101', '宝山区', '3', '1178', '1');
INSERT INTO `area` VALUES ('310114', '3101', '嘉定区', '3', '1179', '1');
INSERT INTO `area` VALUES ('310115', '3101', '浦东新区', '3', '1180', '1');
INSERT INTO `area` VALUES ('310116', '3101', '金山区', '3', '1181', '1');
INSERT INTO `area` VALUES ('310117', '3101', '松江区', '3', '1182', '1');
INSERT INTO `area` VALUES ('310118', '3101', '青浦区', '3', '1183', '1');
INSERT INTO `area` VALUES ('310225', '3102', '南汇县', '3', '1184', '1');
INSERT INTO `area` VALUES ('310226', '3102', '奉贤县', '3', '1185', '1');
INSERT INTO `area` VALUES ('310230', '3102', '崇明县', '3', '1186', '1');
INSERT INTO `area` VALUES ('320101', '3201', '市辖区', '3', '1187', '1');
INSERT INTO `area` VALUES ('320102', '3201', '玄武区', '3', '1188', '1');
INSERT INTO `area` VALUES ('320103', '3201', '白下区', '3', '1189', '1');
INSERT INTO `area` VALUES ('320104', '3201', '秦淮区', '3', '1190', '1');
INSERT INTO `area` VALUES ('320105', '3201', '建邺区', '3', '1191', '1');
INSERT INTO `area` VALUES ('320106', '3201', '鼓楼区', '3', '1192', '1');
INSERT INTO `area` VALUES ('320107', '3201', '下关区', '3', '1193', '1');
INSERT INTO `area` VALUES ('320111', '3201', '浦口区', '3', '1194', '1');
INSERT INTO `area` VALUES ('320112', '3201', '大厂区', '3', '1195', '1');
INSERT INTO `area` VALUES ('320113', '3201', '栖霞区', '3', '1196', '1');
INSERT INTO `area` VALUES ('320114', '3201', '雨花台区', '3', '1197', '1');
INSERT INTO `area` VALUES ('320115', '3201', '江宁区', '3', '1198', '1');
INSERT INTO `area` VALUES ('320122', '3201', '江浦县', '3', '1199', '1');
INSERT INTO `area` VALUES ('320123', '3201', '六合县', '3', '1200', '1');
INSERT INTO `area` VALUES ('320124', '3201', '溧水县', '3', '1201', '1');
INSERT INTO `area` VALUES ('320125', '3201', '高淳县', '3', '1202', '1');
INSERT INTO `area` VALUES ('320201', '3202', '市辖区', '3', '1203', '1');
INSERT INTO `area` VALUES ('320202', '3202', '崇安区', '3', '1204', '1');
INSERT INTO `area` VALUES ('320203', '3202', '南长区', '3', '1205', '1');
INSERT INTO `area` VALUES ('320204', '3202', '北塘区', '3', '1206', '1');
INSERT INTO `area` VALUES ('320205', '3202', '锡山区', '3', '1207', '1');
INSERT INTO `area` VALUES ('320206', '3202', '惠山区', '3', '1208', '1');
INSERT INTO `area` VALUES ('320211', '3202', '滨湖区', '3', '1209', '1');
INSERT INTO `area` VALUES ('320281', '3202', '江阴市', '3', '1210', '1');
INSERT INTO `area` VALUES ('320282', '3202', '宜兴市', '3', '1211', '1');
INSERT INTO `area` VALUES ('320301', '3203', '市辖区', '3', '1212', '1');
INSERT INTO `area` VALUES ('320302', '3203', '鼓楼区', '3', '1213', '1');
INSERT INTO `area` VALUES ('320303', '3203', '云龙区', '3', '1214', '1');
INSERT INTO `area` VALUES ('320304', '3203', '九里区', '3', '1215', '1');
INSERT INTO `area` VALUES ('320305', '3203', '贾汪区', '3', '1216', '1');
INSERT INTO `area` VALUES ('320311', '3203', '泉山区', '3', '1217', '1');
INSERT INTO `area` VALUES ('320321', '3203', '丰  县', '3', '1218', '1');
INSERT INTO `area` VALUES ('320322', '3203', '沛  县', '3', '1219', '1');
INSERT INTO `area` VALUES ('320323', '3203', '铜山县', '3', '1220', '1');
INSERT INTO `area` VALUES ('320324', '3203', '睢宁县', '3', '1221', '1');
INSERT INTO `area` VALUES ('320381', '3203', '新沂市', '3', '1222', '1');
INSERT INTO `area` VALUES ('320382', '3203', '邳州市', '3', '1223', '1');
INSERT INTO `area` VALUES ('320401', '3204', '市辖区', '3', '1224', '1');
INSERT INTO `area` VALUES ('320402', '3204', '天宁区', '3', '1225', '1');
INSERT INTO `area` VALUES ('320404', '3204', '钟楼区', '3', '1226', '1');
INSERT INTO `area` VALUES ('320405', '3204', '戚墅堰区', '3', '1227', '1');
INSERT INTO `area` VALUES ('320411', '3204', '郊  区', '3', '1228', '1');
INSERT INTO `area` VALUES ('320481', '3204', '溧阳市', '3', '1229', '1');
INSERT INTO `area` VALUES ('320482', '3204', '金坛市', '3', '1230', '1');
INSERT INTO `area` VALUES ('320483', '3204', '武进市', '3', '1231', '1');
INSERT INTO `area` VALUES ('320501', '3205', '市辖区', '3', '1232', '1');
INSERT INTO `area` VALUES ('320502', '3205', '沧浪区', '3', '1233', '1');
INSERT INTO `area` VALUES ('320503', '3205', '平江区', '3', '1234', '1');
INSERT INTO `area` VALUES ('320504', '3205', '金阊区', '3', '1235', '1');
INSERT INTO `area` VALUES ('320505', '3205', '虎丘区', '3', '1236', '1');
INSERT INTO `area` VALUES ('320506', '3205', '吴中区', '3', '1237', '1');
INSERT INTO `area` VALUES ('320507', '3205', '相城区', '3', '1238', '1');
INSERT INTO `area` VALUES ('320581', '3205', '常熟市', '3', '1239', '1');
INSERT INTO `area` VALUES ('320582', '3205', '张家港市', '3', '1240', '1');
INSERT INTO `area` VALUES ('320583', '3205', '昆山市', '3', '1241', '1');
INSERT INTO `area` VALUES ('320584', '3205', '吴江市', '3', '1242', '1');
INSERT INTO `area` VALUES ('320585', '3205', '太仓市', '3', '1243', '1');
INSERT INTO `area` VALUES ('320601', '3206', '市辖区', '3', '1244', '1');
INSERT INTO `area` VALUES ('320602', '3206', '崇川区', '3', '1245', '1');
INSERT INTO `area` VALUES ('320611', '3206', '港闸区', '3', '1246', '1');
INSERT INTO `area` VALUES ('320621', '3206', '海安县', '3', '1247', '1');
INSERT INTO `area` VALUES ('320623', '3206', '如东县', '3', '1248', '1');
INSERT INTO `area` VALUES ('320681', '3206', '启东市', '3', '1249', '1');
INSERT INTO `area` VALUES ('320682', '3206', '如皋市', '3', '1250', '1');
INSERT INTO `area` VALUES ('320683', '3206', '通州市', '3', '1251', '1');
INSERT INTO `area` VALUES ('320684', '3206', '海门市', '3', '1252', '1');
INSERT INTO `area` VALUES ('320701', '3207', '市辖区', '3', '1253', '1');
INSERT INTO `area` VALUES ('320703', '3207', '连云区', '3', '1254', '1');
INSERT INTO `area` VALUES ('320704', '3207', '云台区', '3', '1255', '1');
INSERT INTO `area` VALUES ('320705', '3207', '新浦区', '3', '1256', '1');
INSERT INTO `area` VALUES ('320706', '3207', '海州区', '3', '1257', '1');
INSERT INTO `area` VALUES ('320721', '3207', '赣榆县', '3', '1258', '1');
INSERT INTO `area` VALUES ('320722', '3207', '东海县', '3', '1259', '1');
INSERT INTO `area` VALUES ('320723', '3207', '灌云县', '3', '1260', '1');
INSERT INTO `area` VALUES ('320724', '3207', '灌南县', '3', '1261', '1');
INSERT INTO `area` VALUES ('320801', '3208', '市辖区', '3', '1262', '1');
INSERT INTO `area` VALUES ('320802', '3208', '清河区', '3', '1263', '1');
INSERT INTO `area` VALUES ('320803', '3208', '楚州区', '3', '1264', '1');
INSERT INTO `area` VALUES ('320804', '3208', '淮阴区', '3', '1265', '1');
INSERT INTO `area` VALUES ('320811', '3208', '清浦区', '3', '1266', '1');
INSERT INTO `area` VALUES ('320826', '3208', '涟水县', '3', '1267', '1');
INSERT INTO `area` VALUES ('320829', '3208', '洪泽县', '3', '1268', '1');
INSERT INTO `area` VALUES ('320830', '3208', '盱眙县', '3', '1269', '1');
INSERT INTO `area` VALUES ('320831', '3208', '金湖县', '3', '1270', '1');
INSERT INTO `area` VALUES ('320901', '3209', '市辖区', '3', '1271', '1');
INSERT INTO `area` VALUES ('320902', '3209', '城  区', '3', '1272', '1');
INSERT INTO `area` VALUES ('320921', '3209', '响水县', '3', '1273', '1');
INSERT INTO `area` VALUES ('320922', '3209', '滨海县', '3', '1274', '1');
INSERT INTO `area` VALUES ('320923', '3209', '阜宁县', '3', '1275', '1');
INSERT INTO `area` VALUES ('320924', '3209', '射阳县', '3', '1276', '1');
INSERT INTO `area` VALUES ('320925', '3209', '建湖县', '3', '1277', '1');
INSERT INTO `area` VALUES ('320928', '3209', '盐都县', '3', '1278', '1');
INSERT INTO `area` VALUES ('320981', '3209', '东台市', '3', '1279', '1');
INSERT INTO `area` VALUES ('320982', '3209', '大丰市', '3', '1280', '1');
INSERT INTO `area` VALUES ('321001', '3210', '市辖区', '3', '1281', '1');
INSERT INTO `area` VALUES ('321002', '3210', '广陵区', '3', '1282', '1');
INSERT INTO `area` VALUES ('321003', '3210', '邗江区', '3', '1283', '1');
INSERT INTO `area` VALUES ('321011', '3210', '郊  区', '3', '1284', '1');
INSERT INTO `area` VALUES ('321023', '3210', '宝应县', '3', '1285', '1');
INSERT INTO `area` VALUES ('321081', '3210', '仪征市', '3', '1286', '1');
INSERT INTO `area` VALUES ('321084', '3210', '高邮市', '3', '1287', '1');
INSERT INTO `area` VALUES ('321088', '3210', '江都市', '3', '1288', '1');
INSERT INTO `area` VALUES ('321101', '3211', '市辖区', '3', '1289', '1');
INSERT INTO `area` VALUES ('321102', '3211', '京口区', '3', '1290', '1');
INSERT INTO `area` VALUES ('321111', '3211', '润州区', '3', '1291', '1');
INSERT INTO `area` VALUES ('321121', '3211', '丹徒县', '3', '1292', '1');
INSERT INTO `area` VALUES ('321181', '3211', '丹阳市', '3', '1293', '1');
INSERT INTO `area` VALUES ('321182', '3211', '扬中市', '3', '1294', '1');
INSERT INTO `area` VALUES ('321183', '3211', '句容市', '3', '1295', '1');
INSERT INTO `area` VALUES ('321201', '3212', '市辖区', '3', '1296', '1');
INSERT INTO `area` VALUES ('321202', '3212', '海陵区', '3', '1297', '1');
INSERT INTO `area` VALUES ('321203', '3212', '高港区', '3', '1298', '1');
INSERT INTO `area` VALUES ('321281', '3212', '兴化市', '3', '1299', '1');
INSERT INTO `area` VALUES ('321282', '3212', '靖江市', '3', '1300', '1');
INSERT INTO `area` VALUES ('321283', '3212', '泰兴市', '3', '1301', '1');
INSERT INTO `area` VALUES ('321284', '3212', '姜堰市', '3', '1302', '1');
INSERT INTO `area` VALUES ('321301', '3213', '市辖区', '3', '1303', '1');
INSERT INTO `area` VALUES ('321302', '3213', '宿城区', '3', '1304', '1');
INSERT INTO `area` VALUES ('321321', '3213', '宿豫县', '3', '1305', '1');
INSERT INTO `area` VALUES ('321322', '3213', '沭阳县', '3', '1306', '1');
INSERT INTO `area` VALUES ('321323', '3213', '泗阳县', '3', '1307', '1');
INSERT INTO `area` VALUES ('321324', '3213', '泗洪县', '3', '1308', '1');
INSERT INTO `area` VALUES ('330101', '3301', '市辖区', '3', '1309', '1');
INSERT INTO `area` VALUES ('330102', '3301', '上城区', '3', '1310', '1');
INSERT INTO `area` VALUES ('330103', '3301', '下城区', '3', '1311', '1');
INSERT INTO `area` VALUES ('330104', '3301', '江干区', '3', '1312', '1');
INSERT INTO `area` VALUES ('330105', '3301', '拱墅区', '3', '1313', '1');
INSERT INTO `area` VALUES ('330106', '3301', '西湖区', '3', '1314', '1');
INSERT INTO `area` VALUES ('330108', '3301', '滨江区', '3', '1315', '1');
INSERT INTO `area` VALUES ('330122', '3301', '桐庐县', '3', '1316', '1');
INSERT INTO `area` VALUES ('330127', '3301', '淳安县', '3', '1317', '1');
INSERT INTO `area` VALUES ('330181', '3301', '萧山市', '3', '1318', '1');
INSERT INTO `area` VALUES ('330182', '3301', '建德市', '3', '1319', '1');
INSERT INTO `area` VALUES ('330183', '3301', '富阳市', '3', '1320', '1');
INSERT INTO `area` VALUES ('330184', '3301', '余杭市', '3', '1321', '1');
INSERT INTO `area` VALUES ('330185', '3301', '临安市', '3', '1322', '1');
INSERT INTO `area` VALUES ('330201', '3302', '市辖区', '3', '1323', '1');
INSERT INTO `area` VALUES ('330203', '3302', '海曙区', '3', '1324', '1');
INSERT INTO `area` VALUES ('330204', '3302', '江东区', '3', '1325', '1');
INSERT INTO `area` VALUES ('330205', '3302', '江北区', '3', '1326', '1');
INSERT INTO `area` VALUES ('330206', '3302', '北仑区', '3', '1327', '1');
INSERT INTO `area` VALUES ('330211', '3302', '镇海区', '3', '1328', '1');
INSERT INTO `area` VALUES ('330225', '3302', '象山县', '3', '1329', '1');
INSERT INTO `area` VALUES ('330226', '3302', '宁海县', '3', '1330', '1');
INSERT INTO `area` VALUES ('330227', '3302', '鄞  县', '3', '1331', '1');
INSERT INTO `area` VALUES ('330281', '3302', '余姚市', '3', '1332', '1');
INSERT INTO `area` VALUES ('330282', '3302', '慈溪市', '3', '1333', '1');
INSERT INTO `area` VALUES ('330283', '3302', '奉化市', '3', '1334', '1');
INSERT INTO `area` VALUES ('330301', '3303', '市辖区', '3', '1335', '1');
INSERT INTO `area` VALUES ('330302', '3303', '鹿城区', '3', '1336', '1');
INSERT INTO `area` VALUES ('330303', '3303', '龙湾区', '3', '1337', '1');
INSERT INTO `area` VALUES ('330304', '3303', '瓯海区', '3', '1338', '1');
INSERT INTO `area` VALUES ('330322', '3303', '洞头县', '3', '1339', '1');
INSERT INTO `area` VALUES ('330324', '3303', '永嘉县', '3', '1340', '1');
INSERT INTO `area` VALUES ('330326', '3303', '平阳县', '3', '1341', '1');
INSERT INTO `area` VALUES ('330327', '3303', '苍南县', '3', '1342', '1');
INSERT INTO `area` VALUES ('330328', '3303', '文成县', '3', '1343', '1');
INSERT INTO `area` VALUES ('330329', '3303', '泰顺县', '3', '1344', '1');
INSERT INTO `area` VALUES ('330381', '3303', '瑞安市', '3', '1345', '1');
INSERT INTO `area` VALUES ('330382', '3303', '乐清市', '3', '1346', '1');
INSERT INTO `area` VALUES ('330401', '3304', '市辖区', '3', '1347', '1');
INSERT INTO `area` VALUES ('330402', '3304', '秀城区', '3', '1348', '1');
INSERT INTO `area` VALUES ('330411', '3304', '秀洲区', '3', '1349', '1');
INSERT INTO `area` VALUES ('330421', '3304', '嘉善县', '3', '1350', '1');
INSERT INTO `area` VALUES ('330424', '3304', '海盐县', '3', '1351', '1');
INSERT INTO `area` VALUES ('330481', '3304', '海宁市', '3', '1352', '1');
INSERT INTO `area` VALUES ('330482', '3304', '平湖市', '3', '1353', '1');
INSERT INTO `area` VALUES ('330483', '3304', '桐乡市', '3', '1354', '1');
INSERT INTO `area` VALUES ('330501', '3305', '市辖区', '3', '1355', '1');
INSERT INTO `area` VALUES ('330521', '3305', '德清县', '3', '1356', '1');
INSERT INTO `area` VALUES ('330522', '3305', '长兴县', '3', '1357', '1');
INSERT INTO `area` VALUES ('330523', '3305', '安吉县', '3', '1358', '1');
INSERT INTO `area` VALUES ('330601', '3306', '市辖区', '3', '1359', '1');
INSERT INTO `area` VALUES ('330602', '3306', '越城区', '3', '1360', '1');
INSERT INTO `area` VALUES ('330621', '3306', '绍兴县', '3', '1361', '1');
INSERT INTO `area` VALUES ('330624', '3306', '新昌县', '3', '1362', '1');
INSERT INTO `area` VALUES ('330681', '3306', '诸暨市', '3', '1363', '1');
INSERT INTO `area` VALUES ('330682', '3306', '上虞市', '3', '1364', '1');
INSERT INTO `area` VALUES ('330683', '3306', '嵊州市', '3', '1365', '1');
INSERT INTO `area` VALUES ('330701', '3307', '市辖区', '3', '1366', '1');
INSERT INTO `area` VALUES ('330702', '3307', '婺城区', '3', '1367', '1');
INSERT INTO `area` VALUES ('330703', '3307', '金东区', '3', '1368', '1');
INSERT INTO `area` VALUES ('330723', '3307', '武义县', '3', '1369', '1');
INSERT INTO `area` VALUES ('330726', '3307', '浦江县', '3', '1370', '1');
INSERT INTO `area` VALUES ('330727', '3307', '磐安县', '3', '1371', '1');
INSERT INTO `area` VALUES ('330781', '3307', '兰溪市', '3', '1372', '1');
INSERT INTO `area` VALUES ('330782', '3307', '义乌市', '3', '1373', '1');
INSERT INTO `area` VALUES ('330783', '3307', '东阳市', '3', '1374', '1');
INSERT INTO `area` VALUES ('330784', '3307', '永康市', '3', '1375', '1');
INSERT INTO `area` VALUES ('330801', '3308', '市辖区', '3', '1376', '1');
INSERT INTO `area` VALUES ('330802', '3308', '柯城区', '3', '1377', '1');
INSERT INTO `area` VALUES ('330821', '3308', '衢  县', '3', '1378', '1');
INSERT INTO `area` VALUES ('330822', '3308', '常山县', '3', '1379', '1');
INSERT INTO `area` VALUES ('330824', '3308', '开化县', '3', '1380', '1');
INSERT INTO `area` VALUES ('330825', '3308', '龙游县', '3', '1381', '1');
INSERT INTO `area` VALUES ('330881', '3308', '江山市', '3', '1382', '1');
INSERT INTO `area` VALUES ('330901', '3309', '市辖区', '3', '1383', '1');
INSERT INTO `area` VALUES ('330902', '3309', '定海区', '3', '1384', '1');
INSERT INTO `area` VALUES ('330903', '3309', '普陀区', '3', '1385', '1');
INSERT INTO `area` VALUES ('330921', '3309', '岱山县', '3', '1386', '1');
INSERT INTO `area` VALUES ('330922', '3309', '嵊泗县', '3', '1387', '1');
INSERT INTO `area` VALUES ('331001', '3310', '市辖区', '3', '1388', '1');
INSERT INTO `area` VALUES ('331002', '3310', '椒江区', '3', '1389', '1');
INSERT INTO `area` VALUES ('331003', '3310', '黄岩区', '3', '1390', '1');
INSERT INTO `area` VALUES ('331004', '3310', '路桥区', '3', '1391', '1');
INSERT INTO `area` VALUES ('331021', '3310', '玉环县', '3', '1392', '1');
INSERT INTO `area` VALUES ('331022', '3310', '三门县', '3', '1393', '1');
INSERT INTO `area` VALUES ('331023', '3310', '天台县', '3', '1394', '1');
INSERT INTO `area` VALUES ('331024', '3310', '仙居县', '3', '1395', '1');
INSERT INTO `area` VALUES ('331081', '3310', '温岭市', '3', '1396', '1');
INSERT INTO `area` VALUES ('331082', '3310', '临海市', '3', '1397', '1');
INSERT INTO `area` VALUES ('331101', '3311', '市辖区', '3', '1398', '1');
INSERT INTO `area` VALUES ('331102', '3311', '莲都区', '3', '1399', '1');
INSERT INTO `area` VALUES ('331121', '3311', '青田县', '3', '1400', '1');
INSERT INTO `area` VALUES ('331122', '3311', '缙云县', '3', '1401', '1');
INSERT INTO `area` VALUES ('331123', '3311', '遂昌县', '3', '1402', '1');
INSERT INTO `area` VALUES ('331124', '3311', '松阳县', '3', '1403', '1');
INSERT INTO `area` VALUES ('331125', '3311', '云和县', '3', '1404', '1');
INSERT INTO `area` VALUES ('331126', '3311', '庆元县', '3', '1405', '1');
INSERT INTO `area` VALUES ('331127', '3311', '景宁畲族自治县', '3', '1406', '1');
INSERT INTO `area` VALUES ('331181', '3311', '龙泉市', '3', '1407', '1');
INSERT INTO `area` VALUES ('340101', '3401', '市辖区', '3', '1408', '1');
INSERT INTO `area` VALUES ('340102', '3401', '东市区', '3', '1409', '1');
INSERT INTO `area` VALUES ('340103', '3401', '中市区', '3', '1410', '1');
INSERT INTO `area` VALUES ('340104', '3401', '西市区', '3', '1411', '1');
INSERT INTO `area` VALUES ('340111', '3401', '郊  区', '3', '1412', '1');
INSERT INTO `area` VALUES ('340121', '3401', '长丰县', '3', '1413', '1');
INSERT INTO `area` VALUES ('340122', '3401', '肥东县', '3', '1414', '1');
INSERT INTO `area` VALUES ('340123', '3401', '肥西县', '3', '1415', '1');
INSERT INTO `area` VALUES ('340201', '3402', '市辖区', '3', '1416', '1');
INSERT INTO `area` VALUES ('340202', '3402', '镜湖区', '3', '1417', '1');
INSERT INTO `area` VALUES ('340203', '3402', '马塘区', '3', '1418', '1');
INSERT INTO `area` VALUES ('340204', '3402', '新芜区', '3', '1419', '1');
INSERT INTO `area` VALUES ('340207', '3402', '鸠江区', '3', '1420', '1');
INSERT INTO `area` VALUES ('340221', '3402', '芜湖县', '3', '1421', '1');
INSERT INTO `area` VALUES ('340222', '3402', '繁昌县', '3', '1422', '1');
INSERT INTO `area` VALUES ('340223', '3402', '南陵县', '3', '1423', '1');
INSERT INTO `area` VALUES ('340301', '3403', '市辖区', '3', '1424', '1');
INSERT INTO `area` VALUES ('340302', '3403', '东市区', '3', '1425', '1');
INSERT INTO `area` VALUES ('340303', '3403', '中市区', '3', '1426', '1');
INSERT INTO `area` VALUES ('340304', '3403', '西市区', '3', '1427', '1');
INSERT INTO `area` VALUES ('340311', '3403', '郊  区', '3', '1428', '1');
INSERT INTO `area` VALUES ('340321', '3403', '怀远县', '3', '1429', '1');
INSERT INTO `area` VALUES ('340322', '3403', '五河县', '3', '1430', '1');
INSERT INTO `area` VALUES ('340323', '3403', '固镇县', '3', '1431', '1');
INSERT INTO `area` VALUES ('340401', '3404', '市辖区', '3', '1432', '1');
INSERT INTO `area` VALUES ('340402', '3404', '大通区', '3', '1433', '1');
INSERT INTO `area` VALUES ('340403', '3404', '田家庵区', '3', '1434', '1');
INSERT INTO `area` VALUES ('340404', '3404', '谢家集区', '3', '1435', '1');
INSERT INTO `area` VALUES ('340405', '3404', '八公山区', '3', '1436', '1');
INSERT INTO `area` VALUES ('340406', '3404', '潘集区', '3', '1437', '1');
INSERT INTO `area` VALUES ('340421', '3404', '凤台县', '3', '1438', '1');
INSERT INTO `area` VALUES ('340501', '3405', '市辖区', '3', '1439', '1');
INSERT INTO `area` VALUES ('340502', '3405', '金家庄区', '3', '1440', '1');
INSERT INTO `area` VALUES ('340503', '3405', '花山区', '3', '1441', '1');
INSERT INTO `area` VALUES ('340504', '3405', '雨山区', '3', '1442', '1');
INSERT INTO `area` VALUES ('340505', '3405', '向山区', '3', '1443', '1');
INSERT INTO `area` VALUES ('340521', '3405', '当涂县', '3', '1444', '1');
INSERT INTO `area` VALUES ('340601', '3406', '市辖区', '3', '1445', '1');
INSERT INTO `area` VALUES ('340602', '3406', '杜集区', '3', '1446', '1');
INSERT INTO `area` VALUES ('340603', '3406', '相山区', '3', '1447', '1');
INSERT INTO `area` VALUES ('340604', '3406', '烈山区', '3', '1448', '1');
INSERT INTO `area` VALUES ('340621', '3406', '濉溪县', '3', '1449', '1');
INSERT INTO `area` VALUES ('340701', '3407', '市辖区', '3', '1450', '1');
INSERT INTO `area` VALUES ('340702', '3407', '铜官山区', '3', '1451', '1');
INSERT INTO `area` VALUES ('340703', '3407', '狮子山区', '3', '1452', '1');
INSERT INTO `area` VALUES ('340711', '3407', '郊  区', '3', '1453', '1');
INSERT INTO `area` VALUES ('340721', '3407', '铜陵县', '3', '1454', '1');
INSERT INTO `area` VALUES ('340801', '3408', '市辖区', '3', '1455', '1');
INSERT INTO `area` VALUES ('340802', '3408', '迎江区', '3', '1456', '1');
INSERT INTO `area` VALUES ('340803', '3408', '大观区', '3', '1457', '1');
INSERT INTO `area` VALUES ('340811', '3408', '郊  区', '3', '1458', '1');
INSERT INTO `area` VALUES ('340822', '3408', '怀宁县', '3', '1459', '1');
INSERT INTO `area` VALUES ('340823', '3408', '枞阳县', '3', '1460', '1');
INSERT INTO `area` VALUES ('340824', '3408', '潜山县', '3', '1461', '1');
INSERT INTO `area` VALUES ('340825', '3408', '太湖县', '3', '1462', '1');
INSERT INTO `area` VALUES ('340826', '3408', '宿松县', '3', '1463', '1');
INSERT INTO `area` VALUES ('340827', '3408', '望江县', '3', '1464', '1');
INSERT INTO `area` VALUES ('340828', '3408', '岳西县', '3', '1465', '1');
INSERT INTO `area` VALUES ('340881', '3408', '桐城市', '3', '1466', '1');
INSERT INTO `area` VALUES ('341001', '3410', '市辖区', '3', '1467', '1');
INSERT INTO `area` VALUES ('341002', '3410', '屯溪区', '3', '1468', '1');
INSERT INTO `area` VALUES ('341003', '3410', '黄山区', '3', '1469', '1');
INSERT INTO `area` VALUES ('341004', '3410', '徽州区', '3', '1470', '1');
INSERT INTO `area` VALUES ('341021', '3410', '歙  县', '3', '1471', '1');
INSERT INTO `area` VALUES ('341022', '3410', '休宁县', '3', '1472', '1');
INSERT INTO `area` VALUES ('341023', '3410', '黟  县', '3', '1473', '1');
INSERT INTO `area` VALUES ('341024', '3410', '祁门县', '3', '1474', '1');
INSERT INTO `area` VALUES ('341101', '3411', '市辖区', '3', '1475', '1');
INSERT INTO `area` VALUES ('341102', '3411', '琅琊区', '3', '1476', '1');
INSERT INTO `area` VALUES ('341103', '3411', '南谯区', '3', '1477', '1');
INSERT INTO `area` VALUES ('341122', '3411', '来安县', '3', '1478', '1');
INSERT INTO `area` VALUES ('341124', '3411', '全椒县', '3', '1479', '1');
INSERT INTO `area` VALUES ('341125', '3411', '定远县', '3', '1480', '1');
INSERT INTO `area` VALUES ('341126', '3411', '凤阳县', '3', '1481', '1');
INSERT INTO `area` VALUES ('341181', '3411', '天长市', '3', '1482', '1');
INSERT INTO `area` VALUES ('341182', '3411', '明光市', '3', '1483', '1');
INSERT INTO `area` VALUES ('341201', '3412', '市辖区', '3', '1484', '1');
INSERT INTO `area` VALUES ('341202', '3412', '颍州区', '3', '1485', '1');
INSERT INTO `area` VALUES ('341203', '3412', '颍东区', '3', '1486', '1');
INSERT INTO `area` VALUES ('341204', '3412', '颍泉区', '3', '1487', '1');
INSERT INTO `area` VALUES ('341221', '3412', '临泉县', '3', '1488', '1');
INSERT INTO `area` VALUES ('341222', '3412', '太和县', '3', '1489', '1');
INSERT INTO `area` VALUES ('341225', '3412', '阜南县', '3', '1490', '1');
INSERT INTO `area` VALUES ('341226', '3412', '颍上县', '3', '1491', '1');
INSERT INTO `area` VALUES ('341282', '3412', '界首市', '3', '1492', '1');
INSERT INTO `area` VALUES ('341301', '3413', '市辖区', '3', '1493', '1');
INSERT INTO `area` VALUES ('341302', '3413', '墉桥区', '3', '1494', '1');
INSERT INTO `area` VALUES ('341321', '3413', '砀山县', '3', '1495', '1');
INSERT INTO `area` VALUES ('341322', '3413', '萧  县', '3', '1496', '1');
INSERT INTO `area` VALUES ('341323', '3413', '灵璧县', '3', '1497', '1');
INSERT INTO `area` VALUES ('341324', '3413', '泗  县', '3', '1498', '1');
INSERT INTO `area` VALUES ('341401', '3414', '市辖区', '3', '1499', '1');
INSERT INTO `area` VALUES ('341402', '3414', '居巢区', '3', '1500', '1');
INSERT INTO `area` VALUES ('341421', '3414', '庐江县', '3', '1501', '1');
INSERT INTO `area` VALUES ('341422', '3414', '无为县', '3', '1502', '1');
INSERT INTO `area` VALUES ('341423', '3414', '含山县', '3', '1503', '1');
INSERT INTO `area` VALUES ('341424', '3414', '和  县', '3', '1504', '1');
INSERT INTO `area` VALUES ('341501', '3415', '市辖区', '3', '1505', '1');
INSERT INTO `area` VALUES ('341502', '3415', '金安区', '3', '1506', '1');
INSERT INTO `area` VALUES ('341503', '3415', '裕安区', '3', '1507', '1');
INSERT INTO `area` VALUES ('341521', '3415', '寿  县', '3', '1508', '1');
INSERT INTO `area` VALUES ('341522', '3415', '霍邱县', '3', '1509', '1');
INSERT INTO `area` VALUES ('341523', '3415', '舒城县', '3', '1510', '1');
INSERT INTO `area` VALUES ('341524', '3415', '金寨县', '3', '1511', '1');
INSERT INTO `area` VALUES ('341525', '3415', '霍山县', '3', '1512', '1');
INSERT INTO `area` VALUES ('341601', '3416', '市辖区', '3', '1513', '1');
INSERT INTO `area` VALUES ('341602', '3416', '谯城区', '3', '1514', '1');
INSERT INTO `area` VALUES ('341621', '3416', '涡阳县', '3', '1515', '1');
INSERT INTO `area` VALUES ('341622', '3416', '蒙城县', '3', '1516', '1');
INSERT INTO `area` VALUES ('341623', '3416', '利辛县', '3', '1517', '1');
INSERT INTO `area` VALUES ('341701', '3417', '市辖区', '3', '1518', '1');
INSERT INTO `area` VALUES ('341702', '3417', '贵池区', '3', '1519', '1');
INSERT INTO `area` VALUES ('341721', '3417', '东至县', '3', '1520', '1');
INSERT INTO `area` VALUES ('341722', '3417', '石台县', '3', '1521', '1');
INSERT INTO `area` VALUES ('341723', '3417', '青阳县', '3', '1522', '1');
INSERT INTO `area` VALUES ('341801', '3418', '市辖区', '3', '1523', '1');
INSERT INTO `area` VALUES ('341802', '3418', '宣州区', '3', '1524', '1');
INSERT INTO `area` VALUES ('341821', '3418', '郎溪县', '3', '1525', '1');
INSERT INTO `area` VALUES ('341822', '3418', '广德县', '3', '1526', '1');
INSERT INTO `area` VALUES ('341823', '3418', '泾  县', '3', '1527', '1');
INSERT INTO `area` VALUES ('341824', '3418', '绩溪县', '3', '1528', '1');
INSERT INTO `area` VALUES ('341825', '3418', '旌德县', '3', '1529', '1');
INSERT INTO `area` VALUES ('341881', '3418', '宁国市', '3', '1530', '1');
INSERT INTO `area` VALUES ('350101', '3501', '市辖区', '3', '1531', '0');
INSERT INTO `area` VALUES ('350102', '3501', '鼓楼区', '3', '1532', '0');
INSERT INTO `area` VALUES ('350103', '3501', '台江区', '3', '1533', '0');
INSERT INTO `area` VALUES ('350104', '3501', '仓山区', '3', '1534', '0');
INSERT INTO `area` VALUES ('350105', '3501', '马尾区', '3', '1535', '0');
INSERT INTO `area` VALUES ('350111', '3501', '晋安区', '3', '1536', '0');
INSERT INTO `area` VALUES ('350121', '3501', '闽侯县', '3', '1537', '0');
INSERT INTO `area` VALUES ('350122', '3501', '连江县', '3', '1538', '0');
INSERT INTO `area` VALUES ('350123', '3501', '罗源县', '3', '1539', '0');
INSERT INTO `area` VALUES ('350124', '3501', '闽清县', '3', '1540', '0');
INSERT INTO `area` VALUES ('350125', '3501', '永泰县', '3', '1541', '0');
INSERT INTO `area` VALUES ('350128', '3501', '平潭县', '3', '1542', '0');
INSERT INTO `area` VALUES ('350181', '3501', '福清市', '3', '1543', '0');
INSERT INTO `area` VALUES ('350182', '3501', '长乐市', '3', '1544', '0');
INSERT INTO `area` VALUES ('350201', '3502', '市辖区', '3', '1545', '0');
INSERT INTO `area` VALUES ('350202', '3502', '鼓浪屿区', '3', '1546', '0');
INSERT INTO `area` VALUES ('350203', '3502', '思明区', '3', '1547', '0');
INSERT INTO `area` VALUES ('350204', '3502', '开元区', '3', '1548', '0');
INSERT INTO `area` VALUES ('350205', '3502', '杏林区', '3', '1549', '0');
INSERT INTO `area` VALUES ('350206', '3502', '湖里区', '3', '1550', '0');
INSERT INTO `area` VALUES ('350211', '3502', '集美区', '3', '1551', '0');
INSERT INTO `area` VALUES ('350212', '3502', '同安区', '3', '1552', '0');
INSERT INTO `area` VALUES ('350301', '3503', '市辖区', '3', '1553', '0');
INSERT INTO `area` VALUES ('350302', '3503', '城厢区', '3', '1554', '0');
INSERT INTO `area` VALUES ('350303', '3503', '涵江区', '3', '1555', '0');
INSERT INTO `area` VALUES ('350321', '3503', '莆田县', '3', '1556', '0');
INSERT INTO `area` VALUES ('350322', '3503', '仙游县', '3', '1557', '0');
INSERT INTO `area` VALUES ('350401', '3504', '市辖区', '3', '1558', '0');
INSERT INTO `area` VALUES ('350402', '3504', '梅列区', '3', '1559', '0');
INSERT INTO `area` VALUES ('350403', '3504', '三元区', '3', '1560', '0');
INSERT INTO `area` VALUES ('350421', '3504', '明溪县', '3', '1561', '0');
INSERT INTO `area` VALUES ('350423', '3504', '清流县', '3', '1562', '0');
INSERT INTO `area` VALUES ('350424', '3504', '宁化县', '3', '1563', '0');
INSERT INTO `area` VALUES ('350425', '3504', '大田县', '3', '1564', '0');
INSERT INTO `area` VALUES ('350426', '3504', '尤溪县', '3', '1565', '0');
INSERT INTO `area` VALUES ('350427', '3504', '沙  县', '3', '1566', '0');
INSERT INTO `area` VALUES ('350428', '3504', '将乐县', '3', '1567', '0');
INSERT INTO `area` VALUES ('350429', '3504', '泰宁县', '3', '1568', '0');
INSERT INTO `area` VALUES ('350430', '3504', '建宁县', '3', '1569', '0');
INSERT INTO `area` VALUES ('350481', '3504', '永安市', '3', '1570', '0');
INSERT INTO `area` VALUES ('350501', '3505', '市辖区', '3', '1571', '0');
INSERT INTO `area` VALUES ('350502', '3505', '鲤城区', '3', '1572', '0');
INSERT INTO `area` VALUES ('350503', '3505', '丰泽区', '3', '1573', '0');
INSERT INTO `area` VALUES ('350504', '3505', '洛江区', '3', '1574', '0');
INSERT INTO `area` VALUES ('350505', '3505', '泉港区', '3', '1575', '0');
INSERT INTO `area` VALUES ('350521', '3505', '惠安县', '3', '1576', '0');
INSERT INTO `area` VALUES ('350524', '3505', '安溪县', '3', '1577', '0');
INSERT INTO `area` VALUES ('350525', '3505', '永春县', '3', '1578', '0');
INSERT INTO `area` VALUES ('350526', '3505', '德化县', '3', '1579', '0');
INSERT INTO `area` VALUES ('350527', '3505', '金门县', '3', '1580', '0');
INSERT INTO `area` VALUES ('350581', '3505', '石狮市', '3', '1581', '0');
INSERT INTO `area` VALUES ('350582', '3505', '晋江市', '3', '1582', '0');
INSERT INTO `area` VALUES ('350583', '3505', '南安市', '3', '1583', '0');
INSERT INTO `area` VALUES ('350601', '3506', '市辖区', '3', '1584', '0');
INSERT INTO `area` VALUES ('350602', '3506', '芗城区', '3', '1585', '0');
INSERT INTO `area` VALUES ('350603', '3506', '龙文区', '3', '1586', '0');
INSERT INTO `area` VALUES ('350622', '3506', '云霄县', '3', '1587', '0');
INSERT INTO `area` VALUES ('350623', '3506', '漳浦县', '3', '1588', '0');
INSERT INTO `area` VALUES ('350624', '3506', '诏安县', '3', '1589', '0');
INSERT INTO `area` VALUES ('350625', '3506', '长泰县', '3', '1590', '0');
INSERT INTO `area` VALUES ('350626', '3506', '东山县', '3', '1591', '0');
INSERT INTO `area` VALUES ('350627', '3506', '南靖县', '3', '1592', '0');
INSERT INTO `area` VALUES ('350628', '3506', '平和县', '3', '1593', '0');
INSERT INTO `area` VALUES ('350629', '3506', '华安县', '3', '1594', '0');
INSERT INTO `area` VALUES ('350681', '3506', '龙海市', '3', '1595', '0');
INSERT INTO `area` VALUES ('350701', '3507', '市辖区', '3', '1596', '0');
INSERT INTO `area` VALUES ('350702', '3507', '延平区', '3', '1597', '0');
INSERT INTO `area` VALUES ('350721', '3507', '顺昌县', '3', '1598', '0');
INSERT INTO `area` VALUES ('350722', '3507', '浦城县', '3', '1599', '0');
INSERT INTO `area` VALUES ('350723', '3507', '光泽县', '3', '1600', '0');
INSERT INTO `area` VALUES ('350724', '3507', '松溪县', '3', '1601', '0');
INSERT INTO `area` VALUES ('350725', '3507', '政和县', '3', '1602', '0');
INSERT INTO `area` VALUES ('350781', '3507', '邵武市', '3', '1603', '0');
INSERT INTO `area` VALUES ('350782', '3507', '武夷山市', '3', '1604', '0');
INSERT INTO `area` VALUES ('350783', '3507', '建瓯市', '3', '1605', '0');
INSERT INTO `area` VALUES ('350784', '3507', '建阳市', '3', '1606', '0');
INSERT INTO `area` VALUES ('350801', '3508', '市辖区', '3', '1607', '0');
INSERT INTO `area` VALUES ('350802', '3508', '新罗区', '3', '1608', '0');
INSERT INTO `area` VALUES ('350821', '3508', '长汀县', '3', '1609', '0');
INSERT INTO `area` VALUES ('350822', '3508', '永定县', '3', '1610', '0');
INSERT INTO `area` VALUES ('350823', '3508', '上杭县', '3', '1611', '0');
INSERT INTO `area` VALUES ('350824', '3508', '武平县', '3', '1612', '0');
INSERT INTO `area` VALUES ('350825', '3508', '连城县', '3', '1613', '0');
INSERT INTO `area` VALUES ('350881', '3508', '漳平市', '3', '1614', '0');
INSERT INTO `area` VALUES ('350901', '3509', '市辖区', '3', '1615', '0');
INSERT INTO `area` VALUES ('350902', '3509', '蕉城区', '3', '1616', '0');
INSERT INTO `area` VALUES ('350921', '3509', '霞浦县', '3', '1617', '0');
INSERT INTO `area` VALUES ('350922', '3509', '古田县', '3', '1618', '0');
INSERT INTO `area` VALUES ('350923', '3509', '屏南县', '3', '1619', '0');
INSERT INTO `area` VALUES ('350924', '3509', '寿宁县', '3', '1620', '0');
INSERT INTO `area` VALUES ('350925', '3509', '周宁县', '3', '1621', '0');
INSERT INTO `area` VALUES ('350926', '3509', '柘荣县', '3', '1622', '0');
INSERT INTO `area` VALUES ('350981', '3509', '福安市', '3', '1623', '0');
INSERT INTO `area` VALUES ('350982', '3509', '福鼎市', '3', '1624', '0');
INSERT INTO `area` VALUES ('360101', '3601', '市辖区', '3', '1625', '1');
INSERT INTO `area` VALUES ('360102', '3601', '东湖区', '3', '1626', '1');
INSERT INTO `area` VALUES ('360103', '3601', '西湖区', '3', '1627', '1');
INSERT INTO `area` VALUES ('360104', '3601', '青云谱区', '3', '1628', '1');
INSERT INTO `area` VALUES ('360105', '3601', '湾里区', '3', '1629', '1');
INSERT INTO `area` VALUES ('360111', '3601', '郊  区', '3', '1630', '1');
INSERT INTO `area` VALUES ('360121', '3601', '南昌县', '3', '1631', '1');
INSERT INTO `area` VALUES ('360122', '3601', '新建县', '3', '1632', '1');
INSERT INTO `area` VALUES ('360123', '3601', '安义县', '3', '1633', '1');
INSERT INTO `area` VALUES ('360124', '3601', '进贤县', '3', '1634', '1');
INSERT INTO `area` VALUES ('360201', '3602', '市辖区', '3', '1635', '1');
INSERT INTO `area` VALUES ('360202', '3602', '昌江区', '3', '1636', '1');
INSERT INTO `area` VALUES ('360203', '3602', '珠山区', '3', '1637', '1');
INSERT INTO `area` VALUES ('360222', '3602', '浮梁县', '3', '1638', '1');
INSERT INTO `area` VALUES ('360281', '3602', '乐平市', '3', '1639', '1');
INSERT INTO `area` VALUES ('360301', '3603', '市辖区', '3', '1640', '1');
INSERT INTO `area` VALUES ('360302', '3603', '安源区', '3', '1641', '1');
INSERT INTO `area` VALUES ('360313', '3603', '湘东区', '3', '1642', '1');
INSERT INTO `area` VALUES ('360321', '3603', '莲花县', '3', '1643', '1');
INSERT INTO `area` VALUES ('360322', '3603', '上栗县', '3', '1644', '1');
INSERT INTO `area` VALUES ('360323', '3603', '芦溪县', '3', '1645', '1');
INSERT INTO `area` VALUES ('360401', '3604', '市辖区', '3', '1646', '1');
INSERT INTO `area` VALUES ('360402', '3604', '庐山区', '3', '1647', '1');
INSERT INTO `area` VALUES ('360403', '3604', '浔阳区', '3', '1648', '1');
INSERT INTO `area` VALUES ('360421', '3604', '九江县', '3', '1649', '1');
INSERT INTO `area` VALUES ('360423', '3604', '武宁县', '3', '1650', '1');
INSERT INTO `area` VALUES ('360424', '3604', '修水县', '3', '1651', '1');
INSERT INTO `area` VALUES ('360425', '3604', '永修县', '3', '1652', '1');
INSERT INTO `area` VALUES ('360426', '3604', '德安县', '3', '1653', '1');
INSERT INTO `area` VALUES ('360427', '3604', '星子县', '3', '1654', '1');
INSERT INTO `area` VALUES ('360428', '3604', '都昌县', '3', '1655', '1');
INSERT INTO `area` VALUES ('360429', '3604', '湖口县', '3', '1656', '1');
INSERT INTO `area` VALUES ('360430', '3604', '彭泽县', '3', '1657', '1');
INSERT INTO `area` VALUES ('360481', '3604', '瑞昌市', '3', '1658', '1');
INSERT INTO `area` VALUES ('360501', '3605', '市辖区', '3', '1659', '1');
INSERT INTO `area` VALUES ('360502', '3605', '渝水区', '3', '1660', '1');
INSERT INTO `area` VALUES ('360521', '3605', '分宜县', '3', '1661', '1');
INSERT INTO `area` VALUES ('360601', '3606', '市辖区', '3', '1662', '1');
INSERT INTO `area` VALUES ('360602', '3606', '月湖区', '3', '1663', '1');
INSERT INTO `area` VALUES ('360622', '3606', '余江县', '3', '1664', '1');
INSERT INTO `area` VALUES ('360681', '3606', '贵溪市', '3', '1665', '1');
INSERT INTO `area` VALUES ('360701', '3607', '市辖区', '3', '1666', '1');
INSERT INTO `area` VALUES ('360702', '3607', '章贡区', '3', '1667', '1');
INSERT INTO `area` VALUES ('360721', '3607', '赣  县', '3', '1668', '1');
INSERT INTO `area` VALUES ('360722', '3607', '信丰县', '3', '1669', '1');
INSERT INTO `area` VALUES ('360723', '3607', '大余县', '3', '1670', '1');
INSERT INTO `area` VALUES ('360724', '3607', '上犹县', '3', '1671', '1');
INSERT INTO `area` VALUES ('360725', '3607', '崇义县', '3', '1672', '1');
INSERT INTO `area` VALUES ('360726', '3607', '安远县', '3', '1673', '1');
INSERT INTO `area` VALUES ('360727', '3607', '龙南县', '3', '1674', '1');
INSERT INTO `area` VALUES ('360728', '3607', '定南县', '3', '1675', '1');
INSERT INTO `area` VALUES ('360729', '3607', '全南县', '3', '1676', '1');
INSERT INTO `area` VALUES ('360730', '3607', '宁都县', '3', '1677', '1');
INSERT INTO `area` VALUES ('360731', '3607', '于都县', '3', '1678', '1');
INSERT INTO `area` VALUES ('360732', '3607', '兴国县', '3', '1679', '1');
INSERT INTO `area` VALUES ('360733', '3607', '会昌县', '3', '1680', '1');
INSERT INTO `area` VALUES ('360734', '3607', '寻乌县', '3', '1681', '1');
INSERT INTO `area` VALUES ('360735', '3607', '石城县', '3', '1682', '1');
INSERT INTO `area` VALUES ('360781', '3607', '瑞金市', '3', '1683', '1');
INSERT INTO `area` VALUES ('360782', '3607', '南康市', '3', '1684', '1');
INSERT INTO `area` VALUES ('360801', '3608', '市辖区', '3', '1685', '1');
INSERT INTO `area` VALUES ('360802', '3608', '吉州区', '3', '1686', '1');
INSERT INTO `area` VALUES ('360803', '3608', '青原区', '3', '1687', '1');
INSERT INTO `area` VALUES ('360821', '3608', '吉安县', '3', '1688', '1');
INSERT INTO `area` VALUES ('360822', '3608', '吉水县', '3', '1689', '1');
INSERT INTO `area` VALUES ('360823', '3608', '峡江县', '3', '1690', '1');
INSERT INTO `area` VALUES ('360824', '3608', '新干县', '3', '1691', '1');
INSERT INTO `area` VALUES ('360825', '3608', '永丰县', '3', '1692', '1');
INSERT INTO `area` VALUES ('360826', '3608', '泰和县', '3', '1693', '1');
INSERT INTO `area` VALUES ('360827', '3608', '遂川县', '3', '1694', '1');
INSERT INTO `area` VALUES ('360828', '3608', '万安县', '3', '1695', '1');
INSERT INTO `area` VALUES ('360829', '3608', '安福县', '3', '1696', '1');
INSERT INTO `area` VALUES ('360830', '3608', '永新县', '3', '1697', '1');
INSERT INTO `area` VALUES ('360881', '3608', '井冈山市', '3', '1698', '1');
INSERT INTO `area` VALUES ('360901', '3609', '市辖区', '3', '1699', '1');
INSERT INTO `area` VALUES ('360902', '3609', '袁州区', '3', '1700', '1');
INSERT INTO `area` VALUES ('360921', '3609', '奉新县', '3', '1701', '1');
INSERT INTO `area` VALUES ('360922', '3609', '万载县', '3', '1702', '1');
INSERT INTO `area` VALUES ('360923', '3609', '上高县', '3', '1703', '1');
INSERT INTO `area` VALUES ('360924', '3609', '宜丰县', '3', '1704', '1');
INSERT INTO `area` VALUES ('360925', '3609', '靖安县', '3', '1705', '1');
INSERT INTO `area` VALUES ('360926', '3609', '铜鼓县', '3', '1706', '1');
INSERT INTO `area` VALUES ('360981', '3609', '丰城市', '3', '1707', '1');
INSERT INTO `area` VALUES ('360982', '3609', '樟树市', '3', '1708', '1');
INSERT INTO `area` VALUES ('360983', '3609', '高安市', '3', '1709', '1');
INSERT INTO `area` VALUES ('361001', '3610', '市辖区', '3', '1710', '1');
INSERT INTO `area` VALUES ('361002', '3610', '临川区', '3', '1711', '1');
INSERT INTO `area` VALUES ('361021', '3610', '南城县', '3', '1712', '1');
INSERT INTO `area` VALUES ('361022', '3610', '黎川县', '3', '1713', '1');
INSERT INTO `area` VALUES ('361023', '3610', '南丰县', '3', '1714', '1');
INSERT INTO `area` VALUES ('361024', '3610', '崇仁县', '3', '1715', '1');
INSERT INTO `area` VALUES ('361025', '3610', '乐安县', '3', '1716', '1');
INSERT INTO `area` VALUES ('361026', '3610', '宜黄县', '3', '1717', '1');
INSERT INTO `area` VALUES ('361027', '3610', '金溪县', '3', '1718', '1');
INSERT INTO `area` VALUES ('361028', '3610', '资溪县', '3', '1719', '1');
INSERT INTO `area` VALUES ('361029', '3610', '东乡县', '3', '1720', '1');
INSERT INTO `area` VALUES ('361030', '3610', '广昌县', '3', '1721', '1');
INSERT INTO `area` VALUES ('361101', '3611', '市辖区', '3', '1722', '1');
INSERT INTO `area` VALUES ('361102', '3611', '信州区', '3', '1723', '1');
INSERT INTO `area` VALUES ('361121', '3611', '上饶县', '3', '1724', '1');
INSERT INTO `area` VALUES ('361122', '3611', '广丰县', '3', '1725', '1');
INSERT INTO `area` VALUES ('361123', '3611', '玉山县', '3', '1726', '1');
INSERT INTO `area` VALUES ('361124', '3611', '铅山县', '3', '1727', '1');
INSERT INTO `area` VALUES ('361125', '3611', '横峰县', '3', '1728', '1');
INSERT INTO `area` VALUES ('361126', '3611', '弋阳县', '3', '1729', '1');
INSERT INTO `area` VALUES ('361127', '3611', '余干县', '3', '1730', '1');
INSERT INTO `area` VALUES ('361128', '3611', '波阳县', '3', '1731', '1');
INSERT INTO `area` VALUES ('361129', '3611', '万年县', '3', '1732', '1');
INSERT INTO `area` VALUES ('361130', '3611', '婺源县', '3', '1733', '1');
INSERT INTO `area` VALUES ('361181', '3611', '德兴市', '3', '1734', '1');
INSERT INTO `area` VALUES ('370101', '3701', '市辖区', '3', '1735', '1');
INSERT INTO `area` VALUES ('370102', '3701', '历下区', '3', '1736', '1');
INSERT INTO `area` VALUES ('370103', '3701', '市中区', '3', '1737', '1');
INSERT INTO `area` VALUES ('370104', '3701', '槐荫区', '3', '1738', '1');
INSERT INTO `area` VALUES ('370105', '3701', '天桥区', '3', '1739', '1');
INSERT INTO `area` VALUES ('370112', '3701', '历城区', '3', '1740', '1');
INSERT INTO `area` VALUES ('370123', '3701', '长清县', '3', '1741', '1');
INSERT INTO `area` VALUES ('370124', '3701', '平阴县', '3', '1742', '1');
INSERT INTO `area` VALUES ('370125', '3701', '济阳县', '3', '1743', '1');
INSERT INTO `area` VALUES ('370126', '3701', '商河县', '3', '1744', '1');
INSERT INTO `area` VALUES ('370181', '3701', '章丘市', '3', '1745', '1');
INSERT INTO `area` VALUES ('370201', '3702', '市辖区', '3', '1746', '1');
INSERT INTO `area` VALUES ('370202', '3702', '市南区', '3', '1747', '1');
INSERT INTO `area` VALUES ('370203', '3702', '市北区', '3', '1748', '1');
INSERT INTO `area` VALUES ('370205', '3702', '四方区', '3', '1749', '1');
INSERT INTO `area` VALUES ('370211', '3702', '黄岛区', '3', '1750', '1');
INSERT INTO `area` VALUES ('370212', '3702', '崂山区', '3', '1751', '1');
INSERT INTO `area` VALUES ('370213', '3702', '李沧区', '3', '1752', '1');
INSERT INTO `area` VALUES ('370214', '3702', '城阳区', '3', '1753', '1');
INSERT INTO `area` VALUES ('370281', '3702', '胶州市', '3', '1754', '1');
INSERT INTO `area` VALUES ('370282', '3702', '即墨市', '3', '1755', '1');
INSERT INTO `area` VALUES ('370283', '3702', '平度市', '3', '1756', '1');
INSERT INTO `area` VALUES ('370284', '3702', '胶南市', '3', '1757', '1');
INSERT INTO `area` VALUES ('370285', '3702', '莱西市', '3', '1758', '1');
INSERT INTO `area` VALUES ('370301', '3703', '市辖区', '3', '1759', '1');
INSERT INTO `area` VALUES ('370302', '3703', '淄川区', '3', '1760', '1');
INSERT INTO `area` VALUES ('370303', '3703', '张店区', '3', '1761', '1');
INSERT INTO `area` VALUES ('370304', '3703', '博山区', '3', '1762', '1');
INSERT INTO `area` VALUES ('370305', '3703', '临淄区', '3', '1763', '1');
INSERT INTO `area` VALUES ('370306', '3703', '周村区', '3', '1764', '1');
INSERT INTO `area` VALUES ('370321', '3703', '桓台县', '3', '1765', '1');
INSERT INTO `area` VALUES ('370322', '3703', '高青县', '3', '1766', '1');
INSERT INTO `area` VALUES ('370323', '3703', '沂源县', '3', '1767', '1');
INSERT INTO `area` VALUES ('370401', '3704', '市辖区', '3', '1768', '1');
INSERT INTO `area` VALUES ('370402', '3704', '市中区', '3', '1769', '1');
INSERT INTO `area` VALUES ('370403', '3704', '薛城区', '3', '1770', '1');
INSERT INTO `area` VALUES ('370404', '3704', '峄城区', '3', '1771', '1');
INSERT INTO `area` VALUES ('370405', '3704', '台儿庄区', '3', '1772', '1');
INSERT INTO `area` VALUES ('370406', '3704', '山亭区', '3', '1773', '1');
INSERT INTO `area` VALUES ('370481', '3704', '滕州市', '3', '1774', '1');
INSERT INTO `area` VALUES ('370501', '3705', '市辖区', '3', '1775', '1');
INSERT INTO `area` VALUES ('370502', '3705', '东营区', '3', '1776', '1');
INSERT INTO `area` VALUES ('370503', '3705', '河口区', '3', '1777', '1');
INSERT INTO `area` VALUES ('370521', '3705', '垦利县', '3', '1778', '1');
INSERT INTO `area` VALUES ('370522', '3705', '利津县', '3', '1779', '1');
INSERT INTO `area` VALUES ('370523', '3705', '广饶县', '3', '1780', '1');
INSERT INTO `area` VALUES ('370601', '3706', '市辖区', '3', '1781', '1');
INSERT INTO `area` VALUES ('370602', '3706', '芝罘区', '3', '1782', '1');
INSERT INTO `area` VALUES ('370611', '3706', '福山区', '3', '1783', '1');
INSERT INTO `area` VALUES ('370612', '3706', '牟平区', '3', '1784', '1');
INSERT INTO `area` VALUES ('370613', '3706', '莱山区', '3', '1785', '1');
INSERT INTO `area` VALUES ('370634', '3706', '长岛县', '3', '1786', '1');
INSERT INTO `area` VALUES ('370681', '3706', '龙口市', '3', '1787', '1');
INSERT INTO `area` VALUES ('370682', '3706', '莱阳市', '3', '1788', '1');
INSERT INTO `area` VALUES ('370683', '3706', '莱州市', '3', '1789', '1');
INSERT INTO `area` VALUES ('370684', '3706', '蓬莱市', '3', '1790', '1');
INSERT INTO `area` VALUES ('370685', '3706', '招远市', '3', '1791', '1');
INSERT INTO `area` VALUES ('370686', '3706', '栖霞市', '3', '1792', '1');
INSERT INTO `area` VALUES ('370687', '3706', '海阳市', '3', '1793', '1');
INSERT INTO `area` VALUES ('370701', '3707', '市辖区', '3', '1794', '1');
INSERT INTO `area` VALUES ('370702', '3707', '潍城区', '3', '1795', '1');
INSERT INTO `area` VALUES ('370703', '3707', '寒亭区', '3', '1796', '1');
INSERT INTO `area` VALUES ('370704', '3707', '坊子区', '3', '1797', '1');
INSERT INTO `area` VALUES ('370705', '3707', '奎文区', '3', '1798', '1');
INSERT INTO `area` VALUES ('370724', '3707', '临朐县', '3', '1799', '1');
INSERT INTO `area` VALUES ('370725', '3707', '昌乐县', '3', '1800', '1');
INSERT INTO `area` VALUES ('370781', '3707', '青州市', '3', '1801', '1');
INSERT INTO `area` VALUES ('370782', '3707', '诸城市', '3', '1802', '1');
INSERT INTO `area` VALUES ('370783', '3707', '寿光市', '3', '1803', '1');
INSERT INTO `area` VALUES ('370784', '3707', '安丘市', '3', '1804', '1');
INSERT INTO `area` VALUES ('370785', '3707', '高密市', '3', '1805', '1');
INSERT INTO `area` VALUES ('370786', '3707', '昌邑市', '3', '1806', '1');
INSERT INTO `area` VALUES ('370801', '3708', '市辖区', '3', '1807', '1');
INSERT INTO `area` VALUES ('370802', '3708', '市中区', '3', '1808', '1');
INSERT INTO `area` VALUES ('370811', '3708', '任城区', '3', '1809', '1');
INSERT INTO `area` VALUES ('370826', '3708', '微山县', '3', '1810', '1');
INSERT INTO `area` VALUES ('370827', '3708', '鱼台县', '3', '1811', '1');
INSERT INTO `area` VALUES ('370828', '3708', '金乡县', '3', '1812', '1');
INSERT INTO `area` VALUES ('370829', '3708', '嘉祥县', '3', '1813', '1');
INSERT INTO `area` VALUES ('370830', '3708', '汶上县', '3', '1814', '1');
INSERT INTO `area` VALUES ('370831', '3708', '泗水县', '3', '1815', '1');
INSERT INTO `area` VALUES ('370832', '3708', '梁山县', '3', '1816', '1');
INSERT INTO `area` VALUES ('370881', '3708', '曲阜市', '3', '1817', '1');
INSERT INTO `area` VALUES ('370882', '3708', '兖州市', '3', '1818', '1');
INSERT INTO `area` VALUES ('370883', '3708', '邹城市', '3', '1819', '1');
INSERT INTO `area` VALUES ('370901', '3709', '市辖区', '3', '1820', '1');
INSERT INTO `area` VALUES ('370902', '3709', '泰山区', '3', '1821', '1');
INSERT INTO `area` VALUES ('370903', '3709', '岱岳区', '3', '1822', '1');
INSERT INTO `area` VALUES ('370921', '3709', '宁阳县', '3', '1823', '1');
INSERT INTO `area` VALUES ('370923', '3709', '东平县', '3', '1824', '1');
INSERT INTO `area` VALUES ('370982', '3709', '新泰市', '3', '1825', '1');
INSERT INTO `area` VALUES ('370983', '3709', '肥城市', '3', '1826', '1');
INSERT INTO `area` VALUES ('371001', '3710', '市辖区', '3', '1827', '1');
INSERT INTO `area` VALUES ('371002', '3710', '环翠区', '3', '1828', '1');
INSERT INTO `area` VALUES ('371081', '3710', '文登市', '3', '1829', '1');
INSERT INTO `area` VALUES ('371082', '3710', '荣成市', '3', '1830', '1');
INSERT INTO `area` VALUES ('371083', '3710', '乳山市', '3', '1831', '1');
INSERT INTO `area` VALUES ('371101', '3711', '市辖区', '3', '1832', '1');
INSERT INTO `area` VALUES ('371102', '3711', '东港区', '3', '1833', '1');
INSERT INTO `area` VALUES ('371121', '3711', '五莲县', '3', '1834', '1');
INSERT INTO `area` VALUES ('371122', '3711', '莒  县', '3', '1835', '1');
INSERT INTO `area` VALUES ('371201', '3712', '市辖区', '3', '1836', '1');
INSERT INTO `area` VALUES ('371202', '3712', '莱城区', '3', '1837', '1');
INSERT INTO `area` VALUES ('371203', '3712', '钢城区', '3', '1838', '1');
INSERT INTO `area` VALUES ('371301', '3713', '市辖区', '3', '1839', '1');
INSERT INTO `area` VALUES ('371302', '3713', '兰山区', '3', '1840', '1');
INSERT INTO `area` VALUES ('371311', '3713', '罗庄区', '3', '1841', '1');
INSERT INTO `area` VALUES ('371312', '3713', '河东区', '3', '1842', '1');
INSERT INTO `area` VALUES ('371321', '3713', '沂南县', '3', '1843', '1');
INSERT INTO `area` VALUES ('371322', '3713', '郯城县', '3', '1844', '1');
INSERT INTO `area` VALUES ('371323', '3713', '沂水县', '3', '1845', '1');
INSERT INTO `area` VALUES ('371324', '3713', '苍山县', '3', '1846', '1');
INSERT INTO `area` VALUES ('371325', '3713', '费  县', '3', '1847', '1');
INSERT INTO `area` VALUES ('371326', '3713', '平邑县', '3', '1848', '1');
INSERT INTO `area` VALUES ('371327', '3713', '莒南县', '3', '1849', '1');
INSERT INTO `area` VALUES ('371328', '3713', '蒙阴县', '3', '1850', '1');
INSERT INTO `area` VALUES ('371329', '3713', '临沭县', '3', '1851', '1');
INSERT INTO `area` VALUES ('371401', '3714', '市辖区', '3', '1852', '1');
INSERT INTO `area` VALUES ('371402', '3714', '德城区', '3', '1853', '1');
INSERT INTO `area` VALUES ('371421', '3714', '陵  县', '3', '1854', '1');
INSERT INTO `area` VALUES ('371422', '3714', '宁津县', '3', '1855', '1');
INSERT INTO `area` VALUES ('371423', '3714', '庆云县', '3', '1856', '1');
INSERT INTO `area` VALUES ('371424', '3714', '临邑县', '3', '1857', '1');
INSERT INTO `area` VALUES ('371425', '3714', '齐河县', '3', '1858', '1');
INSERT INTO `area` VALUES ('371426', '3714', '平原县', '3', '1859', '1');
INSERT INTO `area` VALUES ('371427', '3714', '夏津县', '3', '1860', '1');
INSERT INTO `area` VALUES ('371428', '3714', '武城县', '3', '1861', '1');
INSERT INTO `area` VALUES ('371481', '3714', '乐陵市', '3', '1862', '1');
INSERT INTO `area` VALUES ('371482', '3714', '禹城市', '3', '1863', '1');
INSERT INTO `area` VALUES ('371501', '3715', '市辖区', '3', '1864', '1');
INSERT INTO `area` VALUES ('371502', '3715', '东昌府区', '3', '1865', '1');
INSERT INTO `area` VALUES ('371521', '3715', '阳谷县', '3', '1866', '1');
INSERT INTO `area` VALUES ('371522', '3715', '莘  县', '3', '1867', '1');
INSERT INTO `area` VALUES ('371523', '3715', '茌平县', '3', '1868', '1');
INSERT INTO `area` VALUES ('371524', '3715', '东阿县', '3', '1869', '1');
INSERT INTO `area` VALUES ('371525', '3715', '冠  县', '3', '1870', '1');
INSERT INTO `area` VALUES ('371526', '3715', '高唐县', '3', '1871', '1');
INSERT INTO `area` VALUES ('371581', '3715', '临清市', '3', '1872', '1');
INSERT INTO `area` VALUES ('371601', '3716', '市辖区', '3', '1873', '1');
INSERT INTO `area` VALUES ('371603', '3716', '滨城区', '3', '1874', '1');
INSERT INTO `area` VALUES ('371621', '3716', '惠民县', '3', '1875', '1');
INSERT INTO `area` VALUES ('371622', '3716', '阳信县', '3', '1876', '1');
INSERT INTO `area` VALUES ('371623', '3716', '无棣县', '3', '1877', '1');
INSERT INTO `area` VALUES ('371624', '3716', '沾化县', '3', '1878', '1');
INSERT INTO `area` VALUES ('371625', '3716', '博兴县', '3', '1879', '1');
INSERT INTO `area` VALUES ('371626', '3716', '邹平县', '3', '1880', '1');
INSERT INTO `area` VALUES ('371701', '3717', '市辖区', '3', '1881', '1');
INSERT INTO `area` VALUES ('371702', '3717', '牡丹区', '3', '1882', '1');
INSERT INTO `area` VALUES ('371721', '3717', '曹  县', '3', '1883', '1');
INSERT INTO `area` VALUES ('371722', '3717', '单  县', '3', '1884', '1');
INSERT INTO `area` VALUES ('371723', '3717', '成武县', '3', '1885', '1');
INSERT INTO `area` VALUES ('371724', '3717', '巨野县', '3', '1886', '1');
INSERT INTO `area` VALUES ('371725', '3717', '郓城县', '3', '1887', '1');
INSERT INTO `area` VALUES ('371726', '3717', '鄄城县', '3', '1888', '1');
INSERT INTO `area` VALUES ('371727', '3717', '定陶县', '3', '1889', '1');
INSERT INTO `area` VALUES ('371728', '3717', '东明县', '3', '1890', '1');
INSERT INTO `area` VALUES ('410101', '4101', '市辖区', '3', '1891', '1');
INSERT INTO `area` VALUES ('410102', '4101', '中原区', '3', '1892', '1');
INSERT INTO `area` VALUES ('410103', '4101', '二七区', '3', '1893', '1');
INSERT INTO `area` VALUES ('410104', '4101', '管城回族区', '3', '1894', '1');
INSERT INTO `area` VALUES ('410105', '4101', '金水区', '3', '1895', '1');
INSERT INTO `area` VALUES ('410106', '4101', '上街区', '3', '1896', '1');
INSERT INTO `area` VALUES ('410108', '4101', '邙山区', '3', '1897', '1');
INSERT INTO `area` VALUES ('410122', '4101', '中牟县', '3', '1898', '1');
INSERT INTO `area` VALUES ('410181', '4101', '巩义市', '3', '1899', '1');
INSERT INTO `area` VALUES ('410182', '4101', '荥阳市', '3', '1900', '1');
INSERT INTO `area` VALUES ('410183', '4101', '新密市', '3', '1901', '1');
INSERT INTO `area` VALUES ('410184', '4101', '新郑市', '3', '1902', '1');
INSERT INTO `area` VALUES ('410185', '4101', '登封市', '3', '1903', '1');
INSERT INTO `area` VALUES ('410201', '4102', '市辖区', '3', '1904', '1');
INSERT INTO `area` VALUES ('410202', '4102', '龙亭区', '3', '1905', '1');
INSERT INTO `area` VALUES ('410203', '4102', '顺河回族区', '3', '1906', '1');
INSERT INTO `area` VALUES ('410204', '4102', '鼓楼区', '3', '1907', '1');
INSERT INTO `area` VALUES ('410205', '4102', '南关区', '3', '1908', '1');
INSERT INTO `area` VALUES ('410211', '4102', '郊  区', '3', '1909', '1');
INSERT INTO `area` VALUES ('410221', '4102', '杞  县', '3', '1910', '1');
INSERT INTO `area` VALUES ('410222', '4102', '通许县', '3', '1911', '1');
INSERT INTO `area` VALUES ('410223', '4102', '尉氏县', '3', '1912', '1');
INSERT INTO `area` VALUES ('410224', '4102', '开封县', '3', '1913', '1');
INSERT INTO `area` VALUES ('410225', '4102', '兰考县', '3', '1914', '1');
INSERT INTO `area` VALUES ('410301', '4103', '市辖区', '3', '1915', '1');
INSERT INTO `area` VALUES ('410302', '4103', '老城区', '3', '1916', '1');
INSERT INTO `area` VALUES ('410303', '4103', '西工区', '3', '1917', '1');
INSERT INTO `area` VALUES ('410304', '4103', '廛河回族区', '3', '1918', '1');
INSERT INTO `area` VALUES ('410305', '4103', '涧西区', '3', '1919', '1');
INSERT INTO `area` VALUES ('410306', '4103', '吉利区', '3', '1920', '1');
INSERT INTO `area` VALUES ('410307', '4103', '洛龙区', '3', '1921', '1');
INSERT INTO `area` VALUES ('410322', '4103', '孟津县', '3', '1922', '1');
INSERT INTO `area` VALUES ('410323', '4103', '新安县', '3', '1923', '1');
INSERT INTO `area` VALUES ('410324', '4103', '栾川县', '3', '1924', '1');
INSERT INTO `area` VALUES ('410325', '4103', '嵩  县', '3', '1925', '1');
INSERT INTO `area` VALUES ('410326', '4103', '汝阳县', '3', '1926', '1');
INSERT INTO `area` VALUES ('410327', '4103', '宜阳县', '3', '1927', '1');
INSERT INTO `area` VALUES ('410328', '4103', '洛宁县', '3', '1928', '1');
INSERT INTO `area` VALUES ('410329', '4103', '伊川县', '3', '1929', '1');
INSERT INTO `area` VALUES ('410381', '4103', '偃师市', '3', '1930', '1');
INSERT INTO `area` VALUES ('410401', '4104', '市辖区', '3', '1931', '1');
INSERT INTO `area` VALUES ('410402', '4104', '新华区', '3', '1932', '1');
INSERT INTO `area` VALUES ('410403', '4104', '卫东区', '3', '1933', '1');
INSERT INTO `area` VALUES ('410404', '4104', '石龙区', '3', '1934', '1');
INSERT INTO `area` VALUES ('410411', '4104', '湛河区', '3', '1935', '1');
INSERT INTO `area` VALUES ('410421', '4104', '宝丰县', '3', '1936', '1');
INSERT INTO `area` VALUES ('410422', '4104', '叶  县', '3', '1937', '1');
INSERT INTO `area` VALUES ('410423', '4104', '鲁山县', '3', '1938', '1');
INSERT INTO `area` VALUES ('410425', '4104', '郏  县', '3', '1939', '1');
INSERT INTO `area` VALUES ('410481', '4104', '舞钢市', '3', '1940', '1');
INSERT INTO `area` VALUES ('410482', '4104', '汝州市', '3', '1941', '1');
INSERT INTO `area` VALUES ('410501', '4105', '市辖区', '3', '1942', '1');
INSERT INTO `area` VALUES ('410502', '4105', '文峰区', '3', '1943', '1');
INSERT INTO `area` VALUES ('410503', '4105', '北关区', '3', '1944', '1');
INSERT INTO `area` VALUES ('410504', '4105', '铁西区', '3', '1945', '1');
INSERT INTO `area` VALUES ('410511', '4105', '郊  区', '3', '1946', '1');
INSERT INTO `area` VALUES ('410522', '4105', '安阳县', '3', '1947', '1');
INSERT INTO `area` VALUES ('410523', '4105', '汤阴县', '3', '1948', '1');
INSERT INTO `area` VALUES ('410526', '4105', '滑  县', '3', '1949', '1');
INSERT INTO `area` VALUES ('410527', '4105', '内黄县', '3', '1950', '1');
INSERT INTO `area` VALUES ('410581', '4105', '林州市', '3', '1951', '1');
INSERT INTO `area` VALUES ('410601', '4106', '市辖区', '3', '1952', '1');
INSERT INTO `area` VALUES ('410602', '4106', '鹤山区', '3', '1953', '1');
INSERT INTO `area` VALUES ('410603', '4106', '山城区', '3', '1954', '1');
INSERT INTO `area` VALUES ('410611', '4106', '郊  区', '3', '1955', '1');
INSERT INTO `area` VALUES ('410621', '4106', '浚  县', '3', '1956', '1');
INSERT INTO `area` VALUES ('410622', '4106', '淇  县', '3', '1957', '1');
INSERT INTO `area` VALUES ('410701', '4107', '市辖区', '3', '1958', '1');
INSERT INTO `area` VALUES ('410702', '4107', '红旗区', '3', '1959', '1');
INSERT INTO `area` VALUES ('410703', '4107', '新华区', '3', '1960', '1');
INSERT INTO `area` VALUES ('410704', '4107', '北站区', '3', '1961', '1');
INSERT INTO `area` VALUES ('410711', '4107', '郊  区', '3', '1962', '1');
INSERT INTO `area` VALUES ('410721', '4107', '新乡县', '3', '1963', '1');
INSERT INTO `area` VALUES ('410724', '4107', '获嘉县', '3', '1964', '1');
INSERT INTO `area` VALUES ('410725', '4107', '原阳县', '3', '1965', '1');
INSERT INTO `area` VALUES ('410726', '4107', '延津县', '3', '1966', '1');
INSERT INTO `area` VALUES ('410727', '4107', '封丘县', '3', '1967', '1');
INSERT INTO `area` VALUES ('410728', '4107', '长垣县', '3', '1968', '1');
INSERT INTO `area` VALUES ('410781', '4107', '卫辉市', '3', '1969', '1');
INSERT INTO `area` VALUES ('410782', '4107', '辉县市', '3', '1970', '1');
INSERT INTO `area` VALUES ('410801', '4108', '市辖区', '3', '1971', '1');
INSERT INTO `area` VALUES ('410802', '4108', '解放区', '3', '1972', '1');
INSERT INTO `area` VALUES ('410803', '4108', '中站区', '3', '1973', '1');
INSERT INTO `area` VALUES ('410804', '4108', '马村区', '3', '1974', '1');
INSERT INTO `area` VALUES ('410811', '4108', '山阳区', '3', '1975', '1');
INSERT INTO `area` VALUES ('410821', '4108', '修武县', '3', '1976', '1');
INSERT INTO `area` VALUES ('410822', '4108', '博爱县', '3', '1977', '1');
INSERT INTO `area` VALUES ('410823', '4108', '武陟县', '3', '1978', '1');
INSERT INTO `area` VALUES ('410825', '4108', '温  县', '3', '1979', '1');
INSERT INTO `area` VALUES ('410881', '4108', '济源市', '3', '1980', '1');
INSERT INTO `area` VALUES ('410882', '4108', '沁阳市', '3', '1981', '1');
INSERT INTO `area` VALUES ('410883', '4108', '孟州市', '3', '1982', '1');
INSERT INTO `area` VALUES ('410901', '4109', '市辖区', '3', '1983', '1');
INSERT INTO `area` VALUES ('410902', '4109', '市  区', '3', '1984', '1');
INSERT INTO `area` VALUES ('410922', '4109', '清丰县', '3', '1985', '1');
INSERT INTO `area` VALUES ('410923', '4109', '南乐县', '3', '1986', '1');
INSERT INTO `area` VALUES ('410926', '4109', '范  县', '3', '1987', '1');
INSERT INTO `area` VALUES ('410927', '4109', '台前县', '3', '1988', '1');
INSERT INTO `area` VALUES ('410928', '4109', '濮阳县', '3', '1989', '1');
INSERT INTO `area` VALUES ('411001', '4110', '市辖区', '3', '1990', '1');
INSERT INTO `area` VALUES ('411002', '4110', '魏都区', '3', '1991', '1');
INSERT INTO `area` VALUES ('411023', '4110', '许昌县', '3', '1992', '1');
INSERT INTO `area` VALUES ('411024', '4110', '鄢陵县', '3', '1993', '1');
INSERT INTO `area` VALUES ('411025', '4110', '襄城县', '3', '1994', '1');
INSERT INTO `area` VALUES ('411081', '4110', '禹州市', '3', '1995', '1');
INSERT INTO `area` VALUES ('411082', '4110', '长葛市', '3', '1996', '1');
INSERT INTO `area` VALUES ('411101', '4111', '市辖区', '3', '1997', '1');
INSERT INTO `area` VALUES ('411102', '4111', '源汇区', '3', '1998', '1');
INSERT INTO `area` VALUES ('411121', '4111', '舞阳县', '3', '1999', '1');
INSERT INTO `area` VALUES ('411122', '4111', '临颍县', '3', '2000', '1');
INSERT INTO `area` VALUES ('411123', '4111', '郾城县', '3', '2001', '1');
INSERT INTO `area` VALUES ('411201', '4112', '市辖区', '3', '2002', '1');
INSERT INTO `area` VALUES ('411202', '4112', '湖滨区', '3', '2003', '1');
INSERT INTO `area` VALUES ('411221', '4112', '渑池县', '3', '2004', '1');
INSERT INTO `area` VALUES ('411222', '4112', '陕  县', '3', '2005', '1');
INSERT INTO `area` VALUES ('411224', '4112', '卢氏县', '3', '2006', '1');
INSERT INTO `area` VALUES ('411281', '4112', '义马市', '3', '2007', '1');
INSERT INTO `area` VALUES ('411282', '4112', '灵宝市', '3', '2008', '1');
INSERT INTO `area` VALUES ('411301', '4113', '市辖区', '3', '2009', '1');
INSERT INTO `area` VALUES ('411302', '4113', '宛城区', '3', '2010', '1');
INSERT INTO `area` VALUES ('411303', '4113', '卧龙区', '3', '2011', '1');
INSERT INTO `area` VALUES ('411321', '4113', '南召县', '3', '2012', '1');
INSERT INTO `area` VALUES ('411322', '4113', '方城县', '3', '2013', '1');
INSERT INTO `area` VALUES ('411323', '4113', '西峡县', '3', '2014', '1');
INSERT INTO `area` VALUES ('411324', '4113', '镇平县', '3', '2015', '1');
INSERT INTO `area` VALUES ('411325', '4113', '内乡县', '3', '2016', '1');
INSERT INTO `area` VALUES ('411326', '4113', '淅川县', '3', '2017', '1');
INSERT INTO `area` VALUES ('411327', '4113', '社旗县', '3', '2018', '1');
INSERT INTO `area` VALUES ('411328', '4113', '唐河县', '3', '2019', '1');
INSERT INTO `area` VALUES ('411329', '4113', '新野县', '3', '2020', '1');
INSERT INTO `area` VALUES ('411330', '4113', '桐柏县', '3', '2021', '1');
INSERT INTO `area` VALUES ('411381', '4113', '邓州市', '3', '2022', '1');
INSERT INTO `area` VALUES ('411401', '4114', '市辖区', '3', '2023', '1');
INSERT INTO `area` VALUES ('411402', '4114', '梁园区', '3', '2024', '1');
INSERT INTO `area` VALUES ('411403', '4114', '睢阳区', '3', '2025', '1');
INSERT INTO `area` VALUES ('411421', '4114', '民权县', '3', '2026', '1');
INSERT INTO `area` VALUES ('411422', '4114', '睢  县', '3', '2027', '1');
INSERT INTO `area` VALUES ('411423', '4114', '宁陵县', '3', '2028', '1');
INSERT INTO `area` VALUES ('411424', '4114', '柘城县', '3', '2029', '1');
INSERT INTO `area` VALUES ('411425', '4114', '虞城县', '3', '2030', '1');
INSERT INTO `area` VALUES ('411426', '4114', '夏邑县', '3', '2031', '1');
INSERT INTO `area` VALUES ('411481', '4114', '永城市', '3', '2032', '1');
INSERT INTO `area` VALUES ('411501', '4115', '市辖区', '3', '2033', '1');
INSERT INTO `area` VALUES ('411502', '4115', '师河区', '3', '2034', '1');
INSERT INTO `area` VALUES ('411503', '4115', '平桥区', '3', '2035', '1');
INSERT INTO `area` VALUES ('411521', '4115', '罗山县', '3', '2036', '1');
INSERT INTO `area` VALUES ('411522', '4115', '光山县', '3', '2037', '1');
INSERT INTO `area` VALUES ('411523', '4115', '新  县', '3', '2038', '1');
INSERT INTO `area` VALUES ('411524', '4115', '商城县', '3', '2039', '1');
INSERT INTO `area` VALUES ('411525', '4115', '固始县', '3', '2040', '1');
INSERT INTO `area` VALUES ('411526', '4115', '潢川县', '3', '2041', '1');
INSERT INTO `area` VALUES ('411527', '4115', '淮滨县', '3', '2042', '1');
INSERT INTO `area` VALUES ('411528', '4115', '息  县', '3', '2043', '1');
INSERT INTO `area` VALUES ('411601', '4116', '市辖区', '3', '2044', '1');
INSERT INTO `area` VALUES ('411602', '4116', '川汇区', '3', '2045', '1');
INSERT INTO `area` VALUES ('411621', '4116', '扶沟县', '3', '2046', '1');
INSERT INTO `area` VALUES ('411622', '4116', '西华县', '3', '2047', '1');
INSERT INTO `area` VALUES ('411623', '4116', '商水县', '3', '2048', '1');
INSERT INTO `area` VALUES ('411624', '4116', '沈丘县', '3', '2049', '1');
INSERT INTO `area` VALUES ('411625', '4116', '郸城县', '3', '2050', '1');
INSERT INTO `area` VALUES ('411626', '4116', '淮阳县', '3', '2051', '1');
INSERT INTO `area` VALUES ('411627', '4116', '太康县', '3', '2052', '1');
INSERT INTO `area` VALUES ('411628', '4116', '鹿邑县', '3', '2053', '1');
INSERT INTO `area` VALUES ('411681', '4116', '项城市', '3', '2054', '1');
INSERT INTO `area` VALUES ('411701', '4117', '市辖区', '3', '2055', '1');
INSERT INTO `area` VALUES ('411702', '4117', '驿城区', '3', '2056', '1');
INSERT INTO `area` VALUES ('411721', '4117', '西平县', '3', '2057', '1');
INSERT INTO `area` VALUES ('411722', '4117', '上蔡县', '3', '2058', '1');
INSERT INTO `area` VALUES ('411723', '4117', '平舆县', '3', '2059', '1');
INSERT INTO `area` VALUES ('411724', '4117', '正阳县', '3', '2060', '1');
INSERT INTO `area` VALUES ('411725', '4117', '确山县', '3', '2061', '1');
INSERT INTO `area` VALUES ('411726', '4117', '泌阳县', '3', '2062', '1');
INSERT INTO `area` VALUES ('411727', '4117', '汝南县', '3', '2063', '1');
INSERT INTO `area` VALUES ('411728', '4117', '遂平县', '3', '2064', '1');
INSERT INTO `area` VALUES ('411729', '4117', '新蔡县', '3', '2065', '1');
INSERT INTO `area` VALUES ('420101', '4201', '市辖区', '3', '2066', '1');
INSERT INTO `area` VALUES ('420102', '4201', '江岸区', '3', '2067', '1');
INSERT INTO `area` VALUES ('420103', '4201', '江汉区', '3', '2068', '1');
INSERT INTO `area` VALUES ('420104', '4201', '乔口区', '3', '2069', '1');
INSERT INTO `area` VALUES ('420105', '4201', '汉阳区', '3', '2070', '1');
INSERT INTO `area` VALUES ('420106', '4201', '武昌区', '3', '2071', '1');
INSERT INTO `area` VALUES ('420107', '4201', '青山区', '3', '2072', '1');
INSERT INTO `area` VALUES ('420111', '4201', '洪山区', '3', '2073', '1');
INSERT INTO `area` VALUES ('420112', '4201', '东西湖区', '3', '2074', '1');
INSERT INTO `area` VALUES ('420113', '4201', '汉南区', '3', '2075', '1');
INSERT INTO `area` VALUES ('420114', '4201', '蔡甸区', '3', '2076', '1');
INSERT INTO `area` VALUES ('420115', '4201', '江夏区', '3', '2077', '1');
INSERT INTO `area` VALUES ('420116', '4201', '黄陂区', '3', '2078', '1');
INSERT INTO `area` VALUES ('420117', '4201', '新洲区', '3', '2079', '1');
INSERT INTO `area` VALUES ('420201', '4202', '市辖区', '3', '2080', '1');
INSERT INTO `area` VALUES ('420202', '4202', '黄石港区', '3', '2081', '1');
INSERT INTO `area` VALUES ('420203', '4202', '石灰窑区', '3', '2082', '1');
INSERT INTO `area` VALUES ('420204', '4202', '下陆区', '3', '2083', '1');
INSERT INTO `area` VALUES ('420205', '4202', '铁山区', '3', '2084', '1');
INSERT INTO `area` VALUES ('420222', '4202', '阳新县', '3', '2085', '1');
INSERT INTO `area` VALUES ('420281', '4202', '大冶市', '3', '2086', '1');
INSERT INTO `area` VALUES ('420301', '4203', '市辖区', '3', '2087', '1');
INSERT INTO `area` VALUES ('420302', '4203', '茅箭区', '3', '2088', '1');
INSERT INTO `area` VALUES ('420303', '4203', '张湾区', '3', '2089', '1');
INSERT INTO `area` VALUES ('420321', '4203', '郧  县', '3', '2090', '1');
INSERT INTO `area` VALUES ('420322', '4203', '郧西县', '3', '2091', '1');
INSERT INTO `area` VALUES ('420323', '4203', '竹山县', '3', '2092', '1');
INSERT INTO `area` VALUES ('420324', '4203', '竹溪县', '3', '2093', '1');
INSERT INTO `area` VALUES ('420325', '4203', '房  县', '3', '2094', '1');
INSERT INTO `area` VALUES ('420381', '4203', '丹江口市', '3', '2095', '1');
INSERT INTO `area` VALUES ('420501', '4205', '市辖区', '3', '2096', '1');
INSERT INTO `area` VALUES ('420502', '4205', '西陵区', '3', '2097', '1');
INSERT INTO `area` VALUES ('420503', '4205', '伍家岗区', '3', '2098', '1');
INSERT INTO `area` VALUES ('420504', '4205', '点军区', '3', '2099', '1');
INSERT INTO `area` VALUES ('420505', '4205', '虎亭区', '3', '2100', '1');
INSERT INTO `area` VALUES ('420521', '4205', '宜昌县', '3', '2101', '1');
INSERT INTO `area` VALUES ('420525', '4205', '远安县', '3', '2102', '1');
INSERT INTO `area` VALUES ('420526', '4205', '兴山县', '3', '2103', '1');
INSERT INTO `area` VALUES ('420527', '4205', '秭归县', '3', '2104', '1');
INSERT INTO `area` VALUES ('420528', '4205', '长阳土家族自治县', '3', '2105', '1');
INSERT INTO `area` VALUES ('420529', '4205', '五峰土家族自治县', '3', '2106', '1');
INSERT INTO `area` VALUES ('420581', '4205', '宜都市', '3', '2107', '1');
INSERT INTO `area` VALUES ('420582', '4205', '当阳市', '3', '2108', '1');
INSERT INTO `area` VALUES ('420583', '4205', '枝江市', '3', '2109', '1');
INSERT INTO `area` VALUES ('420601', '4206', '市辖区', '3', '2110', '1');
INSERT INTO `area` VALUES ('420602', '4206', '襄城区', '3', '2111', '1');
INSERT INTO `area` VALUES ('420606', '4206', '樊城区', '3', '2112', '1');
INSERT INTO `area` VALUES ('420621', '4206', '襄阳县', '3', '2113', '1');
INSERT INTO `area` VALUES ('420624', '4206', '南漳县', '3', '2114', '1');
INSERT INTO `area` VALUES ('420625', '4206', '谷城县', '3', '2115', '1');
INSERT INTO `area` VALUES ('420626', '4206', '保康县', '3', '2116', '1');
INSERT INTO `area` VALUES ('420682', '4206', '老河口市', '3', '2117', '1');
INSERT INTO `area` VALUES ('420683', '4206', '枣阳市', '3', '2118', '1');
INSERT INTO `area` VALUES ('420684', '4206', '宜城市', '3', '2119', '1');
INSERT INTO `area` VALUES ('420701', '4207', '市辖区', '3', '2120', '1');
INSERT INTO `area` VALUES ('420702', '4207', '梁子湖区', '3', '2121', '1');
INSERT INTO `area` VALUES ('420703', '4207', '华容区', '3', '2122', '1');
INSERT INTO `area` VALUES ('420704', '4207', '鄂城区', '3', '2123', '1');
INSERT INTO `area` VALUES ('420801', '4208', '市辖区', '3', '2124', '1');
INSERT INTO `area` VALUES ('420802', '4208', '东宝区', '3', '2125', '1');
INSERT INTO `area` VALUES ('420821', '4208', '京山县', '3', '2126', '1');
INSERT INTO `area` VALUES ('420822', '4208', '沙洋县', '3', '2127', '1');
INSERT INTO `area` VALUES ('420881', '4208', '钟祥市', '3', '2128', '1');
INSERT INTO `area` VALUES ('420901', '4209', '市辖区', '3', '2129', '1');
INSERT INTO `area` VALUES ('420902', '4209', '孝南区', '3', '2130', '1');
INSERT INTO `area` VALUES ('420921', '4209', '孝昌县', '3', '2131', '1');
INSERT INTO `area` VALUES ('420922', '4209', '大悟县', '3', '2132', '1');
INSERT INTO `area` VALUES ('420923', '4209', '云梦县', '3', '2133', '1');
INSERT INTO `area` VALUES ('420981', '4209', '应城市', '3', '2134', '1');
INSERT INTO `area` VALUES ('420982', '4209', '安陆市', '3', '2135', '1');
INSERT INTO `area` VALUES ('420984', '4209', '汉川市', '3', '2136', '1');
INSERT INTO `area` VALUES ('421001', '4210', '市辖区', '3', '2137', '1');
INSERT INTO `area` VALUES ('421002', '4210', '沙市区', '3', '2138', '1');
INSERT INTO `area` VALUES ('421003', '4210', '荆州区', '3', '2139', '1');
INSERT INTO `area` VALUES ('421022', '4210', '公安县', '3', '2140', '1');
INSERT INTO `area` VALUES ('421023', '4210', '监利县', '3', '2141', '1');
INSERT INTO `area` VALUES ('421024', '4210', '江陵县', '3', '2142', '1');
INSERT INTO `area` VALUES ('421081', '4210', '石首市', '3', '2143', '1');
INSERT INTO `area` VALUES ('421083', '4210', '洪湖市', '3', '2144', '1');
INSERT INTO `area` VALUES ('421087', '4210', '松滋市', '3', '2145', '1');
INSERT INTO `area` VALUES ('421101', '4211', '市辖区', '3', '2146', '1');
INSERT INTO `area` VALUES ('421102', '4211', '黄州区', '3', '2147', '1');
INSERT INTO `area` VALUES ('421121', '4211', '团风县', '3', '2148', '1');
INSERT INTO `area` VALUES ('421122', '4211', '红安县', '3', '2149', '1');
INSERT INTO `area` VALUES ('421123', '4211', '罗田县', '3', '2150', '1');
INSERT INTO `area` VALUES ('421124', '4211', '英山县', '3', '2151', '1');
INSERT INTO `area` VALUES ('421125', '4211', '浠水县', '3', '2152', '1');
INSERT INTO `area` VALUES ('421126', '4211', '蕲春县', '3', '2153', '1');
INSERT INTO `area` VALUES ('421127', '4211', '黄梅县', '3', '2154', '1');
INSERT INTO `area` VALUES ('421181', '4211', '麻城市', '3', '2155', '1');
INSERT INTO `area` VALUES ('421182', '4211', '武穴市', '3', '2156', '1');
INSERT INTO `area` VALUES ('421201', '4212', '市辖区', '3', '2157', '1');
INSERT INTO `area` VALUES ('421202', '4212', '咸安区', '3', '2158', '1');
INSERT INTO `area` VALUES ('421221', '4212', '嘉鱼县', '3', '2159', '1');
INSERT INTO `area` VALUES ('421222', '4212', '通城县', '3', '2160', '1');
INSERT INTO `area` VALUES ('421223', '4212', '崇阳县', '3', '2161', '1');
INSERT INTO `area` VALUES ('421224', '4212', '通山县', '3', '2162', '1');
INSERT INTO `area` VALUES ('421281', '4212', '赤壁市', '3', '2163', '1');
INSERT INTO `area` VALUES ('421301', '4213', '市辖区', '3', '2164', '1');
INSERT INTO `area` VALUES ('421302', '4213', '曾都区', '3', '2165', '1');
INSERT INTO `area` VALUES ('421381', '4213', '广水市', '3', '2166', '1');
INSERT INTO `area` VALUES ('422801', '4228', '恩施市', '3', '2167', '1');
INSERT INTO `area` VALUES ('422802', '4228', '利川市', '3', '2168', '1');
INSERT INTO `area` VALUES ('422822', '4228', '建始县', '3', '2169', '1');
INSERT INTO `area` VALUES ('422823', '4228', '巴东县', '3', '2170', '1');
INSERT INTO `area` VALUES ('422825', '4228', '宣恩县', '3', '2171', '1');
INSERT INTO `area` VALUES ('422826', '4228', '咸丰县', '3', '2172', '1');
INSERT INTO `area` VALUES ('422827', '4228', '来凤县', '3', '2173', '1');
INSERT INTO `area` VALUES ('422828', '4228', '鹤峰县', '3', '2174', '1');
INSERT INTO `area` VALUES ('429004', '4290', '仙桃市', '3', '2175', '1');
INSERT INTO `area` VALUES ('429005', '4290', '潜江市', '3', '2176', '1');
INSERT INTO `area` VALUES ('429006', '4290', '天门市', '3', '2177', '1');
INSERT INTO `area` VALUES ('429021', '4290', '神农架林区', '3', '2178', '1');
INSERT INTO `area` VALUES ('430101', '4301', '市辖区', '3', '2179', '0');
INSERT INTO `area` VALUES ('430102', '4301', '芙蓉区', '3', '2180', '0');
INSERT INTO `area` VALUES ('430103', '4301', '天心区', '3', '2181', '0');
INSERT INTO `area` VALUES ('430104', '4301', '岳麓区', '3', '2182', '0');
INSERT INTO `area` VALUES ('430105', '4301', '开福区', '3', '2183', '0');
INSERT INTO `area` VALUES ('430111', '4301', '雨花区', '3', '2184', '0');
INSERT INTO `area` VALUES ('430121', '4301', '长沙县', '3', '2185', '0');
INSERT INTO `area` VALUES ('430122', '4301', '望城县', '3', '2186', '0');
INSERT INTO `area` VALUES ('430124', '4301', '宁乡县', '3', '2187', '0');
INSERT INTO `area` VALUES ('430181', '4301', '浏阳市', '3', '2188', '0');
INSERT INTO `area` VALUES ('430201', '4302', '市辖区', '3', '2189', '0');
INSERT INTO `area` VALUES ('430202', '4302', '荷塘区', '3', '2190', '0');
INSERT INTO `area` VALUES ('430203', '4302', '芦淞区', '3', '2191', '0');
INSERT INTO `area` VALUES ('430204', '4302', '石峰区', '3', '2192', '0');
INSERT INTO `area` VALUES ('430211', '4302', '天元区', '3', '2193', '0');
INSERT INTO `area` VALUES ('430221', '4302', '株洲县', '3', '2194', '0');
INSERT INTO `area` VALUES ('430223', '4302', '攸  县', '3', '2195', '0');
INSERT INTO `area` VALUES ('430224', '4302', '茶陵县', '3', '2196', '0');
INSERT INTO `area` VALUES ('430225', '4302', '炎陵县', '3', '2197', '0');
INSERT INTO `area` VALUES ('430281', '4302', '醴陵市', '3', '2198', '0');
INSERT INTO `area` VALUES ('430301', '4303', '市辖区', '3', '2199', '0');
INSERT INTO `area` VALUES ('430302', '4303', '雨湖区', '3', '2200', '0');
INSERT INTO `area` VALUES ('430304', '4303', '岳塘区', '3', '2201', '0');
INSERT INTO `area` VALUES ('430321', '4303', '湘潭县', '3', '2202', '0');
INSERT INTO `area` VALUES ('430381', '4303', '湘乡市', '3', '2203', '0');
INSERT INTO `area` VALUES ('430382', '4303', '韶山市', '3', '2204', '0');
INSERT INTO `area` VALUES ('430401', '4304', '市辖区', '3', '2205', '0');
INSERT INTO `area` VALUES ('430402', '4304', '江东区', '3', '2206', '0');
INSERT INTO `area` VALUES ('430403', '4304', '城南区', '3', '2207', '0');
INSERT INTO `area` VALUES ('430404', '4304', '城北区', '3', '2208', '0');
INSERT INTO `area` VALUES ('430411', '4304', '郊   区', '3', '2209', '0');
INSERT INTO `area` VALUES ('430412', '4304', '南岳区', '3', '2210', '0');
INSERT INTO `area` VALUES ('430421', '4304', '衡阳县', '3', '2211', '0');
INSERT INTO `area` VALUES ('430422', '4304', '衡南县', '3', '2212', '0');
INSERT INTO `area` VALUES ('430423', '4304', '衡山县', '3', '2213', '0');
INSERT INTO `area` VALUES ('430424', '4304', '衡东县', '3', '2214', '0');
INSERT INTO `area` VALUES ('430426', '4304', '祁东县', '3', '2215', '0');
INSERT INTO `area` VALUES ('430481', '4304', '耒阳市', '3', '2216', '0');
INSERT INTO `area` VALUES ('430482', '4304', '常宁市', '3', '2217', '0');
INSERT INTO `area` VALUES ('430501', '4305', '市辖区', '3', '2218', '0');
INSERT INTO `area` VALUES ('430502', '4305', '双清区', '3', '2219', '0');
INSERT INTO `area` VALUES ('430503', '4305', '大祥区', '3', '2220', '0');
INSERT INTO `area` VALUES ('430511', '4305', '北塔区', '3', '2221', '0');
INSERT INTO `area` VALUES ('430521', '4305', '邵东县', '3', '2222', '0');
INSERT INTO `area` VALUES ('430522', '4305', '新邵县', '3', '2223', '0');
INSERT INTO `area` VALUES ('430523', '4305', '邵阳县', '3', '2224', '0');
INSERT INTO `area` VALUES ('430524', '4305', '隆回县', '3', '2225', '0');
INSERT INTO `area` VALUES ('430525', '4305', '洞口县', '3', '2226', '0');
INSERT INTO `area` VALUES ('430527', '4305', '绥宁县', '3', '2227', '0');
INSERT INTO `area` VALUES ('430528', '4305', '新宁县', '3', '2228', '0');
INSERT INTO `area` VALUES ('430529', '4305', '城步苗族自治县', '3', '2229', '0');
INSERT INTO `area` VALUES ('430581', '4305', '武冈市', '3', '2230', '0');
INSERT INTO `area` VALUES ('430601', '4306', '市辖区', '3', '2231', '0');
INSERT INTO `area` VALUES ('430602', '4306', '岳阳楼区', '3', '2232', '0');
INSERT INTO `area` VALUES ('430603', '4306', '云溪区', '3', '2233', '0');
INSERT INTO `area` VALUES ('430611', '4306', '君山区', '3', '2234', '0');
INSERT INTO `area` VALUES ('430621', '4306', '岳阳县', '3', '2235', '0');
INSERT INTO `area` VALUES ('430623', '4306', '华容县', '3', '2236', '0');
INSERT INTO `area` VALUES ('430624', '4306', '湘阴县', '3', '2237', '0');
INSERT INTO `area` VALUES ('430626', '4306', '平江县', '3', '2238', '0');
INSERT INTO `area` VALUES ('430681', '4306', '汨罗市', '3', '2239', '0');
INSERT INTO `area` VALUES ('430682', '4306', '临湘市', '3', '2240', '0');
INSERT INTO `area` VALUES ('430701', '4307', '市辖区', '3', '2241', '0');
INSERT INTO `area` VALUES ('430702', '4307', '武陵区', '3', '2242', '0');
INSERT INTO `area` VALUES ('430703', '4307', '鼎城区', '3', '2243', '0');
INSERT INTO `area` VALUES ('430721', '4307', '安乡县', '3', '2244', '0');
INSERT INTO `area` VALUES ('430722', '4307', '汉寿县', '3', '2245', '0');
INSERT INTO `area` VALUES ('430723', '4307', '澧  县', '3', '2246', '0');
INSERT INTO `area` VALUES ('430724', '4307', '临澧县', '3', '2247', '0');
INSERT INTO `area` VALUES ('430725', '4307', '桃源县', '3', '2248', '0');
INSERT INTO `area` VALUES ('430726', '4307', '石门县', '3', '2249', '0');
INSERT INTO `area` VALUES ('430781', '4307', '津市市', '3', '2250', '0');
INSERT INTO `area` VALUES ('430801', '4308', '市辖区', '3', '2251', '0');
INSERT INTO `area` VALUES ('430802', '4308', '永定区', '3', '2252', '0');
INSERT INTO `area` VALUES ('430811', '4308', '武陵源区', '3', '2253', '0');
INSERT INTO `area` VALUES ('430821', '4308', '慈利县', '3', '2254', '0');
INSERT INTO `area` VALUES ('430822', '4308', '桑植县', '3', '2255', '0');
INSERT INTO `area` VALUES ('430901', '4309', '市辖区', '3', '2256', '0');
INSERT INTO `area` VALUES ('430902', '4309', '资阳区', '3', '2257', '0');
INSERT INTO `area` VALUES ('430903', '4309', '赫山区', '3', '2258', '0');
INSERT INTO `area` VALUES ('430921', '4309', '南  县', '3', '2259', '0');
INSERT INTO `area` VALUES ('430922', '4309', '桃江县', '3', '2260', '0');
INSERT INTO `area` VALUES ('430923', '4309', '安化县', '3', '2261', '0');
INSERT INTO `area` VALUES ('430981', '4309', '沅江市', '3', '2262', '0');
INSERT INTO `area` VALUES ('431001', '4310', '市辖区', '3', '2263', '0');
INSERT INTO `area` VALUES ('431002', '4310', '北湖区', '3', '2264', '0');
INSERT INTO `area` VALUES ('431003', '4310', '苏仙区', '3', '2265', '0');
INSERT INTO `area` VALUES ('431021', '4310', '桂阳县', '3', '2266', '0');
INSERT INTO `area` VALUES ('431022', '4310', '宜章县', '3', '2267', '0');
INSERT INTO `area` VALUES ('431023', '4310', '永兴县', '3', '2268', '0');
INSERT INTO `area` VALUES ('431024', '4310', '嘉禾县', '3', '2269', '0');
INSERT INTO `area` VALUES ('431025', '4310', '临武县', '3', '2270', '0');
INSERT INTO `area` VALUES ('431026', '4310', '汝城县', '3', '2271', '0');
INSERT INTO `area` VALUES ('431027', '4310', '桂东县', '3', '2272', '0');
INSERT INTO `area` VALUES ('431028', '4310', '安仁县', '3', '2273', '0');
INSERT INTO `area` VALUES ('431081', '4310', '资兴市', '3', '2274', '0');
INSERT INTO `area` VALUES ('431101', '4311', '市辖区', '3', '2275', '0');
INSERT INTO `area` VALUES ('431102', '4311', '芝山区', '3', '2276', '0');
INSERT INTO `area` VALUES ('431103', '4311', '冷水滩区', '3', '2277', '0');
INSERT INTO `area` VALUES ('431121', '4311', '祁阳县', '3', '2278', '0');
INSERT INTO `area` VALUES ('431122', '4311', '东安县', '3', '2279', '0');
INSERT INTO `area` VALUES ('431123', '4311', '双牌县', '3', '2280', '0');
INSERT INTO `area` VALUES ('431124', '4311', '道  县', '3', '2281', '0');
INSERT INTO `area` VALUES ('431125', '4311', '江永县', '3', '2282', '0');
INSERT INTO `area` VALUES ('431126', '4311', '宁远县', '3', '2283', '0');
INSERT INTO `area` VALUES ('431127', '4311', '蓝山县', '3', '2284', '0');
INSERT INTO `area` VALUES ('431128', '4311', '新田县', '3', '2285', '0');
INSERT INTO `area` VALUES ('431129', '4311', '江华瑶族自治县', '3', '2286', '0');
INSERT INTO `area` VALUES ('431201', '4312', '市辖区', '3', '2287', '0');
INSERT INTO `area` VALUES ('431202', '4312', '鹤城区', '3', '2288', '0');
INSERT INTO `area` VALUES ('431221', '4312', '中方县', '3', '2289', '0');
INSERT INTO `area` VALUES ('431222', '4312', '沅陵县', '3', '2290', '0');
INSERT INTO `area` VALUES ('431223', '4312', '辰溪县', '3', '2291', '0');
INSERT INTO `area` VALUES ('431224', '4312', '溆浦县', '3', '2292', '0');
INSERT INTO `area` VALUES ('431225', '4312', '会同县', '3', '2293', '0');
INSERT INTO `area` VALUES ('431226', '4312', '麻阳苗族自治县', '3', '2294', '0');
INSERT INTO `area` VALUES ('431227', '4312', '新晃侗族自治县', '3', '2295', '0');
INSERT INTO `area` VALUES ('431228', '4312', '芷江侗族自治县', '3', '2296', '0');
INSERT INTO `area` VALUES ('431229', '4312', '靖州苗族侗族自治县', '3', '2297', '0');
INSERT INTO `area` VALUES ('431230', '4312', '通道侗族自治县', '3', '2298', '0');
INSERT INTO `area` VALUES ('431281', '4312', '洪江市', '3', '2299', '0');
INSERT INTO `area` VALUES ('431301', '4313', '市辖区', '3', '2300', '0');
INSERT INTO `area` VALUES ('431302', '4313', '娄星区', '3', '2301', '0');
INSERT INTO `area` VALUES ('431321', '4313', '双峰县', '3', '2302', '0');
INSERT INTO `area` VALUES ('431322', '4313', '新化县', '3', '2303', '0');
INSERT INTO `area` VALUES ('431381', '4313', '冷水江市', '3', '2304', '0');
INSERT INTO `area` VALUES ('431382', '4313', '涟源市', '3', '2305', '0');
INSERT INTO `area` VALUES ('433101', '4331', '吉首市', '3', '2306', '0');
INSERT INTO `area` VALUES ('433122', '4331', '泸溪县', '3', '2307', '0');
INSERT INTO `area` VALUES ('433123', '4331', '凤凰县', '3', '2308', '0');
INSERT INTO `area` VALUES ('433124', '4331', '花垣县', '3', '2309', '0');
INSERT INTO `area` VALUES ('433125', '4331', '保靖县', '3', '2310', '0');
INSERT INTO `area` VALUES ('433126', '4331', '古丈县', '3', '2311', '0');
INSERT INTO `area` VALUES ('433127', '4331', '永顺县', '3', '2312', '0');
INSERT INTO `area` VALUES ('433130', '4331', '龙山县', '3', '2313', '0');
INSERT INTO `area` VALUES ('440101', '4401', '市辖区', '3', '2314', '0');
INSERT INTO `area` VALUES ('440102', '4401', '东山区', '3', '2315', '0');
INSERT INTO `area` VALUES ('440103', '4401', '荔湾区', '3', '2316', '0');
INSERT INTO `area` VALUES ('440104', '4401', '越秀区', '3', '2317', '0');
INSERT INTO `area` VALUES ('440105', '4401', '海珠区', '3', '2318', '0');
INSERT INTO `area` VALUES ('440106', '4401', '天河区', '3', '2319', '0');
INSERT INTO `area` VALUES ('440107', '4401', '芳村区', '3', '2320', '0');
INSERT INTO `area` VALUES ('440111', '4401', '白云区', '3', '2321', '0');
INSERT INTO `area` VALUES ('440112', '4401', '黄埔区', '3', '2322', '0');
INSERT INTO `area` VALUES ('440113', '4401', '番禺区', '3', '2323', '0');
INSERT INTO `area` VALUES ('440114', '4401', '花都区', '3', '2324', '0');
INSERT INTO `area` VALUES ('440183', '4401', '增城市', '3', '2325', '0');
INSERT INTO `area` VALUES ('440184', '4401', '从化市', '3', '2326', '0');
INSERT INTO `area` VALUES ('440201', '4402', '市辖区', '3', '2327', '0');
INSERT INTO `area` VALUES ('440202', '4402', '北江区', '3', '2328', '0');
INSERT INTO `area` VALUES ('440203', '4402', '武江区', '3', '2329', '0');
INSERT INTO `area` VALUES ('440204', '4402', '浈江区', '3', '2330', '0');
INSERT INTO `area` VALUES ('440221', '4402', '曲江县', '3', '2331', '0');
INSERT INTO `area` VALUES ('440222', '4402', '始兴县', '3', '2332', '0');
INSERT INTO `area` VALUES ('440224', '4402', '仁化县', '3', '2333', '0');
INSERT INTO `area` VALUES ('440229', '4402', '翁源县', '3', '2334', '0');
INSERT INTO `area` VALUES ('440232', '4402', '乳源瑶族自治县', '3', '2335', '0');
INSERT INTO `area` VALUES ('440233', '4402', '新丰县', '3', '2336', '0');
INSERT INTO `area` VALUES ('440281', '4402', '乐昌市', '3', '2337', '0');
INSERT INTO `area` VALUES ('440282', '4402', '南雄市', '3', '2338', '0');
INSERT INTO `area` VALUES ('440301', '4403', '市辖区', '3', '2339', '0');
INSERT INTO `area` VALUES ('440303', '4403', '罗湖区', '3', '2340', '0');
INSERT INTO `area` VALUES ('440304', '4403', '福田区', '3', '2341', '0');
INSERT INTO `area` VALUES ('440305', '4403', '南山区', '3', '2342', '0');
INSERT INTO `area` VALUES ('440306', '4403', '宝安区', '3', '2343', '0');
INSERT INTO `area` VALUES ('440307', '4403', '龙岗区', '3', '2344', '0');
INSERT INTO `area` VALUES ('440308', '4403', '盐田区', '3', '2345', '0');
INSERT INTO `area` VALUES ('440401', '4404', '市辖区', '3', '2346', '0');
INSERT INTO `area` VALUES ('440402', '4404', '香洲区', '3', '2347', '0');
INSERT INTO `area` VALUES ('440421', '4404', '斗门县', '3', '2348', '0');
INSERT INTO `area` VALUES ('440501', '4405', '市辖区', '3', '2349', '0');
INSERT INTO `area` VALUES ('440506', '4405', '达濠区', '3', '2350', '0');
INSERT INTO `area` VALUES ('440507', '4405', '龙湖区', '3', '2351', '0');
INSERT INTO `area` VALUES ('440508', '4405', '金园区', '3', '2352', '0');
INSERT INTO `area` VALUES ('440509', '4405', '升平区', '3', '2353', '0');
INSERT INTO `area` VALUES ('440510', '4405', '河浦区', '3', '2354', '0');
INSERT INTO `area` VALUES ('440523', '4405', '南澳县', '3', '2355', '0');
INSERT INTO `area` VALUES ('440582', '4405', '潮阳市', '3', '2356', '0');
INSERT INTO `area` VALUES ('440583', '4405', '澄海市', '3', '2357', '0');
INSERT INTO `area` VALUES ('440601', '4406', '市辖区', '3', '2358', '0');
INSERT INTO `area` VALUES ('440602', '4406', '城  区', '3', '2359', '0');
INSERT INTO `area` VALUES ('440603', '4406', '石湾区', '3', '2360', '0');
INSERT INTO `area` VALUES ('440681', '4406', '顺德市', '3', '2361', '0');
INSERT INTO `area` VALUES ('440682', '4406', '南海市', '3', '2362', '0');
INSERT INTO `area` VALUES ('440683', '4406', '三水市', '3', '2363', '0');
INSERT INTO `area` VALUES ('440684', '4406', '高明市', '3', '2364', '0');
INSERT INTO `area` VALUES ('440701', '4407', '市辖区', '3', '2365', '0');
INSERT INTO `area` VALUES ('440703', '4407', '蓬江区', '3', '2366', '0');
INSERT INTO `area` VALUES ('440704', '4407', '江海区', '3', '2367', '0');
INSERT INTO `area` VALUES ('440781', '4407', '台山市', '3', '2368', '0');
INSERT INTO `area` VALUES ('440782', '4407', '新会市', '3', '2369', '0');
INSERT INTO `area` VALUES ('440783', '4407', '开平市', '3', '2370', '0');
INSERT INTO `area` VALUES ('440784', '4407', '鹤山市', '3', '2371', '0');
INSERT INTO `area` VALUES ('440785', '4407', '恩平市', '3', '2372', '0');
INSERT INTO `area` VALUES ('440801', '4408', '市辖区', '3', '2373', '0');
INSERT INTO `area` VALUES ('440802', '4408', '赤坎区', '3', '2374', '0');
INSERT INTO `area` VALUES ('440803', '4408', '霞山区', '3', '2375', '0');
INSERT INTO `area` VALUES ('440804', '4408', '坡头区', '3', '2376', '0');
INSERT INTO `area` VALUES ('440811', '4408', '麻章区', '3', '2377', '0');
INSERT INTO `area` VALUES ('440823', '4408', '遂溪县', '3', '2378', '0');
INSERT INTO `area` VALUES ('440825', '4408', '徐闻县', '3', '2379', '0');
INSERT INTO `area` VALUES ('440881', '4408', '廉江市', '3', '2380', '0');
INSERT INTO `area` VALUES ('440882', '4408', '雷州市', '3', '2381', '0');
INSERT INTO `area` VALUES ('440883', '4408', '吴川市', '3', '2382', '0');
INSERT INTO `area` VALUES ('440901', '4409', '市辖区', '3', '2383', '0');
INSERT INTO `area` VALUES ('440902', '4409', '茂南区', '3', '2384', '0');
INSERT INTO `area` VALUES ('440923', '4409', '电白县', '3', '2385', '0');
INSERT INTO `area` VALUES ('440981', '4409', '高州市', '3', '2386', '0');
INSERT INTO `area` VALUES ('440982', '4409', '化州市', '3', '2387', '0');
INSERT INTO `area` VALUES ('440983', '4409', '信宜市', '3', '2388', '0');
INSERT INTO `area` VALUES ('441201', '4412', '市辖区', '3', '2389', '0');
INSERT INTO `area` VALUES ('441202', '4412', '端州区', '3', '2390', '0');
INSERT INTO `area` VALUES ('441203', '4412', '鼎湖区', '3', '2391', '0');
INSERT INTO `area` VALUES ('441223', '4412', '广宁县', '3', '2392', '0');
INSERT INTO `area` VALUES ('441224', '4412', '怀集县', '3', '2393', '0');
INSERT INTO `area` VALUES ('441225', '4412', '封开县', '3', '2394', '0');
INSERT INTO `area` VALUES ('441226', '4412', '德庆县', '3', '2395', '0');
INSERT INTO `area` VALUES ('441283', '4412', '高要市', '3', '2396', '0');
INSERT INTO `area` VALUES ('441284', '4412', '四会市', '3', '2397', '0');
INSERT INTO `area` VALUES ('441301', '4413', '市辖区', '3', '2398', '0');
INSERT INTO `area` VALUES ('441302', '4413', '惠城区', '3', '2399', '0');
INSERT INTO `area` VALUES ('441322', '4413', '博罗县', '3', '2400', '0');
INSERT INTO `area` VALUES ('441323', '4413', '惠东县', '3', '2401', '0');
INSERT INTO `area` VALUES ('441324', '4413', '龙门县', '3', '2402', '0');
INSERT INTO `area` VALUES ('441381', '4413', '惠阳市', '3', '2403', '0');
INSERT INTO `area` VALUES ('441401', '4414', '市辖区', '3', '2404', '0');
INSERT INTO `area` VALUES ('441402', '4414', '梅江区', '3', '2405', '0');
INSERT INTO `area` VALUES ('441421', '4414', '梅  县', '3', '2406', '0');
INSERT INTO `area` VALUES ('441422', '4414', '大埔县', '3', '2407', '0');
INSERT INTO `area` VALUES ('441423', '4414', '丰顺县', '3', '2408', '0');
INSERT INTO `area` VALUES ('441424', '4414', '五华县', '3', '2409', '0');
INSERT INTO `area` VALUES ('441426', '4414', '平远县', '3', '2410', '0');
INSERT INTO `area` VALUES ('441427', '4414', '蕉岭县', '3', '2411', '0');
INSERT INTO `area` VALUES ('441481', '4414', '兴宁市', '3', '2412', '0');
INSERT INTO `area` VALUES ('441501', '4415', '市辖区', '3', '2413', '0');
INSERT INTO `area` VALUES ('441502', '4415', '城  区', '3', '2414', '0');
INSERT INTO `area` VALUES ('441521', '4415', '海丰县', '3', '2415', '0');
INSERT INTO `area` VALUES ('441523', '4415', '陆河县', '3', '2416', '0');
INSERT INTO `area` VALUES ('441581', '4415', '陆丰市', '3', '2417', '0');
INSERT INTO `area` VALUES ('441601', '4416', '市辖区', '3', '2418', '0');
INSERT INTO `area` VALUES ('441602', '4416', '源城区', '3', '2419', '0');
INSERT INTO `area` VALUES ('441621', '4416', '紫金县', '3', '2420', '0');
INSERT INTO `area` VALUES ('441622', '4416', '龙川县', '3', '2421', '0');
INSERT INTO `area` VALUES ('441623', '4416', '连平县', '3', '2422', '0');
INSERT INTO `area` VALUES ('441624', '4416', '和平县', '3', '2423', '0');
INSERT INTO `area` VALUES ('441625', '4416', '东源县', '3', '2424', '0');
INSERT INTO `area` VALUES ('441701', '4417', '市辖区', '3', '2425', '0');
INSERT INTO `area` VALUES ('441702', '4417', '江城区', '3', '2426', '0');
INSERT INTO `area` VALUES ('441721', '4417', '阳西县', '3', '2427', '0');
INSERT INTO `area` VALUES ('441723', '4417', '阳东县', '3', '2428', '0');
INSERT INTO `area` VALUES ('441781', '4417', '阳春市', '3', '2429', '0');
INSERT INTO `area` VALUES ('441801', '4418', '市辖区', '3', '2430', '0');
INSERT INTO `area` VALUES ('441802', '4418', '清城区', '3', '2431', '0');
INSERT INTO `area` VALUES ('441821', '4418', '佛冈县', '3', '2432', '0');
INSERT INTO `area` VALUES ('441823', '4418', '阳山县', '3', '2433', '0');
INSERT INTO `area` VALUES ('441825', '4418', '连山壮族瑶族自治县', '3', '2434', '0');
INSERT INTO `area` VALUES ('441826', '4418', '连南瑶族自治县', '3', '2435', '0');
INSERT INTO `area` VALUES ('441827', '4418', '清新县', '3', '2436', '0');
INSERT INTO `area` VALUES ('441881', '4418', '英德市', '3', '2437', '0');
INSERT INTO `area` VALUES ('441882', '4418', '连州市', '3', '2438', '0');
INSERT INTO `area` VALUES ('441901', '4419', '莞城区', '3', '2439', '0');
INSERT INTO `area` VALUES ('441902', '4419', '东城区', '3', '2440', '0');
INSERT INTO `area` VALUES ('441903', '4419', '南城区', '3', '2441', '0');
INSERT INTO `area` VALUES ('441904', '4419', '万江区', '3', '2442', '0');
INSERT INTO `area` VALUES ('442001', '4420', '石岐区', '3', '2443', '0');
INSERT INTO `area` VALUES ('442002', '4420', '东区', '3', '2444', '0');
INSERT INTO `area` VALUES ('442003', '4420', '西区', '3', '2445', '0');
INSERT INTO `area` VALUES ('442004', '4420', '南区', '3', '2446', '0');
INSERT INTO `area` VALUES ('442005', '4420', '五桂山', '3', '2447', '0');
INSERT INTO `area` VALUES ('445101', '4451', '市辖区', '3', '2448', '0');
INSERT INTO `area` VALUES ('445102', '4451', '湘桥区', '3', '2449', '0');
INSERT INTO `area` VALUES ('445121', '4451', '潮安县', '3', '2450', '0');
INSERT INTO `area` VALUES ('445122', '4451', '饶平县', '3', '2451', '0');
INSERT INTO `area` VALUES ('445201', '4452', '市辖区', '3', '2452', '0');
INSERT INTO `area` VALUES ('445202', '4452', '榕城区', '3', '2453', '0');
INSERT INTO `area` VALUES ('445221', '4452', '揭东县', '3', '2454', '0');
INSERT INTO `area` VALUES ('445222', '4452', '揭西县', '3', '2455', '0');
INSERT INTO `area` VALUES ('445224', '4452', '惠来县', '3', '2456', '0');
INSERT INTO `area` VALUES ('445281', '4452', '普宁市', '3', '2457', '0');
INSERT INTO `area` VALUES ('445301', '4453', '市辖区', '3', '2458', '0');
INSERT INTO `area` VALUES ('445302', '4453', '云城区', '3', '2459', '0');
INSERT INTO `area` VALUES ('445321', '4453', '新兴县', '3', '2460', '0');
INSERT INTO `area` VALUES ('445322', '4453', '郁南县', '3', '2461', '0');
INSERT INTO `area` VALUES ('445323', '4453', '云安县', '3', '2462', '0');
INSERT INTO `area` VALUES ('445381', '4453', '罗定市', '3', '2463', '0');
INSERT INTO `area` VALUES ('450101', '4501', '市辖区', '3', '2464', '1');
INSERT INTO `area` VALUES ('450102', '4501', '兴宁区', '3', '2465', '1');
INSERT INTO `area` VALUES ('450103', '4501', '新城区', '3', '2466', '1');
INSERT INTO `area` VALUES ('450104', '4501', '城北区', '3', '2467', '1');
INSERT INTO `area` VALUES ('450105', '4501', '江南区', '3', '2468', '1');
INSERT INTO `area` VALUES ('450106', '4501', '永新区', '3', '2469', '1');
INSERT INTO `area` VALUES ('450111', '4501', '市郊区', '3', '2470', '1');
INSERT INTO `area` VALUES ('450121', '4501', '邕宁县', '3', '2471', '1');
INSERT INTO `area` VALUES ('450122', '4501', '武鸣县', '3', '2472', '1');
INSERT INTO `area` VALUES ('450201', '4502', '市辖区', '3', '2473', '1');
INSERT INTO `area` VALUES ('450202', '4502', '城中区', '3', '2474', '1');
INSERT INTO `area` VALUES ('450203', '4502', '鱼峰区', '3', '2475', '1');
INSERT INTO `area` VALUES ('450204', '4502', '柳南区', '3', '2476', '1');
INSERT INTO `area` VALUES ('450205', '4502', '柳北区', '3', '2477', '1');
INSERT INTO `area` VALUES ('450211', '4502', '市郊区', '3', '2478', '1');
INSERT INTO `area` VALUES ('450221', '4502', '柳江县', '3', '2479', '1');
INSERT INTO `area` VALUES ('450222', '4502', '柳城县', '3', '2480', '1');
INSERT INTO `area` VALUES ('450301', '4503', '市辖区', '3', '2481', '1');
INSERT INTO `area` VALUES ('450302', '4503', '秀峰区', '3', '2482', '1');
INSERT INTO `area` VALUES ('450303', '4503', '叠彩区', '3', '2483', '1');
INSERT INTO `area` VALUES ('450304', '4503', '象山区', '3', '2484', '1');
INSERT INTO `area` VALUES ('450305', '4503', '七星区', '3', '2485', '1');
INSERT INTO `area` VALUES ('450311', '4503', '雁山区', '3', '2486', '1');
INSERT INTO `area` VALUES ('450321', '4503', '阳朔县', '3', '2487', '1');
INSERT INTO `area` VALUES ('450322', '4503', '临桂县', '3', '2488', '1');
INSERT INTO `area` VALUES ('450323', '4503', '灵川县', '3', '2489', '1');
INSERT INTO `area` VALUES ('450324', '4503', '全州县', '3', '2490', '1');
INSERT INTO `area` VALUES ('450325', '4503', '兴安县', '3', '2491', '1');
INSERT INTO `area` VALUES ('450326', '4503', '永福县', '3', '2492', '1');
INSERT INTO `area` VALUES ('450327', '4503', '灌阳县', '3', '2493', '1');
INSERT INTO `area` VALUES ('450328', '4503', '龙胜各县自治区', '3', '2494', '1');
INSERT INTO `area` VALUES ('450329', '4503', '资源县', '3', '2495', '1');
INSERT INTO `area` VALUES ('450330', '4503', '平乐县', '3', '2496', '1');
INSERT INTO `area` VALUES ('450331', '4503', '荔蒲县', '3', '2497', '1');
INSERT INTO `area` VALUES ('450332', '4503', '恭城瑶族自治县', '3', '2498', '1');
INSERT INTO `area` VALUES ('450401', '4504', '市辖区', '3', '2499', '1');
INSERT INTO `area` VALUES ('450403', '4504', '万秀区', '3', '2500', '1');
INSERT INTO `area` VALUES ('450404', '4504', '蝶山区', '3', '2501', '1');
INSERT INTO `area` VALUES ('450411', '4504', '市郊区', '3', '2502', '1');
INSERT INTO `area` VALUES ('450421', '4504', '苍梧县', '3', '2503', '1');
INSERT INTO `area` VALUES ('450422', '4504', '藤  县', '3', '2504', '1');
INSERT INTO `area` VALUES ('450423', '4504', '蒙山县', '3', '2505', '1');
INSERT INTO `area` VALUES ('450481', '4504', '岑溪市', '3', '2506', '1');
INSERT INTO `area` VALUES ('450501', '4505', '市辖区', '3', '2507', '1');
INSERT INTO `area` VALUES ('450502', '4505', '海城区', '3', '2508', '1');
INSERT INTO `area` VALUES ('450503', '4505', '银海区', '3', '2509', '1');
INSERT INTO `area` VALUES ('450512', '4505', '铁山港区', '3', '2510', '1');
INSERT INTO `area` VALUES ('450521', '4505', '合浦县', '3', '2511', '1');
INSERT INTO `area` VALUES ('450601', '4506', '市辖区', '3', '2512', '1');
INSERT INTO `area` VALUES ('450602', '4506', '港口区', '3', '2513', '1');
INSERT INTO `area` VALUES ('450603', '4506', '防城区', '3', '2514', '1');
INSERT INTO `area` VALUES ('450621', '4506', '上思县', '3', '2515', '1');
INSERT INTO `area` VALUES ('450681', '4506', '东兴市', '3', '2516', '1');
INSERT INTO `area` VALUES ('450701', '4507', '市辖区', '3', '2517', '1');
INSERT INTO `area` VALUES ('450702', '4507', '钦南区', '3', '2518', '1');
INSERT INTO `area` VALUES ('450703', '4507', '钦北区', '3', '2519', '1');
INSERT INTO `area` VALUES ('450721', '4507', '浦北县', '3', '2520', '1');
INSERT INTO `area` VALUES ('450722', '4507', '灵山县', '3', '2521', '1');
INSERT INTO `area` VALUES ('450801', '4508', '市辖区', '3', '2522', '1');
INSERT INTO `area` VALUES ('450802', '4508', '港北区', '3', '2523', '1');
INSERT INTO `area` VALUES ('450803', '4508', '港南区', '3', '2524', '1');
INSERT INTO `area` VALUES ('450821', '4508', '平南县', '3', '2525', '1');
INSERT INTO `area` VALUES ('450881', '4508', '桂平市', '3', '2526', '1');
INSERT INTO `area` VALUES ('450901', '4509', '市辖区', '3', '2527', '1');
INSERT INTO `area` VALUES ('450902', '4509', '玉州区', '3', '2528', '1');
INSERT INTO `area` VALUES ('450921', '4509', '容  县', '3', '2529', '1');
INSERT INTO `area` VALUES ('450922', '4509', '陆川县', '3', '2530', '1');
INSERT INTO `area` VALUES ('450923', '4509', '博白县', '3', '2531', '1');
INSERT INTO `area` VALUES ('450924', '4509', '兴业县', '3', '2532', '1');
INSERT INTO `area` VALUES ('450981', '4509', '北流市', '3', '2533', '1');
INSERT INTO `area` VALUES ('452101', '4521', '凭祥市', '3', '2534', '1');
INSERT INTO `area` VALUES ('452122', '4521', '横  县', '3', '2535', '1');
INSERT INTO `area` VALUES ('452123', '4521', '宾阳县', '3', '2536', '1');
INSERT INTO `area` VALUES ('452124', '4521', '上林县', '3', '2537', '1');
INSERT INTO `area` VALUES ('452126', '4521', '隆安县', '3', '2538', '1');
INSERT INTO `area` VALUES ('452127', '4521', '马山县', '3', '2539', '1');
INSERT INTO `area` VALUES ('452128', '4521', '扶绥县', '3', '2540', '1');
INSERT INTO `area` VALUES ('452129', '4521', '崇左县', '3', '2541', '1');
INSERT INTO `area` VALUES ('452130', '4521', '大新县', '3', '2542', '1');
INSERT INTO `area` VALUES ('452131', '4521', '天等县', '3', '2543', '1');
INSERT INTO `area` VALUES ('452132', '4521', '宁明县', '3', '2544', '1');
INSERT INTO `area` VALUES ('452133', '4521', '龙州县', '3', '2545', '1');
INSERT INTO `area` VALUES ('452201', '4522', '合山市', '3', '2546', '1');
INSERT INTO `area` VALUES ('452223', '4522', '鹿寨县', '3', '2547', '1');
INSERT INTO `area` VALUES ('452224', '4522', '象州县', '3', '2548', '1');
INSERT INTO `area` VALUES ('452225', '4522', '武宣县', '3', '2549', '1');
INSERT INTO `area` VALUES ('452226', '4522', '来宾县', '3', '2550', '1');
INSERT INTO `area` VALUES ('452227', '4522', '融安县', '3', '2551', '1');
INSERT INTO `area` VALUES ('452228', '4522', '三江侗族自治县', '3', '2552', '1');
INSERT INTO `area` VALUES ('452229', '4522', '融水苗族自治县', '3', '2553', '1');
INSERT INTO `area` VALUES ('452230', '4522', '金秀瑶族自治县', '3', '2554', '1');
INSERT INTO `area` VALUES ('452231', '4522', '忻城县', '3', '2555', '1');
INSERT INTO `area` VALUES ('452402', '4524', '贺州市', '3', '2556', '1');
INSERT INTO `area` VALUES ('452424', '4524', '昭平县', '3', '2557', '1');
INSERT INTO `area` VALUES ('452427', '4524', '钟山县', '3', '2558', '1');
INSERT INTO `area` VALUES ('452428', '4524', '富川瑶族自治县', '3', '2559', '1');
INSERT INTO `area` VALUES ('452601', '4526', '百色市', '3', '2560', '1');
INSERT INTO `area` VALUES ('452622', '4526', '田阳县', '3', '2561', '1');
INSERT INTO `area` VALUES ('452623', '4526', '田东县', '3', '2562', '1');
INSERT INTO `area` VALUES ('452624', '4526', '平果县', '3', '2563', '1');
INSERT INTO `area` VALUES ('452625', '4526', '德保县', '3', '2564', '1');
INSERT INTO `area` VALUES ('452626', '4526', '靖西县', '3', '2565', '1');
INSERT INTO `area` VALUES ('452627', '4526', '那坡县', '3', '2566', '1');
INSERT INTO `area` VALUES ('452628', '4526', '凌云县', '3', '2567', '1');
INSERT INTO `area` VALUES ('452629', '4526', '乐业县', '3', '2568', '1');
INSERT INTO `area` VALUES ('452630', '4526', '田林县', '3', '2569', '1');
INSERT INTO `area` VALUES ('452631', '4526', '隆林各族自治县', '3', '2570', '1');
INSERT INTO `area` VALUES ('452632', '4526', '西林县', '3', '2571', '1');
INSERT INTO `area` VALUES ('452701', '4527', '河池市', '3', '2572', '1');
INSERT INTO `area` VALUES ('452702', '4527', '宜州市', '3', '2573', '1');
INSERT INTO `area` VALUES ('452723', '4527', '罗城仫佬族自治县', '3', '2574', '1');
INSERT INTO `area` VALUES ('452724', '4527', '环江毛南族自治县', '3', '2575', '1');
INSERT INTO `area` VALUES ('452725', '4527', '南丹县', '3', '2576', '1');
INSERT INTO `area` VALUES ('452726', '4527', '天峨县', '3', '2577', '1');
INSERT INTO `area` VALUES ('452727', '4527', '凤山县', '3', '2578', '1');
INSERT INTO `area` VALUES ('452728', '4527', '东兰县', '3', '2579', '1');
INSERT INTO `area` VALUES ('452729', '4527', '巴马瑶族自治县', '3', '2580', '1');
INSERT INTO `area` VALUES ('452730', '4527', '都安瑶族自治县', '3', '2581', '1');
INSERT INTO `area` VALUES ('452731', '4527', '大化瑶族自治县', '3', '2582', '1');
INSERT INTO `area` VALUES ('460101', '4601', '通什市', '3', '2583', '1');
INSERT INTO `area` VALUES ('460102', '4601', '琼海市', '3', '2584', '1');
INSERT INTO `area` VALUES ('460103', '4601', '儋州市', '3', '2585', '1');
INSERT INTO `area` VALUES ('460104', '4601', '琼山市', '3', '2586', '1');
INSERT INTO `area` VALUES ('460105', '4601', '文昌市', '3', '2587', '1');
INSERT INTO `area` VALUES ('460106', '4601', '万宁市', '3', '2588', '1');
INSERT INTO `area` VALUES ('460107', '4601', '东方市', '3', '2589', '1');
INSERT INTO `area` VALUES ('460125', '4601', '定安县', '3', '2590', '1');
INSERT INTO `area` VALUES ('460126', '4601', '屯昌县', '3', '2591', '1');
INSERT INTO `area` VALUES ('460127', '4601', '澄迈县', '3', '2592', '1');
INSERT INTO `area` VALUES ('460128', '4601', '临高县', '3', '2593', '1');
INSERT INTO `area` VALUES ('460130', '4601', '白沙黎族自治县', '3', '2594', '1');
INSERT INTO `area` VALUES ('460131', '4601', '昌江黎族自治县', '3', '2595', '1');
INSERT INTO `area` VALUES ('460133', '4601', '乐东黎族自治县', '3', '2596', '1');
INSERT INTO `area` VALUES ('460134', '4601', '陵水黎族自治县', '3', '2597', '1');
INSERT INTO `area` VALUES ('460135', '4601', '保亭黎族苗族自治县', '3', '2598', '1');
INSERT INTO `area` VALUES ('460136', '4601', '琼中黎族苗族自治县', '3', '2599', '1');
INSERT INTO `area` VALUES ('460137', '4601', '西沙群岛', '3', '2600', '1');
INSERT INTO `area` VALUES ('460138', '4601', '南沙群岛', '3', '2601', '1');
INSERT INTO `area` VALUES ('460139', '4601', '中沙群岛的岛礁及其海', '3', '2602', '1');
INSERT INTO `area` VALUES ('460201', '4602', '市辖区', '3', '2603', '1');
INSERT INTO `area` VALUES ('460202', '4602', '振东区', '3', '2604', '1');
INSERT INTO `area` VALUES ('460203', '4602', '新华区', '3', '2605', '1');
INSERT INTO `area` VALUES ('460204', '4602', '秀英区', '3', '2606', '1');
INSERT INTO `area` VALUES ('460301', '4603', '市辖区', '3', '2607', '1');
INSERT INTO `area` VALUES ('500101', '5001', '万州区', '3', '13', '0');
INSERT INTO `area` VALUES ('500102', '5001', '涪陵区', '3', '14', '0');
INSERT INTO `area` VALUES ('500103', '5001', '渝中区', '3', '1', '0');
INSERT INTO `area` VALUES ('500104', '5001', '大渡口区', '3', '7', '0');
INSERT INTO `area` VALUES ('500105', '5001', '江北区', '3', '2', '0');
INSERT INTO `area` VALUES ('500106', '5001', '沙坪坝区', '3', '5', '0');
INSERT INTO `area` VALUES ('500107', '5001', '九龙坡区', '3', '4', '0');
INSERT INTO `area` VALUES ('500108', '5001', '南岸区', '3', '6', '0');
INSERT INTO `area` VALUES ('500109', '5001', '北碚区', '3', '9', '0');
INSERT INTO `area` VALUES ('500110', '5001', '綦江区', '3', '15', '0');
INSERT INTO `area` VALUES ('500111', '5001', '大足区', '3', '16', '0');
INSERT INTO `area` VALUES ('500112', '5001', '渝北区', '3', '3', '0');
INSERT INTO `area` VALUES ('500113', '5001', '巴南区', '3', '8', '0');
INSERT INTO `area` VALUES ('500114', '5001', '黔江区', '3', '25', '0');
INSERT INTO `area` VALUES ('500115', '5001', '长寿区', '3', '12', '0');
INSERT INTO `area` VALUES ('500116', '5001', '江津区', '3', '11', '0');
INSERT INTO `area` VALUES ('500117', '5001', '合川区', '3', '17', '0');
INSERT INTO `area` VALUES ('500118', '5001', '永川区', '3', '18', '0');
INSERT INTO `area` VALUES ('500119', '5001', '南川区', '3', '19', '0');
INSERT INTO `area` VALUES ('500120', '5001', '璧山区', '3', '10', '0');
INSERT INTO `area` VALUES ('500151', '5001', '铜梁区', '3', '20', '0');
INSERT INTO `area` VALUES ('500152', '5001', '潼南区', '3', '21', '0');
INSERT INTO `area` VALUES ('500153', '5001', '荣昌区', '3', '22', '0');
INSERT INTO `area` VALUES ('500154', '5001', '开州区', '3', '23', '0');
INSERT INTO `area` VALUES ('500155', '5001', '梁平区', '3', '24', '0');
INSERT INTO `area` VALUES ('500156', '5001', '武隆区', '3', '25', '0');
INSERT INTO `area` VALUES ('500229', '5001', '城口县', '3', '33', '0');
INSERT INTO `area` VALUES ('500230', '5001', '丰都县', '3', '26', '0');
INSERT INTO `area` VALUES ('500231', '5001', '垫江县', '3', '27', '0');
INSERT INTO `area` VALUES ('500233', '5001', '忠县', '3', '32', '0');
INSERT INTO `area` VALUES ('500235', '5001', '云阳县', '3', '28', '0');
INSERT INTO `area` VALUES ('500236', '5001', '奉节县', '3', '29', '0');
INSERT INTO `area` VALUES ('500237', '5001', '巫山县', '3', '30', '0');
INSERT INTO `area` VALUES ('500238', '5001', '巫溪县', '3', '31', '0');
INSERT INTO `area` VALUES ('500240', '5001', '石柱土家族自治县', '3', '34', '0');
INSERT INTO `area` VALUES ('500241', '5001', '秀山土家族苗族自治县', '3', '35', '0');
INSERT INTO `area` VALUES ('500242', '5001', '酉阳土家族苗族自治县', '3', '36', '0');
INSERT INTO `area` VALUES ('500243', '5001', '彭水苗族土家族自治县', '3', '37', '0');
INSERT INTO `area` VALUES ('510101', '5101', '市辖区', '3', '2646', '1');
INSERT INTO `area` VALUES ('510103', '5101', '高新区', '3', '2647', '1');
INSERT INTO `area` VALUES ('510104', '5101', '锦江区', '3', '2648', '1');
INSERT INTO `area` VALUES ('510105', '5101', '青羊区', '3', '2649', '1');
INSERT INTO `area` VALUES ('510106', '5101', '金牛区', '3', '2650', '1');
INSERT INTO `area` VALUES ('510107', '5101', '武侯区', '3', '2651', '1');
INSERT INTO `area` VALUES ('510108', '5101', '成华区', '3', '2652', '1');
INSERT INTO `area` VALUES ('510112', '5101', '龙泉驿区', '3', '2653', '1');
INSERT INTO `area` VALUES ('510113', '5101', '青白江区', '3', '2654', '1');
INSERT INTO `area` VALUES ('510121', '5101', '金堂县', '3', '2655', '1');
INSERT INTO `area` VALUES ('510122', '5101', '双流县', '3', '2656', '1');
INSERT INTO `area` VALUES ('510123', '5101', '温江县', '3', '2657', '1');
INSERT INTO `area` VALUES ('510124', '5101', '郫  县', '3', '2658', '1');
INSERT INTO `area` VALUES ('510125', '5101', '新都县', '3', '2659', '1');
INSERT INTO `area` VALUES ('510129', '5101', '大邑县', '3', '2660', '1');
INSERT INTO `area` VALUES ('510131', '5101', '蒲江县', '3', '2661', '1');
INSERT INTO `area` VALUES ('510132', '5101', '新津县', '3', '2662', '1');
INSERT INTO `area` VALUES ('510181', '5101', '都江堰市', '3', '2663', '1');
INSERT INTO `area` VALUES ('510182', '5101', '彭州市', '3', '2664', '1');
INSERT INTO `area` VALUES ('510183', '5101', '邛崃市', '3', '2665', '1');
INSERT INTO `area` VALUES ('510184', '5101', '崇州市', '3', '2666', '1');
INSERT INTO `area` VALUES ('510301', '5103', '市辖区', '3', '2667', '1');
INSERT INTO `area` VALUES ('510302', '5103', '自流井区', '3', '2668', '1');
INSERT INTO `area` VALUES ('510303', '5103', '贡井区', '3', '2669', '1');
INSERT INTO `area` VALUES ('510304', '5103', '大安区', '3', '2670', '1');
INSERT INTO `area` VALUES ('510311', '5103', '沿滩区', '3', '2671', '1');
INSERT INTO `area` VALUES ('510321', '5103', '荣  县', '3', '2672', '1');
INSERT INTO `area` VALUES ('510322', '5103', '富顺县', '3', '2673', '1');
INSERT INTO `area` VALUES ('510401', '5104', '市辖区', '3', '2674', '1');
INSERT INTO `area` VALUES ('510402', '5104', '东  区', '3', '2675', '1');
INSERT INTO `area` VALUES ('510403', '5104', '西  区', '3', '2676', '1');
INSERT INTO `area` VALUES ('510411', '5104', '仁和区', '3', '2677', '1');
INSERT INTO `area` VALUES ('510421', '5104', '米易县', '3', '2678', '1');
INSERT INTO `area` VALUES ('510422', '5104', '盐边县', '3', '2679', '1');
INSERT INTO `area` VALUES ('510501', '5105', '市辖区', '3', '2680', '1');
INSERT INTO `area` VALUES ('510502', '5105', '江阳区', '3', '2681', '1');
INSERT INTO `area` VALUES ('510503', '5105', '纳溪区', '3', '2682', '1');
INSERT INTO `area` VALUES ('510504', '5105', '龙马潭区', '3', '2683', '1');
INSERT INTO `area` VALUES ('510521', '5105', '泸  县', '3', '2684', '1');
INSERT INTO `area` VALUES ('510522', '5105', '合江县', '3', '2685', '1');
INSERT INTO `area` VALUES ('510524', '5105', '叙永县', '3', '2686', '1');
INSERT INTO `area` VALUES ('510525', '5105', '古蔺县', '3', '2687', '1');
INSERT INTO `area` VALUES ('510601', '5106', '市辖区', '3', '2688', '1');
INSERT INTO `area` VALUES ('510603', '5106', '旌阳区', '3', '2689', '1');
INSERT INTO `area` VALUES ('510623', '5106', '中江县', '3', '2690', '1');
INSERT INTO `area` VALUES ('510626', '5106', '罗江县', '3', '2691', '1');
INSERT INTO `area` VALUES ('510681', '5106', '广汉市', '3', '2692', '1');
INSERT INTO `area` VALUES ('510682', '5106', '什邡市', '3', '2693', '1');
INSERT INTO `area` VALUES ('510683', '5106', '绵竹市', '3', '2694', '1');
INSERT INTO `area` VALUES ('510701', '5107', '市辖区', '3', '2695', '1');
INSERT INTO `area` VALUES ('510703', '5107', '涪城区', '3', '2696', '1');
INSERT INTO `area` VALUES ('510704', '5107', '游仙区', '3', '2697', '1');
INSERT INTO `area` VALUES ('510710', '5107', '科学城区', '3', '2698', '1');
INSERT INTO `area` VALUES ('510722', '5107', '三台县', '3', '2699', '1');
INSERT INTO `area` VALUES ('510723', '5107', '盐亭县', '3', '2700', '1');
INSERT INTO `area` VALUES ('510724', '5107', '安  县', '3', '2701', '1');
INSERT INTO `area` VALUES ('510725', '5107', '梓潼县', '3', '2702', '1');
INSERT INTO `area` VALUES ('510726', '5107', '北川县', '3', '2703', '1');
INSERT INTO `area` VALUES ('510727', '5107', '平武县', '3', '2704', '1');
INSERT INTO `area` VALUES ('510781', '5107', '江油市', '3', '2705', '1');
INSERT INTO `area` VALUES ('510801', '5108', '市辖区', '3', '2706', '1');
INSERT INTO `area` VALUES ('510802', '5108', '市中区', '3', '2707', '1');
INSERT INTO `area` VALUES ('510811', '5108', '元坝区', '3', '2708', '1');
INSERT INTO `area` VALUES ('510812', '5108', '朝天区', '3', '2709', '1');
INSERT INTO `area` VALUES ('510821', '5108', '旺苍县', '3', '2710', '1');
INSERT INTO `area` VALUES ('510822', '5108', '青川县', '3', '2711', '1');
INSERT INTO `area` VALUES ('510823', '5108', '剑阁县', '3', '2712', '1');
INSERT INTO `area` VALUES ('510824', '5108', '苍溪县', '3', '2713', '1');
INSERT INTO `area` VALUES ('510901', '5109', '市辖区', '3', '2714', '1');
INSERT INTO `area` VALUES ('510902', '5109', '市中区', '3', '2715', '1');
INSERT INTO `area` VALUES ('510921', '5109', '蓬溪县', '3', '2716', '1');
INSERT INTO `area` VALUES ('510922', '5109', '射洪县', '3', '2717', '1');
INSERT INTO `area` VALUES ('510923', '5109', '大英县', '3', '2718', '1');
INSERT INTO `area` VALUES ('511001', '5110', '市辖区', '3', '2719', '1');
INSERT INTO `area` VALUES ('511002', '5110', '市中区', '3', '2720', '1');
INSERT INTO `area` VALUES ('511011', '5110', '东兴区', '3', '2721', '1');
INSERT INTO `area` VALUES ('511024', '5110', '威远县', '3', '2722', '1');
INSERT INTO `area` VALUES ('511025', '5110', '资中县', '3', '2723', '1');
INSERT INTO `area` VALUES ('511028', '5110', '隆昌县', '3', '2724', '1');
INSERT INTO `area` VALUES ('511101', '5111', '市辖区', '3', '2725', '1');
INSERT INTO `area` VALUES ('511102', '5111', '市中区', '3', '2726', '1');
INSERT INTO `area` VALUES ('511111', '5111', '沙湾区', '3', '2727', '1');
INSERT INTO `area` VALUES ('511112', '5111', '五通桥区', '3', '2728', '1');
INSERT INTO `area` VALUES ('511113', '5111', '金口河区', '3', '2729', '1');
INSERT INTO `area` VALUES ('511123', '5111', '犍为县', '3', '2730', '1');
INSERT INTO `area` VALUES ('511124', '5111', '井研县', '3', '2731', '1');
INSERT INTO `area` VALUES ('511126', '5111', '夹江县', '3', '2732', '1');
INSERT INTO `area` VALUES ('511129', '5111', '沐川县', '3', '2733', '1');
INSERT INTO `area` VALUES ('511132', '5111', '峨边彝族自治县', '3', '2734', '1');
INSERT INTO `area` VALUES ('511133', '5111', '马边彝族自治县', '3', '2735', '1');
INSERT INTO `area` VALUES ('511181', '5111', '峨眉山市', '3', '2736', '1');
INSERT INTO `area` VALUES ('511301', '5113', '市辖区', '3', '2737', '1');
INSERT INTO `area` VALUES ('511302', '5113', '顺庆区', '3', '2738', '1');
INSERT INTO `area` VALUES ('511303', '5113', '高坪区', '3', '2739', '1');
INSERT INTO `area` VALUES ('511304', '5113', '嘉陵区', '3', '2740', '1');
INSERT INTO `area` VALUES ('511321', '5113', '南部县', '3', '2741', '1');
INSERT INTO `area` VALUES ('511322', '5113', '营山县', '3', '2742', '1');
INSERT INTO `area` VALUES ('511323', '5113', '蓬安县', '3', '2743', '1');
INSERT INTO `area` VALUES ('511324', '5113', '仪陇县', '3', '2744', '1');
INSERT INTO `area` VALUES ('511325', '5113', '西充县', '3', '2745', '1');
INSERT INTO `area` VALUES ('511381', '5113', '阆中市', '3', '2746', '1');
INSERT INTO `area` VALUES ('511401', '5114', '市辖区', '3', '2747', '1');
INSERT INTO `area` VALUES ('511402', '5114', '东坡区', '3', '2748', '1');
INSERT INTO `area` VALUES ('511421', '5114', '仁寿县', '3', '2749', '1');
INSERT INTO `area` VALUES ('511422', '5114', '彭山县', '3', '2750', '1');
INSERT INTO `area` VALUES ('511423', '5114', '洪雅县', '3', '2751', '1');
INSERT INTO `area` VALUES ('511424', '5114', '丹棱县', '3', '2752', '1');
INSERT INTO `area` VALUES ('511425', '5114', '青神县', '3', '2753', '1');
INSERT INTO `area` VALUES ('511501', '5115', '市辖区', '3', '2754', '1');
INSERT INTO `area` VALUES ('511502', '5115', '翠屏区', '3', '2755', '1');
INSERT INTO `area` VALUES ('511521', '5115', '宜宾县', '3', '2756', '1');
INSERT INTO `area` VALUES ('511522', '5115', '南溪县', '3', '2757', '1');
INSERT INTO `area` VALUES ('511523', '5115', '江安县', '3', '2758', '1');
INSERT INTO `area` VALUES ('511524', '5115', '长宁县', '3', '2759', '1');
INSERT INTO `area` VALUES ('511525', '5115', '高  县', '3', '2760', '1');
INSERT INTO `area` VALUES ('511526', '5115', '珙  县', '3', '2761', '1');
INSERT INTO `area` VALUES ('511527', '5115', '筠连县', '3', '2762', '1');
INSERT INTO `area` VALUES ('511528', '5115', '兴文县', '3', '2763', '1');
INSERT INTO `area` VALUES ('511529', '5115', '屏山县', '3', '2764', '1');
INSERT INTO `area` VALUES ('511601', '5116', '市辖区', '3', '2765', '1');
INSERT INTO `area` VALUES ('511602', '5116', '广安区', '3', '2766', '1');
INSERT INTO `area` VALUES ('511621', '5116', '岳池县', '3', '2767', '1');
INSERT INTO `area` VALUES ('511622', '5116', '武胜县', '3', '2768', '1');
INSERT INTO `area` VALUES ('511623', '5116', '邻水县', '3', '2769', '1');
INSERT INTO `area` VALUES ('511681', '5116', '华蓥市', '3', '2770', '1');
INSERT INTO `area` VALUES ('511701', '5117', '市辖区', '3', '2771', '1');
INSERT INTO `area` VALUES ('511702', '5117', '通川区', '3', '2772', '1');
INSERT INTO `area` VALUES ('511721', '5117', '达  县', '3', '2773', '1');
INSERT INTO `area` VALUES ('511722', '5117', '宣汉县', '3', '2774', '1');
INSERT INTO `area` VALUES ('511723', '5117', '开江县', '3', '2775', '1');
INSERT INTO `area` VALUES ('511724', '5117', '大竹县', '3', '2776', '1');
INSERT INTO `area` VALUES ('511725', '5117', '渠  县', '3', '2777', '1');
INSERT INTO `area` VALUES ('511781', '5117', '万源市', '3', '2778', '1');
INSERT INTO `area` VALUES ('511801', '5118', '市辖区', '3', '2779', '1');
INSERT INTO `area` VALUES ('511802', '5118', '雨城区', '3', '2780', '1');
INSERT INTO `area` VALUES ('511821', '5118', '名山县', '3', '2781', '1');
INSERT INTO `area` VALUES ('511822', '5118', '荥经县', '3', '2782', '1');
INSERT INTO `area` VALUES ('511823', '5118', '汉源县', '3', '2783', '1');
INSERT INTO `area` VALUES ('511824', '5118', '石棉县', '3', '2784', '1');
INSERT INTO `area` VALUES ('511825', '5118', '天全县', '3', '2785', '1');
INSERT INTO `area` VALUES ('511826', '5118', '芦山县', '3', '2786', '1');
INSERT INTO `area` VALUES ('511827', '5118', '宝兴县', '3', '2787', '1');
INSERT INTO `area` VALUES ('511901', '5119', '市辖区', '3', '2788', '1');
INSERT INTO `area` VALUES ('511902', '5119', '巴州区', '3', '2789', '1');
INSERT INTO `area` VALUES ('511921', '5119', '通江县', '3', '2790', '1');
INSERT INTO `area` VALUES ('511922', '5119', '南江县', '3', '2791', '1');
INSERT INTO `area` VALUES ('511923', '5119', '平昌县', '3', '2792', '1');
INSERT INTO `area` VALUES ('512001', '5120', '市辖区', '3', '2793', '1');
INSERT INTO `area` VALUES ('512002', '5120', '雁江区', '3', '2794', '1');
INSERT INTO `area` VALUES ('512021', '5120', '安岳县', '3', '2795', '1');
INSERT INTO `area` VALUES ('512022', '5120', '乐至县', '3', '2796', '1');
INSERT INTO `area` VALUES ('512081', '5120', '简阳市', '3', '2797', '1');
INSERT INTO `area` VALUES ('513221', '5132', '汶川县', '3', '2798', '1');
INSERT INTO `area` VALUES ('513222', '5132', '理  县', '3', '2799', '1');
INSERT INTO `area` VALUES ('513223', '5132', '茂  县', '3', '2800', '1');
INSERT INTO `area` VALUES ('513224', '5132', '松潘县', '3', '2801', '1');
INSERT INTO `area` VALUES ('513225', '5132', '九寨沟县', '3', '2802', '1');
INSERT INTO `area` VALUES ('513226', '5132', '金川县', '3', '2803', '1');
INSERT INTO `area` VALUES ('513227', '5132', '小金县', '3', '2804', '1');
INSERT INTO `area` VALUES ('513228', '5132', '黑水县', '3', '2805', '1');
INSERT INTO `area` VALUES ('513229', '5132', '马尔康县', '3', '2806', '1');
INSERT INTO `area` VALUES ('513230', '5132', '壤塘县', '3', '2807', '1');
INSERT INTO `area` VALUES ('513231', '5132', '阿坝县', '3', '2808', '1');
INSERT INTO `area` VALUES ('513232', '5132', '若尔盖县', '3', '2809', '1');
INSERT INTO `area` VALUES ('513233', '5132', '红原县', '3', '2810', '1');
INSERT INTO `area` VALUES ('513321', '5133', '康定县', '3', '2811', '1');
INSERT INTO `area` VALUES ('513322', '5133', '泸定县', '3', '2812', '1');
INSERT INTO `area` VALUES ('513323', '5133', '丹巴县', '3', '2813', '1');
INSERT INTO `area` VALUES ('513324', '5133', '九龙县', '3', '2814', '1');
INSERT INTO `area` VALUES ('513325', '5133', '雅江县', '3', '2815', '1');
INSERT INTO `area` VALUES ('513326', '5133', '道孚县', '3', '2816', '1');
INSERT INTO `area` VALUES ('513327', '5133', '炉霍县', '3', '2817', '1');
INSERT INTO `area` VALUES ('513328', '5133', '甘孜县', '3', '2818', '1');
INSERT INTO `area` VALUES ('513329', '5133', '新龙县', '3', '2819', '1');
INSERT INTO `area` VALUES ('513330', '5133', '德格县', '3', '2820', '1');
INSERT INTO `area` VALUES ('513331', '5133', '白玉县', '3', '2821', '1');
INSERT INTO `area` VALUES ('513332', '5133', '石渠县', '3', '2822', '1');
INSERT INTO `area` VALUES ('513333', '5133', '色达县', '3', '2823', '1');
INSERT INTO `area` VALUES ('513334', '5133', '理塘县', '3', '2824', '1');
INSERT INTO `area` VALUES ('513335', '5133', '巴塘县', '3', '2825', '1');
INSERT INTO `area` VALUES ('513336', '5133', '乡城县', '3', '2826', '1');
INSERT INTO `area` VALUES ('513337', '5133', '稻城县', '3', '2827', '1');
INSERT INTO `area` VALUES ('513338', '5133', '得荣县', '3', '2828', '1');
INSERT INTO `area` VALUES ('513401', '5134', '西昌市', '3', '2829', '1');
INSERT INTO `area` VALUES ('513422', '5134', '木里藏族自治县', '3', '2830', '1');
INSERT INTO `area` VALUES ('513423', '5134', '盐源县', '3', '2831', '1');
INSERT INTO `area` VALUES ('513424', '5134', '德昌县', '3', '2832', '1');
INSERT INTO `area` VALUES ('513425', '5134', '会理县', '3', '2833', '1');
INSERT INTO `area` VALUES ('513426', '5134', '会东县', '3', '2834', '1');
INSERT INTO `area` VALUES ('513427', '5134', '宁南县', '3', '2835', '1');
INSERT INTO `area` VALUES ('513428', '5134', '普格县', '3', '2836', '1');
INSERT INTO `area` VALUES ('513429', '5134', '布拖县', '3', '2837', '1');
INSERT INTO `area` VALUES ('513430', '5134', '金阳县', '3', '2838', '1');
INSERT INTO `area` VALUES ('513431', '5134', '昭觉县', '3', '2839', '1');
INSERT INTO `area` VALUES ('513432', '5134', '喜德县', '3', '2840', '1');
INSERT INTO `area` VALUES ('513433', '5134', '冕宁县', '3', '2841', '1');
INSERT INTO `area` VALUES ('513434', '5134', '越西县', '3', '2842', '1');
INSERT INTO `area` VALUES ('513435', '5134', '甘洛县', '3', '2843', '1');
INSERT INTO `area` VALUES ('513436', '5134', '美姑县', '3', '2844', '1');
INSERT INTO `area` VALUES ('513437', '5134', '雷波县', '3', '2845', '1');
INSERT INTO `area` VALUES ('520101', '5201', '市辖区', '3', '2846', '1');
INSERT INTO `area` VALUES ('520102', '5201', '南明区', '3', '2847', '1');
INSERT INTO `area` VALUES ('520103', '5201', '云岩区', '3', '2848', '1');
INSERT INTO `area` VALUES ('520111', '5201', '花溪区', '3', '2849', '1');
INSERT INTO `area` VALUES ('520112', '5201', '乌当区', '3', '2850', '1');
INSERT INTO `area` VALUES ('520113', '5201', '白云区', '3', '2851', '1');
INSERT INTO `area` VALUES ('520114', '5201', '小河区', '3', '2852', '1');
INSERT INTO `area` VALUES ('520121', '5201', '开阳县', '3', '2853', '1');
INSERT INTO `area` VALUES ('520122', '5201', '息烽县', '3', '2854', '1');
INSERT INTO `area` VALUES ('520123', '5201', '修文县', '3', '2855', '1');
INSERT INTO `area` VALUES ('520181', '5201', '清镇市', '3', '2856', '1');
INSERT INTO `area` VALUES ('520201', '5202', '钟山区', '3', '2857', '1');
INSERT INTO `area` VALUES ('520203', '5202', '六枝特区', '3', '2858', '1');
INSERT INTO `area` VALUES ('520221', '5202', '水城县', '3', '2859', '1');
INSERT INTO `area` VALUES ('520222', '5202', '盘  县', '3', '2860', '1');
INSERT INTO `area` VALUES ('520301', '5203', '市辖区', '3', '2861', '1');
INSERT INTO `area` VALUES ('520302', '5203', '红花岗区', '3', '2862', '1');
INSERT INTO `area` VALUES ('520321', '5203', '遵义县', '3', '2863', '1');
INSERT INTO `area` VALUES ('520322', '5203', '桐梓县', '3', '2864', '1');
INSERT INTO `area` VALUES ('520323', '5203', '绥阳县', '3', '2865', '1');
INSERT INTO `area` VALUES ('520324', '5203', '正安县', '3', '2866', '1');
INSERT INTO `area` VALUES ('520325', '5203', '道真仡佬族苗族自治县', '3', '2867', '1');
INSERT INTO `area` VALUES ('520326', '5203', '务川仡佬族苗族自治县', '3', '2868', '1');
INSERT INTO `area` VALUES ('520327', '5203', '凤冈县', '3', '2869', '1');
INSERT INTO `area` VALUES ('520328', '5203', '湄潭县', '3', '2870', '1');
INSERT INTO `area` VALUES ('520329', '5203', '余庆县', '3', '2871', '1');
INSERT INTO `area` VALUES ('520330', '5203', '习水县', '3', '2872', '1');
INSERT INTO `area` VALUES ('520381', '5203', '赤水市', '3', '2873', '1');
INSERT INTO `area` VALUES ('520382', '5203', '仁怀市', '3', '2874', '1');
INSERT INTO `area` VALUES ('520401', '5204', '市辖区', '3', '2875', '1');
INSERT INTO `area` VALUES ('520402', '5204', '西秀区', '3', '2876', '1');
INSERT INTO `area` VALUES ('520421', '5204', '平坝县', '3', '2877', '1');
INSERT INTO `area` VALUES ('520422', '5204', '普定县', '3', '2878', '1');
INSERT INTO `area` VALUES ('520423', '5204', '镇宁布依族苗族自治县', '3', '2879', '1');
INSERT INTO `area` VALUES ('520424', '5204', '关岭布依族苗族自治县', '3', '2880', '1');
INSERT INTO `area` VALUES ('520425', '5204', '紫云苗族布依族自治县', '3', '2881', '1');
INSERT INTO `area` VALUES ('522201', '5222', '铜仁市', '3', '2882', '1');
INSERT INTO `area` VALUES ('522222', '5222', '江口县', '3', '2883', '1');
INSERT INTO `area` VALUES ('522223', '5222', '玉屏侗族自治县', '3', '2884', '1');
INSERT INTO `area` VALUES ('522224', '5222', '石阡县', '3', '2885', '1');
INSERT INTO `area` VALUES ('522225', '5222', '思南县', '3', '2886', '1');
INSERT INTO `area` VALUES ('522226', '5222', '印江土家族苗族自治县', '3', '2887', '1');
INSERT INTO `area` VALUES ('522227', '5222', '德江县', '3', '2888', '1');
INSERT INTO `area` VALUES ('522228', '5222', '沿河土家族自治县', '3', '2889', '1');
INSERT INTO `area` VALUES ('522229', '5222', '松桃苗族自治县', '3', '2890', '1');
INSERT INTO `area` VALUES ('522230', '5222', '万山特区', '3', '2891', '1');
INSERT INTO `area` VALUES ('522301', '5223', '兴义市', '3', '2892', '1');
INSERT INTO `area` VALUES ('522322', '5223', '兴仁县', '3', '2893', '1');
INSERT INTO `area` VALUES ('522323', '5223', '普安县', '3', '2894', '1');
INSERT INTO `area` VALUES ('522324', '5223', '晴隆县', '3', '2895', '1');
INSERT INTO `area` VALUES ('522325', '5223', '贞丰县', '3', '2896', '1');
INSERT INTO `area` VALUES ('522326', '5223', '望谟县', '3', '2897', '1');
INSERT INTO `area` VALUES ('522327', '5223', '册亨县', '3', '2898', '1');
INSERT INTO `area` VALUES ('522328', '5223', '安龙县', '3', '2899', '1');
INSERT INTO `area` VALUES ('522401', '5224', '毕节市', '3', '2900', '1');
INSERT INTO `area` VALUES ('522422', '5224', '大方县', '3', '2901', '1');
INSERT INTO `area` VALUES ('522423', '5224', '黔西县', '3', '2902', '1');
INSERT INTO `area` VALUES ('522424', '5224', '金沙县', '3', '2903', '1');
INSERT INTO `area` VALUES ('522425', '5224', '织金县', '3', '2904', '1');
INSERT INTO `area` VALUES ('522426', '5224', '纳雍县', '3', '2905', '1');
INSERT INTO `area` VALUES ('522427', '5224', '威宁彝族回族苗族自治', '3', '2906', '1');
INSERT INTO `area` VALUES ('522428', '5224', '赫章县', '3', '2907', '1');
INSERT INTO `area` VALUES ('522601', '5226', '凯里市', '3', '2908', '1');
INSERT INTO `area` VALUES ('522622', '5226', '黄平县', '3', '2909', '1');
INSERT INTO `area` VALUES ('522623', '5226', '施秉县', '3', '2910', '1');
INSERT INTO `area` VALUES ('522624', '5226', '三穗县', '3', '2911', '1');
INSERT INTO `area` VALUES ('522625', '5226', '镇远县', '3', '2912', '1');
INSERT INTO `area` VALUES ('522626', '5226', '岑巩县', '3', '2913', '1');
INSERT INTO `area` VALUES ('522627', '5226', '天柱县', '3', '2914', '1');
INSERT INTO `area` VALUES ('522628', '5226', '锦屏县', '3', '2915', '1');
INSERT INTO `area` VALUES ('522629', '5226', '剑河县', '3', '2916', '1');
INSERT INTO `area` VALUES ('522630', '5226', '台江县', '3', '2917', '1');
INSERT INTO `area` VALUES ('522631', '5226', '黎平县', '3', '2918', '1');
INSERT INTO `area` VALUES ('522632', '5226', '榕江县', '3', '2919', '1');
INSERT INTO `area` VALUES ('522633', '5226', '从江县', '3', '2920', '1');
INSERT INTO `area` VALUES ('522634', '5226', '雷山县', '3', '2921', '1');
INSERT INTO `area` VALUES ('522635', '5226', '麻江县', '3', '2922', '1');
INSERT INTO `area` VALUES ('522636', '5226', '丹寨县', '3', '2923', '1');
INSERT INTO `area` VALUES ('522701', '5227', '都匀市', '3', '2924', '1');
INSERT INTO `area` VALUES ('522702', '5227', '福泉市', '3', '2925', '1');
INSERT INTO `area` VALUES ('522722', '5227', '荔波县', '3', '2926', '1');
INSERT INTO `area` VALUES ('522723', '5227', '贵定县', '3', '2927', '1');
INSERT INTO `area` VALUES ('522725', '5227', '瓮安县', '3', '2928', '1');
INSERT INTO `area` VALUES ('522726', '5227', '独山县', '3', '2929', '1');
INSERT INTO `area` VALUES ('522727', '5227', '平塘县', '3', '2930', '1');
INSERT INTO `area` VALUES ('522728', '5227', '罗甸县', '3', '2931', '1');
INSERT INTO `area` VALUES ('522729', '5227', '长顺县', '3', '2932', '1');
INSERT INTO `area` VALUES ('522730', '5227', '龙里县', '3', '2933', '1');
INSERT INTO `area` VALUES ('522731', '5227', '惠水县', '3', '2934', '1');
INSERT INTO `area` VALUES ('522732', '5227', '三都水族自治县', '3', '2935', '1');
INSERT INTO `area` VALUES ('530101', '5301', '市辖区', '3', '2936', '1');
INSERT INTO `area` VALUES ('530102', '5301', '五华区', '3', '2937', '1');
INSERT INTO `area` VALUES ('530103', '5301', '盘龙区', '3', '2938', '1');
INSERT INTO `area` VALUES ('530111', '5301', '官渡区', '3', '2939', '1');
INSERT INTO `area` VALUES ('530112', '5301', '西山区', '3', '2940', '1');
INSERT INTO `area` VALUES ('530113', '5301', '东川区', '3', '2941', '1');
INSERT INTO `area` VALUES ('530121', '5301', '呈贡县', '3', '2942', '1');
INSERT INTO `area` VALUES ('530122', '5301', '晋宁县', '3', '2943', '1');
INSERT INTO `area` VALUES ('530124', '5301', '富民县', '3', '2944', '1');
INSERT INTO `area` VALUES ('530125', '5301', '宜良县', '3', '2945', '1');
INSERT INTO `area` VALUES ('530126', '5301', '石林彝族自治县', '3', '2946', '1');
INSERT INTO `area` VALUES ('530127', '5301', '嵩明县', '3', '2947', '1');
INSERT INTO `area` VALUES ('530128', '5301', '禄劝彝族苗族自治县', '3', '2948', '1');
INSERT INTO `area` VALUES ('530129', '5301', '寻甸回族彝族自治县', '3', '2949', '1');
INSERT INTO `area` VALUES ('530181', '5301', '安宁市', '3', '2950', '1');
INSERT INTO `area` VALUES ('530301', '5303', '市辖区', '3', '2951', '1');
INSERT INTO `area` VALUES ('530302', '5303', '麒麟区', '3', '2952', '1');
INSERT INTO `area` VALUES ('530321', '5303', '马龙县', '3', '2953', '1');
INSERT INTO `area` VALUES ('530322', '5303', '陆良县', '3', '2954', '1');
INSERT INTO `area` VALUES ('530323', '5303', '师宗县', '3', '2955', '1');
INSERT INTO `area` VALUES ('530324', '5303', '罗平县', '3', '2956', '1');
INSERT INTO `area` VALUES ('530325', '5303', '富源县', '3', '2957', '1');
INSERT INTO `area` VALUES ('530326', '5303', '会泽县', '3', '2958', '1');
INSERT INTO `area` VALUES ('530328', '5303', '沾益县', '3', '2959', '1');
INSERT INTO `area` VALUES ('530381', '5303', '宣威市', '3', '2960', '1');
INSERT INTO `area` VALUES ('530401', '5304', '市辖区', '3', '2961', '1');
INSERT INTO `area` VALUES ('530402', '5304', '红塔区', '3', '2962', '1');
INSERT INTO `area` VALUES ('530421', '5304', '江川县', '3', '2963', '1');
INSERT INTO `area` VALUES ('530422', '5304', '澄江县', '3', '2964', '1');
INSERT INTO `area` VALUES ('530423', '5304', '通海县', '3', '2965', '1');
INSERT INTO `area` VALUES ('530424', '5304', '华宁县', '3', '2966', '1');
INSERT INTO `area` VALUES ('530425', '5304', '易门县', '3', '2967', '1');
INSERT INTO `area` VALUES ('530426', '5304', '峨山彝族自治县', '3', '2968', '1');
INSERT INTO `area` VALUES ('530427', '5304', '新平彝族傣族自治县', '3', '2969', '1');
INSERT INTO `area` VALUES ('530428', '5304', '元江哈尼族彝族傣族自', '3', '2970', '1');
INSERT INTO `area` VALUES ('530501', '5305', '市辖区', '3', '2971', '1');
INSERT INTO `area` VALUES ('530502', '5305', '隆阳区', '3', '2972', '1');
INSERT INTO `area` VALUES ('530521', '5305', '施甸县', '3', '2973', '1');
INSERT INTO `area` VALUES ('530522', '5305', '腾冲县', '3', '2974', '1');
INSERT INTO `area` VALUES ('530523', '5305', '龙陵县', '3', '2975', '1');
INSERT INTO `area` VALUES ('530524', '5305', '昌宁县', '3', '2976', '1');
INSERT INTO `area` VALUES ('532101', '5321', '昭通市', '3', '2977', '1');
INSERT INTO `area` VALUES ('532122', '5321', '鲁甸县', '3', '2978', '1');
INSERT INTO `area` VALUES ('532123', '5321', '巧家县', '3', '2979', '1');
INSERT INTO `area` VALUES ('532124', '5321', '盐津县', '3', '2980', '1');
INSERT INTO `area` VALUES ('532125', '5321', '大关县', '3', '2981', '1');
INSERT INTO `area` VALUES ('532126', '5321', '永善县', '3', '2982', '1');
INSERT INTO `area` VALUES ('532127', '5321', '绥江县', '3', '2983', '1');
INSERT INTO `area` VALUES ('532128', '5321', '镇雄县', '3', '2984', '1');
INSERT INTO `area` VALUES ('532129', '5321', '彝良县', '3', '2985', '1');
INSERT INTO `area` VALUES ('532130', '5321', '威信县', '3', '2986', '1');
INSERT INTO `area` VALUES ('532131', '5321', '水富县', '3', '2987', '1');
INSERT INTO `area` VALUES ('532301', '5323', '楚雄市', '3', '2988', '1');
INSERT INTO `area` VALUES ('532322', '5323', '双柏县', '3', '2989', '1');
INSERT INTO `area` VALUES ('532323', '5323', '牟定县', '3', '2990', '1');
INSERT INTO `area` VALUES ('532324', '5323', '南华县', '3', '2991', '1');
INSERT INTO `area` VALUES ('532325', '5323', '姚安县', '3', '2992', '1');
INSERT INTO `area` VALUES ('532326', '5323', '大姚县', '3', '2993', '1');
INSERT INTO `area` VALUES ('532327', '5323', '永仁县', '3', '2994', '1');
INSERT INTO `area` VALUES ('532328', '5323', '元谋县', '3', '2995', '1');
INSERT INTO `area` VALUES ('532329', '5323', '武定县', '3', '2996', '1');
INSERT INTO `area` VALUES ('532331', '5323', '禄丰县', '3', '2997', '1');
INSERT INTO `area` VALUES ('532501', '5325', '个旧市', '3', '2998', '1');
INSERT INTO `area` VALUES ('532502', '5325', '开远市', '3', '2999', '1');
INSERT INTO `area` VALUES ('532522', '5325', '蒙自县', '3', '3000', '1');
INSERT INTO `area` VALUES ('532523', '5325', '屏边苗族自治县', '3', '3001', '1');
INSERT INTO `area` VALUES ('532524', '5325', '建水县', '3', '3002', '1');
INSERT INTO `area` VALUES ('532525', '5325', '石屏县', '3', '3003', '1');
INSERT INTO `area` VALUES ('532526', '5325', '弥勒县', '3', '3004', '1');
INSERT INTO `area` VALUES ('532527', '5325', '泸西县', '3', '3005', '1');
INSERT INTO `area` VALUES ('532528', '5325', '元阳县', '3', '3006', '1');
INSERT INTO `area` VALUES ('532529', '5325', '红河县', '3', '3007', '1');
INSERT INTO `area` VALUES ('532530', '5325', '金平苗族瑶族傣族自治', '3', '3008', '1');
INSERT INTO `area` VALUES ('532531', '5325', '绿春县', '3', '3009', '1');
INSERT INTO `area` VALUES ('532532', '5325', '河口瑶族自治县', '3', '3010', '1');
INSERT INTO `area` VALUES ('532621', '5326', '文山县', '3', '3011', '1');
INSERT INTO `area` VALUES ('532622', '5326', '砚山县', '3', '3012', '1');
INSERT INTO `area` VALUES ('532623', '5326', '西畴县', '3', '3013', '1');
INSERT INTO `area` VALUES ('532624', '5326', '麻栗坡县', '3', '3014', '1');
INSERT INTO `area` VALUES ('532625', '5326', '马关县', '3', '3015', '1');
INSERT INTO `area` VALUES ('532626', '5326', '丘北县', '3', '3016', '1');
INSERT INTO `area` VALUES ('532627', '5326', '广南县', '3', '3017', '1');
INSERT INTO `area` VALUES ('532628', '5326', '富宁县', '3', '3018', '1');
INSERT INTO `area` VALUES ('532701', '5327', '思茅市', '3', '3019', '1');
INSERT INTO `area` VALUES ('532722', '5327', '普洱哈尼族彝族自治县', '3', '3020', '1');
INSERT INTO `area` VALUES ('532723', '5327', '墨江哈尼族自治县', '3', '3021', '1');
INSERT INTO `area` VALUES ('532724', '5327', '景东彝族自治县', '3', '3022', '1');
INSERT INTO `area` VALUES ('532725', '5327', '景谷傣族彝族自治县', '3', '3023', '1');
INSERT INTO `area` VALUES ('532726', '5327', '镇沅彝族哈尼族拉祜族', '3', '3024', '1');
INSERT INTO `area` VALUES ('532727', '5327', '江城哈尼族彝族自治县', '3', '3025', '1');
INSERT INTO `area` VALUES ('532728', '5327', '孟连傣族拉祜族佤族自', '3', '3026', '1');
INSERT INTO `area` VALUES ('532729', '5327', '澜沧拉祜族自治县', '3', '3027', '1');
INSERT INTO `area` VALUES ('532730', '5327', '西盟佤族自治县', '3', '3028', '1');
INSERT INTO `area` VALUES ('532801', '5328', '景洪市', '3', '3029', '1');
INSERT INTO `area` VALUES ('532822', '5328', '勐海县', '3', '3030', '1');
INSERT INTO `area` VALUES ('532823', '5328', '勐腊县', '3', '3031', '1');
INSERT INTO `area` VALUES ('532901', '5329', '大理市', '3', '3032', '1');
INSERT INTO `area` VALUES ('532922', '5329', '漾濞彝族自治县', '3', '3033', '1');
INSERT INTO `area` VALUES ('532923', '5329', '祥云县', '3', '3034', '1');
INSERT INTO `area` VALUES ('532924', '5329', '宾川县', '3', '3035', '1');
INSERT INTO `area` VALUES ('532925', '5329', '弥渡县', '3', '3036', '1');
INSERT INTO `area` VALUES ('532926', '5329', '南涧彝族自治县', '3', '3037', '1');
INSERT INTO `area` VALUES ('532927', '5329', '巍山彝族回族自治县', '3', '3038', '1');
INSERT INTO `area` VALUES ('532928', '5329', '永平县', '3', '3039', '1');
INSERT INTO `area` VALUES ('532929', '5329', '云龙县', '3', '3040', '1');
INSERT INTO `area` VALUES ('532930', '5329', '洱源县', '3', '3041', '1');
INSERT INTO `area` VALUES ('532931', '5329', '剑川县', '3', '3042', '1');
INSERT INTO `area` VALUES ('532932', '5329', '鹤庆县', '3', '3043', '1');
INSERT INTO `area` VALUES ('533102', '5331', '瑞丽市', '3', '3044', '1');
INSERT INTO `area` VALUES ('533103', '5331', '潞西市', '3', '3045', '1');
INSERT INTO `area` VALUES ('533122', '5331', '梁河县', '3', '3046', '1');
INSERT INTO `area` VALUES ('533123', '5331', '盈江县', '3', '3047', '1');
INSERT INTO `area` VALUES ('533124', '5331', '陇川县', '3', '3048', '1');
INSERT INTO `area` VALUES ('533221', '5332', '丽江纳西族自治县', '3', '3049', '1');
INSERT INTO `area` VALUES ('533222', '5332', '永胜县', '3', '3050', '1');
INSERT INTO `area` VALUES ('533223', '5332', '华坪县', '3', '3051', '1');
INSERT INTO `area` VALUES ('533224', '5332', '宁蒗彝族自治县', '3', '3052', '1');
INSERT INTO `area` VALUES ('533321', '5333', '泸水县', '3', '3053', '1');
INSERT INTO `area` VALUES ('533323', '5333', '福贡县', '3', '3054', '1');
INSERT INTO `area` VALUES ('533324', '5333', '贡山独龙族怒族自治县', '3', '3055', '1');
INSERT INTO `area` VALUES ('533325', '5333', '兰坪白族普米族自治县', '3', '3056', '1');
INSERT INTO `area` VALUES ('533421', '5334', '中甸县', '3', '3057', '1');
INSERT INTO `area` VALUES ('533422', '5334', '德钦县', '3', '3058', '1');
INSERT INTO `area` VALUES ('533423', '5334', '维西傈僳族自治县', '3', '3059', '1');
INSERT INTO `area` VALUES ('533521', '5335', '临沧县', '3', '3060', '1');
INSERT INTO `area` VALUES ('533522', '5335', '凤庆县', '3', '3061', '1');
INSERT INTO `area` VALUES ('533523', '5335', '云  县', '3', '3062', '1');
INSERT INTO `area` VALUES ('533524', '5335', '永德县', '3', '3063', '1');
INSERT INTO `area` VALUES ('533525', '5335', '镇康县', '3', '3064', '1');
INSERT INTO `area` VALUES ('533526', '5335', '双江拉祜族佤族布朗族', '3', '3065', '1');
INSERT INTO `area` VALUES ('533527', '5335', '耿马傣族佤族自治县', '3', '3066', '1');
INSERT INTO `area` VALUES ('533528', '5335', '沧源佤族自治县', '3', '3067', '1');
INSERT INTO `area` VALUES ('540101', '5401', '市辖区', '3', '3068', '1');
INSERT INTO `area` VALUES ('540102', '5401', '城关区', '3', '3069', '1');
INSERT INTO `area` VALUES ('540121', '5401', '林周县', '3', '3070', '1');
INSERT INTO `area` VALUES ('540122', '5401', '当雄县', '3', '3071', '1');
INSERT INTO `area` VALUES ('540123', '5401', '尼木县', '3', '3072', '1');
INSERT INTO `area` VALUES ('540124', '5401', '曲水县', '3', '3073', '1');
INSERT INTO `area` VALUES ('540125', '5401', '堆龙德庆县', '3', '3074', '1');
INSERT INTO `area` VALUES ('540126', '5401', '达孜县', '3', '3075', '1');
INSERT INTO `area` VALUES ('540127', '5401', '墨竹工卡县', '3', '3076', '1');
INSERT INTO `area` VALUES ('542121', '5421', '昌都县', '3', '3077', '1');
INSERT INTO `area` VALUES ('542122', '5421', '江达县', '3', '3078', '1');
INSERT INTO `area` VALUES ('542123', '5421', '贡觉县', '3', '3079', '1');
INSERT INTO `area` VALUES ('542124', '5421', '类乌齐县', '3', '3080', '1');
INSERT INTO `area` VALUES ('542125', '5421', '丁青县', '3', '3081', '1');
INSERT INTO `area` VALUES ('542126', '5421', '察雅县', '3', '3082', '1');
INSERT INTO `area` VALUES ('542127', '5421', '八宿县', '3', '3083', '1');
INSERT INTO `area` VALUES ('542128', '5421', '左贡县', '3', '3084', '1');
INSERT INTO `area` VALUES ('542129', '5421', '芒康县', '3', '3085', '1');
INSERT INTO `area` VALUES ('542132', '5421', '洛隆县', '3', '3086', '1');
INSERT INTO `area` VALUES ('542133', '5421', '边坝县', '3', '3087', '1');
INSERT INTO `area` VALUES ('542221', '5422', '乃东县', '3', '3088', '1');
INSERT INTO `area` VALUES ('542222', '5422', '扎囊县', '3', '3089', '1');
INSERT INTO `area` VALUES ('542223', '5422', '贡嘎县', '3', '3090', '1');
INSERT INTO `area` VALUES ('542224', '5422', '桑日县', '3', '3091', '1');
INSERT INTO `area` VALUES ('542225', '5422', '琼结县', '3', '3092', '1');
INSERT INTO `area` VALUES ('542226', '5422', '曲松县', '3', '3093', '1');
INSERT INTO `area` VALUES ('542227', '5422', '措美县', '3', '3094', '1');
INSERT INTO `area` VALUES ('542228', '5422', '洛扎县', '3', '3095', '1');
INSERT INTO `area` VALUES ('542229', '5422', '加查县', '3', '3096', '1');
INSERT INTO `area` VALUES ('542231', '5422', '隆子县', '3', '3097', '1');
INSERT INTO `area` VALUES ('542232', '5422', '错那县', '3', '3098', '1');
INSERT INTO `area` VALUES ('542233', '5422', '浪卡子县', '3', '3099', '1');
INSERT INTO `area` VALUES ('542301', '5423', '日喀则市', '3', '3100', '1');
INSERT INTO `area` VALUES ('542322', '5423', '南木林县', '3', '3101', '1');
INSERT INTO `area` VALUES ('542323', '5423', '江孜县', '3', '3102', '1');
INSERT INTO `area` VALUES ('542324', '5423', '定日县', '3', '3103', '1');
INSERT INTO `area` VALUES ('542325', '5423', '萨迦县', '3', '3104', '1');
INSERT INTO `area` VALUES ('542326', '5423', '拉孜县', '3', '3105', '1');
INSERT INTO `area` VALUES ('542327', '5423', '昂仁县', '3', '3106', '1');
INSERT INTO `area` VALUES ('542328', '5423', '谢通门县', '3', '3107', '1');
INSERT INTO `area` VALUES ('542329', '5423', '白朗县', '3', '3108', '1');
INSERT INTO `area` VALUES ('542330', '5423', '仁布县', '3', '3109', '1');
INSERT INTO `area` VALUES ('542331', '5423', '康马县', '3', '3110', '1');
INSERT INTO `area` VALUES ('542332', '5423', '定结县', '3', '3111', '1');
INSERT INTO `area` VALUES ('542333', '5423', '仲巴县', '3', '3112', '1');
INSERT INTO `area` VALUES ('542334', '5423', '亚东县', '3', '3113', '1');
INSERT INTO `area` VALUES ('542335', '5423', '吉隆县', '3', '3114', '1');
INSERT INTO `area` VALUES ('542336', '5423', '聂拉木县', '3', '3115', '1');
INSERT INTO `area` VALUES ('542337', '5423', '萨嘎县', '3', '3116', '1');
INSERT INTO `area` VALUES ('542338', '5423', '岗巴县', '3', '3117', '1');
INSERT INTO `area` VALUES ('542421', '5424', '那曲县', '3', '3118', '1');
INSERT INTO `area` VALUES ('542422', '5424', '嘉黎县', '3', '3119', '1');
INSERT INTO `area` VALUES ('542423', '5424', '比如县', '3', '3120', '1');
INSERT INTO `area` VALUES ('542424', '5424', '聂荣县', '3', '3121', '1');
INSERT INTO `area` VALUES ('542425', '5424', '安多县', '3', '3122', '1');
INSERT INTO `area` VALUES ('542426', '5424', '申扎县', '3', '3123', '1');
INSERT INTO `area` VALUES ('542427', '5424', '索  县', '3', '3124', '1');
INSERT INTO `area` VALUES ('542428', '5424', '班戈县', '3', '3125', '1');
INSERT INTO `area` VALUES ('542429', '5424', '巴青县', '3', '3126', '1');
INSERT INTO `area` VALUES ('542430', '5424', '尼玛县', '3', '3127', '1');
INSERT INTO `area` VALUES ('542521', '5425', '普兰县', '3', '3128', '1');
INSERT INTO `area` VALUES ('542522', '5425', '札达县', '3', '3129', '1');
INSERT INTO `area` VALUES ('542523', '5425', '噶尔县', '3', '3130', '1');
INSERT INTO `area` VALUES ('542524', '5425', '日土县', '3', '3131', '1');
INSERT INTO `area` VALUES ('542525', '5425', '革吉县', '3', '3132', '1');
INSERT INTO `area` VALUES ('542526', '5425', '改则县', '3', '3133', '1');
INSERT INTO `area` VALUES ('542527', '5425', '措勤县', '3', '3134', '1');
INSERT INTO `area` VALUES ('542621', '5426', '林芝县', '3', '3135', '1');
INSERT INTO `area` VALUES ('542622', '5426', '工布江达县', '3', '3136', '1');
INSERT INTO `area` VALUES ('542623', '5426', '米林县', '3', '3137', '1');
INSERT INTO `area` VALUES ('542624', '5426', '墨脱县', '3', '3138', '1');
INSERT INTO `area` VALUES ('542625', '5426', '波密县', '3', '3139', '1');
INSERT INTO `area` VALUES ('542626', '5426', '察隅县', '3', '3140', '1');
INSERT INTO `area` VALUES ('542627', '5426', '朗  县', '3', '3141', '1');
INSERT INTO `area` VALUES ('610101', '6101', '市辖区', '3', '3142', '1');
INSERT INTO `area` VALUES ('610102', '6101', '新城区', '3', '3143', '1');
INSERT INTO `area` VALUES ('610103', '6101', '碑林区', '3', '3144', '1');
INSERT INTO `area` VALUES ('610104', '6101', '莲湖区', '3', '3145', '1');
INSERT INTO `area` VALUES ('610111', '6101', '灞桥区', '3', '3146', '1');
INSERT INTO `area` VALUES ('610112', '6101', '未央区', '3', '3147', '1');
INSERT INTO `area` VALUES ('610113', '6101', '雁塔区', '3', '3148', '1');
INSERT INTO `area` VALUES ('610114', '6101', '阎良区', '3', '3149', '1');
INSERT INTO `area` VALUES ('610115', '6101', '临潼区', '3', '3150', '1');
INSERT INTO `area` VALUES ('610121', '6101', '长安县', '3', '3151', '1');
INSERT INTO `area` VALUES ('610122', '6101', '蓝田县', '3', '3152', '1');
INSERT INTO `area` VALUES ('610124', '6101', '周至县', '3', '3153', '1');
INSERT INTO `area` VALUES ('610125', '6101', '户  县', '3', '3154', '1');
INSERT INTO `area` VALUES ('610126', '6101', '高陵县', '3', '3155', '1');
INSERT INTO `area` VALUES ('610201', '6102', '市辖区', '3', '3156', '1');
INSERT INTO `area` VALUES ('610202', '6102', '王益区', '3', '3157', '1');
INSERT INTO `area` VALUES ('610203', '6102', '印台区', '3', '3158', '1');
INSERT INTO `area` VALUES ('610221', '6102', '耀  县', '3', '3159', '1');
INSERT INTO `area` VALUES ('610222', '6102', '宜君县', '3', '3160', '1');
INSERT INTO `area` VALUES ('610301', '6103', '市辖区', '3', '3161', '1');
INSERT INTO `area` VALUES ('610302', '6103', '渭滨区', '3', '3162', '1');
INSERT INTO `area` VALUES ('610303', '6103', '金台区', '3', '3163', '1');
INSERT INTO `area` VALUES ('610321', '6103', '宝鸡县', '3', '3164', '1');
INSERT INTO `area` VALUES ('610322', '6103', '凤翔县', '3', '3165', '1');
INSERT INTO `area` VALUES ('610323', '6103', '岐山县', '3', '3166', '1');
INSERT INTO `area` VALUES ('610324', '6103', '扶风县', '3', '3167', '1');
INSERT INTO `area` VALUES ('610326', '6103', '眉  县', '3', '3168', '1');
INSERT INTO `area` VALUES ('610327', '6103', '陇  县', '3', '3169', '1');
INSERT INTO `area` VALUES ('610328', '6103', '千阳县', '3', '3170', '1');
INSERT INTO `area` VALUES ('610329', '6103', '麟游县', '3', '3171', '1');
INSERT INTO `area` VALUES ('610330', '6103', '凤  县', '3', '3172', '1');
INSERT INTO `area` VALUES ('610331', '6103', '太白县', '3', '3173', '1');
INSERT INTO `area` VALUES ('610401', '6104', '市辖区', '3', '3174', '1');
INSERT INTO `area` VALUES ('610402', '6104', '秦都区', '3', '3175', '1');
INSERT INTO `area` VALUES ('610403', '6104', '杨陵区', '3', '3176', '1');
INSERT INTO `area` VALUES ('610404', '6104', '渭城区', '3', '3177', '1');
INSERT INTO `area` VALUES ('610422', '6104', '三原县', '3', '3178', '1');
INSERT INTO `area` VALUES ('610423', '6104', '泾阳县', '3', '3179', '1');
INSERT INTO `area` VALUES ('610424', '6104', '乾  县', '3', '3180', '1');
INSERT INTO `area` VALUES ('610425', '6104', '礼泉县', '3', '3181', '1');
INSERT INTO `area` VALUES ('610426', '6104', '永寿县', '3', '3182', '1');
INSERT INTO `area` VALUES ('610427', '6104', '彬  县', '3', '3183', '1');
INSERT INTO `area` VALUES ('610428', '6104', '长武县', '3', '3184', '1');
INSERT INTO `area` VALUES ('610429', '6104', '旬邑县', '3', '3185', '1');
INSERT INTO `area` VALUES ('610430', '6104', '淳化县', '3', '3186', '1');
INSERT INTO `area` VALUES ('610431', '6104', '武功县', '3', '3187', '1');
INSERT INTO `area` VALUES ('610481', '6104', '兴平市', '3', '3188', '1');
INSERT INTO `area` VALUES ('610501', '6105', '市辖区', '3', '3189', '1');
INSERT INTO `area` VALUES ('610502', '6105', '临渭区', '3', '3190', '1');
INSERT INTO `area` VALUES ('610521', '6105', '华  县', '3', '3191', '1');
INSERT INTO `area` VALUES ('610522', '6105', '潼关县', '3', '3192', '1');
INSERT INTO `area` VALUES ('610523', '6105', '大荔县', '3', '3193', '1');
INSERT INTO `area` VALUES ('610524', '6105', '合阳县', '3', '3194', '1');
INSERT INTO `area` VALUES ('610525', '6105', '澄城县', '3', '3195', '1');
INSERT INTO `area` VALUES ('610526', '6105', '蒲城县', '3', '3196', '1');
INSERT INTO `area` VALUES ('610527', '6105', '白水县', '3', '3197', '1');
INSERT INTO `area` VALUES ('610528', '6105', '富平县', '3', '3198', '1');
INSERT INTO `area` VALUES ('610581', '6105', '韩城市', '3', '3199', '1');
INSERT INTO `area` VALUES ('610582', '6105', '华阴市', '3', '3200', '1');
INSERT INTO `area` VALUES ('610601', '6106', '市辖区', '3', '3201', '1');
INSERT INTO `area` VALUES ('610602', '6106', '宝塔区', '3', '3202', '1');
INSERT INTO `area` VALUES ('610621', '6106', '延长县', '3', '3203', '1');
INSERT INTO `area` VALUES ('610622', '6106', '延川县', '3', '3204', '1');
INSERT INTO `area` VALUES ('610623', '6106', '子长县', '3', '3205', '1');
INSERT INTO `area` VALUES ('610624', '6106', '安塞县', '3', '3206', '1');
INSERT INTO `area` VALUES ('610625', '6106', '志丹县', '3', '3207', '1');
INSERT INTO `area` VALUES ('610626', '6106', '吴旗县', '3', '3208', '1');
INSERT INTO `area` VALUES ('610627', '6106', '甘泉县', '3', '3209', '1');
INSERT INTO `area` VALUES ('610628', '6106', '富  县', '3', '3210', '1');
INSERT INTO `area` VALUES ('610629', '6106', '洛川县', '3', '3211', '1');
INSERT INTO `area` VALUES ('610630', '6106', '宜川县', '3', '3212', '1');
INSERT INTO `area` VALUES ('610631', '6106', '黄龙县', '3', '3213', '1');
INSERT INTO `area` VALUES ('610632', '6106', '黄陵县', '3', '3214', '1');
INSERT INTO `area` VALUES ('610701', '6107', '市辖区', '3', '3215', '1');
INSERT INTO `area` VALUES ('610702', '6107', '汉台区', '3', '3216', '1');
INSERT INTO `area` VALUES ('610721', '6107', '南郑县', '3', '3217', '1');
INSERT INTO `area` VALUES ('610722', '6107', '城固县', '3', '3218', '1');
INSERT INTO `area` VALUES ('610723', '6107', '洋  县', '3', '3219', '1');
INSERT INTO `area` VALUES ('610724', '6107', '西乡县', '3', '3220', '1');
INSERT INTO `area` VALUES ('610725', '6107', '勉  县', '3', '3221', '1');
INSERT INTO `area` VALUES ('610726', '6107', '宁强县', '3', '3222', '1');
INSERT INTO `area` VALUES ('610727', '6107', '略阳县', '3', '3223', '1');
INSERT INTO `area` VALUES ('610728', '6107', '镇巴县', '3', '3224', '1');
INSERT INTO `area` VALUES ('610729', '6107', '留坝县', '3', '3225', '1');
INSERT INTO `area` VALUES ('610730', '6107', '佛坪县', '3', '3226', '1');
INSERT INTO `area` VALUES ('610801', '6108', '市辖区', '3', '3227', '1');
INSERT INTO `area` VALUES ('610802', '6108', '榆阳区', '3', '3228', '1');
INSERT INTO `area` VALUES ('610821', '6108', '神木县', '3', '3229', '1');
INSERT INTO `area` VALUES ('610822', '6108', '府谷县', '3', '3230', '1');
INSERT INTO `area` VALUES ('610823', '6108', '横山县', '3', '3231', '1');
INSERT INTO `area` VALUES ('610824', '6108', '靖边县', '3', '3232', '1');
INSERT INTO `area` VALUES ('610825', '6108', '定边县', '3', '3233', '1');
INSERT INTO `area` VALUES ('610826', '6108', '绥德县', '3', '3234', '1');
INSERT INTO `area` VALUES ('610827', '6108', '米脂县', '3', '3235', '1');
INSERT INTO `area` VALUES ('610828', '6108', '佳  县', '3', '3236', '1');
INSERT INTO `area` VALUES ('610829', '6108', '吴堡县', '3', '3237', '1');
INSERT INTO `area` VALUES ('610830', '6108', '清涧县', '3', '3238', '1');
INSERT INTO `area` VALUES ('610831', '6108', '子洲县', '3', '3239', '1');
INSERT INTO `area` VALUES ('610901', '6109', '市辖区', '3', '3240', '1');
INSERT INTO `area` VALUES ('610902', '6109', '汉滨区', '3', '3241', '1');
INSERT INTO `area` VALUES ('610921', '6109', '汉阴县', '3', '3242', '1');
INSERT INTO `area` VALUES ('610922', '6109', '石泉县', '3', '3243', '1');
INSERT INTO `area` VALUES ('610923', '6109', '宁陕县', '3', '3244', '1');
INSERT INTO `area` VALUES ('610924', '6109', '紫阳县', '3', '3245', '1');
INSERT INTO `area` VALUES ('610925', '6109', '岚皋县', '3', '3246', '1');
INSERT INTO `area` VALUES ('610926', '6109', '平利县', '3', '3247', '1');
INSERT INTO `area` VALUES ('610927', '6109', '镇坪县', '3', '3248', '1');
INSERT INTO `area` VALUES ('610928', '6109', '旬阳县', '3', '3249', '1');
INSERT INTO `area` VALUES ('610929', '6109', '白河县', '3', '3250', '1');
INSERT INTO `area` VALUES ('612501', '6125', '商州市', '3', '3251', '1');
INSERT INTO `area` VALUES ('612522', '6125', '洛南县', '3', '3252', '1');
INSERT INTO `area` VALUES ('612523', '6125', '丹凤县', '3', '3253', '1');
INSERT INTO `area` VALUES ('612524', '6125', '商南县', '3', '3254', '1');
INSERT INTO `area` VALUES ('612525', '6125', '山阳县', '3', '3255', '1');
INSERT INTO `area` VALUES ('612526', '6125', '镇安县', '3', '3256', '1');
INSERT INTO `area` VALUES ('612527', '6125', '柞水县', '3', '3257', '1');
INSERT INTO `area` VALUES ('620101', '6201', '市辖区', '3', '3258', '1');
INSERT INTO `area` VALUES ('620102', '6201', '城关区', '3', '3259', '1');
INSERT INTO `area` VALUES ('620103', '6201', '七里河区', '3', '3260', '1');
INSERT INTO `area` VALUES ('620104', '6201', '西固区', '3', '3261', '1');
INSERT INTO `area` VALUES ('620105', '6201', '安宁区', '3', '3262', '1');
INSERT INTO `area` VALUES ('620111', '6201', '红古区', '3', '3263', '1');
INSERT INTO `area` VALUES ('620121', '6201', '永登县', '3', '3264', '1');
INSERT INTO `area` VALUES ('620122', '6201', '皋兰县', '3', '3265', '1');
INSERT INTO `area` VALUES ('620123', '6201', '榆中县', '3', '3266', '1');
INSERT INTO `area` VALUES ('620201', '6202', '市辖区', '3', '3267', '1');
INSERT INTO `area` VALUES ('620301', '6203', '市辖区', '3', '3268', '1');
INSERT INTO `area` VALUES ('620302', '6203', '金川区', '3', '3269', '1');
INSERT INTO `area` VALUES ('620321', '6203', '永昌县', '3', '3270', '1');
INSERT INTO `area` VALUES ('620401', '6204', '市辖区', '3', '3271', '1');
INSERT INTO `area` VALUES ('620402', '6204', '白银区', '3', '3272', '1');
INSERT INTO `area` VALUES ('620403', '6204', '平川区', '3', '3273', '1');
INSERT INTO `area` VALUES ('620421', '6204', '靖远县', '3', '3274', '1');
INSERT INTO `area` VALUES ('620422', '6204', '会宁县', '3', '3275', '1');
INSERT INTO `area` VALUES ('620423', '6204', '景泰县', '3', '3276', '1');
INSERT INTO `area` VALUES ('620501', '6205', '市辖区', '3', '3277', '1');
INSERT INTO `area` VALUES ('620502', '6205', '秦城区', '3', '3278', '1');
INSERT INTO `area` VALUES ('620503', '6205', '北道区', '3', '3279', '1');
INSERT INTO `area` VALUES ('620521', '6205', '清水县', '3', '3280', '1');
INSERT INTO `area` VALUES ('620522', '6205', '秦安县', '3', '3281', '1');
INSERT INTO `area` VALUES ('620523', '6205', '甘谷县', '3', '3282', '1');
INSERT INTO `area` VALUES ('620524', '6205', '武山县', '3', '3283', '1');
INSERT INTO `area` VALUES ('620525', '6205', '张家川回族自治县', '3', '3284', '1');
INSERT INTO `area` VALUES ('622101', '6221', '玉门市', '3', '3285', '1');
INSERT INTO `area` VALUES ('622102', '6221', '酒泉市', '3', '3286', '1');
INSERT INTO `area` VALUES ('622103', '6221', '敦煌市', '3', '3287', '1');
INSERT INTO `area` VALUES ('622123', '6221', '金塔县', '3', '3288', '1');
INSERT INTO `area` VALUES ('622124', '6221', '肃北蒙古族自治县', '3', '3289', '1');
INSERT INTO `area` VALUES ('622125', '6221', '阿克塞哈萨克族自治县', '3', '3290', '1');
INSERT INTO `area` VALUES ('622126', '6221', '安西县', '3', '3291', '1');
INSERT INTO `area` VALUES ('622201', '6222', '张掖市', '3', '3292', '1');
INSERT INTO `area` VALUES ('622222', '6222', '肃南裕固族自治县', '3', '3293', '1');
INSERT INTO `area` VALUES ('622223', '6222', '民乐县', '3', '3294', '1');
INSERT INTO `area` VALUES ('622224', '6222', '临泽县', '3', '3295', '1');
INSERT INTO `area` VALUES ('622225', '6222', '高台县', '3', '3296', '1');
INSERT INTO `area` VALUES ('622226', '6222', '山丹县', '3', '3297', '1');
INSERT INTO `area` VALUES ('622301', '6223', '武威市', '3', '3298', '1');
INSERT INTO `area` VALUES ('622322', '6223', '民勤县', '3', '3299', '1');
INSERT INTO `area` VALUES ('622323', '6223', '古浪县', '3', '3300', '1');
INSERT INTO `area` VALUES ('622326', '6223', '天祝藏族自治县', '3', '3301', '1');
INSERT INTO `area` VALUES ('622421', '6224', '定西县', '3', '3302', '1');
INSERT INTO `area` VALUES ('622424', '6224', '通渭县', '3', '3303', '1');
INSERT INTO `area` VALUES ('622425', '6224', '陇西县', '3', '3304', '1');
INSERT INTO `area` VALUES ('622426', '6224', '渭源县', '3', '3305', '1');
INSERT INTO `area` VALUES ('622427', '6224', '临洮县', '3', '3306', '1');
INSERT INTO `area` VALUES ('622428', '6224', '漳  县', '3', '3307', '1');
INSERT INTO `area` VALUES ('622429', '6224', '岷  县', '3', '3308', '1');
INSERT INTO `area` VALUES ('622621', '6226', '武都县', '3', '3309', '1');
INSERT INTO `area` VALUES ('622623', '6226', '宕昌县', '3', '3310', '1');
INSERT INTO `area` VALUES ('622624', '6226', '成  县', '3', '3311', '1');
INSERT INTO `area` VALUES ('622625', '6226', '康  县', '3', '3312', '1');
INSERT INTO `area` VALUES ('622626', '6226', '文  县', '3', '3313', '1');
INSERT INTO `area` VALUES ('622627', '6226', '西和县', '3', '3314', '1');
INSERT INTO `area` VALUES ('622628', '6226', '礼  县', '3', '3315', '1');
INSERT INTO `area` VALUES ('622629', '6226', '两当县', '3', '3316', '1');
INSERT INTO `area` VALUES ('622630', '6226', '徽  县', '3', '3317', '1');
INSERT INTO `area` VALUES ('622701', '6227', '平凉市', '3', '3318', '1');
INSERT INTO `area` VALUES ('622722', '6227', '泾川县', '3', '3319', '1');
INSERT INTO `area` VALUES ('622723', '6227', '灵台县', '3', '3320', '1');
INSERT INTO `area` VALUES ('622724', '6227', '崇信县', '3', '3321', '1');
INSERT INTO `area` VALUES ('622725', '6227', '华亭县', '3', '3322', '1');
INSERT INTO `area` VALUES ('622726', '6227', '庄浪县', '3', '3323', '1');
INSERT INTO `area` VALUES ('622727', '6227', '静宁县', '3', '3324', '1');
INSERT INTO `area` VALUES ('622801', '6228', '西峰市', '3', '3325', '1');
INSERT INTO `area` VALUES ('622821', '6228', '庆阳县', '3', '3326', '1');
INSERT INTO `area` VALUES ('622822', '6228', '环  县', '3', '3327', '1');
INSERT INTO `area` VALUES ('622823', '6228', '华池县', '3', '3328', '1');
INSERT INTO `area` VALUES ('622824', '6228', '合水县', '3', '3329', '1');
INSERT INTO `area` VALUES ('622825', '6228', '正宁县', '3', '3330', '1');
INSERT INTO `area` VALUES ('622826', '6228', '宁  县', '3', '3331', '1');
INSERT INTO `area` VALUES ('622827', '6228', '镇原县', '3', '3332', '1');
INSERT INTO `area` VALUES ('622901', '6229', '临夏市', '3', '3333', '1');
INSERT INTO `area` VALUES ('622921', '6229', '临夏县', '3', '3334', '1');
INSERT INTO `area` VALUES ('622922', '6229', '康乐县', '3', '3335', '1');
INSERT INTO `area` VALUES ('622923', '6229', '永靖县', '3', '3336', '1');
INSERT INTO `area` VALUES ('622924', '6229', '广河县', '3', '3337', '1');
INSERT INTO `area` VALUES ('622925', '6229', '和政县', '3', '3338', '1');
INSERT INTO `area` VALUES ('622926', '6229', '东乡族自治县', '3', '3339', '1');
INSERT INTO `area` VALUES ('622927', '6229', '积石山保安族东乡族撒', '3', '3340', '1');
INSERT INTO `area` VALUES ('623001', '6230', '合作市', '3', '3341', '1');
INSERT INTO `area` VALUES ('623021', '6230', '临潭县', '3', '3342', '1');
INSERT INTO `area` VALUES ('623022', '6230', '卓尼县', '3', '3343', '1');
INSERT INTO `area` VALUES ('623023', '6230', '舟曲县', '3', '3344', '1');
INSERT INTO `area` VALUES ('623024', '6230', '迭部县', '3', '3345', '1');
INSERT INTO `area` VALUES ('623025', '6230', '玛曲县', '3', '3346', '1');
INSERT INTO `area` VALUES ('623026', '6230', '碌曲县', '3', '3347', '1');
INSERT INTO `area` VALUES ('623027', '6230', '夏河县', '3', '3348', '1');
INSERT INTO `area` VALUES ('630101', '6301', '市辖区', '3', '3349', '1');
INSERT INTO `area` VALUES ('630102', '6301', '城东区', '3', '3350', '1');
INSERT INTO `area` VALUES ('630103', '6301', '城中区', '3', '3351', '1');
INSERT INTO `area` VALUES ('630104', '6301', '城西区', '3', '3352', '1');
INSERT INTO `area` VALUES ('630105', '6301', '城北区', '3', '3353', '1');
INSERT INTO `area` VALUES ('630121', '6301', '大通回族土族自治县', '3', '3354', '1');
INSERT INTO `area` VALUES ('630122', '6301', '湟中县', '3', '3355', '1');
INSERT INTO `area` VALUES ('630123', '6301', '湟源县', '3', '3356', '1');
INSERT INTO `area` VALUES ('632121', '6321', '平安县', '3', '3357', '1');
INSERT INTO `area` VALUES ('632122', '6321', '民和回族土族自治县', '3', '3358', '1');
INSERT INTO `area` VALUES ('632123', '6321', '乐都县', '3', '3359', '1');
INSERT INTO `area` VALUES ('632126', '6321', '互助土族自治县', '3', '3360', '1');
INSERT INTO `area` VALUES ('632127', '6321', '化隆回族自治县', '3', '3361', '1');
INSERT INTO `area` VALUES ('632128', '6321', '循化撒拉族自治县', '3', '3362', '1');
INSERT INTO `area` VALUES ('632221', '6322', '门源回族自治县', '3', '3363', '1');
INSERT INTO `area` VALUES ('632222', '6322', '祁连县', '3', '3364', '1');
INSERT INTO `area` VALUES ('632223', '6322', '海晏县', '3', '3365', '1');
INSERT INTO `area` VALUES ('632224', '6322', '刚察县', '3', '3366', '1');
INSERT INTO `area` VALUES ('632321', '6323', '同仁县', '3', '3367', '1');
INSERT INTO `area` VALUES ('632322', '6323', '尖扎县', '3', '3368', '1');
INSERT INTO `area` VALUES ('632323', '6323', '泽库县', '3', '3369', '1');
INSERT INTO `area` VALUES ('632324', '6323', '河南蒙古族自治县', '3', '3370', '1');
INSERT INTO `area` VALUES ('632521', '6325', '共和县', '3', '3371', '1');
INSERT INTO `area` VALUES ('632522', '6325', '同德县', '3', '3372', '1');
INSERT INTO `area` VALUES ('632523', '6325', '贵德县', '3', '3373', '1');
INSERT INTO `area` VALUES ('632524', '6325', '兴海县', '3', '3374', '1');
INSERT INTO `area` VALUES ('632525', '6325', '贵南县', '3', '3375', '1');
INSERT INTO `area` VALUES ('632621', '6326', '玛沁县', '3', '3376', '1');
INSERT INTO `area` VALUES ('632622', '6326', '班玛县', '3', '3377', '1');
INSERT INTO `area` VALUES ('632623', '6326', '甘德县', '3', '3378', '1');
INSERT INTO `area` VALUES ('632624', '6326', '达日县', '3', '3379', '1');
INSERT INTO `area` VALUES ('632625', '6326', '久治县', '3', '3380', '1');
INSERT INTO `area` VALUES ('632626', '6326', '玛多县', '3', '3381', '1');
INSERT INTO `area` VALUES ('632721', '6327', '玉树县', '3', '3382', '1');
INSERT INTO `area` VALUES ('632722', '6327', '杂多县', '3', '3383', '1');
INSERT INTO `area` VALUES ('632723', '6327', '称多县', '3', '3384', '1');
INSERT INTO `area` VALUES ('632724', '6327', '治多县', '3', '3385', '1');
INSERT INTO `area` VALUES ('632725', '6327', '囊谦县', '3', '3386', '1');
INSERT INTO `area` VALUES ('632726', '6327', '曲麻莱县', '3', '3387', '1');
INSERT INTO `area` VALUES ('632801', '6328', '格尔木市', '3', '3388', '1');
INSERT INTO `area` VALUES ('632802', '6328', '德令哈市', '3', '3389', '1');
INSERT INTO `area` VALUES ('632821', '6328', '乌兰县', '3', '3390', '1');
INSERT INTO `area` VALUES ('632822', '6328', '都兰县', '3', '3391', '1');
INSERT INTO `area` VALUES ('632823', '6328', '天峻县', '3', '3392', '1');
INSERT INTO `area` VALUES ('640101', '6401', '市辖区', '3', '3393', '1');
INSERT INTO `area` VALUES ('640102', '6401', '城  区', '3', '3394', '1');
INSERT INTO `area` VALUES ('640103', '6401', '新城区', '3', '3395', '1');
INSERT INTO `area` VALUES ('640111', '6401', '郊  区', '3', '3396', '1');
INSERT INTO `area` VALUES ('640121', '6401', '永宁县', '3', '3397', '1');
INSERT INTO `area` VALUES ('640122', '6401', '贺兰县', '3', '3398', '1');
INSERT INTO `area` VALUES ('640201', '6402', '市辖区', '3', '3399', '1');
INSERT INTO `area` VALUES ('640202', '6402', '大武口区', '3', '3400', '1');
INSERT INTO `area` VALUES ('640203', '6402', '石嘴山区', '3', '3401', '1');
INSERT INTO `area` VALUES ('640204', '6402', '石炭井区', '3', '3402', '1');
INSERT INTO `area` VALUES ('640221', '6402', '平罗县', '3', '3403', '1');
INSERT INTO `area` VALUES ('640222', '6402', '陶乐县', '3', '3404', '1');
INSERT INTO `area` VALUES ('640223', '6402', '惠农县', '3', '3405', '1');
INSERT INTO `area` VALUES ('640301', '6403', '市辖区', '3', '3406', '1');
INSERT INTO `area` VALUES ('640302', '6403', '利通区', '3', '3407', '1');
INSERT INTO `area` VALUES ('640321', '6403', '中卫县', '3', '3408', '1');
INSERT INTO `area` VALUES ('640322', '6403', '中宁县', '3', '3409', '1');
INSERT INTO `area` VALUES ('640323', '6403', '盐池县', '3', '3410', '1');
INSERT INTO `area` VALUES ('640324', '6403', '同心县', '3', '3411', '1');
INSERT INTO `area` VALUES ('640381', '6403', '青铜峡市', '3', '3412', '1');
INSERT INTO `area` VALUES ('640382', '6403', '灵武市', '3', '3413', '1');
INSERT INTO `area` VALUES ('642221', '6422', '固原县', '3', '3414', '1');
INSERT INTO `area` VALUES ('642222', '6422', '海原县', '3', '3415', '1');
INSERT INTO `area` VALUES ('642223', '6422', '西吉县', '3', '3416', '1');
INSERT INTO `area` VALUES ('642224', '6422', '隆德县', '3', '3417', '1');
INSERT INTO `area` VALUES ('642225', '6422', '泾源县', '3', '3418', '1');
INSERT INTO `area` VALUES ('642226', '6422', '彭阳县', '3', '3419', '1');
INSERT INTO `area` VALUES ('650101', '6501', '市辖区', '3', '3420', '1');
INSERT INTO `area` VALUES ('650102', '6501', '天山区', '3', '3421', '1');
INSERT INTO `area` VALUES ('650103', '6501', '沙依巴克区', '3', '3422', '1');
INSERT INTO `area` VALUES ('650104', '6501', '新市区', '3', '3423', '1');
INSERT INTO `area` VALUES ('650105', '6501', '水磨沟区', '3', '3424', '1');
INSERT INTO `area` VALUES ('650106', '6501', '头屯河区', '3', '3425', '1');
INSERT INTO `area` VALUES ('650107', '6501', '南泉区', '3', '3426', '1');
INSERT INTO `area` VALUES ('650108', '6501', '东山区', '3', '3427', '1');
INSERT INTO `area` VALUES ('650121', '6501', '乌鲁木齐县', '3', '3428', '1');
INSERT INTO `area` VALUES ('650201', '6502', '市辖区', '3', '3429', '1');
INSERT INTO `area` VALUES ('650202', '6502', '独山子区', '3', '3430', '1');
INSERT INTO `area` VALUES ('650203', '6502', '克拉玛依区', '3', '3431', '1');
INSERT INTO `area` VALUES ('650204', '6502', '白碱滩区', '3', '3432', '1');
INSERT INTO `area` VALUES ('650205', '6502', '乌尔禾区', '3', '3433', '1');
INSERT INTO `area` VALUES ('652101', '6521', '吐鲁番市', '3', '3434', '1');
INSERT INTO `area` VALUES ('652122', '6521', '鄯善县', '3', '3435', '1');
INSERT INTO `area` VALUES ('652123', '6521', '托克逊县', '3', '3436', '1');
INSERT INTO `area` VALUES ('652201', '6522', '哈密市', '3', '3437', '1');
INSERT INTO `area` VALUES ('652222', '6522', '巴里坤哈萨克自治县', '3', '3438', '1');
INSERT INTO `area` VALUES ('652223', '6522', '伊吾县', '3', '3439', '1');
INSERT INTO `area` VALUES ('652301', '6523', '昌吉市', '3', '3440', '1');
INSERT INTO `area` VALUES ('652302', '6523', '阜康市', '3', '3441', '1');
INSERT INTO `area` VALUES ('652303', '6523', '米泉市', '3', '3442', '1');
INSERT INTO `area` VALUES ('652323', '6523', '呼图壁县', '3', '3443', '1');
INSERT INTO `area` VALUES ('652324', '6523', '玛纳斯县', '3', '3444', '1');
INSERT INTO `area` VALUES ('652325', '6523', '奇台县', '3', '3445', '1');
INSERT INTO `area` VALUES ('652327', '6523', '吉木萨尔县', '3', '3446', '1');
INSERT INTO `area` VALUES ('652328', '6523', '木垒哈萨克自治县', '3', '3447', '1');
INSERT INTO `area` VALUES ('652701', '6527', '博乐市', '3', '3448', '1');
INSERT INTO `area` VALUES ('652722', '6527', '精河县', '3', '3449', '1');
INSERT INTO `area` VALUES ('652723', '6527', '温泉县', '3', '3450', '1');
INSERT INTO `area` VALUES ('652801', '6528', '库尔勒市', '3', '3451', '1');
INSERT INTO `area` VALUES ('652822', '6528', '轮台县', '3', '3452', '1');
INSERT INTO `area` VALUES ('652823', '6528', '尉犁县', '3', '3453', '1');
INSERT INTO `area` VALUES ('652824', '6528', '若羌县', '3', '3454', '1');
INSERT INTO `area` VALUES ('652825', '6528', '且末县', '3', '3455', '1');
INSERT INTO `area` VALUES ('652826', '6528', '焉耆回族自治县', '3', '3456', '1');
INSERT INTO `area` VALUES ('652827', '6528', '和静县', '3', '3457', '1');
INSERT INTO `area` VALUES ('652828', '6528', '和硕县', '3', '3458', '1');
INSERT INTO `area` VALUES ('652829', '6528', '博湖县', '3', '3459', '1');
INSERT INTO `area` VALUES ('652901', '6529', '阿克苏市', '3', '3460', '1');
INSERT INTO `area` VALUES ('652922', '6529', '温宿县', '3', '3461', '1');
INSERT INTO `area` VALUES ('652923', '6529', '库车县', '3', '3462', '1');
INSERT INTO `area` VALUES ('652924', '6529', '沙雅县', '3', '3463', '1');
INSERT INTO `area` VALUES ('652925', '6529', '新和县', '3', '3464', '1');
INSERT INTO `area` VALUES ('652926', '6529', '拜城县', '3', '3465', '1');
INSERT INTO `area` VALUES ('652927', '6529', '乌什县', '3', '3466', '1');
INSERT INTO `area` VALUES ('652928', '6529', '阿瓦提县', '3', '3467', '1');
INSERT INTO `area` VALUES ('652929', '6529', '柯坪县', '3', '3468', '1');
INSERT INTO `area` VALUES ('653001', '6530', '阿图什市', '3', '3469', '1');
INSERT INTO `area` VALUES ('653022', '6530', '阿克陶县', '3', '3470', '1');
INSERT INTO `area` VALUES ('653023', '6530', '阿合奇县', '3', '3471', '1');
INSERT INTO `area` VALUES ('653024', '6530', '乌恰县', '3', '3472', '1');
INSERT INTO `area` VALUES ('653101', '6531', '喀什市', '3', '3473', '1');
INSERT INTO `area` VALUES ('653121', '6531', '疏附县', '3', '3474', '1');
INSERT INTO `area` VALUES ('653122', '6531', '疏勒县', '3', '3475', '1');
INSERT INTO `area` VALUES ('653123', '6531', '英吉沙县', '3', '3476', '1');
INSERT INTO `area` VALUES ('653124', '6531', '泽普县', '3', '3477', '1');
INSERT INTO `area` VALUES ('653125', '6531', '莎车县', '3', '3478', '1');
INSERT INTO `area` VALUES ('653126', '6531', '叶城县', '3', '3479', '1');
INSERT INTO `area` VALUES ('653127', '6531', '麦盖提县', '3', '3480', '1');
INSERT INTO `area` VALUES ('653128', '6531', '岳普湖县', '3', '3481', '1');
INSERT INTO `area` VALUES ('653129', '6531', '伽师县', '3', '3482', '1');
INSERT INTO `area` VALUES ('653130', '6531', '巴楚县', '3', '3483', '1');
INSERT INTO `area` VALUES ('653131', '6531', '塔什库尔干塔吉克自治', '3', '3484', '1');
INSERT INTO `area` VALUES ('653201', '6532', '和田市', '3', '3485', '1');
INSERT INTO `area` VALUES ('653221', '6532', '和田县', '3', '3486', '1');
INSERT INTO `area` VALUES ('653222', '6532', '墨玉县', '3', '3487', '1');
INSERT INTO `area` VALUES ('653223', '6532', '皮山县', '3', '3488', '1');
INSERT INTO `area` VALUES ('653224', '6532', '洛浦县', '3', '3489', '1');
INSERT INTO `area` VALUES ('653225', '6532', '策勒县', '3', '3490', '1');
INSERT INTO `area` VALUES ('653226', '6532', '于田县', '3', '3491', '1');
INSERT INTO `area` VALUES ('653227', '6532', '民丰县', '3', '3492', '1');
INSERT INTO `area` VALUES ('654001', '6540', '奎屯市', '3', '3493', '1');
INSERT INTO `area` VALUES ('654101', '6541', '伊宁市', '3', '3494', '1');
INSERT INTO `area` VALUES ('654121', '6541', '伊宁县', '3', '3495', '1');
INSERT INTO `area` VALUES ('654122', '6541', '察布查尔锡伯自治县', '3', '3496', '1');
INSERT INTO `area` VALUES ('654123', '6541', '霍城县', '3', '3497', '1');
INSERT INTO `area` VALUES ('654124', '6541', '巩留县', '3', '3498', '1');
INSERT INTO `area` VALUES ('654125', '6541', '新源县', '3', '3499', '1');
INSERT INTO `area` VALUES ('654126', '6541', '昭苏县', '3', '3500', '1');
INSERT INTO `area` VALUES ('654127', '6541', '特克斯县', '3', '3501', '1');
INSERT INTO `area` VALUES ('654128', '6541', '尼勒克县', '3', '3502', '1');
INSERT INTO `area` VALUES ('654201', '6542', '塔城市', '3', '3503', '1');
INSERT INTO `area` VALUES ('654202', '6542', '乌苏市', '3', '3504', '1');
INSERT INTO `area` VALUES ('654221', '6542', '额敏县', '3', '3505', '1');
INSERT INTO `area` VALUES ('654223', '6542', '沙湾县', '3', '3506', '1');
INSERT INTO `area` VALUES ('654224', '6542', '托里县', '3', '3507', '1');
INSERT INTO `area` VALUES ('654225', '6542', '裕民县', '3', '3508', '1');
INSERT INTO `area` VALUES ('654226', '6542', '和布克赛尔蒙古自治县', '3', '3509', '1');
INSERT INTO `area` VALUES ('654301', '6543', '阿勒泰市', '3', '3510', '1');
INSERT INTO `area` VALUES ('654321', '6543', '布尔津县', '3', '3511', '1');
INSERT INTO `area` VALUES ('654322', '6543', '富蕴县', '3', '3512', '1');
INSERT INTO `area` VALUES ('654323', '6543', '福海县', '3', '3513', '1');
INSERT INTO `area` VALUES ('654324', '6543', '哈巴河县', '3', '3514', '1');
INSERT INTO `area` VALUES ('654325', '6543', '青河县', '3', '3515', '1');
INSERT INTO `area` VALUES ('654326', '6543', '吉木乃县', '3', '3516', '1');
INSERT INTO `area` VALUES ('659001', '6590', '石河子市', '3', '3517', '1');
INSERT INTO `area` VALUES ('710101', '7101', '请选择', '3', '3518', '1');
INSERT INTO `area` VALUES ('710102', '7101', '市辖区', '3', '3519', '1');
INSERT INTO `area` VALUES ('710103', '7101', '台湾省', '3', '3520', '1');
INSERT INTO `area` VALUES ('810101', '8101', '请选择', '3', '3521', '1');
INSERT INTO `area` VALUES ('810102', '8101', '市辖区', '3', '3522', '1');
INSERT INTO `area` VALUES ('810103', '8101', '香港特区', '3', '3523', '1');
INSERT INTO `area` VALUES ('910101', '9101', '请选择', '3', '3524', '1');
INSERT INTO `area` VALUES ('910102', '9101', '市辖区', '3', '3525', '1');
INSERT INTO `area` VALUES ('910103', '9101', '澳门特区', '3', '3526', '1');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` varchar(32) NOT NULL COMMENT '客户ID(业务)',
  `index_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户id(展示)',
  `company_name` varchar(64) NOT NULL COMMENT '客户名称',
  `company_addr` varchar(128) DEFAULT NULL COMMENT '客户地址',
  `legal_representative` varchar(64) DEFAULT NULL COMMENT '法定代表人',
  `registered_capital` varchar(64) DEFAULT NULL COMMENT '注册资本',
  `business_term_begin` varchar(16) DEFAULT NULL COMMENT '营业期限开始',
  `business_term_end` varchar(16) DEFAULT NULL COMMENT '营业期限结束',
  `credit_code` varchar(32) DEFAULT NULL COMMENT '统一社会信用代码',
  `business_user` varchar(16) DEFAULT NULL COMMENT '商务联系人',
  `business_user_tel` varchar(16) DEFAULT NULL COMMENT '商务联系人电话',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `create_user_id` varchar(32) NOT NULL,
  `create_time` datetime NOT NULL,
  `submitter_id` varchar(32) DEFAULT NULL,
  `verify_user_id` varchar(32) DEFAULT NULL COMMENT '审核人ID',
  `verify_time` datetime DEFAULT NULL COMMENT '审核时间',
  `create_org_id` varchar(32) DEFAULT NULL COMMENT '创建人员所属机构',
  `follow_user_id` varchar(32) DEFAULT NULL COMMENT '归属业务员id',
  `follow_org_id` varchar(32) DEFAULT NULL COMMENT '业务员归属机构',
  `register_place` varchar(128) DEFAULT NULL COMMENT '注册地',
  `industry_para_id` varchar(32) DEFAULT NULL COMMENT '所属行业id',
  PRIMARY KEY (`index_id`,`customer_id`),
  UNIQUE KEY `customer_pk` (`customer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COMMENT='客户表';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('22742c57342311e98a11e0d55edb21ed', '4', '圣罗兰(上海)贸易有限公司', '上海市静安区延安中路1228号2603-2604单元', 'MARCOGIULIOVIGANO', '100000000000', '', '', '913100005588016830', '', '', '3', '1', '2020-06-10 10:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('2ccef77f1dec11e99d5300163e13e3ca', '6', '重庆中国青年旅行社有限公司', '重庆市渝中区中山二路134号', '任强', '500万', '1999-08-09', '', '9150010320280631XL', '', '', '3', '1', '2020-06-14 11:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('5c82a4db246911e98de8e0d55edb21ed', '7', '阿迪达斯体育(中国)有限公司', ' 苏州工业园区现代大道88号普洛斯物流园区C21号', 'ARTHURANTONHOELD', '10000万元人民币', '', '', '91320594660088829J', '', '', '3', '1', '2020-06-15 13:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('5cb59868368211e98a11e0d55edb21ed', '8', '龙湖地产', '龙湖水晶郦城', '陈法蓉', '', '', '', '21342323232323', '', '', '3', '1', '2020-06-17 17:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('6bd50360367911e98a11e0d55edb21ed', '9', '贵阳南明老干妈风味食品有限责任公司', '贵州', '老干妈', '5个亿', '1996-12-02', '2024-02-14', '123456789', '', '', '3', '1', '2020-06-17 19:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('946ca28d22a711e98de8e0d55edb21ed', '12', 'AA广告代理公司', '重庆市九龙坡区石桥铺', 'AAA', '1000万', '2019-01-01', '2025-01-01', '90101001001010101X', '', '', '3', '1', '2020-06-18 15:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('965e4a6822a611e98de8e0d55edb21ed', '13', '耐克体育(中国)有限公司', ' 江苏省太仓经济开发区广州西路88号', '董炜', '48530.75万元人民币', '2005-09-02', '2035-09-02', '9132058571785883XA', '', '', '3', '1', '2020-06-19 11:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('9e8b6229341811e98a11e0d55edb21ed', '14', '李宁体育(上海)有限公司', '中国(上海)自由贸易试验区陆家嘴东路161号3201室', '李宁', '800000000', '', '', '913100006308735783', '', '', '3', '1', '2020-06-19 17:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('d5674d9a22a711e98de8e0d55edb21ed', '18', 'BBB广告渠道公司', '重庆市渝北区', 'BBB', '2000万', '2019-01-01', '2025-01-01', '9303039030303003X', '', '', '3', '1', '2020-06-22 14:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('d718958f22a411e98de8e0d55edb21ed', '19', '华为技术有限公司', ' 深圳市龙岗区坂田华为总部办公楼', '赵明路', '3990813.182万元人民币', '1987-09-15', '2040-04-09', '914403001922038216', '', '', '3', '1', '2020-06-22 16:16:35', '1', '1', '2020-06-22 17:16:35', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', null, 'f0835b3f357511e98a11e0d55edb21ed');
INSERT INTO `customer` VALUES ('e4a351691df311e98de8e0d55edb21ed', '20', '重庆苏宁易购销售有限公司', '重庆市渝中区八一路177号雨田商务大厦', '徐耀华', '57351.237万', '2007-12-10', '', '915001036689375495', '', '', '2', '1', '2020-06-22 19:16:35', '1', '1', '2020-06-29 21:44:34', '1', '859161d895ea11ea9e2a28d244a5fdf0', '2', '', 'f0835b3f357511e98a11e0d55edb21ed');

-- ----------------------------
-- Table structure for dep
-- ----------------------------
DROP TABLE IF EXISTS `dep`;
CREATE TABLE `dep` (
  `dep_id` varchar(32) NOT NULL,
  `org_id` varchar(32) DEFAULT NULL,
  `dep_code` varchar(16) DEFAULT NULL,
  `dep_name` varchar(32) NOT NULL,
  `dep_desc` varchar(1024) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `sort_no` int(11) DEFAULT NULL,
  `dep_status` char(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_user_id` varchar(32) NOT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`dep_id`),
  UNIQUE KEY `dep_pk` (`dep_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='����';

-- ----------------------------
-- Records of dep
-- ----------------------------
INSERT INTO `dep` VALUES ('1', '1', 'CQJKLZ-JTB', '集团办', '金卡联智-集团办', '0', '1', 'C', '2019-01-18 14:42:11', '1', '1');
INSERT INTO `dep` VALUES ('10', '1', 'CQJKLZ-XZRSB', '行政人事部', '金卡联智-行政人事部', '2', '7', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('11', '1', 'CQJKLZ-CHSJB', '策划设计部', '金卡联智-策划设计部', '2', '8', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('13', '1', 'CQJKLZ-MJCGB', '媒介采购部', '金卡联智-专门负责广告媒介的采购部门', '5', '1', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('14', '1', 'CQJKLZ-GGYYB', '广告运营部', '金卡联智-专门负责广告运营的部门', '5', '2', 'C', '2019-01-18 14:42:11', '1', '3');
INSERT INTO `dep` VALUES ('2', '1', 'CQJKLZ-ZJB', '总经办', '金卡联智-总经办', '0', '2', 'C', '2019-01-18 14:42:11', '1', '1');
INSERT INTO `dep` VALUES ('272da6e6213f11ea9b06e0d55edb21ed', '5230d617213b11ea9b06e0d55edb21ed', 'ccdd', '部门2', '部门描述部门描述部门描述巴拉巴拉巴拉', 'c0fcfa57213e11ea9b06e0d55edb21ed', '1', 'C', '2019-12-18 10:36:32', '10', '2');
INSERT INTO `dep` VALUES ('3d965c29167811eabc92e0d55edb21ed', '6b980b81165a11eabc92e0d55edb21ed', 'test_0003', '测试部门3', '测试数据', 'd6c44bf5167711eabc92e0d55edb21ed', '1', 'C', '2019-12-04 17:28:35', '10', '2');
INSERT INTO `dep` VALUES ('4', '1', 'CQJKLZ-CPJSB', '产品技术部', '金卡联智-负责公司的广告平台建设和技术支撑的部门', '2', '1', 'C', '2019-01-18 14:42:11', '1', '1');
INSERT INTO `dep` VALUES ('5', '1', 'CQJKLZ-MJB', '媒介运营部', '金卡联智-媒体广告运营部门', '2', '2', 'C', '2019-01-18 14:42:11', '1', '1');
INSERT INTO `dep` VALUES ('54715d22167f11eabc92e0d55edb21ed', '6b980b81165a11eabc92e0d55edb21ed', 'test_0004', '测试部门2', '测试数据', 'd244b78c167911eabc92e0d55edb21ed', '1', 'R', '2019-12-04 18:19:20', '10', '3');
INSERT INTO `dep` VALUES ('6', '1', 'CQJKLZ-QDTZB', '渠道拓展部', '金卡联智-专门负责数字户外媒体的建设和广告点位拓展的部门', '2', '3', 'C', '2019-01-18 14:42:11', '1', '1');
INSERT INTO `dep` VALUES ('7', '1', 'CQJKLZ-XSB', '销售部', '金卡联智-销售部', '2', '4', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('7f6ecf64213d11ea9b06e0d55edb21ed', '5230d617213b11ea9b06e0d55edb21ed', '123456789vvv', '部门名称', '', '0', null, 'D', '2019-12-18 10:24:41', '10', '1');
INSERT INTO `dep` VALUES ('8', '1', 'CQJKLZ-KFB', '客服部', '金卡联智-客服部', '2', '5', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('88c44818167711eabc92e0d55edb21ed', '6b980b81165a11eabc92e0d55edb21ed', 'test_0001', '测试部门', '这是一条测试数据', '0', '1', 'D', '2019-12-04 17:23:32', '10', '1');
INSERT INTO `dep` VALUES ('9', '1', 'CQJKLZ-CWB', '财务部', '金卡联智-财务部', '2', '6', 'C', '2019-01-18 14:42:11', '1', '2');
INSERT INTO `dep` VALUES ('c0fcfa57213e11ea9b06e0d55edb21ed', '5230d617213b11ea9b06e0d55edb21ed', '部门编码123', '部门1', '', '0', null, 'D', '2019-12-18 10:33:41', '10', '1');
INSERT INTO `dep` VALUES ('d244b78c167911eabc92e0d55edb21ed', '6b980b81165a11eabc92e0d55edb21ed', 'test_00011', '测试部门1', '测试数据', '88c44818167711eabc92e0d55edb21ed', '1', 'R', '2019-12-04 17:39:54', '10', '2');
INSERT INTO `dep` VALUES ('d6c44bf5167711eabc92e0d55edb21ed', '6b980b81165a11eabc92e0d55edb21ed', 'test_0002', '测试部门2', '这是一条测试数据', '0', '1', 'D', '2019-12-04 17:25:43', '10', '1');
INSERT INTO `dep` VALUES ('d94d0180213c11ea9b06e0d55edb21ed', '5230d617213b11ea9b06e0d55edb21ed', '部门编码12345678', '部门名称', '', '0', '2', 'D', '2019-12-18 10:20:03', '10', '1');
INSERT INTO `dep` VALUES ('f402689c213c11ea9b06e0d55edb21ed', '5230d617213b11ea9b06e0d55edb21ed', '123456789', '部门名称', '', '0', null, 'D', '2019-12-18 10:20:47', '10', '1');

-- ----------------------------
-- Table structure for flow_design
-- ----------------------------
DROP TABLE IF EXISTS `flow_design`;
CREATE TABLE `flow_design` (
  `flow_id` varchar(32) NOT NULL COMMENT '流程id',
  `flow_code` varchar(255) DEFAULT NULL,
  `flow_name` varchar(96) NOT NULL COMMENT '流程名称',
  `flow_type` char(1) NOT NULL COMMENT '流程归属类型(1素材2订单3刊播4换刊5客户6品牌)',
  `flow_attribute` char(1) NOT NULL DEFAULT '0' COMMENT '流程属性 0普通流程 1复合流程',
  `flow_data` json DEFAULT NULL COMMENT '流程具体内容',
  `flow_remarks` varchar(255) DEFAULT NULL COMMENT '流程说明',
  `follow_org_id` varchar(32) DEFAULT NULL COMMENT '归属机构id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user_id` varchar(32) NOT NULL COMMENT '创建人id',
  `status` char(1) NOT NULL DEFAULT 'C' COMMENT '流程状态（C正常R停用D删除）',
  `is_used` char(1) DEFAULT '0' COMMENT '使用状态（0未使用2已使用）',
  PRIMARY KEY (`flow_id`),
  UNIQUE KEY `flow_id` (`flow_id`) USING BTREE,
  KEY `sy_o_t_a_s` (`follow_org_id`,`flow_type`,`flow_attribute`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flow_design
-- ----------------------------
INSERT INTO `flow_design` VALUES ('0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '1', '0', '{\"areas\": {}, \"lines\": {\"1571363031721\": {\"to\": \"1571363013720\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}, \"1571643128104\": {\"to\": \"1571363025160\", \"from\": \"1571363013720\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 35, \"left\": 496, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1571363013720\": {\"alt\": true, \"top\": 153, \"left\": 439, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed,f1699be0e0f311e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧),英英(金卡智慧)\"}, \"1571363025160\": {\"alt\": true, \"top\": 457, \"left\": 480, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 5}', '素材审核', '2', '2019-09-27 13:58:08', '2a03890ce0cf11e99358e0d55edb21ed', 'R', '0');
INSERT INTO `flow_design` VALUES ('163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台机构素材审核流程', '1', '0', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台管理员(平台)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"平台\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '1', '2019-08-26 15:15:01', '1', 'C', '0');
INSERT INTO `flow_design` VALUES ('1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '客户审核流程06', '5', '0', '{\"areas\": {}, \"lines\": {\"1569463478787\": {\"to\": \"1569463470054\", \"from\": \"1569463468247\", \"name\": \"\", \"type\": \"sl\"}, \"1569463480390\": {\"to\": \"1569463471598\", \"from\": \"1569463470054\", \"name\": \"\", \"type\": \"sl\"}, \"1569468763086\": {\"to\": \"1569463475286\", \"from\": \"1569463471598\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569463468247\": {\"alt\": true, \"top\": 83, \"left\": 563, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569463470054\": {\"alt\": true, \"top\": 177, \"left\": 507, \"name\": \"经理审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然()\"}, \"1569463471598\": {\"alt\": true, \"top\": 255, \"left\": 516, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监()\"}, \"1569463475286\": {\"alt\": true, \"top\": 427, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"客户审核流程06\", \"initNum\": 4}', '客户审核流程', '2', '2019-09-26 09:34:47', '33341ee4760d11e9ba07e0d55edb21ed', 'C', '0');
INSERT INTO `flow_design` VALUES ('30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '1', '0', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕()\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监()\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2', '2019-09-25 17:14:37', '33341ee4760d11e9ba07e0d55edb21ed', 'R', '0');
INSERT INTO `flow_design` VALUES ('48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', '1', '0', '{\"areas\": {}, \"lines\": {\"1576047054442\": {\"to\": \"1576047041362\", \"from\": \"1576046990996\", \"name\": \"\", \"type\": \"sl\"}, \"1576047057170\": {\"to\": \"1576047052266\", \"from\": \"1576047041362\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046990996\": {\"alt\": true, \"top\": 113, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047041362\": {\"alt\": true, \"top\": 214, \"left\": 448, \"name\": \"任务节点_17\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线)\"}, \"1576047052266\": {\"alt\": true, \"top\": 336, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yiuot\", \"initNum\": 19}', 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2', '2019-12-11 14:49:43', '10', 'R', '0');
INSERT INTO `flow_design` VALUES ('720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', '1', '0', '{\"areas\": {}, \"lines\": {\"1569402571769\": {\"to\": \"1569402561857\", \"from\": \"1569402559026\", \"name\": \"\", \"type\": \"sl\"}, \"1569402576032\": {\"to\": \"1569402564714\", \"from\": \"1569402561857\", \"name\": \"\", \"type\": \"sl\"}, \"1569402578808\": {\"to\": \"1569402568002\", \"from\": \"1569402564714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402559026\": {\"alt\": true, \"top\": 33, \"left\": 541, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402561857\": {\"alt\": true, \"top\": 123, \"left\": 526, \"name\": \"技术部总监角色\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监()\"}, \"1569402564714\": {\"alt\": true, \"top\": 198, \"left\": 525, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕()\"}, \"1569402568002\": {\"alt\": true, \"top\": 299, \"left\": 569, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '素材审核审核审核', '2', '2019-09-25 17:09:16', '33341ee4760d11e9ba07e0d55edb21ed', 'R', '0');
INSERT INTO `flow_design` VALUES ('74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', '1', '0', '{\"areas\": {}, \"lines\": {\"1569398285919\": {\"to\": \"1569398273785\", \"from\": \"1569398268355\", \"name\": \"\", \"type\": \"sl\"}, \"1569398298318\": {\"to\": \"1569398278328\", \"from\": \"1569398273785\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569398268355\": {\"alt\": true, \"top\": 96, \"left\": 519, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569398273785\": {\"alt\": true, \"top\": 189, \"left\": 505, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"6,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"汪新程(),陈伯燕()\"}, \"1569398278328\": {\"alt\": true, \"top\": 283, \"left\": 535, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '素材审核', '2', '2019-09-25 15:57:44', '33341ee4760d11e9ba07e0d55edb21ed', 'R', '0');
INSERT INTO `flow_design` VALUES ('858f39e056f111ea90cc00163e13e3ca', 'test_100002', '测试普通流程', '5', '0', '{\"areas\": {}, \"lines\": {\"1582540610147\": {\"to\": \"1582540605533\", \"from\": \"1582540604036\", \"name\": \"\", \"type\": \"sl\"}, \"1582540614346\": {\"to\": \"1582540606693\", \"from\": \"1582540605533\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582540604036\": {\"alt\": true, \"top\": 126, \"left\": 202, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582540605533\": {\"alt\": true, \"top\": 194, \"left\": 524, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1582540606693\": {\"alt\": true, \"top\": 359, \"left\": 311, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}}, \"title\": \"测试普通流程\", \"initNum\": 3}', '这是一条测试普通流程的数据', '2', '2020-02-24 18:36:31', '10', 'R', '0');
INSERT INTO `flow_design` VALUES ('a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', '5', '0', '{\"areas\": {}, \"lines\": {\"1568602431710\": {\"to\": \"1568602420702\", \"from\": \"1568602415511\", \"name\": \"\", \"type\": \"sl\"}, \"1568602433741\": {\"to\": \"1568602421726\", \"from\": \"1568602420702\", \"name\": \"\", \"type\": \"sl\"}, \"1568602864606\": {\"to\": \"1568602861542\", \"from\": \"1568602421726\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602415511\": {\"alt\": true, \"top\": 29, \"left\": 308, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602420702\": {\"alt\": true, \"top\": 156, \"left\": 270, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,a5133a9818a011e99d5300163e13e3ca,10\", \"verifyModelNames\": \"系统超管(平台视线),李数里(平台视线),平台管理员(平台)\"}, \"1568602421726\": {\"alt\": true, \"top\": 276, \"left\": 272, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,d7e79858c7d211e99358e0d55edb21ed,10\", \"verifyModelNames\": \"系统超管(平台视线),平台总经办测试账号(平台视线),平台管理员(平台)\"}, \"1568602861542\": {\"alt\": true, \"top\": 412, \"left\": 305, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台客户测试流程\", \"initNum\": 12}', '测试', '1', '2019-09-16 10:53:30', '1', 'C', '0');
INSERT INTO `flow_design` VALUES ('c810e3d8651a11ea90cc00163e13e3ca', '流程编号：123', '流程名称：123', '1', '0', '{\"areas\": {}, \"lines\": {\"1584097640126\": {\"to\": \"1584097634781\", \"alt\": true, \"from\": \"1584097633125\", \"name\": \"\", \"type\": \"sl\"}, \"1584097641406\": {\"to\": \"1584097636277\", \"alt\": true, \"from\": \"1584097634781\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584097633125\": {\"alt\": true, \"top\": 85, \"left\": 481, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584097634781\": {\"alt\": true, \"top\": 214, \"left\": 432, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584097636277\": {\"alt\": true, \"top\": 351, \"left\": 547, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称：123\", \"initNum\": 2}', '流程说明：123', '1', '2020-03-13 19:07:08', '10', 'R', '0');
INSERT INTO `flow_design` VALUES ('eb04436d651c11ea90cc00163e13e3ca', '123', 'yy', '5', '0', null, 'grdfg', '2', '2020-03-13 19:22:26', '10', 'R', '0');
INSERT INTO `flow_design` VALUES ('ef8b9201892111ea8b60e0d55edb21ed', '111', '11', '1', '0', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"11\", \"initNum\": 1}', '111', '1', '2020-04-28 15:29:29', '10', 'R', '0');
INSERT INTO `flow_design` VALUES ('f1f92c0fdf7311e99358e0d55edb21ed', 'scsh_yyy', '素材审核流程', '1', '0', '{\"areas\": {}, \"lines\": {\"1569402782263\": {\"to\": \"1569402775344\", \"from\": \"1569402773552\", \"name\": \"\", \"type\": \"sl\"}, \"1569402784558\": {\"to\": \"1569402777151\", \"from\": \"1569402775344\", \"name\": \"\", \"type\": \"sl\"}, \"1569402786015\": {\"to\": \"1569402779544\", \"from\": \"1569402777151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402773552\": {\"alt\": true, \"top\": 88, \"left\": 416, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402775344\": {\"alt\": true, \"top\": 161, \"left\": 388, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监()\"}, \"1569402777151\": {\"alt\": true, \"top\": 240, \"left\": 402, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕()\"}, \"1569402779544\": {\"alt\": true, \"top\": 345, \"left\": 439, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '素材审核流程djklsj', '2', '2019-09-25 17:12:51', '33341ee4760d11e9ba07e0d55edb21ed', 'C', '0');

-- ----------------------------
-- Table structure for flow_design_temp
-- ----------------------------
DROP TABLE IF EXISTS `flow_design_temp`;
CREATE TABLE `flow_design_temp` (
  `flow_temp_id` varchar(32) NOT NULL COMMENT '流程副本表',
  `flow_id` varchar(32) NOT NULL COMMENT '流程id',
  `flow_code` varchar(255) DEFAULT NULL,
  `flow_name` varchar(96) NOT NULL COMMENT '流程名称',
  `flow_data` json DEFAULT NULL COMMENT '流程具体内容',
  `flow_remarks` varchar(255) DEFAULT NULL COMMENT '流程说明',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user_id` varchar(32) NOT NULL COMMENT '创建人id',
  `is_used` char(1) DEFAULT '0' COMMENT '使用状态（0未使用2已使用）',
  `edit_log` text COMMENT '副本更新日志信息',
  `version` int(6) NOT NULL,
  PRIMARY KEY (`flow_temp_id`),
  UNIQUE KEY `flow_temp_id` (`flow_temp_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flow_design_temp
-- ----------------------------
INSERT INTO `flow_design_temp` VALUES ('00007fe9e00211e99358e0d55edb21ed', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '测试机构客户审核流程', '{\"areas\": {}, \"lines\": {\"1569463478787\": {\"to\": \"1569463470054\", \"from\": \"1569463468247\", \"name\": \"\", \"type\": \"sl\"}, \"1569463480390\": {\"to\": \"1569463471598\", \"from\": \"1569463470054\", \"name\": \"\", \"type\": \"sl\"}, \"1569463482142\": {\"to\": \"1569463472855\", \"from\": \"1569463471598\", \"name\": \"\", \"type\": \"sl\"}, \"1569463484671\": {\"to\": \"1569463475286\", \"from\": \"1569463472855\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569463468247\": {\"alt\": true, \"top\": 83, \"left\": 563, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569463470054\": {\"alt\": true, \"top\": 177, \"left\": 507, \"name\": \"经理审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569463471598\": {\"alt\": true, \"top\": 255, \"left\": 516, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569463472855\": {\"alt\": true, \"top\": 330, \"left\": 509, \"name\": \"董事会审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1569463475286\": {\"alt\": true, \"top\": 427, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试机构客户审核流程\", \"initNum\": 4}', '金卡联智客户审核流程', '2019-09-26 10:09:48', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('020d7afcdf4711e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383230798\": {\"to\": \"1569383166151\", \"from\": \"1569383159079\", \"name\": \"\", \"type\": \"sl\"}, \"1569383240134\": {\"to\": \"1569383159079\", \"from\": \"1569383105855\", \"name\": \"\", \"type\": \"sl\"}, \"1569383256194\": {\"to\": \"1569383173575\", \"from\": \"1569383166151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383105855\": {\"alt\": true, \"top\": 98, \"left\": 611, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383159079\": {\"alt\": true, \"top\": 205, \"left\": 588, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2,3,4,5,e30236b501a211e98a32e0d55edb21ed,6,3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,71bcd53e40b611e986f0e0d55edb21ed,7735b100673611e99ec7e0d55edb21ed,9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"廖伟(测试机构),浦童侣(测试机构),包超(测试机构),周琳果(测试机构),傅炳彬(测试机构),汪新程(测试机构),王然(测试机构),王先连(测试机构),test12345(测试机构),黄浩然(测试机构),刘莉莎(平台视线),李数里(平台视线)\"}, \"1569383166151\": {\"alt\": true, \"top\": 305, \"left\": 603, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"d74b72f7d33d11e8a31ae0d55edb21ed,39f0da4701a111e98a32e0d55edb21ed,2,5,6,7,31525394673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"拓展部总监(测试机构),媒介部总监(测试机构),总经办人员(测试机构),技术部总监(测试机构),销售部-商业-总监(测试机构),销售部-地产-总监(测试机构),媒介专员(测试机构)\"}, \"1569383173575\": {\"alt\": true, \"top\": 427, \"left\": 580, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 3}', '流程说明yy', '2019-09-25 11:51:09', '1', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('02dff946797811eabd98e0d55edb21ed', 'e68b5a26797711eabd98e0d55edb21ed', '1704', 'rxb-定制', '{\"areas\": {}, \"lines\": {\"1586336684107\": {\"to\": \"1586336668083\", \"from\": \"1586336666643\", \"name\": \"\", \"type\": \"sl\"}, \"1586336685267\": {\"to\": \"1586336669523\", \"from\": \"1586336668083\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586336666643\": {\"alt\": true, \"top\": 178, \"left\": 566, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586336668083\": {\"alt\": true, \"top\": 248, \"left\": 550, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"4975806e796311eaba96e0d55edb21ed,bb0fcf7a796711eaba96e0d55edb21ed\", \"verifyModelNames\": \"张子凡(lcd媒体商),钉钉(lcd媒体商)\"}, \"1586336669523\": {\"alt\": true, \"top\": 367, \"left\": 579, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"rxb-定制\", \"initNum\": 2}', '没开门', '2020-04-08 17:05:01', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('03ce628a797211eabd98e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', '{\"areas\": {}, \"lines\": {\"1586331866076\": {\"to\": \"1586331861860\", \"from\": \"1586331860013\", \"name\": \"\", \"type\": \"sl\"}, \"1586331867140\": {\"to\": \"1586331863772\", \"from\": \"1586331861860\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586331860013\": {\"alt\": true, \"top\": 132, \"left\": 596, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586331861860\": {\"alt\": true, \"top\": 213, \"left\": 571, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"426141796a5f11ea8f54e0d55edb21ed\", \"verifyModelNames\": \"lcd媒体商\"}, \"1586331863772\": {\"alt\": true, \"top\": 298, \"left\": 601, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"换刊审核流程\", \"initNum\": 2}', '流程说明yy', '2020-04-08 16:22:06', '4975806e796311eaba96e0d55edb21ed', null, '更新流程: 更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('03f3f6f0df4411e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1567410047241\": {\"to\": \"1567410040073\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410040073\": {\"alt\": true, \"top\": 363, \"left\": 355, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 9}', 'hsdf', '2019-09-25 11:29:44', '1', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('0497d79e56f011ea90cc00163e13e3ca', '589dba4756ee11ea90cc00163e13e3ca', 'test_100001', '测试通用流程', '{\"areas\": {}, \"lines\": {\"1582539546754\": {\"to\": \"1582539534056\", \"from\": \"1582539410084\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582539410084\": {\"alt\": true, \"top\": 107, \"left\": 251, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582539534056\": {\"alt\": true, \"top\": 121, \"left\": 319, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试通用流程\", \"initNum\": 1}', '这是测试通用流程', '2020-02-24 18:25:45', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('053da00adaa611e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 75, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3,1\", \"verifyModelNames\": \"总经办人员(平台视线),系统管理员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '顶级机构素材审核流程', '2019-09-19 14:27:49', '1', null, '更新流程:更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('07dc0a28c7d411e99358e0d55edb21ed', '07d9ca0dc7d411e99358e0d55edb21ed', 'hylink-order-test', '平台订单测试流程', null, '订单流程测试', '2019-08-26 15:36:05', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('08c2d4d5650011ea90cc00163e13e3ca', '08bdbade650011ea90cc00163e13e3ca', '流程编号：123', '流程名称：123', null, '流程说明：123', '2020-03-13 15:55:40', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('0bd51de11be311ea80e1e0d55edb21ed', '0bce9b771be311ea80e1e0d55edb21ed', 'tet', 'cby', null, 'teter', '2019-12-11 14:55:11', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('0ce1f31fe0eb11e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', null, '金卡智慧素材审核', '2019-09-27 13:58:08', '2a03890ce0cf11e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('0d4c2a981be211ea80e1e0d55edb21ed', 'ce3cd5a41be111ea80e1e0d55edb21ed', 't1252163fd', 't11', '{\"areas\": {}, \"lines\": {\"1576046812516\": {\"to\": \"1576046806139\", \"from\": \"1576046788292\", \"name\": \"\", \"type\": \"sl\"}, \"1576046814900\": {\"to\": \"1576046807932\", \"from\": \"1576046806139\", \"name\": \"\", \"type\": \"sl\"}, \"1576046816235\": {\"to\": \"1576046810036\", \"from\": \"1576046807932\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046788292\": {\"alt\": true, \"top\": 84, \"left\": 377, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576046806139\": {\"alt\": true, \"top\": 182, \"left\": 389, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b848964e18a011e99d5300163e13e3ca,6082710b46c911e986f0e0d55edb21ed\", \"verifyModelNames\": \"夏超(平台视线),testxie(平台视线)\"}, \"1576046807932\": {\"alt\": true, \"top\": 284, \"left\": 385, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576046810036\": {\"alt\": true, \"top\": 414, \"left\": 382, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"t11\", \"initNum\": 3}', '3342vdgvd过度大范甘迪过度的的过度', '2019-12-11 14:48:04', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('0fbb14dadaaa11e99358e0d55edb21ed', '0fb86399daaa11e99358e0d55edb21ed', '111', '111', null, '1111', '2019-09-19 14:56:45', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('10840fca643d11ea90cc00163e13e3ca', '10830906643d11ea90cc00163e13e3ca', 'e45454', 'ffffffffffffffffff1111111111111111111111111111111111ffffffffffffffffffffff', null, 'vgdfg', '2020-03-12 16:40:02', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('10d96088651d11ea90cc00163e13e3ca', '10d63071651d11ea90cc00163e13e3ca', '123', 'yy', null, 'ff', '2020-03-13 19:23:29', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('10ef6566f17511e99358e0d55edb21ed', 'f7dec02ff17411e99358e0d55edb21ed', '54654', '4545', '{\"areas\": {}, \"lines\": {\"1571382534036\": {\"to\": \"1571382529445\", \"from\": \"1571382525588\", \"name\": \"\", \"type\": \"sl\"}, \"1571382542676\": {\"to\": \"1571382540046\", \"from\": \"1571382529445\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1571382525588\": {\"alt\": true, \"top\": 101, \"left\": 352, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1571382529445\": {\"alt\": true, \"top\": 250, \"left\": 315, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1571382540046\": {\"alt\": true, \"top\": 395, \"left\": 368, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"4545\", \"initNum\": 4}', '654656', '2019-10-18 15:09:25', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1211ecb3df7411e99358e0d55edb21ed', 'f1f92c0fdf7311e99358e0d55edb21ed', 'scsh_yyy', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402782263\": {\"to\": \"1569402775344\", \"from\": \"1569402773552\", \"name\": \"\", \"type\": \"sl\"}, \"1569402784558\": {\"to\": \"1569402777151\", \"from\": \"1569402775344\", \"name\": \"\", \"type\": \"sl\"}, \"1569402786015\": {\"to\": \"1569402779544\", \"from\": \"1569402777151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402773552\": {\"alt\": true, \"top\": 88, \"left\": 416, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402775344\": {\"alt\": true, \"top\": 161, \"left\": 388, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402777151\": {\"alt\": true, \"top\": 240, \"left\": 402, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402779544\": {\"alt\": true, \"top\": 345, \"left\": 439, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '素材审核流程djklsj', '2019-09-25 17:13:45', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1436210f68c311eaa6d3e0d55edb21ed', '1432f22468c311eaa6d3e0d55edb21ed', '545', 'b刊播', null, '4646', '2020-03-18 10:49:29', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('14872f76650011ea90cc00163e13e3ca', '08bdbade650011ea90cc00163e13e3ca', '流程编号：123', '流程名称：123', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"流程名称：123\", \"initNum\": 1}', '流程说明：123', '2020-03-13 15:55:59', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('14d674d1643c11ea90cc00163e13e3ca', '14d420da643c11ea90cc00163e13e3ca', 'uu123456', '平台通用流程', null, '流程说明巴拉巴拉打开大健康暗示健康的就卡萨42335', '2020-03-12 16:33:00', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('163c2f60c7d111e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材测试流程', null, '顶级机构素材审核流程', '2019-08-26 15:15:01', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('165573b2e0fb11e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569570734429\": {\"to\": \"1569570708079\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1569570736333\": {\"to\": \"1569570730173\", \"from\": \"1569570708079\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570708079\": {\"alt\": true, \"top\": 187, \"left\": 539, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧),小艳(金卡智慧)\"}, \"1569570730173\": {\"alt\": true, \"top\": 265, \"left\": 588, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 2}', '金卡智慧品牌审核', '2019-09-27 15:52:56', 'f1699be0e0f311e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('17990e21796b11eaba96e0d55edb21ed', 'b2509777796811eaba96e0d55edb21ed', 'test-0408-1515', '订单审核', '{\"areas\": {}, \"lines\": {\"1586330185800\": {\"to\": \"1586330168047\", \"from\": \"1586330166231\", \"name\": \"\", \"type\": \"sl\"}, \"1586330186815\": {\"to\": \"1586330169687\", \"from\": \"1586330168047\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586330166231\": {\"alt\": true, \"top\": 126, \"left\": 536, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586330168047\": {\"alt\": true, \"top\": 220, \"left\": 509, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"a9edd9056d9e11ea88bde0d55edb21ed\", \"verifyModelNames\": \"管理员二级角色(lcd媒体商)\"}, \"1586330169687\": {\"alt\": true, \"top\": 320, \"left\": 534, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核\", \"initNum\": 2}', '控件', '2020-04-08 15:33:05', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('18599c13796c11eaba96e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', null, '流程说明yy', '2020-04-08 15:40:16', 'bb0fcf7a796711eaba96e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('188f9440ef3311e99358e0d55edb21ed', '188de383ef3311e99358e0d55edb21ed', '11', 'testad', null, '123', '2019-10-15 18:11:29', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('1b3f1a4d1be311ea80e1e0d55edb21ed', '0bce9b771be311ea80e1e0d55edb21ed', 'tet', 'cby', '{\"areas\": {}, \"lines\": {\"1576047332354\": {\"to\": \"1576047329907\", \"from\": \"1576047325556\", \"name\": \"\", \"type\": \"sl\"}, \"1576047333212\": {\"to\": \"1576047327522\", \"from\": \"1576047329907\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047325556\": {\"alt\": true, \"top\": 95, \"left\": 725, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047327522\": {\"alt\": true, \"top\": 190, \"left\": 686, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047329907\": {\"alt\": true, \"top\": 150, \"left\": 636, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),李数里(平台视线)\"}}, \"title\": \"cby\", \"initNum\": 2}', 'teter', '2019-12-11 14:55:37', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1bd07f96dffd11e99358e0d55edb21ed', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '测试机构客户审核流程', null, '金卡联智客户审核流程', '2019-09-26 09:34:47', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('1ca876a6cd5511e99358e0d55edb21ed', 'ebf9e424cd5411e99358e0d55edb21ed', 'hylink-orde-change-test', '平台换刊测试流程', '{\"areas\": {}, \"lines\": {\"1567410148411\": {\"to\": \"1567410142219\", \"from\": \"1567410139635\", \"name\": \"\", \"type\": \"sl\"}, \"1567410150554\": {\"to\": \"1567410142723\", \"from\": \"1567410142219\", \"name\": \"\", \"type\": \"sl\"}, \"1567410151618\": {\"to\": \"1567410144418\", \"from\": \"1567410142723\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410139635\": {\"alt\": true, \"top\": 67, \"left\": 550, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410142219\": {\"alt\": true, \"top\": 180, \"left\": 517, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410142723\": {\"alt\": true, \"top\": 271, \"left\": 529, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410144418\": {\"alt\": true, \"top\": 395, \"left\": 529, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台换刊流程\", \"initNum\": 9}', 'c', '2019-09-02 15:43:22', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1dea91fadffd11e99358e0d55edb21ed', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '测试机构客户审核流程', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"测试机构客户审核流程\", \"initNum\": 1}', '金卡联智客户审核流程', '2019-09-26 09:34:50', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1ec01258643d11ea90cc00163e13e3ca', '10830906643d11ea90cc00163e13e3ca', 'e45454', 'ffffffffffffffffff1111111111111111111111111111111111ffffffffffffffffffffff', '{\"areas\": {}, \"lines\": {\"1584002411883\": {\"to\": \"1584002406898\", \"from\": \"1584002404935\", \"name\": \"\", \"type\": \"sl\"}, \"1584002413212\": {\"to\": \"1584002409220\", \"from\": \"1584002406898\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584002404935\": {\"alt\": true, \"top\": 76, \"left\": 456, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584002406898\": {\"alt\": true, \"top\": 176, \"left\": 455, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台普通管理(平台视线)\"}, \"1584002409220\": {\"alt\": true, \"top\": 313, \"left\": 489, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"ffffffffffffffffff1111111111111111111111111111111111ffffffffffffffffffffff\", \"initNum\": 2}', 'vgdfg', '2020-03-12 16:40:26', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('1ee9ccf5650211ea90cc00163e13e3ca', '1ee84810650211ea90cc00163e13e3ca', '流程编号：1234', '流程名称：123', null, '流程说明：123', '2020-03-13 16:10:36', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('1f057c8056ef11ea90cc00163e13e3ca', '589dba4756ee11ea90cc00163e13e3ca', 'test_100001', '测试通用流程', '{\"areas\": {}, \"lines\": {\"1582539546754\": {\"to\": \"1582539534056\", \"alt\": true, \"from\": \"1582539410084\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582539410084\": {\"alt\": true, \"top\": 107, \"left\": 251, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582539534056\": {\"alt\": true, \"top\": 121, \"left\": 319, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试通用流程\", \"initNum\": 1}', '这是测试通用流程', '2020-02-24 18:19:20', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('207adc58df3e11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:47:34', '1', null, '更新流程:更新了流程设计.', '11');
INSERT INTO `flow_design_temp` VALUES ('21f10466650211ea90cc00163e13e3ca', '1ee84810650211ea90cc00163e13e3ca', '流程编号：1234', '流程名称：123', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"流程名称：123\", \"initNum\": 1}', '流程说明：123', '2020-03-13 16:10:41', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('2326fa3de28e11e99358e0d55edb21ed', 'b82f954de28d11e99358e0d55edb21ed', 'jkzh_hhsh', '金卡智慧换刊审核', '{\"areas\": {}, \"lines\": {\"1569743793954\": {\"to\": \"1569743787795\", \"from\": \"1569743785891\", \"name\": \"\", \"type\": \"sl\"}, \"1569743796137\": {\"to\": \"1569743789459\", \"from\": \"1569743787795\", \"name\": \"\", \"type\": \"sl\"}, \"1569743797426\": {\"to\": \"1569743791738\", \"from\": \"1569743789459\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569743785891\": {\"alt\": true, \"top\": 84, \"left\": 559, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569743787795\": {\"alt\": true, \"top\": 155, \"left\": 559, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"cf47f07ae0cd11e99358e0d55edb21ed\", \"verifyModelNames\": \"金卡智慧\"}, \"1569743789459\": {\"alt\": true, \"top\": 239, \"left\": 548, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"王然(测试机构),黄浩然(测试机构)\"}, \"1569743791738\": {\"alt\": true, \"top\": 325, \"left\": 607, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧换刊审核\", \"initNum\": 3}', '金卡智慧换刊审核', '2019-09-29 15:58:18', 'f1699be0e0f311e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('24a5753f1fe511ea9b06e0d55edb21ed', '249f5ed61fe511ea9b06e0d55edb21ed', '12', '12', null, '23', '2019-12-16 17:19:38', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('28393e55076e11ea8da6e0d55edb21ed', '2834b123076e11ea8da6e0d55edb21ed', '1', '测试权限流程', null, '1', '2019-11-15 14:08:14', '1e3c0c4b05d511ea8da6e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('286f10bb1be211ea80e1e0d55edb21ed', 'ce3cd5a41be111ea80e1e0d55edb21ed', 't1252163fd', 't11', '{\"areas\": {}, \"lines\": {\"1576046812516\": {\"to\": \"1576046806139\", \"from\": \"1576046788292\", \"name\": \"\", \"type\": \"sl\"}, \"1576046814900\": {\"to\": \"1576046807932\", \"from\": \"1576046806139\", \"name\": \"\", \"type\": \"sl\"}, \"1576046816235\": {\"to\": \"1576046810036\", \"from\": \"1576046807932\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046788292\": {\"alt\": true, \"top\": 84, \"left\": 377, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576046806139\": {\"alt\": true, \"top\": 182, \"left\": 389, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b848964e18a011e99d5300163e13e3ca,6082710b46c911e986f0e0d55edb21ed\", \"verifyModelNames\": \"夏超(平台视线),testxie(平台视线)\"}, \"1576046807932\": {\"alt\": true, \"top\": 284, \"left\": 385, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2,3,4,5,e30236b501a211e98a32e0d55edb21ed,6\", \"verifyModelNames\": \"廖伟(测试机构),浦童侣(测试机构),包超(测试机构),周琳果(测试机构),傅炳彬(测试机构),汪新程(测试机构)\"}, \"1576046810036\": {\"alt\": true, \"top\": 414, \"left\": 382, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"t11\", \"initNum\": 3}', '3342vdgvd过度大范甘迪过度的的过度', '2019-12-11 14:48:50', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('288b66e7f3ae11e99358e0d55edb21ed', '07d9ca0dc7d411e99358e0d55edb21ed', 'hylink-order-test', '平台订单流程测试', '{\"areas\": {}, \"lines\": {\"1566806821818\": {\"to\": \"1566806750875\", \"from\": \"1566806745596\", \"name\": \"\", \"type\": \"sl\"}, \"1571626904720\": {\"to\": \"1566806748916\", \"from\": \"1566806750875\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566806745596\": {\"alt\": true, \"top\": 91, \"left\": 576, \"name\": \"提交订单\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566806748916\": {\"alt\": true, \"top\": 456, \"left\": 564, \"name\": \"完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1566806750875\": {\"alt\": true, \"top\": 213, \"left\": 530, \"name\": \"业务部\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"刘莉莎(平台视线),系统超管(平台视线)\"}}, \"title\": \"平台订单流程测试\", \"initNum\": 9}', '订单流程测试', '2019-10-21 11:03:27', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('2aaa85931be311ea80e1e0d55edb21ed', '2aa3146b1be311ea80e1e0d55edb21ed', 'yy', 'yy', null, 'tetete', '2019-12-11 14:56:03', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('2ba4f66a796211eaba96e0d55edb21ed', '2b9461e8796211eaba96e0d55edb21ed', 'test-0408-yy-uu', '素材审核流程', null, '流程说明', '2020-04-08 14:29:13', 'f7d7fea56a6d11ea8f54e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('2c211c9468c311eaa6d3e0d55edb21ed', '1432f22468c311eaa6d3e0d55edb21ed', '545', 'b刊播', '{\"areas\": {}, \"lines\": {\"1584499782938\": {\"to\": \"1584499779170\", \"from\": \"1584499777419\", \"name\": \"\", \"type\": \"sl\"}, \"1584499784082\": {\"to\": \"1584499777419\", \"from\": \"1584499775331\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584499775331\": {\"alt\": true, \"top\": 150, \"left\": 615, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584499777419\": {\"alt\": true, \"top\": 245, \"left\": 585, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"d80e85265dec11ea90cc00163e13e3ca\", \"verifyModelNames\": \"rxbadmin(仁相b)\"}, \"1584499779170\": {\"alt\": true, \"top\": 316, \"left\": 646, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"b刊播\", \"initNum\": 2}', '4646', '2020-03-18 10:50:09', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('2de5d7f6f0bd11e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', '{\"areas\": {}, \"lines\": {\"1569555169175\": {\"to\": \"1569555163040\", \"from\": \"1569555161257\", \"name\": \"\", \"type\": \"sl\"}, \"1569555170990\": {\"to\": \"1569555165959\", \"from\": \"1569555163040\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569555161257\": {\"alt\": true, \"top\": 116, \"left\": 608, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569555163040\": {\"alt\": true, \"top\": 207, \"left\": 563, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed,3774e4de1deb11e99d5300163e13e3ca\", \"verifyModelNames\": \"黄浩然(测试机构),王然(测试机构)\"}, \"1569555165959\": {\"alt\": true, \"top\": 321, \"left\": 609, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"客户审核\", \"initNum\": 2}', '金卡智慧客户审核', '2019-10-17 17:12:40', '8b462d09e0ce11e99358e0d55edb21ed', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('2ef17412e02a11e99358e0d55edb21ed', '2eee0c08e02a11e99358e0d55edb21ed', 'jklz_pp', '测试机构品牌审核', null, '金卡联智品牌审核', '2019-09-26 14:57:28', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('30748d79f3d711e99358e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', '{\"areas\": {}, \"lines\": {\"1570589522057\": {\"to\": \"1570589480697\", \"from\": \"1570589478490\", \"name\": \"\", \"type\": \"sl\"}, \"1571644620889\": {\"to\": \"1570589532931\", \"alt\": true, \"from\": \"1570589480697\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570589478490\": {\"alt\": true, \"top\": 63, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570589480697\": {\"alt\": true, \"top\": 188, \"left\": 471, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589532931\": {\"alt\": true, \"top\": 556, \"left\": 512, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核2\", \"initNum\": 4}', 'sfdsf', '2019-10-21 15:57:11', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('30f3d96bdf7411e99358e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', null, '素材审核', '2019-09-25 17:14:37', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('311ca8a3651811ea90cc00163e13e3ca', '3118a248651811ea90cc00163e13e3ca', '756', '6565', null, '56775', '2020-03-13 18:48:36', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('316a036ce02a11e99358e0d55edb21ed', '2eee0c08e02a11e99358e0d55edb21ed', 'jklz_pp', '测试机构品牌审核', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"测试机构品牌审核\", \"initNum\": 1}', '金卡联智品牌审核', '2019-09-26 14:57:32', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('340e68f3651911ea90cc00163e13e3ca', '3118a248651811ea90cc00163e13e3ca', '756', '6565', '{\"areas\": {}, \"lines\": {\"1584096538454\": {\"to\": \"1584096523709\", \"from\": \"1584096520302\", \"name\": \"\", \"type\": \"sl\"}, \"1584096540229\": {\"to\": \"1584096525181\", \"from\": \"1584096523709\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584096520302\": {\"alt\": true, \"top\": 119, \"left\": 535, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584096523709\": {\"alt\": true, \"top\": 244, \"left\": 505, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"e49ba1ca1df311e98de8e0d55edb21ed,d712d2d022a411e98de8e0d55edb21ed\", \"verifyModelNames\": \"重庆苏宁易购销售有限公司,华为技术有限公司\"}, \"1584096525181\": {\"alt\": true, \"top\": 366, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"6565\", \"initNum\": 2}', '56775', '2020-03-13 18:55:50', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('35ec9f2bf3d311e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1571369415327\": {\"to\": \"1571369410987\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1571642900698\": {\"to\": \"1569570818536\", \"from\": \"1571369410987\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570818536\": {\"alt\": true, \"top\": 432, \"left\": 568, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1571369410987\": {\"alt\": true, \"top\": 209, \"left\": 557, \"name\": \"任务节点_6\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 8}', '金卡智慧品牌审核', '2019-10-21 15:28:42', '10', null, '更新流程: 更新了流程设计.', '7');
INSERT INTO `flow_design_temp` VALUES ('36a2778bcd5411e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材测试流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 75, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3,1\", \"verifyModelNames\": \"总经办人员(平台视线),系统管理员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '顶级机构素材审核流程', '2019-09-02 15:36:56', '1', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('3777a7a5df4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', null, '流程说明yy', '2019-09-25 11:52:39', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('37edfd8c651a11ea90cc00163e13e3ca', '98756700651911ea90cc00163e13e3ca', 'yy123', '金卡订单通用流程', '{\"areas\": {}, \"lines\": {\"1584097133901\": {\"to\": \"1584097124861\", \"from\": \"1584097123477\", \"name\": \"\", \"type\": \"sl\"}, \"1584097134942\": {\"to\": \"1584097128181\", \"from\": \"1584097124861\", \"name\": \"\", \"type\": \"sl\"}, \"1584097135837\": {\"to\": \"1584097129638\", \"from\": \"1584097128181\", \"name\": \"\", \"type\": \"sl\"}, \"1584097137109\": {\"to\": \"1584097131351\", \"from\": \"1584097129638\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584097123477\": {\"alt\": true, \"top\": 152, \"left\": 526, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584097124861\": {\"alt\": true, \"top\": 265, \"left\": 503, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,1d0ef1e91b2711ea80e1e0d55edb21ed\", \"verifyModelNames\": \"平台系统超管(平台视线),353(平台视线)\"}, \"1584097128181\": {\"alt\": true, \"top\": 323, \"left\": 505, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,3\", \"verifyModelNames\": \"系统管理员(平台视线),总经办人员(平台视线)\"}, \"1584097129638\": {\"alt\": true, \"top\": 405, \"left\": 529, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"城投金卡\"}, \"1584097131351\": {\"alt\": true, \"top\": 528, \"left\": 600, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡订单通用流程\", \"initNum\": 4}', 'jghj', '2020-03-13 19:03:06', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('380770f7644111ea90cc00163e13e3ca', '38066a89644111ea90cc00163e13e3ca', 'ttt', '平台订单通用流程', null, '第三方', '2020-03-12 17:09:46', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('38e60d61df4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"流程名称yy\", \"initNum\": 1}', '流程说明yy', '2019-09-25 11:52:41', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('3aabc866b9b011eaabbb28d244a5fdf0', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2020-06-29 10:27:31', '10', null, 'R流程:自动(该机构其他[普通]流程[素材审核流程]手动启用时将此流程自动改为停用状态)', '8');
INSERT INTO `flow_design_temp` VALUES ('3aafd957b9b011eaabbb28d244a5fdf0', 'f1f92c0fdf7311e99358e0d55edb21ed', 'scsh_yyy', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402782263\": {\"to\": \"1569402775344\", \"from\": \"1569402773552\", \"name\": \"\", \"type\": \"sl\"}, \"1569402784558\": {\"to\": \"1569402777151\", \"from\": \"1569402775344\", \"name\": \"\", \"type\": \"sl\"}, \"1569402786015\": {\"to\": \"1569402779544\", \"from\": \"1569402777151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402773552\": {\"alt\": true, \"top\": 88, \"left\": 416, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402775344\": {\"alt\": true, \"top\": 161, \"left\": 388, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402777151\": {\"alt\": true, \"top\": 240, \"left\": 402, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402779544\": {\"alt\": true, \"top\": 345, \"left\": 439, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '素材审核流程djklsj', '2020-06-29 10:27:31', '10', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('3b5886fa936311eaaab1e0d55edb21ed', '3b5603bf936311eaaab1e0d55edb21ed', '0511', '素材审核流程', null, '流程说明123', '2020-05-11 16:42:00', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('3bd9560d651b11ea90cc00163e13e3ca', '3bd8536a651b11ea90cc00163e13e3ca', '流程编号：1234', '流程名称：123', null, '流程说明巴拉巴拉巴拉', '2020-03-13 19:10:22', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('3ce01249e10211e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '{\"areas\": {}, \"lines\": {\"1569563923256\": {\"to\": \"1569563906214\", \"from\": \"1569563897495\", \"name\": \"\", \"type\": \"sl\"}, \"1569563925709\": {\"to\": \"1569563897495\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 77, \"left\": 478, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569563897495\": {\"alt\": true, \"top\": 221, \"left\": 455, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧)\"}, \"1569563906214\": {\"alt\": true, \"top\": 291, \"left\": 468, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 2}', '金卡智慧素材审核', '2019-09-27 16:44:07', '8b462d09e0ce11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('3d906cdc05e311ea8da6e0d55edb21ed', '3d8e174c05e311ea8da6e0d55edb21ed', '111111', '测试流程', null, '111', '2019-11-13 15:01:15', '1e3c0c4b05d511ea8da6e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('3dac363fdf7411e99358e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"alt\": true, \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"alt\": true, \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"alt\": true, \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2019-09-25 17:14:58', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('3dbe11b8e28111e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1569728633697\": {\"to\": \"1569728630919\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}, \"1569728641870\": {\"to\": \"1569728635742\", \"from\": \"1569728630919\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed,8b462d09e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构),柏林(金卡智慧)\"}, \"1569728630919\": {\"alt\": true, \"top\": 364, \"left\": 344, \"name\": \"任务节点_9\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569728635742\": {\"alt\": true, \"top\": 456, \"left\": 367, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 10}', 'hsdf', '2019-09-29 14:25:59', '9b57cf6c17dd11e99d5300163e13e3ca', null, '更新流程:更新了流程设计.', '8');
INSERT INTO `flow_design_temp` VALUES ('3e943247e0fb11e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569570734429\": {\"to\": \"1569570708079\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1569570821763\": {\"to\": \"1569570818536\", \"from\": \"1569570708079\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570708079\": {\"alt\": true, \"top\": 187, \"left\": 539, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧),小艳(金卡智慧)\"}, \"1569570818536\": {\"alt\": true, \"top\": 289, \"left\": 583, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 4}', '金卡智慧品牌审核', '2019-09-27 15:54:03', 'f1699be0e0f311e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('3f91fcd0df6c11e99358e0d55edb21ed', '74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569398285919\": {\"to\": \"1569398273785\", \"from\": \"1569398268355\", \"name\": \"\", \"type\": \"sl\"}, \"1569398298318\": {\"to\": \"1569398278328\", \"from\": \"1569398273785\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569398268355\": {\"alt\": true, \"top\": 96, \"left\": 519, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569398273785\": {\"alt\": true, \"top\": 189, \"left\": 505, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"6,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"汪新程(测试机构),陈伯燕(测试机构)\"}, \"1569398278328\": {\"alt\": true, \"top\": 283, \"left\": 535, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '金卡联智素材审核', '2019-09-25 16:17:45', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('3fc53d5a650b11ea90cc00163e13e3ca', '1ee84810650211ea90cc00163e13e3ca', '流程编号：1234', '流程名称：123', '{\"areas\": {}, \"lines\": {\"1584087238692\": {\"to\": \"1584087229445\", \"from\": \"1584087226996\", \"name\": \"\", \"type\": \"sl\"}, \"1584087241220\": {\"to\": \"1584087235916\", \"from\": \"1584087232868\", \"name\": \"\", \"type\": \"sl\"}, \"1584087243924\": {\"to\": \"1584087232868\", \"from\": \"1584087229445\", \"name\": \"\", \"type\": \"sl\"}, \"1584087249755\": {\"to\": \"1584087247356\", \"from\": \"1584087235916\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584087226996\": {\"alt\": true, \"top\": 69, \"left\": 479, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584087229445\": {\"alt\": true, \"top\": 142, \"left\": 454, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca,3\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线),总经办人员(平台视线)\"}, \"1584087232868\": {\"alt\": true, \"top\": 217, \"left\": 483, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"a5133a9818a011e99d5300163e13e3ca,9b57cf6c17dd11e99d5300163e13e3ca,b848964e18a011e99d5300163e13e3ca,6082710b46c911e986f0e0d55edb21ed\", \"verifyModelNames\": \"李数里(平台视线),刘莉莎(平台视线),夏超(平台视线),testxie(平台视线)\"}, \"1584087235916\": {\"alt\": true, \"top\": 305, \"left\": 473, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,b848964e18a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),夏超(平台视线)\"}, \"1584087247356\": {\"alt\": true, \"top\": 410, \"left\": 514, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称：123\", \"initNum\": 4}', '流程说明：123', '2020-03-13 17:15:57', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('40683849df3c11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3,1\", \"verifyModelNames\": \"总经办人员(平台视线),系统管理员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:34:09', '1', null, '更新流程:更新了流程设计.', '9');
INSERT INTO `flow_design_temp` VALUES ('4190170d651c11ea90cc00163e13e3ca', '418f58e6651c11ea90cc00163e13e3ca', '11', '名称', null, '嗯嗯', '2020-03-13 19:17:41', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('41f5a01b1be311ea80e1e0d55edb21ed', '2aa3146b1be311ea80e1e0d55edb21ed', 'yy', 'yy', '{\"areas\": {}, \"lines\": {\"1576047386481\": {\"to\": \"1576047377305\", \"from\": \"1576047370011\", \"name\": \"\", \"type\": \"sl\"}, \"1576047388425\": {\"to\": \"1576047383937\", \"from\": \"1576047377305\", \"name\": \"\", \"type\": \"sl\"}, \"1576047389394\": {\"to\": \"1576047372498\", \"from\": \"1576047383937\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047370011\": {\"alt\": true, \"top\": 155, \"left\": 637, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047372498\": {\"alt\": true, \"top\": 316, \"left\": 648, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047377305\": {\"alt\": true, \"top\": 223, \"left\": 638, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),李数里(平台视线)\"}, \"1576047383937\": {\"alt\": true, \"top\": 276, \"left\": 641, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6082710b46c911e986f0e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed\", \"verifyModelNames\": \"testxie(平台视线),平台运营测试账号1(平台视线)\"}}, \"title\": \"yy\", \"initNum\": 4}', 'tetete', '2019-12-11 14:56:42', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('421e86d8df4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383573896\": {\"to\": \"1569383569433\", \"alt\": true, \"from\": \"1569383567481\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383567481\": {\"alt\": true, \"top\": 132, \"left\": 488, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383569433\": {\"alt\": true, \"top\": 302, \"left\": 494, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 1}', '流程说明yy', '2019-09-25 11:52:57', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('435319b7df3f11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"8250ee23a2c111e99130e0d55edb21ed\", \"verifyModelNames\": \"信息科员(重庆八中)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:55:42', '1', null, '更新流程:更新了流程设计.', '12');
INSERT INTO `flow_design_temp` VALUES ('44df8b4fe0fb11e99358e0d55edb21ed', '5760e0a9e0f011e99358e0d55edb21ed', 'jkzh_崔莺莺', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569566176767\": {\"to\": \"1569566169725\", \"from\": \"1569566167630\", \"name\": \"\", \"type\": \"sl\"}, \"1569566179420\": {\"to\": \"1569566172686\", \"from\": \"1569566169725\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569566167630\": {\"alt\": true, \"top\": 113, \"left\": 560, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569566169725\": {\"alt\": true, \"top\": 183, \"left\": 533, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"3b1e0c01e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"管理员(金卡智慧)\"}, \"1569566172686\": {\"alt\": true, \"top\": 272, \"left\": 575, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 2}', '金卡智慧品牌审核', '2019-09-27 15:54:14', 'f1699be0e0f311e99358e0d55edb21ed', null, 'R流程:自动(该机构其他[普通]流程[金卡智慧品牌审核]手动启用时将此流程自动改为停用状态)', '3');
INSERT INTO `flow_design_temp` VALUES ('44fe8be0e0fb11e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569570734429\": {\"to\": \"1569570708079\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1569570821763\": {\"to\": \"1569570818536\", \"from\": \"1569570708079\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570708079\": {\"alt\": true, \"top\": 187, \"left\": 539, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧),小艳(金卡智慧)\"}, \"1569570818536\": {\"alt\": true, \"top\": 289, \"left\": 583, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 4}', '金卡智慧品牌审核', '2019-09-27 15:54:14', 'f1699be0e0f311e99358e0d55edb21ed', null, '启用流程:手动', '4');
INSERT INTO `flow_design_temp` VALUES ('459e3078796d11eaba96e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', '{\"areas\": {}, \"lines\": {\"1586331866076\": {\"to\": \"1586331861860\", \"from\": \"1586331860013\", \"name\": \"\", \"type\": \"sl\"}, \"1586331867140\": {\"to\": \"1586331863772\", \"from\": \"1586331861860\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586331860013\": {\"alt\": true, \"top\": 132, \"left\": 596, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586331861860\": {\"alt\": true, \"top\": 213, \"left\": 571, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"87cedb6d6a6d11ea8f54e0d55edb21ed,a9edd9056d9e11ea88bde0d55edb21ed\", \"verifyModelNames\": \"系统管理员角色(lcd媒体商),管理员二级角色(lcd媒体商)\"}, \"1586331863772\": {\"alt\": true, \"top\": 298, \"left\": 601, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"换刊审核流程\", \"initNum\": 2}', '流程说明yy', '2020-04-08 15:48:41', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('45bf1d78644111ea90cc00163e13e3ca', '38066a89644111ea90cc00163e13e3ca', 'ttt', '平台订单通用流程', '{\"areas\": {}, \"lines\": {\"1584004199299\": {\"to\": \"1584004195812\", \"from\": \"1584004194062\", \"name\": \"\", \"type\": \"sl\"}, \"1584004200310\": {\"to\": \"1584004196943\", \"from\": \"1584004195812\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584004194062\": {\"alt\": true, \"top\": 107, \"left\": 130, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584004195812\": {\"alt\": true, \"top\": 249, \"left\": 166, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台普通管理(平台视线)\"}, \"1584004196943\": {\"alt\": true, \"top\": 330, \"left\": 220, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台订单通用流程\", \"initNum\": 2}', '第三方', '2020-03-12 17:10:09', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('4635188e1be311ea80e1e0d55edb21ed', '0bce9b771be311ea80e1e0d55edb21ed', 'tet', 'cby', '{\"areas\": {}, \"lines\": {\"1576047332354\": {\"to\": \"1576047329907\", \"from\": \"1576047325556\", \"name\": \"\", \"type\": \"sl\"}, \"1576047333212\": {\"to\": \"1576047327522\", \"from\": \"1576047329907\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047325556\": {\"alt\": true, \"top\": 95, \"left\": 725, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047327522\": {\"alt\": true, \"top\": 190, \"left\": 686, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047329907\": {\"alt\": true, \"top\": 150, \"left\": 636, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),李数里(平台视线)\"}}, \"title\": \"cby\", \"initNum\": 2}', 'teter', '2019-12-11 14:56:49', '10', null, 'R流程:自动(该机构其他[普通]流程[yy]手动启用时将此流程自动改为停用状态)', '3');
INSERT INTO `flow_design_temp` VALUES ('466c71301be311ea80e1e0d55edb21ed', '2aa3146b1be311ea80e1e0d55edb21ed', 'yy', 'yy', '{\"areas\": {}, \"lines\": {\"1576047386481\": {\"to\": \"1576047377305\", \"from\": \"1576047370011\", \"name\": \"\", \"type\": \"sl\"}, \"1576047388425\": {\"to\": \"1576047383937\", \"from\": \"1576047377305\", \"name\": \"\", \"type\": \"sl\"}, \"1576047389394\": {\"to\": \"1576047372498\", \"from\": \"1576047383937\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047370011\": {\"alt\": true, \"top\": 155, \"left\": 637, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047372498\": {\"alt\": true, \"top\": 316, \"left\": 648, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047377305\": {\"alt\": true, \"top\": 223, \"left\": 638, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),李数里(平台视线)\"}, \"1576047383937\": {\"alt\": true, \"top\": 276, \"left\": 641, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6082710b46c911e986f0e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed\", \"verifyModelNames\": \"testxie(平台视线),平台运营测试账号1(平台视线)\"}}, \"title\": \"yy\", \"initNum\": 4}', 'tetete', '2019-12-11 14:56:49', '10', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('4734826df14e11e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', '{\"areas\": {}, \"lines\": {\"1571365731366\": {\"to\": \"1571365728793\", \"from\": \"1569555161257\", \"name\": \"\", \"type\": \"sl\"}, \"1571365732367\": {\"to\": \"1569555165959\", \"from\": \"1571365728793\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569555161257\": {\"alt\": true, \"top\": 116, \"left\": 608, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569555165959\": {\"alt\": true, \"top\": 321, \"left\": 609, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1571365728793\": {\"alt\": true, \"top\": 204, \"left\": 594, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}}, \"title\": \"客户审核\", \"initNum\": 3}', '金卡智慧客户审核', '2019-10-18 10:31:44', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('476c9e79afa711eaabbb28d244a5fdf0', '858f39e056f111ea90cc00163e13e3ca', 'test_100002', '测试普通流程', '{\"areas\": {}, \"lines\": {\"1582540610147\": {\"to\": \"1582540605533\", \"from\": \"1582540604036\", \"name\": \"\", \"type\": \"sl\"}, \"1582540614346\": {\"to\": \"1582540606693\", \"from\": \"1582540605533\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582540604036\": {\"alt\": true, \"top\": 126, \"left\": 202, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582540605533\": {\"alt\": true, \"top\": 194, \"left\": 524, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1582540606693\": {\"alt\": true, \"top\": 359, \"left\": 311, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}}, \"title\": \"测试普通流程\", \"initNum\": 3}', '这是一条测试普通流程的数据', '2020-06-16 15:58:43', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('480ce7af1be211ea80e1e0d55edb21ed', '48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', null, 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2019-12-11 14:49:43', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('4a14e95ccd5411e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"39f0da4701a111e98a32e0d55edb21ed,1\", \"verifyModelNames\": \"媒介部总监(测试机构),系统管理员(平台视线)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,33341ee4760d11e9ba07e0d55edb21ed,1\", \"verifyModelNames\": \"王然(测试机构),王先连(测试机构),陈伯燕(测试机构),系统超管(平台视线)\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"2,1\", \"verifyModelNames\": \"总经办人员(测试机构),系统管理员(平台视线)\"}}, \"title\": \"测试客户入库流程1\", \"initNum\": 24}', '测试说明5aaa', '2019-09-02 15:37:29', '1', null, '更新流程:更新了流程设计.', '8');
INSERT INTO `flow_design_temp` VALUES ('4b4ae838df7411e99358e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2019-09-25 17:15:21', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('4c1fc17e56f411ea90cc00163e13e3ca', 'cee793fa56f211ea90cc00163e13e3ca', 'test_100003', '测试普通流程', '{\"areas\": {}, \"lines\": {\"1582541177599\": {\"to\": \"1582541174640\", \"from\": \"1582541173342\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582541173342\": {\"alt\": true, \"top\": 139, \"left\": 242, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582541174640\": {\"alt\": true, \"top\": 257, \"left\": 432, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试普通流程\", \"initNum\": 1}', '测试数据', '2020-02-24 18:56:23', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('4c86ead3651811ea90cc00163e13e3ca', '3118a248651811ea90cc00163e13e3ca', '756', '6565', '{\"areas\": {}, \"lines\": {\"1584096538454\": {\"to\": \"1584096523709\", \"from\": \"1584096520302\", \"name\": \"\", \"type\": \"sl\"}, \"1584096540229\": {\"to\": \"1584096525181\", \"from\": \"1584096523709\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584096520302\": {\"alt\": true, \"top\": 119, \"left\": 535, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584096523709\": {\"alt\": true, \"top\": 244, \"left\": 505, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca,b848964e18a011e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线),李数里(平台视线),夏超(平台视线)\"}, \"1584096525181\": {\"alt\": true, \"top\": 366, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"6565\", \"initNum\": 2}', '56775', '2020-03-13 18:49:22', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('4d6ff5b0f3cc11e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', '{\"areas\": {}, \"lines\": {\"1571365731366\": {\"to\": \"1571365728793\", \"from\": \"1569555161257\", \"name\": \"\", \"type\": \"sl\"}, \"1571365732367\": {\"to\": \"1569555165959\", \"from\": \"1571365728793\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569555161257\": {\"alt\": true, \"top\": 116, \"left\": 608, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569555165959\": {\"alt\": true, \"top\": 321, \"left\": 609, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1571365728793\": {\"alt\": true, \"top\": 204, \"left\": 594, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}}, \"title\": \"客户审核\", \"initNum\": 3}', '金卡智慧客户审核', '2019-10-21 14:39:15', '10', null, '更新流程: 更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('4ffa3b75936311eaaab1e0d55edb21ed', '3b5603bf936311eaaab1e0d55edb21ed', '0511', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1589186541542\": {\"to\": \"1589186536863\", \"from\": \"1589186534879\", \"name\": \"\", \"type\": \"sl\"}, \"1589186542734\": {\"to\": \"1589186539086\", \"from\": \"1589186536863\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1589186534879\": {\"alt\": true, \"top\": 97, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1589186536863\": {\"alt\": true, \"top\": 176, \"left\": 501, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1589186539086\": {\"alt\": true, \"top\": 304, \"left\": 480, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '流程说明123', '2020-05-11 16:42:35', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('500b5f0ae0eb11e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '{\"areas\": {}, \"lines\": {\"1569563923256\": {\"to\": \"1569563906214\", \"from\": \"1569563897495\", \"name\": \"\", \"type\": \"sl\"}, \"1569563925709\": {\"to\": \"1569563897495\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 77, \"left\": 478, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569563897495\": {\"alt\": true, \"top\": 221, \"left\": 455, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧),小艳(金卡智慧)\"}, \"1569563906214\": {\"alt\": true, \"top\": 291, \"left\": 468, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 2}', '金卡智慧素材审核', '2019-09-27 14:00:00', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('50f8b25edf3f11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"8250ee23a2c111e99130e0d55edb21ed\", \"verifyModelNames\": \"信息科员(重庆八中)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:56:05', '1', null, '更新流程:更新了流程设计.', '13');
INSERT INTO `flow_design_temp` VALUES ('532a29a61be311ea80e1e0d55edb21ed', '5322ab371be311ea80e1e0d55edb21ed', 'kmnkj', 'jojo', null, 'bnjnn', '2019-12-11 14:57:11', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('5534fc48df3c11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3,1\", \"verifyModelNames\": \"总经办人员(平台视线),系统管理员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:34:44', '1', null, '更新流程:更新了流程设计.', '10');
INSERT INTO `flow_design_temp` VALUES ('5763dbfde0f011e99358e0d55edb21ed', '5760e0a9e0f011e99358e0d55edb21ed', 'jkzh_崔莺莺', '金卡智慧品牌审核', null, '金卡智慧品牌审核', '2019-09-27 14:36:00', '2a03890ce0cf11e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('589f881a56ee11ea90cc00163e13e3ca', '589dba4756ee11ea90cc00163e13e3ca', 'test_100001', '测试通用流程', null, '这是测试通用流程', '2020-02-24 18:13:47', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('59b4b5c9df7411e99358e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2019-09-25 17:15:45', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('5ae95b71e0d211e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', '{\"areas\": {}, \"lines\": {\"1569553200897\": {\"to\": \"1569553197864\", \"from\": \"1569553195890\", \"name\": \"\", \"type\": \"sl\"}, \"1569553222504\": {\"to\": \"1569553219808\", \"from\": \"1569553197864\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569553195890\": {\"alt\": true, \"top\": 51, \"left\": 465, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569553197864\": {\"alt\": true, \"top\": 155, \"left\": 460, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569553219808\": {\"alt\": true, \"top\": 275, \"left\": 482, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧订单审核\", \"initNum\": 4}', '金卡智慧订单审核', '2019-09-27 11:01:20', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('5b3edc58796211eaba96e0d55edb21ed', '2b9461e8796211eaba96e0d55edb21ed', 'test-0408-yy-uu11', '素材审核流程11', null, '流程说明11', '2020-04-08 14:30:33', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: <br/>1.更新了流程编码.<br/>2.更新了流程名称.<br/>3.更新了流程说明.', '2');
INSERT INTO `flow_design_temp` VALUES ('5c1e7d84076e11ea8da6e0d55edb21ed', '3d8e174c05e311ea8da6e0d55edb21ed', '111111', '测试流程', '{\"areas\": {}, \"lines\": {\"1573798141643\": {\"to\": \"1573798136359\", \"from\": \"1573798131116\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1573798131116\": {\"alt\": true, \"top\": 203, \"left\": 339, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1573798136359\": {\"alt\": true, \"top\": 222, \"left\": 507, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6e9d3d9905cc11ea8da6e0d55edb21ed\", \"verifyModelNames\": \"测试数据权限机构01\"}}, \"title\": \"测试流程\", \"initNum\": 2}', '111', '2019-11-15 14:09:41', '1e3c0c4b05d511ea8da6e0d55edb21ed', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('5d7c078856ee11ea90cc00163e13e3ca', '589dba4756ee11ea90cc00163e13e3ca', 'test_100001', '测试通用流程', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"测试通用流程\", \"initNum\": 1}', '这是测试通用流程', '2020-02-24 18:13:55', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('5d9a54ccdf4511e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', null, '流程说明yy', '2019-09-25 11:39:24', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('5e10f8a5df7411e99358e0d55edb21ed', '74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569398285919\": {\"to\": \"1569398273785\", \"from\": \"1569398268355\", \"name\": \"\", \"type\": \"sl\"}, \"1569398298318\": {\"to\": \"1569398278328\", \"from\": \"1569398273785\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569398268355\": {\"alt\": true, \"top\": 96, \"left\": 519, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569398273785\": {\"alt\": true, \"top\": 189, \"left\": 505, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"6,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"汪新程(测试机构),陈伯燕(测试机构)\"}, \"1569398278328\": {\"alt\": true, \"top\": 283, \"left\": 535, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '金卡联智素材审核', '2019-09-25 17:15:52', '33341ee4760d11e9ba07e0d55edb21ed', null, 'R流程:自动(该机构其他[普通]流程[素材审核]手动启用时将此流程自动改为停用状态)', '5');
INSERT INTO `flow_design_temp` VALUES ('5e2709a4df7411e99358e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2019-09-25 17:15:52', '33341ee4760d11e9ba07e0d55edb21ed', null, '启用流程:手动', '5');
INSERT INTO `flow_design_temp` VALUES ('5f37cbedc25411e99358e0d55edb22ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"alt\": true, \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"alt\": true, \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"傅炳彬\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"王然,贺磊\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"总经办\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5', '2019-08-19 15:39:29', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('5f37cbedc25411e99358e0d55edb23ed', '5f37cbedc25411e99358e0d55edb22ed', 'TEST-06', '联智品牌测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"alt\": true, \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"alt\": true, \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"傅炳彬\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"王然,贺磊\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"总经办\"}}, \"title\": \"测试品牌入库流程\", \"initNum\": 24}', '测试说明6', '2019-08-19 15:39:29', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('5f3e1964df3b11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', null, '辉煌光环', '2019-09-25 10:27:51', '1', null, '更新流程:更新了流程说明.', '6');
INSERT INTO `flow_design_temp` VALUES ('5f415940650d11ea90cc00163e13e3ca', 'ca3f57de650b11ea90cc00163e13e3ca', '1567878978777777', '14好久好看看很', '{\"areas\": {}, \"lines\": {\"1584091615265\": {\"to\": \"1584091610473\", \"from\": \"1584091608841\", \"name\": \"\", \"type\": \"sl\"}, \"1584091616673\": {\"to\": \"1584091612665\", \"from\": \"1584091610473\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584091608841\": {\"alt\": true, \"top\": 148, \"left\": 511, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584091610473\": {\"alt\": true, \"top\": 231, \"left\": 480, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"d7e79858c7d211e99358e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"平台总经办测试账号(平台视线),平台运营测试账号1(平台视线),李数里(平台视线)\"}, \"1584091612665\": {\"alt\": true, \"top\": 358, \"left\": 506, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"14好久好看看很\", \"initNum\": 2}', '16', '2020-03-13 17:31:09', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('6180769285fc11ea9bd5e0d55edb21ed', '617f7f1285fc11ea9bd5e0d55edb21ed', '1234', '1234', null, '23', '2020-04-24 15:23:34', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('63d2bcfbe0d211e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', '{\"areas\": {}, \"lines\": {\"1569553200897\": {\"to\": \"1569553197864\", \"from\": \"1569553195890\", \"name\": \"\", \"type\": \"sl\"}, \"1569553222504\": {\"to\": \"1569553219808\", \"from\": \"1569553197864\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569553195890\": {\"alt\": true, \"top\": 51, \"left\": 465, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569553197864\": {\"alt\": true, \"top\": 155, \"left\": 460, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"4\", \"verifyModelNames\": \"包超(测试机构)\"}, \"1569553219808\": {\"alt\": true, \"top\": 275, \"left\": 482, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧订单审核\", \"initNum\": 4}', '金卡智慧订单审核', '2019-09-27 11:01:35', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('640939231be311ea80e1e0d55edb21ed', '5322ab371be311ea80e1e0d55edb21ed', 'kmnkj', 'jojo', '{\"areas\": {}, \"lines\": {\"1576047443612\": {\"to\": \"1576047439465\", \"from\": \"1576047437418\", \"name\": \"\", \"type\": \"sl\"}, \"1576047444746\": {\"to\": \"1576047441242\", \"from\": \"1576047439465\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047437418\": {\"alt\": true, \"top\": 121, \"left\": 478, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047439465\": {\"alt\": true, \"top\": 242, \"left\": 418, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1576047441242\": {\"alt\": true, \"top\": 360, \"left\": 474, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"jojo\", \"initNum\": 2}', 'bnjnn', '2019-12-11 14:57:39', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('64e1d125651811ea90cc00163e13e3ca', '3118a248651811ea90cc00163e13e3ca', '756', '6565', '{\"areas\": {}, \"lines\": {\"1584096538454\": {\"to\": \"1584096523709\", \"from\": \"1584096520302\", \"name\": \"\", \"type\": \"sl\"}, \"1584096540229\": {\"to\": \"1584096525181\", \"from\": \"1584096523709\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584096520302\": {\"alt\": true, \"top\": 119, \"left\": 535, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584096523709\": {\"alt\": true, \"top\": 244, \"left\": 505, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca,3\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线),总经办人员(平台视线)\"}, \"1584096525181\": {\"alt\": true, \"top\": 366, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"6565\", \"initNum\": 2}', '56775', '2020-03-13 18:50:03', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('65b9b5df643d11ea90cc00163e13e3ca', '10830906643d11ea90cc00163e13e3ca', 'e45454', 'ffffffffffffffffff1111111111111111111111111111111111ffffffffffffffffffffff', '{\"areas\": {}, \"lines\": {\"1584002411883\": {\"to\": \"1584002406898\", \"from\": \"1584002404935\", \"name\": \"\", \"type\": \"sl\"}, \"1584002413212\": {\"to\": \"1584002409220\", \"from\": \"1584002406898\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584002404935\": {\"alt\": true, \"top\": 76, \"left\": 456, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584002406898\": {\"alt\": true, \"top\": 176, \"left\": 455, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台普通管理(平台视线)\"}, \"1584002409220\": {\"alt\": true, \"top\": 313, \"left\": 489, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"ffffffffffffffffff1111111111111111111111111111111111ffffffffffffffffffffff\", \"initNum\": 2}', 'vgdfg', '2020-03-12 16:42:25', '10', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('65c5a498c3eb11e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"傅炳彬\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"王然,贺磊\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"总经办\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5aaa', '2019-08-21 16:12:33', '1', null, '更新流程:<br/>1.更新了流程说明.', '2');
INSERT INTO `flow_design_temp` VALUES ('66204524df4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383604685\": {\"to\": \"1569383595774\", \"from\": \"1569383567481\", \"name\": \"\", \"type\": \"sl\"}, \"1569383611050\": {\"to\": \"1569383569433\", \"from\": \"1569383595774\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383567481\": {\"alt\": true, \"top\": 132, \"left\": 488, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383569433\": {\"alt\": true, \"top\": 302, \"left\": 494, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1569383595774\": {\"alt\": true, \"top\": 211, \"left\": 491, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,2,3,f1000faf193e11e99d5300163e13e3ca,2cc9c14e1dec11e99d5300163e13e3ca,e49ba1ca1df311e98de8e0d55edb21ed,d712d2d022a411e98de8e0d55edb21ed,965236b522a611e98de8e0d55edb21ed\", \"verifyModelNames\": \"平台视线,测试机构,城投金卡,三星电子屏厂,重庆中国青年旅行社有限公司,重庆苏宁易购销售有限公司,华为技术有限公司,耐克体育(中国)有限公司\"}}, \"title\": \"流程名称yy\", \"initNum\": 2}', '流程说明yy', '2019-09-25 11:53:57', '1', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('66ed582f1be311ea80e1e0d55edb21ed', '2eee0c08e02a11e99358e0d55edb21ed', 'jklz_pp', '测试机构品牌审核', '{\"areas\": {}, \"lines\": {\"1569481095735\": {\"to\": \"1569481077822\", \"from\": \"1569481076061\", \"name\": \"\", \"type\": \"sl\"}, \"1569481098667\": {\"to\": \"1569481090845\", \"from\": \"1569481077822\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569481076061\": {\"alt\": true, \"top\": 87, \"left\": 462, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569481077822\": {\"alt\": true, \"top\": 158, \"left\": 389, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"4e27613e1deb11e99d5300163e13e3ca,7735b100673611e99ec7e0d55edb21ed,8a11f41476c111e99d4be0d55edb21ed\", \"verifyModelNames\": \"王先连(测试机构),黄浩然(测试机构),看见好看(测试机构)\"}, \"1569481090845\": {\"alt\": true, \"top\": 256, \"left\": 458, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试机构品牌审核\", \"initNum\": 2}', '金卡联智品牌审核', '2019-12-11 14:57:44', '10', null, 'R流程:自动(该机构其他[普通]流程[jojo]手动启用时将此流程自动改为停用状态)', '4');
INSERT INTO `flow_design_temp` VALUES ('6723f0a51be311ea80e1e0d55edb21ed', '5322ab371be311ea80e1e0d55edb21ed', 'kmnkj', 'jojo', '{\"areas\": {}, \"lines\": {\"1576047443612\": {\"to\": \"1576047439465\", \"from\": \"1576047437418\", \"name\": \"\", \"type\": \"sl\"}, \"1576047444746\": {\"to\": \"1576047441242\", \"from\": \"1576047439465\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047437418\": {\"alt\": true, \"top\": 121, \"left\": 478, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047439465\": {\"alt\": true, \"top\": 242, \"left\": 418, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1576047441242\": {\"alt\": true, \"top\": 360, \"left\": 474, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"jojo\", \"initNum\": 2}', 'bnjnn', '2019-12-11 14:57:44', '10', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('686d1d11df4711e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383230798\": {\"to\": \"1569383166151\", \"from\": \"1569383159079\", \"name\": \"\", \"type\": \"sl\"}, \"1569383240134\": {\"to\": \"1569383159079\", \"from\": \"1569383105855\", \"name\": \"\", \"type\": \"sl\"}, \"1569383256194\": {\"to\": \"1569383173575\", \"from\": \"1569383166151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383105855\": {\"alt\": true, \"top\": 98, \"left\": 611, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383159079\": {\"alt\": true, \"top\": 205, \"left\": 588, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2,3,4,5,e30236b501a211e98a32e0d55edb21ed,6,3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,71bcd53e40b611e986f0e0d55edb21ed,7735b100673611e99ec7e0d55edb21ed,9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"廖伟(测试机构),浦童侣(测试机构),包超(测试机构),周琳果(测试机构),傅炳彬(测试机构),汪新程(测试机构),王然(测试机构),王先连(测试机构),test12345(测试机构),黄浩然(测试机构),刘莉莎(平台视线),李数里(平台视线)\"}, \"1569383166151\": {\"alt\": true, \"top\": 305, \"left\": 603, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"d74b72f7d33d11e8a31ae0d55edb21ed,39f0da4701a111e98a32e0d55edb21ed,2,5,6,7,31525394673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"拓展部总监(测试机构),媒介部总监(测试机构),总经办人员(测试机构),技术部总监(测试机构),销售部-商业-总监(测试机构),销售部-地产-总监(测试机构),媒介专员(测试机构)\"}, \"1569383173575\": {\"alt\": true, \"top\": 427, \"left\": 580, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 3}', '流程说明yy', '2019-09-25 11:54:01', '1', null, 'R流程:自动(该机构其他[普通]流程[流程名称yy]手动启用时将此流程自动改为停用状态)', '5');
INSERT INTO `flow_design_temp` VALUES ('68809698df4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383604685\": {\"to\": \"1569383595774\", \"from\": \"1569383567481\", \"name\": \"\", \"type\": \"sl\"}, \"1569383611050\": {\"to\": \"1569383569433\", \"from\": \"1569383595774\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383567481\": {\"alt\": true, \"top\": 132, \"left\": 488, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383569433\": {\"alt\": true, \"top\": 302, \"left\": 494, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1569383595774\": {\"alt\": true, \"top\": 211, \"left\": 491, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,2,3,f1000faf193e11e99d5300163e13e3ca,2cc9c14e1dec11e99d5300163e13e3ca,e49ba1ca1df311e98de8e0d55edb21ed,d712d2d022a411e98de8e0d55edb21ed,965236b522a611e98de8e0d55edb21ed\", \"verifyModelNames\": \"平台视线,测试机构,城投金卡,三星电子屏厂,重庆中国青年旅行社有限公司,重庆苏宁易购销售有限公司,华为技术有限公司,耐克体育(中国)有限公司\"}}, \"title\": \"流程名称yy\", \"initNum\": 2}', '流程说明yy', '2019-09-25 11:54:01', '1', null, '启用流程:手动', '5');
INSERT INTO `flow_design_temp` VALUES ('6a20dffc643c11ea90cc00163e13e3ca', '6a1fe377643c11ea90cc00163e13e3ca', 'test-12345', '订单通用流程', null, 'fdsfdsg', '2020-03-12 16:35:23', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('6a37e5c3db4b11e99358e0d55edb21ed', '6a35658cdb4b11e99358e0d55edb21ed', '1', '1', null, '1', '2019-09-20 10:11:51', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('6c48ad3adf4711e99358e0d55edb21ed', '377670d4df4711e99358e0d55edb21ed', '流程编码yyyy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383604685\": {\"to\": \"1569383595774\", \"from\": \"1569383567481\", \"name\": \"\", \"type\": \"sl\"}, \"1569383611050\": {\"to\": \"1569383569433\", \"from\": \"1569383595774\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383567481\": {\"alt\": true, \"top\": 132, \"left\": 488, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383569433\": {\"alt\": true, \"top\": 302, \"left\": 494, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1569383595774\": {\"alt\": true, \"top\": 211, \"left\": 491, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,2,3,f1000faf193e11e99d5300163e13e3ca,2cc9c14e1dec11e99d5300163e13e3ca,e49ba1ca1df311e98de8e0d55edb21ed,d712d2d022a411e98de8e0d55edb21ed,965236b522a611e98de8e0d55edb21ed\", \"verifyModelNames\": \"平台视线,测试机构,城投金卡,三星电子屏厂,重庆中国青年旅行社有限公司,重庆苏宁易购销售有限公司,华为技术有限公司,耐克体育(中国)有限公司\"}}, \"title\": \"流程名称yy\", \"initNum\": 2}', '流程说明yy', '2019-09-25 11:54:07', '1', null, 'R流程:自动(该机构其他[普通]流程[流程名称yy]手动启用时将此流程自动改为停用状态)', '6');
INSERT INTO `flow_design_temp` VALUES ('6c5b3251df4711e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383230798\": {\"to\": \"1569383166151\", \"from\": \"1569383159079\", \"name\": \"\", \"type\": \"sl\"}, \"1569383240134\": {\"to\": \"1569383159079\", \"from\": \"1569383105855\", \"name\": \"\", \"type\": \"sl\"}, \"1569383256194\": {\"to\": \"1569383173575\", \"from\": \"1569383166151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383105855\": {\"alt\": true, \"top\": 98, \"left\": 611, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383159079\": {\"alt\": true, \"top\": 205, \"left\": 588, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2,3,4,5,e30236b501a211e98a32e0d55edb21ed,6,3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,71bcd53e40b611e986f0e0d55edb21ed,7735b100673611e99ec7e0d55edb21ed,9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"廖伟(测试机构),浦童侣(测试机构),包超(测试机构),周琳果(测试机构),傅炳彬(测试机构),汪新程(测试机构),王然(测试机构),王先连(测试机构),test12345(测试机构),黄浩然(测试机构),刘莉莎(平台视线),李数里(平台视线)\"}, \"1569383166151\": {\"alt\": true, \"top\": 305, \"left\": 603, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"d74b72f7d33d11e8a31ae0d55edb21ed,39f0da4701a111e98a32e0d55edb21ed,2,5,6,7,31525394673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"拓展部总监(测试机构),媒介部总监(测试机构),总经办人员(测试机构),技术部总监(测试机构),销售部-商业-总监(测试机构),销售部-地产-总监(测试机构),媒介专员(测试机构)\"}, \"1569383173575\": {\"alt\": true, \"top\": 427, \"left\": 580, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 3}', '流程说明yy', '2019-09-25 11:54:07', '1', null, '启用流程:手动', '6');
INSERT INTO `flow_design_temp` VALUES ('6da3dda3796211eaba96e0d55edb21ed', '2b9461e8796211eaba96e0d55edb21ed', 'test-0408-yy-uu11', '素材审核流程11', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"素材审核流程11\", \"initNum\": 1}', '流程说明11', '2020-04-08 14:31:04', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('703e5290e02a11e99358e0d55edb21ed', '2eee0c08e02a11e99358e0d55edb21ed', 'jklz_pp', '测试机构品牌审核', '{\"areas\": {}, \"lines\": {\"1569481095735\": {\"to\": \"1569481077822\", \"from\": \"1569481076061\", \"name\": \"\", \"type\": \"sl\"}, \"1569481098667\": {\"to\": \"1569481090845\", \"from\": \"1569481077822\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569481076061\": {\"alt\": true, \"top\": 87, \"left\": 462, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569481077822\": {\"alt\": true, \"top\": 158, \"left\": 389, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"4e27613e1deb11e99d5300163e13e3ca,7735b100673611e99ec7e0d55edb21ed,8a11f41476c111e99d4be0d55edb21ed\", \"verifyModelNames\": \"王先连(测试机构),黄浩然(测试机构),看见好看(测试机构)\"}, \"1569481090845\": {\"alt\": true, \"top\": 256, \"left\": 458, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试机构品牌审核\", \"initNum\": 2}', '金卡联智品牌审核', '2019-09-26 14:59:17', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('7175f288f3a811e99358e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', '{\"areas\": {}, \"lines\": {\"1570589522057\": {\"to\": \"1570589480697\", \"from\": \"1570589478490\", \"name\": \"\", \"type\": \"sl\"}, \"1570589526305\": {\"to\": \"1570589482513\", \"from\": \"1570589480697\", \"name\": \"\", \"type\": \"sl\"}, \"1570589528074\": {\"to\": \"1570589500659\", \"from\": \"1570589482513\", \"name\": \"\", \"type\": \"sl\"}, \"1570589538212\": {\"to\": \"1570589532931\", \"from\": \"1570589500659\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570589478490\": {\"alt\": true, \"top\": 63, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570589480697\": {\"alt\": true, \"top\": 188, \"left\": 471, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589482513\": {\"alt\": true, \"top\": 309, \"left\": 469, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"f1699be0e0f311e99358e0d55edb21ed\", \"verifyModelNames\": \"英英(金卡智慧)\"}, \"1570589500659\": {\"alt\": true, \"top\": 408, \"left\": 473, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"柏林(金卡智慧)\"}, \"1570589532931\": {\"alt\": true, \"top\": 556, \"left\": 512, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核2\", \"initNum\": 4}', 'sfdsf', '2019-10-21 10:22:32', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('71fc4bd3e9a311e99358e0d55edb21ed', 'b82f954de28d11e99358e0d55edb21ed', 'jkzh_hhsh', '金卡智慧换刊审核', '{\"areas\": {}, \"lines\": {\"1569743793954\": {\"to\": \"1569743787795\", \"from\": \"1569743785891\", \"name\": \"\", \"type\": \"sl\"}, \"1569743796137\": {\"to\": \"1569743789459\", \"from\": \"1569743787795\", \"name\": \"\", \"type\": \"sl\"}, \"1569743797426\": {\"to\": \"1569743791738\", \"from\": \"1569743789459\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569743785891\": {\"alt\": true, \"top\": 84, \"left\": 559, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569743787795\": {\"alt\": true, \"top\": 155, \"left\": 559, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"cf47f07ae0cd11e99358e0d55edb21ed\", \"verifyModelNames\": \"金卡智慧\"}, \"1569743789459\": {\"alt\": true, \"top\": 239, \"left\": 548, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,8b462d09e0ce11e99358e0d55edb21ed,9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"王然(测试机构),柏林(金卡智慧),刘莉莎(平台视线)\"}, \"1569743791738\": {\"alt\": true, \"top\": 325, \"left\": 607, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧换刊审核\", \"initNum\": 3}', '金卡智慧换刊审核', '2019-10-08 16:19:53', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('720fc286df7311e99358e0d55edb21ed', '720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', null, '金卡联智素材审核审核审核', '2019-09-25 17:09:16', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('72b46c16c7d811e99358e0d55edb21ed', '07d9ca0dc7d411e99358e0d55edb21ed', 'hylink-order-test', '平台订单测试流程', '{\"areas\": {}, \"lines\": {\"1566806821818\": {\"to\": \"1566806750875\", \"from\": \"1566806745596\", \"name\": \"\", \"type\": \"sl\"}, \"1566806822650\": {\"to\": \"1566806752675\", \"from\": \"1566806750875\", \"name\": \"\", \"type\": \"sl\"}, \"1566806823794\": {\"to\": \"1566806748916\", \"from\": \"1566806752675\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566806745596\": {\"alt\": true, \"top\": 91, \"left\": 576, \"name\": \"提交订单\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566806748916\": {\"alt\": true, \"top\": 456, \"left\": 564, \"name\": \"完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1566806750875\": {\"alt\": true, \"top\": 213, \"left\": 530, \"name\": \"业务部\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"fc14d10dc7d111e99358e0d55edb21ed,7948c1f4c7d311e99358e0d55edb21ed,b848964e18a011e99d5300163e13e3ca,9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"平台运营测试账号1(平台视线),平台运营测试账号2(平台视线),夏超(平台视线),刘莉莎(平台视线)\"}, \"1566806752675\": {\"alt\": true, \"top\": 326, \"left\": 525, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}}, \"title\": \"平台订单流程测试\", \"initNum\": 9}', '订单流程测试', '2019-08-26 16:07:43', '1', null, '更新流程:<br/>1.更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('74066d81df6911e99358e0d55edb21ed', '74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', null, '金卡联智素材审核', '2019-09-25 15:57:44', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('76efb06298d611eaaab1e0d55edb21ed', '76eded7f98d611eaaab1e0d55edb21ed', '05181510', '刊播审核', null, '流程说明123', '2020-05-18 15:10:34', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('76f5d9ac651811ea90cc00163e13e3ca', '3118a248651811ea90cc00163e13e3ca', '756', '6565', '{\"areas\": {}, \"lines\": {\"1584096538454\": {\"to\": \"1584096523709\", \"from\": \"1584096520302\", \"name\": \"\", \"type\": \"sl\"}, \"1584096540229\": {\"to\": \"1584096525181\", \"from\": \"1584096523709\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584096520302\": {\"alt\": true, \"top\": 119, \"left\": 535, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584096523709\": {\"alt\": true, \"top\": 244, \"left\": 505, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"e49ba1ca1df311e98de8e0d55edb21ed,d712d2d022a411e98de8e0d55edb21ed\", \"verifyModelNames\": \"重庆苏宁易购销售有限公司,华为技术有限公司\"}, \"1584096525181\": {\"alt\": true, \"top\": 366, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"6565\", \"initNum\": 2}', '56775', '2020-03-13 18:50:33', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('78d8f2c31be211ea80e1e0d55edb21ed', '48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', '{\"areas\": {}, \"lines\": {\"1576047054442\": {\"to\": \"1576047041362\", \"from\": \"1576046990996\", \"name\": \"\", \"type\": \"sl\"}, \"1576047057170\": {\"to\": \"1576047052266\", \"from\": \"1576047041362\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046990996\": {\"alt\": true, \"top\": 113, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047041362\": {\"alt\": true, \"top\": 214, \"left\": 448, \"name\": \"任务节点_17\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576047052266\": {\"alt\": true, \"top\": 336, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yiuot\", \"initNum\": 19}', 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2019-12-11 14:51:04', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('79a30dbef3d511e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '{\"areas\": {}, \"lines\": {\"1571363031721\": {\"to\": \"1571363013720\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}, \"1571643128104\": {\"to\": \"1571363025160\", \"from\": \"1571363013720\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 35, \"left\": 496, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1571363013720\": {\"alt\": true, \"top\": 153, \"left\": 439, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed,f1699be0e0f311e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧),英英(金卡智慧)\"}, \"1571363025160\": {\"alt\": true, \"top\": 457, \"left\": 480, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 5}', '金卡智慧素材审核', '2019-10-21 15:44:55', '10', null, '更新流程: 更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('7a9efd5ecd5411e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb22ed', 'TEST-06', '联智品牌测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"e30236b501a211e98a32e0d55edb21ed,1\", \"verifyModelNames\": \"傅炳彬,系统超管(平台视线)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"1,6\", \"verifyModelNames\": \"系统管理员(平台视线),销售部-商业-总监(测试机构)\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3,1\", \"verifyModelNames\": \"总经办,系统管理员(平台视线)\"}}, \"title\": \"测试品牌入库流程\", \"initNum\": 24}', '测试说明6', '2019-09-02 15:38:50', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('7b6d9df8b37411eaabbb28d244a5fdf0', 'ef8b9201892111ea8b60e0d55edb21ed', '111', '11', null, '111', '2020-06-21 12:05:00', '10', null, '删除流程', '2');
INSERT INTO `flow_design_temp` VALUES ('7cc8739ddf3f11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:57:19', '1', null, '更新流程:更新了流程设计.', '14');
INSERT INTO `flow_design_temp` VALUES ('7d7cb71edf3b11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', null, '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看看看就点', '2019-09-25 10:28:42', '1', null, '更新流程:更新了流程说明.', '7');
INSERT INTO `flow_design_temp` VALUES ('7f65fb8d731811eaba96e0d55edb21ed', '7f6129dc731811eaba96e0d55edb21ed', '009', '00', null, '99', '2020-03-31 14:26:06', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('808dfe9a650b11ea90cc00163e13e3ca', '808cf0c6650b11ea90cc00163e13e3ca', '流程编号：12345', '流程名称：123', null, '看看', '2020-03-13 17:17:45', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('80fae188076e11ea8da6e0d55edb21ed', '3d8e174c05e311ea8da6e0d55edb21ed', '111111', '测试流程', '{\"areas\": {}, \"lines\": {\"1573798141643\": {\"to\": \"1573798136359\", \"from\": \"1573798131116\", \"name\": \"\", \"type\": \"sl\"}, \"1573798250664\": {\"to\": \"1573798231721\", \"alt\": true, \"from\": \"1573798136359\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1573798131116\": {\"alt\": true, \"top\": 203, \"left\": 339, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1573798136359\": {\"alt\": true, \"top\": 222, \"left\": 507, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6e9d3d9905cc11ea8da6e0d55edb21ed\", \"verifyModelNames\": \"测试数据权限机构01\"}, \"1573798231721\": {\"alt\": true, \"top\": 253, \"left\": 772, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试流程\", \"initNum\": 2}', '111', '2019-11-15 14:10:43', '1e3c0c4b05d511ea8da6e0d55edb21ed', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('81d0f1b956e211ea90cc00163e13e3ca', '81ceaeb856e211ea90cc00163e13e3ca', '3123', '313', null, '312312', '2020-02-24 16:49:02', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('82447551ea4111e99358e0d55edb21ed', '8241c9dcea4111e99358e0d55edb21ed', 'yuidyis_782379hdkjh', '刊播审核2', null, '刊播审核djkjdkjs', '2019-10-09 11:11:26', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('8340b165797111eabd98e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', '{\"areas\": {}, \"lines\": {\"1586331866076\": {\"to\": \"1586331861860\", \"from\": \"1586331860013\", \"name\": \"\", \"type\": \"sl\"}, \"1586331867140\": {\"to\": \"1586331863772\", \"from\": \"1586331861860\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586331860013\": {\"alt\": true, \"top\": 132, \"left\": 596, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586331861860\": {\"alt\": true, \"top\": 213, \"left\": 571, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"平台视线\"}, \"1586331863772\": {\"alt\": true, \"top\": 298, \"left\": 601, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"换刊审核流程\", \"initNum\": 2}', '流程说明yy', '2020-04-08 16:18:30', '4975806e796311eaba96e0d55edb21ed', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('8369aa7b1be211ea80e1e0d55edb21ed', '48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', '{\"areas\": {}, \"lines\": {\"1576047054442\": {\"to\": \"1576047041362\", \"from\": \"1576046990996\", \"name\": \"\", \"type\": \"sl\"}, \"1576047057170\": {\"to\": \"1576047052266\", \"from\": \"1576047041362\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046990996\": {\"alt\": true, \"top\": 113, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047041362\": {\"alt\": true, \"top\": 214, \"left\": 448, \"name\": \"任务节点_17\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线)\"}, \"1576047052266\": {\"alt\": true, \"top\": 336, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yiuot\", \"initNum\": 19}', 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2019-12-11 14:51:22', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('85745d6cdf3f11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:57:33', '1', null, '更新流程:更新了流程设计.', '15');
INSERT INTO `flow_design_temp` VALUES ('858ff46856f111ea90cc00163e13e3ca', '858f39e056f111ea90cc00163e13e3ca', 'test_100002', '测试普通流程', null, '这是一条测试普通流程的数据', '2020-02-24 18:36:31', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('85f1415c1be211ea80e1e0d55edb21ed', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2019-12-11 14:51:27', '10', null, 'R流程:自动(该机构其他[普通]流程[yiuot]手动启用时将此流程自动改为停用状态)', '6');
INSERT INTO `flow_design_temp` VALUES ('8635c5d81be211ea80e1e0d55edb21ed', '48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', '{\"areas\": {}, \"lines\": {\"1576047054442\": {\"to\": \"1576047041362\", \"from\": \"1576046990996\", \"name\": \"\", \"type\": \"sl\"}, \"1576047057170\": {\"to\": \"1576047052266\", \"from\": \"1576047041362\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046990996\": {\"alt\": true, \"top\": 113, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047041362\": {\"alt\": true, \"top\": 214, \"left\": 448, \"name\": \"任务节点_17\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线)\"}, \"1576047052266\": {\"alt\": true, \"top\": 336, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yiuot\", \"initNum\": 19}', 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2019-12-11 14:51:27', '10', null, '启用流程:手动', '4');
INSERT INTO `flow_design_temp` VALUES ('872457d0df4611e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383230798\": {\"to\": \"1569383166151\", \"alt\": true, \"from\": \"1569383159079\", \"name\": \"\", \"type\": \"sl\"}, \"1569383240134\": {\"to\": \"1569383159079\", \"alt\": true, \"from\": \"1569383105855\", \"name\": \"\", \"type\": \"sl\"}, \"1569383256194\": {\"to\": \"1569383173575\", \"alt\": true, \"from\": \"1569383166151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383105855\": {\"alt\": true, \"top\": 98, \"left\": 611, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383159079\": {\"alt\": true, \"top\": 205, \"left\": 588, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569383166151\": {\"alt\": true, \"top\": 305, \"left\": 603, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569383173575\": {\"alt\": true, \"top\": 427, \"left\": 580, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 3}', '流程说明yy', '2019-09-25 11:47:43', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('87e4ef77baa411eaabbb28d244a5fdf0', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '客户审核流程06', '{\"areas\": {}, \"lines\": {\"1569463478787\": {\"to\": \"1569463470054\", \"from\": \"1569463468247\", \"name\": \"\", \"type\": \"sl\"}, \"1569463480390\": {\"to\": \"1569463471598\", \"from\": \"1569463470054\", \"name\": \"\", \"type\": \"sl\"}, \"1569468763086\": {\"to\": \"1569463475286\", \"from\": \"1569463471598\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569463468247\": {\"alt\": true, \"top\": 83, \"left\": 563, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569463470054\": {\"alt\": true, \"top\": 177, \"left\": 507, \"name\": \"经理审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569463471598\": {\"alt\": true, \"top\": 255, \"left\": 516, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569463475286\": {\"alt\": true, \"top\": 427, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"客户审核流程06\", \"initNum\": 4}', '客户审核流程', '2020-06-30 15:36:15', '10', null, '更新流程: <br/>1.更新了流程说明.<br/>2.更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('8a4e6817cd5411e99358e0d55edb21ed', '07d9ca0dc7d411e99358e0d55edb21ed', 'hylink-order-test', '平台订单测试流程', '{\"areas\": {}, \"lines\": {\"1566806821818\": {\"to\": \"1566806750875\", \"from\": \"1566806745596\", \"name\": \"\", \"type\": \"sl\"}, \"1566806822650\": {\"to\": \"1566806752675\", \"from\": \"1566806750875\", \"name\": \"\", \"type\": \"sl\"}, \"1566806823794\": {\"to\": \"1566806748916\", \"from\": \"1566806752675\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566806745596\": {\"alt\": true, \"top\": 91, \"left\": 576, \"name\": \"提交订单\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566806748916\": {\"alt\": true, \"top\": 456, \"left\": 564, \"name\": \"完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1566806750875\": {\"alt\": true, \"top\": 213, \"left\": 530, \"name\": \"业务部\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"fc14d10dc7d111e99358e0d55edb21ed,7948c1f4c7d311e99358e0d55edb21ed,b848964e18a011e99d5300163e13e3ca,9b57cf6c17dd11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营测试账号1(平台视线),平台运营测试账号2(平台视线),夏超(平台视线),刘莉莎(平台视线),系统超管(平台视线)\"}, \"1566806752675\": {\"alt\": true, \"top\": 326, \"left\": 525, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统管理员(平台视线)\"}}, \"title\": \"平台订单流程测试\", \"initNum\": 9}', '订单流程测试', '2019-09-02 15:39:16', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('8a61de25df3f11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营(平台视线),系统管理员(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"测试机构\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:57:42', '1', null, '更新流程:更新了流程设计.', '16');
INSERT INTO `flow_design_temp` VALUES ('8ad93c28797111eabd98e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', '{\"areas\": {}, \"lines\": {\"1586331866076\": {\"to\": \"1586331861860\", \"from\": \"1586331860013\", \"name\": \"\", \"type\": \"sl\"}, \"1586331867140\": {\"to\": \"1586331863772\", \"from\": \"1586331861860\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586331860013\": {\"alt\": true, \"top\": 132, \"left\": 596, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586331861860\": {\"alt\": true, \"top\": 213, \"left\": 571, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"426141796a5f11ea8f54e0d55edb21ed\", \"verifyModelNames\": \"lcd媒体商\"}, \"1586331863772\": {\"alt\": true, \"top\": 298, \"left\": 601, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"换刊审核流程\", \"initNum\": 2}', '流程说明yy', '2020-04-08 16:18:43', '4975806e796311eaba96e0d55edb21ed', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('8b6585d0c57b11e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"39f0da4701a111e98a32e0d55edb21ed\", \"verifyModelNames\": \"媒介部总监(测试机构)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"王然(测试机构),王先连(测试机构),陈伯燕(测试机构)\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"总经办人员(测试机构)\"}}, \"title\": \"测试客户入库流程1\", \"initNum\": 24}', '测试说明5aaa', '2019-08-23 15:57:05', '1', null, '更新流程:<br/>1.更新了流程设计.', '7');
INSERT INTO `flow_design_temp` VALUES ('8cce28a1df3b11e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', null, '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2019-09-25 10:29:08', '1', null, '更新流程:更新了流程说明.', '8');
INSERT INTO `flow_design_temp` VALUES ('8e5ba72c650c11ea90cc00163e13e3ca', 'ca3f57de650b11ea90cc00163e13e3ca', '1567878978777777777777777777777777777777777754654675756865856856856856856856', '14好久好看看很', null, '16', '2020-03-13 17:25:18', '10', null, '更新流程: <br/>1.更新了流程编码.<br/>2.更新了流程名称.', '2');
INSERT INTO `flow_design_temp` VALUES ('8eb70ae7f15611e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1571369415327\": {\"to\": \"1571369410987\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1571369423774\": {\"to\": \"1571369412858\", \"from\": \"1571369410987\", \"name\": \"\", \"type\": \"sl\"}, \"1571369425662\": {\"to\": \"1569570818536\", \"from\": \"1571369412858\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570818536\": {\"alt\": true, \"top\": 432, \"left\": 568, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1571369410987\": {\"alt\": true, \"top\": 209, \"left\": 557, \"name\": \"任务节点_6\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"db3188e9f15011e99358e0d55edb21ed\", \"verifyModelNames\": \"审核员(金卡智慧)\"}, \"1571369412858\": {\"alt\": true, \"top\": 320, \"left\": 569, \"name\": \"任务节点_7\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"3b1e0c01e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"管理员(金卡智慧)\"}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 8}', '金卡智慧品牌审核', '2019-10-18 11:31:01', '8b462d09e0ce11e99358e0d55edb21ed', null, '更新流程: 更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('914c97ffb8f211eaabbb28d244a5fdf0', 'a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', '{\"areas\": {}, \"lines\": {\"1568602431710\": {\"to\": \"1568602420702\", \"from\": \"1568602415511\", \"name\": \"\", \"type\": \"sl\"}, \"1568602433741\": {\"to\": \"1568602421726\", \"from\": \"1568602420702\", \"name\": \"\", \"type\": \"sl\"}, \"1568602864606\": {\"to\": \"1568602861542\", \"from\": \"1568602421726\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602415511\": {\"alt\": true, \"top\": 29, \"left\": 308, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602420702\": {\"alt\": true, \"top\": 156, \"left\": 270, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,a5133a9818a011e99d5300163e13e3ca,10\", \"verifyModelNames\": \"系统超管(平台视线),李数里(平台视线),平台管理员(平台)\"}, \"1568602421726\": {\"alt\": true, \"top\": 276, \"left\": 272, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,d7e79858c7d211e99358e0d55edb21ed\", \"verifyModelNames\": \"系统超管(平台视线),平台总经办测试账号(平台视线)\"}, \"1568602861542\": {\"alt\": true, \"top\": 412, \"left\": 305, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台客户测试流程\", \"initNum\": 12}', '测试', '2020-06-28 11:49:51', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('923fc82a650c11ea90cc00163e13e3ca', 'ca3f57de650b11ea90cc00163e13e3ca', '1567878978777777', '14好久好看看很', null, '16', '2020-03-13 17:25:25', '10', null, '更新流程: <br/>1.更新了流程编码.<br/>2.更新了流程名称.', '3');
INSERT INTO `flow_design_temp` VALUES ('94559fc2e0cf11e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', null, '金卡智慧订单审核', '2019-09-27 10:41:28', '2a03890ce0cf11e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('947efedff3c611e99358e0d55edb21ed', 'b82f954de28d11e99358e0d55edb21ed', 'jkzh_hhsh', '金卡智慧换刊审核', '{\"areas\": {}, \"lines\": {\"1569743793954\": {\"to\": \"1569743787795\", \"from\": \"1569743785891\", \"name\": \"\", \"type\": \"sl\"}, \"1571637487260\": {\"to\": \"1569743791738\", \"alt\": true, \"from\": \"1569743787795\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569743785891\": {\"alt\": true, \"top\": 84, \"left\": 559, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569743787795\": {\"alt\": true, \"top\": 155, \"left\": 559, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1569743791738\": {\"alt\": true, \"top\": 405, \"left\": 599, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧换刊审核\", \"initNum\": 4}', '金卡智慧换刊审核', '2019-10-21 13:58:17', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('966e1d10e00d11e99358e0d55edb21ed', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '测试机构客户审核流程', '{\"areas\": {}, \"lines\": {\"1569463478787\": {\"to\": \"1569463470054\", \"from\": \"1569463468247\", \"name\": \"\", \"type\": \"sl\"}, \"1569463480390\": {\"to\": \"1569463471598\", \"from\": \"1569463470054\", \"name\": \"\", \"type\": \"sl\"}, \"1569468763086\": {\"to\": \"1569463475286\", \"alt\": true, \"from\": \"1569463471598\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569463468247\": {\"alt\": true, \"top\": 83, \"left\": 563, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569463470054\": {\"alt\": true, \"top\": 177, \"left\": 507, \"name\": \"经理审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569463471598\": {\"alt\": true, \"top\": 255, \"left\": 516, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569463475286\": {\"alt\": true, \"top\": 427, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试机构客户审核流程\", \"initNum\": 4}', '金卡联智客户审核流程', '2019-09-26 11:32:45', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('96caa142643c11ea90cc00163e13e3ca', '6a1fe377643c11ea90cc00163e13e3ca', 'test-12345', '订单通用流程', '{\"areas\": {}, \"lines\": {\"1584002146566\": {\"to\": \"1584002143533\", \"from\": \"1584002129924\", \"name\": \"\", \"type\": \"sl\"}, \"1584002171378\": {\"to\": \"1584002165368\", \"from\": \"1584002143533\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584002129924\": {\"alt\": true, \"top\": 89, \"left\": 240, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584002143533\": {\"alt\": true, \"top\": 215, \"left\": 254, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584002165368\": {\"alt\": true, \"top\": 318, \"left\": 309, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单通用流程\", \"initNum\": 4}', 'fdsfdsg', '2020-03-12 16:36:38', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('972c9caab8f211eaabbb28d244a5fdf0', 'a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', '{\"areas\": {}, \"lines\": {\"1568602431710\": {\"to\": \"1568602420702\", \"from\": \"1568602415511\", \"name\": \"\", \"type\": \"sl\"}, \"1568602433741\": {\"to\": \"1568602421726\", \"from\": \"1568602420702\", \"name\": \"\", \"type\": \"sl\"}, \"1568602864606\": {\"to\": \"1568602861542\", \"from\": \"1568602421726\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602415511\": {\"alt\": true, \"top\": 29, \"left\": 308, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602420702\": {\"alt\": true, \"top\": 156, \"left\": 270, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,a5133a9818a011e99d5300163e13e3ca,10\", \"verifyModelNames\": \"系统超管(平台视线),李数里(平台视线),平台管理员(平台)\"}, \"1568602421726\": {\"alt\": true, \"top\": 276, \"left\": 272, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,d7e79858c7d211e99358e0d55edb21ed,10\", \"verifyModelNames\": \"系统超管(平台视线),平台总经办测试账号(平台视线),平台管理员(平台)\"}, \"1568602861542\": {\"alt\": true, \"top\": 412, \"left\": 305, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台客户测试流程\", \"initNum\": 12}', '测试', '2020-06-28 11:50:01', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('98773e8c651911ea90cc00163e13e3ca', '98756700651911ea90cc00163e13e3ca', 'yy123', '金卡订单通用流程', null, 'jghj', '2020-03-13 18:58:39', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('9af6012256f111ea90cc00163e13e3ca', '858f39e056f111ea90cc00163e13e3ca', 'test_100002', '测试普通流程', '{\"areas\": {}, \"lines\": {\"1582540610147\": {\"to\": \"1582540605533\", \"alt\": true, \"from\": \"1582540604036\", \"name\": \"\", \"type\": \"sl\"}, \"1582540614346\": {\"to\": \"1582540606693\", \"alt\": true, \"from\": \"1582540605533\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582540604036\": {\"alt\": true, \"top\": 126, \"left\": 202, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582540605533\": {\"alt\": true, \"top\": 194, \"left\": 524, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1582540606693\": {\"alt\": true, \"top\": 359, \"left\": 311, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}}, \"title\": \"测试普通流程\", \"initNum\": 3}', '这是一条测试普通流程的数据', '2020-02-24 18:37:07', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('9bde4785df6911e99358e0d55edb21ed', '74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569398285919\": {\"to\": \"1569398273785\", \"from\": \"1569398268355\", \"name\": \"\", \"type\": \"sl\"}, \"1569398298318\": {\"to\": \"1569398278328\", \"from\": \"1569398273785\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569398268355\": {\"alt\": true, \"top\": 96, \"left\": 519, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569398273785\": {\"alt\": true, \"top\": 189, \"left\": 505, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"6,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"汪新程(测试机构),陈伯燕(测试机构)\"}, \"1569398278328\": {\"alt\": true, \"top\": 283, \"left\": 535, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '金卡联智素材审核', '2019-09-25 15:58:51', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('9c5756eb56f211ea90cc00163e13e3ca', '9c53940a56f211ea90cc00163e13e3ca', '10002321', '测试', null, '而且我', '2020-02-24 18:44:19', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('9f4fc80c9b3e11eaaab1e0d55edb21ed', '9f4d7b779b3e11eaaab1e0d55edb21ed', '05211641', '客户审核流程', null, '流程说明123', '2020-05-21 16:41:32', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('9fb13267650211ea90cc00163e13e3ca', '1ee84810650211ea90cc00163e13e3ca', '流程编号：1234', '流程名称：123', '{\"areas\": {}, \"lines\": {\"1584087238692\": {\"to\": \"1584087229445\", \"alt\": true, \"from\": \"1584087226996\", \"name\": \"\", \"type\": \"sl\"}, \"1584087241220\": {\"to\": \"1584087235916\", \"alt\": true, \"from\": \"1584087232868\", \"name\": \"\", \"type\": \"sl\"}, \"1584087243924\": {\"to\": \"1584087232868\", \"alt\": true, \"from\": \"1584087229445\", \"name\": \"\", \"type\": \"sl\"}, \"1584087249755\": {\"to\": \"1584087247356\", \"alt\": true, \"from\": \"1584087235916\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584087226996\": {\"alt\": true, \"top\": 69, \"left\": 479, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584087229445\": {\"alt\": true, \"top\": 142, \"left\": 454, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584087232868\": {\"alt\": true, \"top\": 217, \"left\": 483, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584087235916\": {\"alt\": true, \"top\": 305, \"left\": 473, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584087247356\": {\"alt\": true, \"top\": 410, \"left\": 514, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称：123\", \"initNum\": 4}', '流程说明：123', '2020-03-13 16:14:12', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('9ffab82fc56011e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"39f0da4701a111e98a32e0d55edb21ed\", \"verifyModelNames\": \"媒介部总监(测试机构)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5aaa', '2019-08-23 12:44:22', '1', null, '更新流程:<br/>1.更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('a03227b76d6c11ea88bde0d55edb21ed', 'a02a2c206d6c11ea88bde0d55edb21ed', 'test-0324', '金卡换刊流程', null, '流程说明', '2020-03-24 09:13:36', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('a1b8f88dd82c11e99358e0d55edb21ed', 'a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', null, '测试', '2019-09-16 10:53:30', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('a1cb96ad56f211ea90cc00163e13e3ca', '9c53940a56f211ea90cc00163e13e3ca', '10002321', '测试', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"测试\", \"initNum\": 1}', '而且我', '2020-02-24 18:44:28', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('a2b33eb3e0f011e99358e0d55edb21ed', '5760e0a9e0f011e99358e0d55edb21ed', 'jkzh_崔莺莺', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569566176767\": {\"to\": \"1569566169725\", \"from\": \"1569566167630\", \"name\": \"\", \"type\": \"sl\"}, \"1569566179420\": {\"to\": \"1569566172686\", \"from\": \"1569566169725\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569566167630\": {\"alt\": true, \"top\": 113, \"left\": 560, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569566169725\": {\"alt\": true, \"top\": 183, \"left\": 533, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"3b1e0c01e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"管理员(金卡智慧)\"}, \"1569566172686\": {\"alt\": true, \"top\": 272, \"left\": 575, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 2}', '金卡智慧品牌审核', '2019-09-27 14:38:07', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('a2bb8e711be311ea80e1e0d55edb21ed', 'a2b3f6701be311ea80e1e0d55edb21ed', '5', '5435', null, '453', '2019-12-11 14:59:24', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('a3d9073d650c11ea90cc00163e13e3ca', 'ca3f57de650b11ea90cc00163e13e3ca', '1567878978777777', '14好久好看看很', '{\"areas\": {}, \"lines\": {\"1584091551177\": {\"to\": \"1584091548849\", \"alt\": true, \"from\": \"1584091547217\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584091547217\": {\"alt\": true, \"top\": 130, \"left\": 372, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584091548849\": {\"alt\": true, \"top\": 282, \"left\": 392, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"14好久好看看很\", \"initNum\": 1}', '16', '2020-03-13 17:25:54', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('a6ed53ba651a11ea90cc00163e13e3ca', 'a6ec5577651a11ea90cc00163e13e3ca', '4364', '5435', null, '64', '2020-03-13 19:06:12', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('a7b73112f15111e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', '{\"areas\": {}, \"lines\": {\"1569570734429\": {\"to\": \"1569570708079\", \"from\": \"1569570706134\", \"name\": \"\", \"type\": \"sl\"}, \"1569570821763\": {\"to\": \"1569570818536\", \"from\": \"1569570708079\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569570706134\": {\"alt\": true, \"top\": 110, \"left\": 585, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569570708079\": {\"alt\": true, \"top\": 187, \"left\": 539, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"3b1e0c01e0ce11e99358e0d55edb21ed,db3188e9f15011e99358e0d55edb21ed\", \"verifyModelNames\": \"管理员(金卡智慧),审核员(金卡智慧)\"}, \"1569570818536\": {\"alt\": true, \"top\": 289, \"left\": 583, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧品牌审核\", \"initNum\": 4}', '金卡智慧品牌审核', '2019-10-18 10:55:55', '8b462d09e0ce11e99358e0d55edb21ed', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('a91b7bc305e411ea8da6e0d55edb21ed', 'a91057aa05e411ea8da6e0d55edb21ed', 'werwer', 'sear', null, 'wer', '2019-11-13 15:11:25', '1e3c0c4b05d511ea8da6e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('a92123afea4111e99358e0d55edb21ed', '8241c9dcea4111e99358e0d55edb21ed', 'yuidyis_782379hdkjh', '刊播审核2', '{\"areas\": {}, \"lines\": {\"1570590705560\": {\"to\": \"1570590695905\", \"from\": \"1570590693833\", \"name\": \"\", \"type\": \"sl\"}, \"1570590708568\": {\"to\": \"1570590697810\", \"from\": \"1570590695905\", \"name\": \"\", \"type\": \"sl\"}, \"1570590710087\": {\"to\": \"1570590699714\", \"from\": \"1570590697810\", \"name\": \"\", \"type\": \"sl\"}, \"1570590711511\": {\"to\": \"1570590702250\", \"from\": \"1570590699714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570590693833\": {\"alt\": true, \"top\": 164, \"left\": 623, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570590695905\": {\"alt\": true, \"top\": 270, \"left\": 583, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590697810\": {\"alt\": true, \"top\": 375, \"left\": 594, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590699714\": {\"alt\": true, \"top\": 471, \"left\": 606, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590702250\": {\"alt\": true, \"top\": 580, \"left\": 647, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"刊播审核2\", \"initNum\": 4}', '刊播审核djkjdkjs', '2019-10-09 11:12:32', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('a9e862c7b44411eaabbb28d244a5fdf0', 'ef8b9201892111ea8b60e0d55edb21ed', '111', '11', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"11\", \"initNum\": 1}', '111', '2020-06-22 12:55:11', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('ac5357e0ea4111e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1569728633697\": {\"to\": \"1569728630919\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}, \"1569728641870\": {\"to\": \"1569728635742\", \"from\": \"1569728630919\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed,8b462d09e0ce11e99358e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构),柏林(金卡智慧)\"}, \"1569728630919\": {\"alt\": true, \"top\": 364, \"left\": 344, \"name\": \"任务节点_9\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569728635742\": {\"alt\": true, \"top\": 456, \"left\": 367, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 10}', 'hsdf', '2019-10-09 11:12:37', '1', null, 'R流程:自动(该机构其他[普通]流程[刊播审核2]手动启用时将此流程自动改为停用状态)', '9');
INSERT INTO `flow_design_temp` VALUES ('ac824c80ea4111e99358e0d55edb21ed', '8241c9dcea4111e99358e0d55edb21ed', 'yuidyis_782379hdkjh', '刊播审核2', '{\"areas\": {}, \"lines\": {\"1570590705560\": {\"to\": \"1570590695905\", \"from\": \"1570590693833\", \"name\": \"\", \"type\": \"sl\"}, \"1570590708568\": {\"to\": \"1570590697810\", \"from\": \"1570590695905\", \"name\": \"\", \"type\": \"sl\"}, \"1570590710087\": {\"to\": \"1570590699714\", \"from\": \"1570590697810\", \"name\": \"\", \"type\": \"sl\"}, \"1570590711511\": {\"to\": \"1570590702250\", \"from\": \"1570590699714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570590693833\": {\"alt\": true, \"top\": 164, \"left\": 623, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570590695905\": {\"alt\": true, \"top\": 270, \"left\": 583, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590697810\": {\"alt\": true, \"top\": 375, \"left\": 594, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590699714\": {\"alt\": true, \"top\": 471, \"left\": 606, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570590702250\": {\"alt\": true, \"top\": 580, \"left\": 647, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"刊播审核2\", \"initNum\": 4}', '刊播审核djkjdkjs', '2019-10-09 11:12:37', '1', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('acbac9accd5411e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播测试流程', null, 'hsdf', '2019-09-02 15:40:14', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('adcf06b8ea3e11e99358e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', null, 'sfdsf', '2019-10-09 10:51:11', '2a03890ce0cf11e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('ae89657968c211eaa6d3e0d55edb21ed', 'ae81edf468c211eaa6d3e0d55edb21ed', '1111', '刊播审核', null, 'yyyyuuuu', '2020-03-18 10:46:38', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('aeafa520b57211eaabbb28d244a5fdf0', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材审核流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 77, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台管理员(平台)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"1\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"平台\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '辉煌光环关乎健康干净的刚看了觉得分开两个节流蝶阀了的咖啡旅馆看到了刚看到了看过了的看过了的管理的分开两个东风路高考的卢浮宫个考虑到~！@#，。？仿佛回到开始孵化基地开始互粉开始对房间看电视看看就点结束', '2020-06-24 00:57:02', '10', null, '更新流程: 更新了流程设计.', '17');
INSERT INTO `flow_design_temp` VALUES ('b00910dd6d6c11ea88bde0d55edb21ed', 'a02a2c206d6c11ea88bde0d55edb21ed', 'test-0324', '金卡换刊流程', '{\"areas\": {}, \"lines\": {\"1585012429360\": {\"to\": \"1585012425225\", \"from\": \"1585012423657\", \"name\": \"\", \"type\": \"sl\"}, \"1585012430537\": {\"to\": \"1585012426792\", \"from\": \"1585012425225\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1585012423657\": {\"alt\": true, \"top\": 135, \"left\": 509, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1585012425225\": {\"alt\": true, \"top\": 216, \"left\": 495, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台普通管理(平台视线)\"}, \"1585012426792\": {\"alt\": true, \"top\": 324, \"left\": 530, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡换刊流程\", \"initNum\": 2}', '流程说明', '2020-03-24 09:14:03', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('b089dd75e26a11e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1569728633697\": {\"to\": \"1569728630919\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}, \"1569728641870\": {\"to\": \"1569728635742\", \"from\": \"1569728630919\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"系统超管(平台视线),黄浩然(测试机构)\"}, \"1569728630919\": {\"alt\": true, \"top\": 364, \"left\": 344, \"name\": \"任务节点_9\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1569728635742\": {\"alt\": true, \"top\": 456, \"left\": 367, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 10}', 'hsdf', '2019-09-29 11:44:32', '1', null, '更新流程:更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('b1c4a8f5c56011e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"39f0da4701a111e98a32e0d55edb21ed\", \"verifyModelNames\": \"媒介部总监(测试机构)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca\", \"verifyModelNames\": \"王然(测试机构)\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"总经办人员(测试机构)\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5aaa', '2019-08-23 12:44:52', '1', null, '更新流程:<br/>1.更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('b2573d3b796811eaba96e0d55edb21ed', 'b2509777796811eaba96e0d55edb21ed', 'test-0408-1515', '订单审核', null, 'dhkjshfd发开始的讲课费金石可镂福建烤老鼠解放了~！@《》？：“才好看恢复快速开发佳世客福建卡死积分开始积分开始的九分裤独守空房就代收款房价快速的积分开始经贷款方上刊房价快速的减肥可视对讲焚枯”', '2020-04-08 15:15:56', 'f7d7fea56a6d11ea8f54e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('b285a78e1be311ea80e1e0d55edb21ed', 'a2b3f6701be311ea80e1e0d55edb21ed', '5', '5435', '{\"areas\": {}, \"lines\": {\"1576047581354\": {\"to\": \"1576047577906\", \"from\": \"1576047573588\", \"name\": \"\", \"type\": \"sl\"}, \"1576047585362\": {\"to\": \"1576047575459\", \"from\": \"1576047577906\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047573588\": {\"alt\": true, \"top\": 122, \"left\": 574, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047575459\": {\"alt\": true, \"top\": 305, \"left\": 582, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047577906\": {\"alt\": true, \"top\": 226, \"left\": 555, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10,9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"平台普通管理(平台视线),刘莉莎(平台视线)\"}}, \"title\": \"5435\", \"initNum\": 2}', '453', '2019-12-11 14:59:51', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('b3fc558fe00111e99358e0d55edb21ed', '1bce8bd0dffd11e99358e0d55edb21ed', 'khsh_test_05', '测试机构客户审核流程', '{\"areas\": {}, \"lines\": {\"1569463478787\": {\"to\": \"1569463470054\", \"from\": \"1569463468247\", \"name\": \"\", \"type\": \"sl\"}, \"1569463480390\": {\"to\": \"1569463471598\", \"from\": \"1569463470054\", \"name\": \"\", \"type\": \"sl\"}, \"1569463482142\": {\"to\": \"1569463472855\", \"from\": \"1569463471598\", \"name\": \"\", \"type\": \"sl\"}, \"1569463484671\": {\"to\": \"1569463475286\", \"from\": \"1569463472855\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569463468247\": {\"alt\": true, \"top\": 83, \"left\": 563, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569463470054\": {\"alt\": true, \"top\": 177, \"left\": 507, \"name\": \"经理审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1569463471598\": {\"alt\": true, \"top\": 255, \"left\": 516, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1569463472855\": {\"alt\": true, \"top\": 330, \"left\": 509, \"name\": \"董事会审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1569463475286\": {\"alt\": true, \"top\": 427, \"left\": 539, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试机构客户审核流程\", \"initNum\": 4}', '金卡联智客户审核流程', '2019-09-26 10:07:40', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('b4816d10e0d511e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"金卡智慧订单审核\", \"initNum\": 4}', '金卡智慧订单审核', '2019-09-27 11:25:19', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('b594ddadb91311eaabbb28d244a5fdf0', '48073b281be211ea80e1e0d55edb21ed', '654hf', 'yiuot', '{\"areas\": {}, \"lines\": {\"1576047054442\": {\"to\": \"1576047041362\", \"from\": \"1576046990996\", \"name\": \"\", \"type\": \"sl\"}, \"1576047057170\": {\"to\": \"1576047052266\", \"from\": \"1576047041362\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046990996\": {\"alt\": true, \"top\": 113, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047041362\": {\"alt\": true, \"top\": 214, \"left\": 448, \"name\": \"任务节点_17\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统管理员(平台视线),平台运营(平台视线)\"}, \"1576047052266\": {\"alt\": true, \"top\": 336, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yiuot\", \"initNum\": 19}', 'fdrtgrter3453ertfvgfdsgdgdfgdfgdfgd  dfd dgdfgdf 看就看就看到顾客的', '2020-06-28 15:47:08', '10', null, 'R流程:自动(该机构其他[普通]流程[素材审核流程]手动启用时将此流程自动改为停用状态)', '5');
INSERT INTO `flow_design_temp` VALUES ('b59a454fb91311eaabbb28d244a5fdf0', '720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402571769\": {\"to\": \"1569402561857\", \"from\": \"1569402559026\", \"name\": \"\", \"type\": \"sl\"}, \"1569402576032\": {\"to\": \"1569402564714\", \"from\": \"1569402561857\", \"name\": \"\", \"type\": \"sl\"}, \"1569402578808\": {\"to\": \"1569402568002\", \"from\": \"1569402564714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402559026\": {\"alt\": true, \"top\": 33, \"left\": 541, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402561857\": {\"alt\": true, \"top\": 123, \"left\": 526, \"name\": \"技术部总监角色\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402564714\": {\"alt\": true, \"top\": 198, \"left\": 525, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402568002\": {\"alt\": true, \"top\": 299, \"left\": 569, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '金卡联智素材审核审核审核', '2020-06-28 15:47:08', '10', null, '启用流程:手动', '4');
INSERT INTO `flow_design_temp` VALUES ('b75c372ed82d11e99358e0d55edb21ed', 'a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', '{\"areas\": {}, \"lines\": {\"1568602431710\": {\"to\": \"1568602420702\", \"from\": \"1568602415511\", \"name\": \"\", \"type\": \"sl\"}, \"1568602433741\": {\"to\": \"1568602421726\", \"from\": \"1568602420702\", \"name\": \"\", \"type\": \"sl\"}, \"1568602864606\": {\"to\": \"1568602861542\", \"from\": \"1568602421726\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602415511\": {\"alt\": true, \"top\": 29, \"left\": 308, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602420702\": {\"alt\": true, \"top\": 156, \"left\": 270, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"系统超管(平台视线),李数里(平台视线)\"}, \"1568602421726\": {\"alt\": true, \"top\": 276, \"left\": 272, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,d7e79858c7d211e99358e0d55edb21ed\", \"verifyModelNames\": \"系统超管(平台视线),平台总经办测试账号(平台视线)\"}, \"1568602861542\": {\"alt\": true, \"top\": 412, \"left\": 305, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台客户测试流程\", \"initNum\": 12}', '测试', '2019-09-16 11:01:16', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('b790eee5c7d311e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材测试流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 75, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"平台运营(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"总经办人员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"newFlow_1\", \"initNum\": 9}', '顶级机构素材审核流程', '2019-08-26 15:33:51', '1', null, '更新流程:<br/>1.更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('b832ababe28d11e99358e0d55edb21ed', 'b82f954de28d11e99358e0d55edb21ed', 'jkzh_hhsh', '金卡智慧换刊审核', null, '金卡智慧换刊审核', '2019-09-29 15:55:18', 'f1699be0e0f311e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('b83a4776796611eaba96e0d55edb21ed', 'b8343d68796611eaba96e0d55edb21ed', 'test-0408-1501', '刊播审核', null, '流程说明', '2020-04-08 15:01:47', 'f7d7fea56a6d11ea8f54e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('b8702d35f3d311e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '{\"areas\": {}, \"lines\": {\"1571363031721\": {\"to\": \"1571363013720\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}, \"1571643128104\": {\"to\": \"1571363025160\", \"alt\": true, \"from\": \"1571363013720\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 35, \"left\": 496, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1571363013720\": {\"alt\": true, \"top\": 153, \"left\": 439, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1571363025160\": {\"alt\": true, \"top\": 457, \"left\": 480, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 5}', '金卡智慧素材审核', '2019-10-21 15:32:21', '10', null, '更新流程: 更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('b87d57cde0d611e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', null, '金卡智慧客户审核', '2019-09-27 11:32:35', '2a03890ce0cf11e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('b90cacac076f11ea8da6e0d55edb21ed', '3d8e174c05e311ea8da6e0d55edb21ed', '111111', '测试流程', '{\"areas\": {}, \"lines\": {\"1573798141643\": {\"to\": \"1573798136359\", \"from\": \"1573798131116\", \"name\": \"\", \"type\": \"sl\"}, \"1573798250664\": {\"to\": \"1573798231721\", \"from\": \"1573798136359\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1573798131116\": {\"alt\": true, \"top\": 203, \"left\": 339, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1573798136359\": {\"alt\": true, \"top\": 222, \"left\": 507, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"0150e83b05d511ea8da6e0d55edb21ed\", \"verifyModelNames\": \"测试角色(测试数据权限机构01)\"}, \"1573798231721\": {\"alt\": true, \"top\": 253, \"left\": 772, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试流程\", \"initNum\": 2}', '111', '2019-11-15 14:19:27', '1e3c0c4b05d511ea8da6e0d55edb21ed', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('b9aac8cd796c11eaba96e0d55edb21ed', '185553c0796c11eaba96e0d55edb21ed', 'test-0408-1540', '换刊审核流程', '{\"areas\": {}, \"lines\": {\"1586331866076\": {\"to\": \"1586331861860\", \"from\": \"1586331860013\", \"name\": \"\", \"type\": \"sl\"}, \"1586331867140\": {\"to\": \"1586331863772\", \"from\": \"1586331861860\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586331860013\": {\"alt\": true, \"top\": 132, \"left\": 596, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586331861860\": {\"alt\": true, \"top\": 213, \"left\": 571, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"87cedb6d6a6d11ea8f54e0d55edb21ed,a9edd9056d9e11ea88bde0d55edb21ed\", \"verifyModelNames\": \"系统管理员角色(lcd媒体商),管理员二级角色(lcd媒体商)\"}, \"1586331863772\": {\"alt\": true, \"top\": 298, \"left\": 601, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"换刊审核流程\", \"initNum\": 2}', '流程说明yy', '2020-04-08 15:44:46', 'bb0fcf7a796711eaba96e0d55edb21ed', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('badd86e9c55f11e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5aaa', '2019-08-23 12:37:58', '1', null, '更新流程:<br/>1.更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('bc48f391796311eaba96e0d55edb21ed', '2b9461e8796211eaba96e0d55edb21ed', 'test-0408-yy-uu11', '素材审核流程11', '{\"areas\": {}, \"lines\": {\"1586327967044\": {\"to\": \"1586327959877\", \"from\": \"1586327957532\", \"name\": \"\", \"type\": \"sl\"}, \"1586327967883\": {\"to\": \"1586327961243\", \"from\": \"1586327959877\", \"name\": \"\", \"type\": \"sl\"}, \"1586327968755\": {\"to\": \"1586327964779\", \"from\": \"1586327961243\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586327957532\": {\"alt\": true, \"top\": 75, \"left\": 468, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586327959877\": {\"alt\": true, \"top\": 169, \"left\": 469, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"4975806e796311eaba96e0d55edb21ed\", \"verifyModelNames\": \"张子凡(lcd媒体商)\"}, \"1586327961243\": {\"alt\": true, \"top\": 283, \"left\": 485, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"4975806e796311eaba96e0d55edb21ed,f7d7fea56a6d11ea8f54e0d55edb21ed\", \"verifyModelNames\": \"张子凡(lcd媒体商),lcdadmin(lcd媒体商)\"}, \"1586327964779\": {\"alt\": true, \"top\": 366, \"left\": 481, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程11\", \"initNum\": 3}', '流程说明11', '2020-04-08 14:40:25', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('bce5cd7ec56011e99358e0d55edb21ed', '5f37cbedc25411e99358e0d55edb21ed', 'TEST-05', '联智客户测试流程', '{\"areas\": {}, \"lines\": {\"demo_line_5\": {\"to\": \"demo_node_4\", \"from\": \"demo_node_3\", \"name\": \"\", \"type\": \"sl\"}, \"demo_line_6\": {\"to\": \"demo_node_3\", \"from\": \"demo_node_1\", \"name\": \"\", \"type\": \"sl\"}, \"1566289888466\": {\"to\": \"1566289883978\", \"from\": \"demo_node_4\", \"name\": \"\", \"type\": \"sl\"}, \"1566289890314\": {\"to\": \"demo_node_2\", \"from\": \"1566289883978\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"demo_node_1\": {\"alt\": true, \"top\": 37, \"left\": 464, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"demo_node_2\": {\"alt\": true, \"top\": 412, \"left\": 463, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"demo_node_3\": {\"alt\": true, \"top\": 115, \"left\": 423, \"name\": \"媒介部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"39f0da4701a111e98a32e0d55edb21ed\", \"verifyModelNames\": \"媒介部总监(测试机构)\"}, \"demo_node_4\": {\"alt\": true, \"top\": 209, \"left\": 422, \"name\": \"业务部总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"王然(测试机构),王先连(测试机构),陈伯燕(测试机构)\"}, \"1566289883978\": {\"alt\": true, \"top\": 318, \"left\": 421, \"name\": \"总经办\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"2\", \"verifyModelNames\": \"总经办人员(测试机构)\"}}, \"title\": \"测试客户入库流程\", \"initNum\": 24}', '测试说明5aaa', '2019-08-23 12:45:11', '1', null, '更新流程:<br/>1.更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('bd058732e26a11e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1569728633697\": {\"to\": \"1569728630919\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}, \"1569728641870\": {\"to\": \"1569728635742\", \"from\": \"1569728630919\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569728630919\": {\"alt\": true, \"top\": 364, \"left\": 344, \"name\": \"任务节点_9\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1569728635742\": {\"alt\": true, \"top\": 456, \"left\": 367, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 10}', 'hsdf', '2019-09-29 11:44:53', '1', null, '更新流程:更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('bd111fe1daa911e99358e0d55edb21ed', 'bd0d85cadaa911e99358e0d55edb21ed', '1111', '1111', null, '111', '2019-09-19 14:54:26', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('bd50e3e31be211ea80e1e0d55edb21ed', 'bd4be5781be211ea80e1e0d55edb21ed', 'twtew', 'rwerw', null, 'tetet', '2019-12-11 14:52:59', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('bdc5c9d6df7311e99358e0d55edb21ed', '720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402571769\": {\"to\": \"1569402561857\", \"from\": \"1569402559026\", \"name\": \"\", \"type\": \"sl\"}, \"1569402576032\": {\"to\": \"1569402564714\", \"from\": \"1569402561857\", \"name\": \"\", \"type\": \"sl\"}, \"1569402578808\": {\"to\": \"1569402568002\", \"from\": \"1569402564714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402559026\": {\"alt\": true, \"top\": 33, \"left\": 541, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402561857\": {\"alt\": true, \"top\": 123, \"left\": 526, \"name\": \"技术部总监角色\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402564714\": {\"alt\": true, \"top\": 198, \"left\": 525, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"\", \"verifyModelNames\": \"\"}, \"1569402568002\": {\"alt\": true, \"top\": 299, \"left\": 569, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '金卡联智素材审核审核审核', '2019-09-25 17:11:23', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('be347439731811eaba96e0d55edb21ed', '7f6129dc731811eaba96e0d55edb21ed', '009', '00', '{\"areas\": {}, \"lines\": {\"1585636012586\": {\"to\": \"1585635997178\", \"from\": \"1585635987544\", \"name\": \"\", \"type\": \"sl\"}, \"1585636015099\": {\"to\": \"1585636000586\", \"from\": \"1585635997178\", \"name\": \"\", \"type\": \"sl\"}, \"1585636016734\": {\"to\": \"1585636001944\", \"from\": \"1585636000586\", \"name\": \"\", \"type\": \"sl\"}, \"1585636021774\": {\"to\": \"1585636018662\", \"from\": \"1585636001944\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1585635987544\": {\"alt\": true, \"top\": 179, \"left\": 424, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1585635997178\": {\"alt\": true, \"top\": 270, \"left\": 434, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"d80f36b0c7d311e99358e0d55edb21ed\", \"verifyModelNames\": \"测试所属机构bug(平台视线)\"}, \"1585636000586\": {\"alt\": true, \"top\": 341, \"left\": 644, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"d7e79858c7d211e99358e0d55edb21ed\", \"verifyModelNames\": \"平台总经办测试账号(平台视线)\"}, \"1585636001944\": {\"alt\": true, \"top\": 364, \"left\": 518, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"b848964e18a011e99d5300163e13e3ca\", \"verifyModelNames\": \"夏超(平台视线)\"}, \"1585636018662\": {\"alt\": true, \"top\": 510, \"left\": 560, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"00\", \"initNum\": 4}', '99', '2020-03-31 14:27:51', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('be853c9598d611eaaab1e0d55edb21ed', '76eded7f98d611eaaab1e0d55edb21ed', '05181510', '刊播审核', '{\"areas\": {}, \"lines\": {\"1589785854678\": {\"to\": \"1589785840142\", \"from\": \"1589785837951\", \"name\": \"\", \"type\": \"sl\"}, \"1589785856166\": {\"to\": \"1589785841958\", \"from\": \"1589785840142\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1589785837951\": {\"alt\": true, \"top\": 66, \"left\": 370, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1589785840142\": {\"alt\": true, \"top\": 139, \"left\": 359, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"10\", \"verifyModelNames\": \"平台普通管理(平台视线)\"}, \"1589785841958\": {\"alt\": true, \"top\": 222, \"left\": 360, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"刊播审核\", \"initNum\": 2}', '流程说明123', '2020-05-18 15:12:35', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('bf93c51d643c11ea90cc00163e13e3ca', 'bf92fe8a643c11ea90cc00163e13e3ca', '54354', 'yyyyyy', null, '5hfghgh', '2020-03-12 16:37:46', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('c0983615df6911e99358e0d55edb21ed', '74034d38df6911e99358e0d55edb21ed', 'jklz_scsh', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569398285919\": {\"to\": \"1569398273785\", \"from\": \"1569398268355\", \"name\": \"\", \"type\": \"sl\"}, \"1569398298318\": {\"to\": \"1569398278328\", \"from\": \"1569398273785\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569398268355\": {\"alt\": true, \"top\": 96, \"left\": 519, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569398273785\": {\"alt\": true, \"top\": 189, \"left\": 505, \"name\": \"技术总监审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6,33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"汪新程(测试机构),陈伯燕(测试机构)\"}, \"1569398278328\": {\"alt\": true, \"top\": 283, \"left\": 535, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 2}', '金卡联智素材审核', '2019-09-25 15:59:53', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('c811e5a6651a11ea90cc00163e13e3ca', 'c810e3d8651a11ea90cc00163e13e3ca', '流程编号：123', '流程名称：123', null, '流程说明：123', '2020-03-13 19:07:08', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('c9737dbbc7d311e99358e0d55edb21ed', '163af0dac7d111e99358e0d55edb21ed', 'hylink-ad-verify', '平台素材测试流程', '{\"areas\": {}, \"lines\": {\"1566803786162\": {\"to\": \"1566803722522\", \"from\": \"1566803705111\", \"name\": \"\", \"type\": \"sl\"}, \"1566803791074\": {\"to\": \"1566803724250\", \"from\": \"1566803722522\", \"name\": \"\", \"type\": \"sl\"}, \"1566803793770\": {\"to\": \"1566803746760\", \"from\": \"1566803724250\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566803705111\": {\"alt\": true, \"top\": 75, \"left\": 399, \"name\": \"提交审核\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566803722522\": {\"alt\": true, \"top\": 211, \"left\": 359, \"name\": \"运营人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"b81c30ce17db11e99d5300163e13e3ca\", \"verifyModelNames\": \"平台运营(平台视线)\"}, \"1566803724250\": {\"alt\": true, \"top\": 330, \"left\": 359, \"name\": \"总经办人员\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyModelIds\": \"3\", \"verifyModelNames\": \"总经办人员(平台视线)\"}, \"1566803746760\": {\"alt\": true, \"top\": 457, \"left\": 399, \"name\": \"审核完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台素材审核流程\", \"initNum\": 9}', '顶级机构素材审核流程', '2019-08-26 15:34:21', '1', null, '更新流程:<br/>1.更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('ca46275b650b11ea90cc00163e13e3ca', 'ca3f57de650b11ea90cc00163e13e3ca', '15', '14', null, '16', '2020-03-13 17:19:49', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('cab576631be211ea80e1e0d55edb21ed', 'bd4be5781be211ea80e1e0d55edb21ed', 'twtew', 'rwerw', '{\"areas\": {}, \"lines\": {\"1576047201825\": {\"to\": \"1576047196602\", \"alt\": true, \"from\": \"1576047194538\", \"name\": \"\", \"type\": \"sl\"}, \"1576047202915\": {\"to\": \"1576047198738\", \"alt\": true, \"from\": \"1576047196602\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047194538\": {\"alt\": true, \"top\": 122, \"left\": 508, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047196602\": {\"alt\": true, \"top\": 214, \"left\": 482, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576047198738\": {\"alt\": true, \"top\": 310, \"left\": 518, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"rwerw\", \"initNum\": 2}', 'tetet', '2019-12-11 14:53:22', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('cc2f9ffed82d11e99358e0d55edb21ed', 'cc2ddd63d82d11e99358e0d55edb21ed', 'hytestpp', '平台品牌测试流程', null, 'sdf', '2019-09-16 11:01:51', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('cc5e1c089b3e11eaaab1e0d55edb21ed', '9f4d7b779b3e11eaaab1e0d55edb21ed', '05211641', '客户审核流程', '{\"areas\": {}, \"lines\": {\"1590050509391\": {\"to\": \"1590050507103\", \"from\": \"1590050500224\", \"name\": \"\", \"type\": \"sl\"}, \"1590050511850\": {\"to\": \"1590050504232\", \"from\": \"1590050507103\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1590050500224\": {\"alt\": true, \"top\": 143, \"left\": 562, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1590050504232\": {\"alt\": true, \"top\": 258, \"left\": 530, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1590050507103\": {\"alt\": true, \"top\": 206, \"left\": 541, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"3774e4de1deb11e99d5300163e13e3ca,7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"王然(测试机构),黄浩然(测试机构)\"}}, \"title\": \"客户审核流程\", \"initNum\": 2}', '流程说明123', '2020-05-21 16:42:48', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('cc613a14643c11ea90cc00163e13e3ca', 'bf92fe8a643c11ea90cc00163e13e3ca', '54354', 'yyyyyy', '{\"areas\": {}, \"lines\": {\"1584002278549\": {\"to\": \"1584002273808\", \"alt\": true, \"from\": \"1584002270764\", \"name\": \"\", \"type\": \"sl\"}, \"1584002285331\": {\"to\": \"1584002282443\", \"alt\": true, \"from\": \"1584002273808\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584002270764\": {\"alt\": true, \"top\": 78, \"left\": 181, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584002273808\": {\"alt\": true, \"top\": 173, \"left\": 181, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584002282443\": {\"alt\": true, \"top\": 274, \"left\": 224, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"yyyyyy\", \"initNum\": 2}', '5hfghgh', '2020-03-12 16:38:07', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('ccf1acd368c211eaa6d3e0d55edb21ed', 'ae81edf468c211eaa6d3e0d55edb21ed', '1111', '刊播审核', '{\"areas\": {}, \"lines\": {\"1584499611763\": {\"to\": \"1584499607379\", \"from\": \"1584499605147\", \"name\": \"\", \"type\": \"sl\"}, \"1584499612706\": {\"to\": \"1584499609362\", \"from\": \"1584499607379\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584499605147\": {\"alt\": true, \"top\": 141, \"left\": 628, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584499607379\": {\"alt\": true, \"top\": 229, \"left\": 617, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"f7b70ea259d611ea90cc00163e13e3ca\", \"verifyModelNames\": \"rxcjadmin(仁相科技)\"}, \"1584499609362\": {\"alt\": true, \"top\": 306, \"left\": 655, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"刊播审核\", \"initNum\": 2}', 'yyyyuuuu', '2020-03-18 10:47:29', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('cd163933796811eaba96e0d55edb21ed', 'b2509777796811eaba96e0d55edb21ed', 'test-0408-1515', '订单审核', '{\"areas\": {}, \"lines\": {\"1586330185800\": {\"to\": \"1586330168047\", \"from\": \"1586330166231\", \"name\": \"\", \"type\": \"sl\"}, \"1586330186815\": {\"to\": \"1586330169687\", \"from\": \"1586330168047\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586330166231\": {\"alt\": true, \"top\": 126, \"left\": 536, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586330168047\": {\"alt\": true, \"top\": 220, \"left\": 509, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"a9edd9056d9e11ea88bde0d55edb21ed\", \"verifyModelNames\": \"管理员二级角色(lcd媒体商)\"}, \"1586330169687\": {\"alt\": true, \"top\": 320, \"left\": 534, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核\", \"initNum\": 2}', 'dhkjshfd发开始的讲课费金石可镂福建烤老鼠解放了~！@《》？：“才好看恢复快速开发佳世客福建卡死积分开始积分开始的九分裤独守空房就代收款房价快速的积分开始经贷款方上刊房价快速的减肥可视对讲焚枯”', '2020-04-08 15:16:41', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('cd1ed53c56ee11ea90cc00163e13e3ca', '589dba4756ee11ea90cc00163e13e3ca', 'test_100001', '测试通用流程', '{\"areas\": {}, \"lines\": {}, \"nodes\": {\"1582539410084\": {\"alt\": true, \"top\": 110, \"left\": 246, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试通用流程\", \"initNum\": 1}', '这是测试通用流程', '2020-02-24 18:17:02', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('ce469e261be111ea80e1e0d55edb21ed', 'ce3cd5a41be111ea80e1e0d55edb21ed', 't1252163fd', 't11', null, '3342vdgvd过度大范甘迪过度的的过度', '2019-12-11 14:46:18', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('cee8996056f211ea90cc00163e13e3ca', 'cee793fa56f211ea90cc00163e13e3ca', 'test_100003', '测试普通流程', null, '测试数据', '2020-02-24 18:45:43', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('d05f0590e0d611e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', '{\"areas\": {}, \"lines\": {\"1569555169175\": {\"to\": \"1569555163040\", \"from\": \"1569555161257\", \"name\": \"\", \"type\": \"sl\"}, \"1569555170990\": {\"to\": \"1569555165959\", \"from\": \"1569555163040\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569555161257\": {\"alt\": true, \"top\": 116, \"left\": 608, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569555163040\": {\"alt\": true, \"top\": 207, \"left\": 563, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569555165959\": {\"alt\": true, \"top\": 321, \"left\": 609, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"客户审核\", \"initNum\": 2}', '金卡智慧客户审核', '2019-09-27 11:33:15', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('d0c7ddf8651a11ea90cc00163e13e3ca', 'c810e3d8651a11ea90cc00163e13e3ca', '流程编号：123', '流程名称：123', '{\"areas\": {}, \"lines\": {\"1584097640126\": {\"to\": \"1584097634781\", \"alt\": true, \"from\": \"1584097633125\", \"name\": \"\", \"type\": \"sl\"}, \"1584097641406\": {\"to\": \"1584097636277\", \"alt\": true, \"from\": \"1584097634781\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1584097633125\": {\"alt\": true, \"top\": 85, \"left\": 481, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1584097634781\": {\"alt\": true, \"top\": 214, \"left\": 432, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1584097636277\": {\"alt\": true, \"top\": 351, \"left\": 547, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称：123\", \"initNum\": 2}', '流程说明：123', '2020-03-13 19:07:23', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('d11790f9651d11ea90cc00163e13e3ca', 'd116cd3d651d11ea90cc00163e13e3ca', '756', '765', null, '个头发恢复', '2020-03-13 19:28:52', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('d3404943e27f11e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1569728633697\": {\"to\": \"1569728630919\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}, \"1569728641870\": {\"to\": \"1569728635742\", \"from\": \"1569728630919\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"刘莉莎(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"7735b100673611e99ec7e0d55edb21ed\", \"verifyModelNames\": \"黄浩然(测试机构)\"}, \"1569728630919\": {\"alt\": true, \"top\": 364, \"left\": 344, \"name\": \"任务节点_9\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569728635742\": {\"alt\": true, \"top\": 456, \"left\": 367, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 10}', 'hsdf', '2019-09-29 14:15:50', '9b57cf6c17dd11e99d5300163e13e3ca', null, '更新流程:更新了流程设计.', '7');
INSERT INTO `flow_design_temp` VALUES ('d37dd9a9df7311e99358e0d55edb21ed', '720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402571769\": {\"to\": \"1569402561857\", \"from\": \"1569402559026\", \"name\": \"\", \"type\": \"sl\"}, \"1569402576032\": {\"to\": \"1569402564714\", \"from\": \"1569402561857\", \"name\": \"\", \"type\": \"sl\"}, \"1569402578808\": {\"to\": \"1569402568002\", \"from\": \"1569402564714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402559026\": {\"alt\": true, \"top\": 33, \"left\": 541, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402561857\": {\"alt\": true, \"top\": 123, \"left\": 526, \"name\": \"技术部总监角色\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402564714\": {\"alt\": true, \"top\": 198, \"left\": 525, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402568002\": {\"alt\": true, \"top\": 299, \"left\": 569, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '金卡联智素材审核审核审核', '2019-09-25 17:12:00', '33341ee4760d11e9ba07e0d55edb21ed', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('d39d897456f211ea90cc00163e13e3ca', 'cee793fa56f211ea90cc00163e13e3ca', 'test_100003', '测试普通流程', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"测试普通流程\", \"initNum\": 1}', '测试数据', '2020-02-24 18:45:51', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('d48d0a05ffb411e98da6e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', '{\"areas\": {}, \"lines\": {\"1570589522057\": {\"to\": \"1570589480697\", \"from\": \"1570589478490\", \"name\": \"\", \"type\": \"sl\"}, \"1571644620889\": {\"to\": \"1570589532931\", \"from\": \"1570589480697\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570589478490\": {\"alt\": true, \"top\": 63, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570589480697\": {\"alt\": true, \"top\": 188, \"left\": 471, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589532931\": {\"alt\": true, \"top\": 556, \"left\": 512, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核2\", \"initNum\": 4}', 'sfdsf', '2019-11-05 18:13:13', '10', null, '更新流程: 更新了流程设计.', '6');
INSERT INTO `flow_design_temp` VALUES ('d51b17a7796811eaba96e0d55edb21ed', 'b2509777796811eaba96e0d55edb21ed', 'test-0408-1515', '订单审核', null, '控件', '2020-04-08 15:16:54', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程说明.', '3');
INSERT INTO `flow_design_temp` VALUES ('d7151e321be211ea80e1e0d55edb21ed', 'bd4be5781be211ea80e1e0d55edb21ed', 'twtew', 'rwerw', '{\"areas\": {}, \"lines\": {\"1576047201825\": {\"to\": \"1576047196602\", \"from\": \"1576047194538\", \"name\": \"\", \"type\": \"sl\"}, \"1576047202915\": {\"to\": \"1576047198738\", \"from\": \"1576047196602\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047194538\": {\"alt\": true, \"top\": 122, \"left\": 508, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047196602\": {\"alt\": true, \"top\": 214, \"left\": 482, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"6082710b46c911e986f0e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed\", \"verifyModelNames\": \"testxie(平台视线),平台运营测试账号1(平台视线)\"}, \"1576047198738\": {\"alt\": true, \"top\": 310, \"left\": 518, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"rwerw\", \"initNum\": 2}', 'tetet', '2019-12-11 14:53:43', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('d7c9256ecd5411e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播测试流程', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1567410047241\": {\"to\": \"1567410040073\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410040073\": {\"alt\": true, \"top\": 363, \"left\": 355, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程\", \"initNum\": 9}', 'hsdf', '2019-09-02 15:41:26', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('d89234c3f14711e99358e0d55edb21ed', '0cdea1e8e0eb11e99358e0d55edb21ed', 'test_scsh_01', '素材审核', '{\"areas\": {}, \"lines\": {\"1571363031721\": {\"to\": \"1571363013720\", \"from\": \"1569563894808\", \"name\": \"\", \"type\": \"sl\"}, \"1571363033470\": {\"to\": \"1571363018710\", \"from\": \"1571363013720\", \"name\": \"\", \"type\": \"sl\"}, \"1571363034943\": {\"to\": \"1571363021104\", \"from\": \"1571363018710\", \"name\": \"\", \"type\": \"sl\"}, \"1571363036179\": {\"to\": \"1571363025160\", \"from\": \"1571363021104\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569563894808\": {\"alt\": true, \"top\": 35, \"left\": 496, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1571363013720\": {\"alt\": true, \"top\": 153, \"left\": 439, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1571363018710\": {\"alt\": true, \"top\": 267, \"left\": 455, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"f1699be0e0f311e99358e0d55edb21ed\", \"verifyModelNames\": \"英英(金卡智慧)\"}, \"1571363021104\": {\"alt\": true, \"top\": 378, \"left\": 448, \"name\": \"任务节点_4\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1571363025160\": {\"alt\": true, \"top\": 457, \"left\": 480, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 5}', '金卡智慧素材审核', '2019-10-18 09:45:42', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('da567701df5c11e99358e0d55edb21ed', 'bd0d85cadaa911e99358e0d55edb21ed', '1111', '1111', '{\"areas\": {}, \"lines\": {}, \"nodes\": {}, \"title\": \"1111\", \"initNum\": 1}', '111', '2019-09-25 14:27:32', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('dbc0966456ee11ea90cc00163e13e3ca', '81ceaeb856e211ea90cc00163e13e3ca', '3123', '测试流程', '{\"areas\": {}, \"lines\": {}, \"nodes\": {\"1582539434908\": {\"alt\": true, \"top\": 152, \"left\": 338, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试流程\", \"initNum\": 1}', '312312', '2020-02-24 18:17:27', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('dc2316b1df4611e99358e0d55edb21ed', '5d96ea4adf4511e99358e0d55edb21ed', '流程编码yy', '流程名称yy', '{\"areas\": {}, \"lines\": {\"1569383230798\": {\"to\": \"1569383166151\", \"from\": \"1569383159079\", \"name\": \"\", \"type\": \"sl\"}, \"1569383240134\": {\"to\": \"1569383159079\", \"from\": \"1569383105855\", \"name\": \"\", \"type\": \"sl\"}, \"1569383256194\": {\"to\": \"1569383173575\", \"from\": \"1569383166151\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569383105855\": {\"alt\": true, \"top\": 98, \"left\": 611, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569383159079\": {\"alt\": true, \"top\": 205, \"left\": 588, \"name\": \"技术总监\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"2,3,4,5,e30236b501a211e98a32e0d55edb21ed,6,3774e4de1deb11e99d5300163e13e3ca,4e27613e1deb11e99d5300163e13e3ca,71bcd53e40b611e986f0e0d55edb21ed,7735b100673611e99ec7e0d55edb21ed,9b57cf6c17dd11e99d5300163e13e3ca,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"廖伟(测试机构),浦童侣(测试机构),包超(测试机构),周琳果(测试机构),傅炳彬(测试机构),汪新程(测试机构),王然(测试机构),王先连(测试机构),test12345(测试机构),黄浩然(测试机构),刘莉莎(平台视线),李数里(平台视线)\"}, \"1569383166151\": {\"alt\": true, \"top\": 305, \"left\": 603, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1569383173575\": {\"alt\": true, \"top\": 427, \"left\": 580, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"流程名称yy\", \"initNum\": 3}', '流程说明yy', '2019-09-25 11:50:05', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('dd8d7e61651d11ea90cc00163e13e3ca', 'dd8ca461651d11ea90cc00163e13e3ca', '676', '7657', null, '图一，', '2020-03-13 19:29:13', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('e33c337eea3e11e99358e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', '{\"areas\": {}, \"lines\": {\"1570589522057\": {\"to\": \"1570589480697\", \"from\": \"1570589478490\", \"name\": \"\", \"type\": \"sl\"}, \"1570589526305\": {\"to\": \"1570589482513\", \"from\": \"1570589480697\", \"name\": \"\", \"type\": \"sl\"}, \"1570589528074\": {\"to\": \"1570589500659\", \"from\": \"1570589482513\", \"name\": \"\", \"type\": \"sl\"}, \"1570589538212\": {\"to\": \"1570589532931\", \"from\": \"1570589500659\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570589478490\": {\"alt\": true, \"top\": 63, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570589480697\": {\"alt\": true, \"top\": 188, \"left\": 471, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589482513\": {\"alt\": true, \"top\": 309, \"left\": 469, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589500659\": {\"alt\": true, \"top\": 408, \"left\": 473, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589532931\": {\"alt\": true, \"top\": 556, \"left\": 512, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核2\", \"initNum\": 4}', 'sfdsf', '2019-10-09 10:52:40', '2a03890ce0cf11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('e507e38f1be111ea80e1e0d55edb21ed', 'ce3cd5a41be111ea80e1e0d55edb21ed', 't1252163fd', 't11', '{\"areas\": {}, \"lines\": {\"1576046812516\": {\"to\": \"1576046806139\", \"alt\": true, \"from\": \"1576046788292\", \"name\": \"\", \"type\": \"sl\"}, \"1576046814900\": {\"to\": \"1576046807932\", \"alt\": true, \"from\": \"1576046806139\", \"name\": \"\", \"type\": \"sl\"}, \"1576046816235\": {\"to\": \"1576046810036\", \"alt\": true, \"from\": \"1576046807932\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046788292\": {\"alt\": true, \"top\": 84, \"left\": 377, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576046806139\": {\"alt\": true, \"top\": 182, \"left\": 389, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576046807932\": {\"alt\": true, \"top\": 284, \"left\": 385, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576046810036\": {\"alt\": true, \"top\": 414, \"left\": 382, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"t11\", \"initNum\": 3}', '3342vdgvd过度大范甘迪过度的的过度', '2019-12-11 14:46:56', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('e690478c797711eabd98e0d55edb21ed', 'e68b5a26797711eabd98e0d55edb21ed', '1704', 'rxb-定制', null, '没开门', '2020-04-08 17:04:14', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('e6e5082d1be211ea80e1e0d55edb21ed', 'e6dca9481be211ea80e1e0d55edb21ed', '3', '4234', null, '43', '2019-12-11 14:54:09', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('e741ade7e0fa11e99358e0d55edb21ed', 'e73f90e8e0fa11e99358e0d55edb21ed', 'test_yuyu', '金卡智慧品牌审核', null, '金卡智慧品牌审核', '2019-09-27 15:51:37', 'f1699be0e0f311e99358e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('e7610a80f14d11e99358e0d55edb21ed', 'b87c41dde0d611e99358e0d55edb21ed', 'khsh--test', '客户审核', '{\"areas\": {}, \"lines\": {\"1571365731366\": {\"to\": \"1571365728793\", \"from\": \"1569555161257\", \"name\": \"\", \"type\": \"sl\"}, \"1571365732367\": {\"to\": \"1569555165959\", \"from\": \"1571365728793\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569555161257\": {\"alt\": true, \"top\": 116, \"left\": 608, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569555165959\": {\"alt\": true, \"top\": 321, \"left\": 609, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1571365728793\": {\"alt\": true, \"top\": 204, \"left\": 594, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}}, \"title\": \"客户审核\", \"initNum\": 3}', '金卡智慧客户审核', '2019-10-18 10:29:04', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('e7782a4cea3e11e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', '{\"areas\": {}, \"lines\": {\"1569573254343\": {\"to\": \"1569573247867\", \"from\": \"1569573245940\", \"name\": \"\", \"type\": \"sl\"}, \"1569573255518\": {\"to\": \"1569573249627\", \"from\": \"1569573247867\", \"name\": \"\", \"type\": \"sl\"}, \"1569573257070\": {\"to\": \"1569573251718\", \"from\": \"1569573249627\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569573245940\": {\"alt\": true, \"top\": 95, \"left\": 518, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569573247867\": {\"alt\": true, \"top\": 175, \"left\": 478, \"name\": \"任务节点_4\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,f1699be0e0f311e99358e0d55edb21ed,3774e4de1deb11e99d5300163e13e3ca\", \"verifyModelNames\": \"柏林(金卡智慧),英英(金卡智慧),王然(测试机构)\"}, \"1569573249627\": {\"alt\": true, \"top\": 260, \"left\": 484, \"name\": \"任务节点_5\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569573251718\": {\"alt\": true, \"top\": 349, \"left\": 536, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧订单审核\", \"initNum\": 6}', '金卡智慧订单审核', '2019-10-09 10:52:48', '2a03890ce0cf11e99358e0d55edb21ed', null, 'R流程:自动(该机构其他[普通]流程[订单审核2]手动启用时将此流程自动改为停用状态)', '6');
INSERT INTO `flow_design_temp` VALUES ('e7934a5dea3e11e99358e0d55edb21ed', 'adcc7d92ea3e11e99358e0d55edb21ed', 'tryu_dingdan', '订单审核2', '{\"areas\": {}, \"lines\": {\"1570589522057\": {\"to\": \"1570589480697\", \"from\": \"1570589478490\", \"name\": \"\", \"type\": \"sl\"}, \"1570589526305\": {\"to\": \"1570589482513\", \"from\": \"1570589480697\", \"name\": \"\", \"type\": \"sl\"}, \"1570589528074\": {\"to\": \"1570589500659\", \"from\": \"1570589482513\", \"name\": \"\", \"type\": \"sl\"}, \"1570589538212\": {\"to\": \"1570589532931\", \"from\": \"1570589500659\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1570589478490\": {\"alt\": true, \"top\": 63, \"left\": 502, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1570589480697\": {\"alt\": true, \"top\": 188, \"left\": 471, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589482513\": {\"alt\": true, \"top\": 309, \"left\": 469, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589500659\": {\"alt\": true, \"top\": 408, \"left\": 473, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1570589532931\": {\"alt\": true, \"top\": 556, \"left\": 512, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"订单审核2\", \"initNum\": 4}', 'sfdsf', '2019-10-09 10:52:48', '2a03890ce0cf11e99358e0d55edb21ed', null, '启用流程:手动', '3');
INSERT INTO `flow_design_temp` VALUES ('ea948a2156f211ea90cc00163e13e3ca', 'cee793fa56f211ea90cc00163e13e3ca', 'test_100003', '测试普通流程', '{\"areas\": {}, \"lines\": {\"1582541177599\": {\"to\": \"1582541174640\", \"alt\": true, \"from\": \"1582541173342\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582541173342\": {\"alt\": true, \"top\": 139, \"left\": 242, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582541174640\": {\"alt\": true, \"top\": 257, \"left\": 432, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"测试普通流程\", \"initNum\": 1}', '测试数据', '2020-02-24 18:46:30', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('eb05492c651c11ea90cc00163e13e3ca', 'eb04436d651c11ea90cc00163e13e3ca', '123', 'yy', null, 'grdfg', '2020-03-13 19:22:26', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('ebb2818a651d11ea90cc00163e13e3ca', 'ebb199cf651d11ea90cc00163e13e3ca', '羊肉汤', '依然有人', null, 'y', '2020-03-13 19:29:36', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('ebe31e72d82c11e99358e0d55edb21ed', 'a1b66715d82c11e99358e0d55edb21ed', 'testhykehu', '平台客户测试流程', '{\"areas\": {}, \"lines\": {\"1568602431710\": {\"to\": \"1568602420702\", \"from\": \"1568602415511\", \"name\": \"\", \"type\": \"sl\"}, \"1568602433741\": {\"to\": \"1568602421726\", \"from\": \"1568602420702\", \"name\": \"\", \"type\": \"sl\"}, \"1568602435189\": {\"to\": \"1568602418142\", \"from\": \"1568602421726\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602415511\": {\"alt\": true, \"top\": 29, \"left\": 308, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602418142\": {\"alt\": true, \"top\": 445, \"left\": 306, \"name\": \"结束\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602420702\": {\"alt\": true, \"top\": 156, \"left\": 270, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1,a5133a9818a011e99d5300163e13e3ca\", \"verifyModelNames\": \"系统超管(平台视线),李数里(平台视线)\"}, \"1568602421726\": {\"alt\": true, \"top\": 276, \"left\": 272, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,d7e79858c7d211e99358e0d55edb21ed\", \"verifyModelNames\": \"系统超管(平台视线),平台总经办测试账号(平台视线)\"}}, \"title\": \"平台客户测试流程\", \"initNum\": 9}', '测试', '2019-09-16 10:55:34', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('ebfb2806cd5411e99358e0d55edb21ed', 'ebf9e424cd5411e99358e0d55edb21ed', 'hylink-orde-change-test', '平台换刊测试流程', null, 'c', '2019-09-02 15:42:00', '1', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('ec58adc7ea3811e99358e0d55edb21ed', 'b82f954de28d11e99358e0d55edb21ed', 'jkzh_hhsh', '金卡智慧换刊审核', '{\"areas\": {}, \"lines\": {\"1569743793954\": {\"to\": \"1569743787795\", \"from\": \"1569743785891\", \"name\": \"\", \"type\": \"sl\"}, \"1569743796137\": {\"to\": \"1569743789459\", \"from\": \"1569743787795\", \"name\": \"\", \"type\": \"sl\"}, \"1570586927346\": {\"to\": \"1570586919022\", \"from\": \"1569743789459\", \"name\": \"\", \"type\": \"sl\"}, \"1570586930590\": {\"to\": \"1569743791738\", \"from\": \"1570586919022\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569743785891\": {\"alt\": true, \"top\": 84, \"left\": 559, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569743787795\": {\"alt\": true, \"top\": 155, \"left\": 559, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1569743789459\": {\"alt\": true, \"top\": 239, \"left\": 548, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}, \"1569743791738\": {\"alt\": true, \"top\": 405, \"left\": 599, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1570586919022\": {\"alt\": true, \"top\": 294, \"left\": 583, \"name\": \"任务节点_3\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"2a03890ce0cf11e99358e0d55edb21ed\", \"verifyModelNames\": \"小艳(金卡智慧)\"}}, \"title\": \"金卡智慧换刊审核\", \"initNum\": 4}', '金卡智慧换刊审核', '2019-10-09 10:09:59', '8b462d09e0ce11e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('edcc2689df4311e99358e0d55edb21ed', 'acb59fa7cd5411e99358e0d55edb21ed', 'hylink-order-play-test', '平台刊播流程11111111111111', '{\"areas\": {}, \"lines\": {\"1567410043385\": {\"to\": \"1567410036489\", \"from\": \"1567410033922\", \"name\": \"\", \"type\": \"sl\"}, \"1567410046113\": {\"to\": \"1567410037905\", \"from\": \"1567410036489\", \"name\": \"\", \"type\": \"sl\"}, \"1567410047241\": {\"to\": \"1567410040073\", \"from\": \"1567410037905\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1567410033922\": {\"alt\": true, \"top\": 76, \"left\": 354, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1567410036489\": {\"alt\": true, \"top\": 179, \"left\": 337, \"name\": \"业务部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410037905\": {\"alt\": true, \"top\": 265, \"left\": 332, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"1\", \"verifyModelNames\": \"系统超管(平台视线)\"}, \"1567410040073\": {\"alt\": true, \"top\": 363, \"left\": 355, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"平台刊播流程11111111111111\", \"initNum\": 9}', 'hsdf', '2019-09-25 11:29:06', '1', null, '更新流程:更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('eee10d52f3ad11e99358e0d55edb21ed', '07d9ca0dc7d411e99358e0d55edb21ed', 'hylink-order-test', '平台订单流程测试', '{\"areas\": {}, \"lines\": {\"1566806821818\": {\"to\": \"1566806750875\", \"from\": \"1566806745596\", \"name\": \"\", \"type\": \"sl\"}, \"1571626904720\": {\"to\": \"1566806748916\", \"alt\": true, \"from\": \"1566806750875\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1566806745596\": {\"alt\": true, \"top\": 91, \"left\": 576, \"name\": \"提交订单\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1566806748916\": {\"alt\": true, \"top\": 456, \"left\": 564, \"name\": \"完成\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1566806750875\": {\"alt\": true, \"top\": 213, \"left\": 530, \"name\": \"业务部\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"fc14d10dc7d111e99358e0d55edb21ed,7948c1f4c7d311e99358e0d55edb21ed,b848964e18a011e99d5300163e13e3ca,9b57cf6c17dd11e99d5300163e13e3ca,1\", \"verifyModelNames\": \"平台运营测试账号1(平台视线),平台运营测试账号2(平台视线),夏超(平台视线),刘莉莎(平台视线),系统超管(平台视线)\"}}, \"title\": \"平台订单流程测试\", \"initNum\": 9}', '订单流程测试', '2019-10-21 11:01:50', '10', null, '更新流程: 更新了流程设计.', '4');
INSERT INTO `flow_design_temp` VALUES ('ef8f4ea7892111ea8b60e0d55edb21ed', 'ef8b9201892111ea8b60e0d55edb21ed', '111', '11', null, '111', '2020-04-28 15:29:29', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('f13b1e961be211ea80e1e0d55edb21ed', 'e6dca9481be211ea80e1e0d55edb21ed', '3', '4234', '{\"areas\": {}, \"lines\": {\"1576047265675\": {\"to\": \"1576047258099\", \"alt\": true, \"from\": \"1576047255531\", \"name\": \"\", \"type\": \"sl\"}, \"1576047266843\": {\"to\": \"1576047262563\", \"alt\": true, \"from\": \"1576047258099\", \"name\": \"\", \"type\": \"sl\"}, \"1576047267836\": {\"to\": \"1576047260139\", \"alt\": true, \"from\": \"1576047262563\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576047255531\": {\"alt\": true, \"top\": 124, \"left\": 479, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576047258099\": {\"alt\": true, \"top\": 212, \"left\": 465, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576047260139\": {\"alt\": true, \"top\": 341, \"left\": 502, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1576047262563\": {\"alt\": true, \"top\": 294, \"left\": 483, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}}, \"title\": \"4234\", \"initNum\": 3}', '43', '2019-12-11 14:54:26', '10', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('f1fabb19df7311e99358e0d55edb21ed', 'f1f92c0fdf7311e99358e0d55edb21ed', 'scsh_yyy', '素材审核流程', null, '素材审核流程djklsj', '2019-09-25 17:12:51', '33341ee4760d11e9ba07e0d55edb21ed', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('f29a68eb1be111ea80e1e0d55edb21ed', 'ce3cd5a41be111ea80e1e0d55edb21ed', 't1252163fd', 't11', '{\"areas\": {}, \"lines\": {\"1576046812516\": {\"to\": \"1576046806139\", \"from\": \"1576046788292\", \"name\": \"\", \"type\": \"sl\"}, \"1576046814900\": {\"to\": \"1576046807932\", \"from\": \"1576046806139\", \"name\": \"\", \"type\": \"sl\"}, \"1576046816235\": {\"to\": \"1576046810036\", \"from\": \"1576046807932\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1576046788292\": {\"alt\": true, \"top\": 84, \"left\": 377, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1576046806139\": {\"alt\": true, \"top\": 182, \"left\": 389, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576046807932\": {\"alt\": true, \"top\": 284, \"left\": 385, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26}, \"1576046810036\": {\"alt\": true, \"top\": 414, \"left\": 382, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"t11\", \"initNum\": 3}', '3342vdgvd过度大范甘迪过度的的过度', '2019-12-11 14:47:19', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('f69efa9f56ef11ea90cc00163e13e3ca', '81ceaeb856e211ea90cc00163e13e3ca', '3123', '测试流程', '{\"areas\": {}, \"lines\": {\"1582539908755\": {\"to\": \"1582539904958\", \"alt\": true, \"from\": \"1582539434908\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1582539434908\": {\"alt\": true, \"top\": 152, \"left\": 338, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1582539904958\": {\"alt\": true, \"top\": 233, \"left\": 516, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26}}, \"title\": \"测试流程\", \"initNum\": 2}', '312312', '2020-02-24 18:25:22', '10', null, '更新流程: 更新了流程设计.', '3');
INSERT INTO `flow_design_temp` VALUES ('f75522a8d82d11e99358e0d55edb21ed', 'cc2ddd63d82d11e99358e0d55edb21ed', 'hytestpp', '平台品牌测试流程', '{\"areas\": {}, \"lines\": {\"1568602927486\": {\"to\": \"1568602917382\", \"from\": \"1568602913358\", \"name\": \"\", \"type\": \"sl\"}, \"1568602928661\": {\"to\": \"1568602918046\", \"from\": \"1568602917382\", \"name\": \"\", \"type\": \"sl\"}, \"1568602929829\": {\"to\": \"1568602915806\", \"from\": \"1568602918046\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602913358\": {\"alt\": true, \"top\": 79, \"left\": 532, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602915806\": {\"alt\": true, \"top\": 522, \"left\": 530, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1568602917382\": {\"alt\": true, \"top\": 218, \"left\": 502, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统超管(平台视线),刘莉莎(平台视线)\"}, \"1568602918046\": {\"alt\": true, \"top\": 367, \"left\": 496, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"d7e79858c7d211e99358e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed\", \"verifyModelNames\": \"平台总经办测试账号(平台视线),平台运营测试账号1(平台视线)\"}}, \"title\": \"平台品牌测试流程\", \"initNum\": 9}', 'sdf', '2019-09-16 11:03:03', '1', null, '更新流程:更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('f7e4d44af17411e99358e0d55edb21ed', 'f7dec02ff17411e99358e0d55edb21ed', '54654', '4545', null, '654656', '2019-10-18 15:08:43', '10', '0', '创建流程', '1');
INSERT INTO `flow_design_temp` VALUES ('fa6b57ccb9ae11eaabbb28d244a5fdf0', '720c0684df7311e99358e0d55edb21ed', 'sushlc', '素材审核流程', '{\"areas\": {}, \"lines\": {\"1569402571769\": {\"to\": \"1569402561857\", \"from\": \"1569402559026\", \"name\": \"\", \"type\": \"sl\"}, \"1569402576032\": {\"to\": \"1569402564714\", \"from\": \"1569402561857\", \"name\": \"\", \"type\": \"sl\"}, \"1569402578808\": {\"to\": \"1569402568002\", \"from\": \"1569402564714\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402559026\": {\"alt\": true, \"top\": 33, \"left\": 541, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402561857\": {\"alt\": true, \"top\": 123, \"left\": 526, \"name\": \"技术部总监角色\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402564714\": {\"alt\": true, \"top\": 198, \"left\": 525, \"name\": \"cc审核通过\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402568002\": {\"alt\": true, \"top\": 299, \"left\": 569, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核流程\", \"initNum\": 3}', '金卡联智素材审核审核审核', '2020-06-29 10:18:33', '10', null, 'R流程:自动(该机构其他[普通]流程[素材审核]手动启用时将此流程自动改为停用状态)', '5');
INSERT INTO `flow_design_temp` VALUES ('fa717248b9ae11eaabbb28d244a5fdf0', '30ed1276df7411e99358e0d55edb21ed', 'ttttt', '素材审核', '{\"areas\": {}, \"lines\": {\"1569402887384\": {\"to\": \"1569402881185\", \"from\": \"1569402879426\", \"name\": \"\", \"type\": \"sl\"}, \"1569402888785\": {\"to\": \"1569402882753\", \"from\": \"1569402881185\", \"name\": \"\", \"type\": \"sl\"}, \"1569402890600\": {\"to\": \"1569402884833\", \"from\": \"1569402882753\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569402879426\": {\"alt\": true, \"top\": 60, \"left\": 522, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569402881185\": {\"alt\": true, \"top\": 149, \"left\": 500, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"33341ee4760d11e9ba07e0d55edb21ed\", \"verifyModelNames\": \"陈伯燕(测试机构)\"}, \"1569402882753\": {\"alt\": true, \"top\": 225, \"left\": 510, \"name\": \"任务节点_2\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569402884833\": {\"alt\": true, \"top\": 314, \"left\": 554, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"素材审核\", \"initNum\": 3}', '素材审核', '2020-06-29 10:18:33', '10', null, '启用流程:手动', '7');
INSERT INTO `flow_design_temp` VALUES ('fdd5ced6796611eaba96e0d55edb21ed', 'b8343d68796611eaba96e0d55edb21ed', 'test-0408-1501', '刊播审核', '{\"areas\": {}, \"lines\": {\"1586329324857\": {\"to\": \"1586329320337\", \"from\": \"1586329318722\", \"name\": \"\", \"type\": \"sl\"}, \"1586329325898\": {\"to\": \"1586329322450\", \"from\": \"1586329320337\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1586329318722\": {\"alt\": true, \"top\": 95, \"left\": 506, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1586329320337\": {\"alt\": true, \"top\": 198, \"left\": 428, \"name\": \"任务节点_1\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"f7d7fea56a6d11ea8f54e0d55edb21ed,4975806e796311eaba96e0d55edb21ed\", \"verifyModelNames\": \"lcdadmin(lcd媒体商),张子凡(lcd媒体商)\"}, \"1586329322450\": {\"alt\": true, \"top\": 321, \"left\": 479, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"刊播审核\", \"initNum\": 2}', '流程说明', '2020-04-08 15:03:44', 'f7d7fea56a6d11ea8f54e0d55edb21ed', null, '更新流程: 更新了流程设计.', '2');
INSERT INTO `flow_design_temp` VALUES ('fe8469bee10111e99358e0d55edb21ed', '9452865ee0cf11e99358e0d55edb21ed', 'jin_ka_zhi_hui', '金卡智慧订单审核', '{\"areas\": {}, \"lines\": {\"1569573254343\": {\"to\": \"1569573247867\", \"from\": \"1569573245940\", \"name\": \"\", \"type\": \"sl\"}, \"1569573255518\": {\"to\": \"1569573249627\", \"from\": \"1569573247867\", \"name\": \"\", \"type\": \"sl\"}, \"1569573257070\": {\"to\": \"1569573251718\", \"from\": \"1569573249627\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1569573245940\": {\"alt\": true, \"top\": 95, \"left\": 518, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1569573247867\": {\"alt\": true, \"top\": 175, \"left\": 478, \"name\": \"任务节点_4\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"1\", \"verifyModelIds\": \"8b462d09e0ce11e99358e0d55edb21ed,f1699be0e0f311e99358e0d55edb21ed,3774e4de1deb11e99d5300163e13e3ca\", \"verifyModelNames\": \"柏林(金卡智慧),英英(金卡智慧),王然(测试机构)\"}, \"1569573249627\": {\"alt\": true, \"top\": 260, \"left\": 484, \"name\": \"任务节点_5\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"2\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"5\", \"verifyModelNames\": \"技术部总监(测试机构)\"}, \"1569573251718\": {\"alt\": true, \"top\": 349, \"left\": 536, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}}, \"title\": \"金卡智慧订单审核\", \"initNum\": 6}', '金卡智慧订单审核', '2019-09-27 16:42:23', 'f1699be0e0f311e99358e0d55edb21ed', null, '更新流程:更新了流程设计.', '5');
INSERT INTO `flow_design_temp` VALUES ('fffb03e5d82d11e99358e0d55edb21ed', 'cc2ddd63d82d11e99358e0d55edb21ed', 'hytestpp', '平台品牌测试流程', '{\"areas\": {}, \"lines\": {\"1568602927486\": {\"to\": \"1568602917382\", \"from\": \"1568602913358\", \"name\": \"\", \"type\": \"sl\"}, \"1568602928661\": {\"to\": \"1568602918046\", \"from\": \"1568602917382\", \"name\": \"\", \"type\": \"sl\"}, \"1568602929829\": {\"to\": \"1568602915806\", \"from\": \"1568602918046\", \"name\": \"\", \"type\": \"sl\"}}, \"nodes\": {\"1568602913358\": {\"alt\": true, \"top\": 79, \"left\": 532, \"name\": \"开始\", \"type\": \"start round mix\", \"width\": 26, \"height\": 26}, \"1568602915806\": {\"alt\": true, \"top\": 522, \"left\": 530, \"name\": \"结束\", \"type\": \"end round mix\", \"width\": 26, \"height\": 26}, \"1568602917382\": {\"alt\": true, \"top\": 218, \"left\": 502, \"name\": \"媒介部审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyJoint\": \"0\", \"verifyModelIds\": \"1,9b57cf6c17dd11e99d5300163e13e3ca\", \"verifyModelNames\": \"系统超管(平台视线),刘莉莎(平台视线)\"}, \"1568602918046\": {\"alt\": true, \"top\": 367, \"left\": 496, \"name\": \"总经办审核\", \"type\": \"task\", \"width\": 104, \"height\": 26, \"verifyType\": \"3\", \"verifyModelIds\": \"d7e79858c7d211e99358e0d55edb21ed,fc14d10dc7d111e99358e0d55edb21ed,1\", \"verifyModelNames\": \"平台总经办测试账号(平台视线),平台运营测试账号1(平台视线),系统超管(平台视线)\"}}, \"title\": \"平台品牌测试流程\", \"initNum\": 9}', 'sdf', '2019-09-16 11:03:18', '1', null, '更新流程:更新了流程设计.', '3');

-- ----------------------------
-- Table structure for flow_task_type
-- ----------------------------
DROP TABLE IF EXISTS `flow_task_type`;
CREATE TABLE `flow_task_type` (
  `task_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_type_name` varchar(255) NOT NULL,
  `model` varchar(32) NOT NULL COMMENT '对应JAVA实体名',
  `href` varchar(255) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'C',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`task_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flow_task_type
-- ----------------------------
INSERT INTO `flow_task_type` VALUES ('1', '素材', 'AdContent', 'pages/adContent/showAdContent.html', 'C', '2020-06-21 12:12:33');
INSERT INTO `flow_task_type` VALUES ('5', '客户', 'Customer', 'pages/customer/updateCustomer.html', 'C', '2020-06-21 12:12:37');

-- ----------------------------
-- Table structure for msg_notice
-- ----------------------------
DROP TABLE IF EXISTS `msg_notice`;
CREATE TABLE `msg_notice` (
  `notice_id` varchar(32) NOT NULL,
  `type` char(1) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` text,
  `task_type` char(1) DEFAULT NULL,
  `href` varchar(128) DEFAULT NULL,
  `push_user_id` varchar(32) DEFAULT NULL,
  `push_time` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `show_begin_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `show_end_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `flow_temp_id` varchar(32) DEFAULT NULL COMMENT '流程副本表id',
  `flow_temp_node_id` varchar(32) DEFAULT NULL COMMENT '流程副本节点id',
  `flow_from_id` varchar(32) DEFAULT NULL COMMENT '流程表单id',
  `flow_submit_no` varchar(18) DEFAULT NULL COMMENT '业务流程提交序号',
  PRIMARY KEY (`notice_id`),
  UNIQUE KEY `notice_id` (`notice_id`) USING BTREE,
  KEY `sy_n_t_s` (`notice_id`,`type`,`status`) USING BTREE,
  KEY `sy_n_t_t_s` (`notice_id`,`type`,`task_type`,`status`) USING BTREE,
  KEY `idx_from_id_type` (`flow_from_id`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of msg_notice
-- ----------------------------
INSERT INTO `msg_notice` VALUES ('34f59b84ba0711eaabbb28d244a5fdf0', '4', '素材审核结果(\'非终审\'通过)通知', '审核流程: 平台素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: en.<br>审核通过的素材详情: <br>素材ID: 1034,<br/>素材类型: 图片,<br/>素材名称: timg-1', '1', 'pages/adContent/showAdContent.html?id=64fc1879b48b11eaabbb28d244a5fdf0', '1', '2020-06-29 20:50:07', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', '8a61de25df3f11e99358e0d55edb21ed', '1566803722522', '64fc1879b48b11eaabbb28d244a5fdf0', '1592832090340');
INSERT INTO `msg_notice` VALUES ('34fe1fe3ba0711eaabbb28d244a5fdf0', '1', '素材待(终审)通知', '需要(终审)的素材ID: 1034,<br/>素材类型: 图片,<br/>素材名称: timg-1', '1', null, '10', '2020-06-29 20:50:07', 'C', null, null, '8a61de25df3f11e99358e0d55edb21ed', '1566803724250', '64fc1879b48b11eaabbb28d244a5fdf0', '1592832090340');
INSERT INTO `msg_notice` VALUES ('655ef9b5b48b11eaabbb28d244a5fdf0', '1', '素材待(初)审通知', '需要(初)审的素材ID: 1034,<br/>素材类型: 图片,<br/>素材名称: timg (9)', '1', null, '10', '2020-06-22 21:21:30', 'C', null, null, '8a61de25df3f11e99358e0d55edb21ed', '1566803722522', '64fc1879b48b11eaabbb28d244a5fdf0', '1592832090340');
INSERT INTO `msg_notice` VALUES ('88ab9b8cb49211eaabbb28d244a5fdf0', '4', '素材被删除通知', '您录入/提交的素材已被删除,<br/>素材ID: 1025,<br/>素材类型: 视频,<br/>素材名称: 鞋子', '1', 'views/issueManage/materialManage/materialIndex', '10', '2020-06-22 22:12:36', 'C', null, null, null, null, 'a612dfbc999c11eaaab1e0d55edb21ed', null);
INSERT INTO `msg_notice` VALUES ('8cf557f6b49211eaabbb28d244a5fdf0', '4', '素材被删除通知', '您录入/提交的素材已被删除,<br/>素材ID: 1025,<br/>素材类型: 视频,<br/>素材名称: 鞋子', '1', 'views/issueManage/materialManage/materialIndex', '10', '2020-06-22 22:12:43', 'C', null, null, null, null, 'a612dfbc999c11eaaab1e0d55edb21ed', null);
INSERT INTO `msg_notice` VALUES ('a757aba0ba0e11eaabbb28d244a5fdf0', '4', '客户审核结果(\'非终审\'通过)通知', '审核流程: 平台客户测试流程,<br>任务节点: 媒介部审核,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: 1.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', 'pages/customer/updateCustomer.html?id=e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:43:26', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', '972c9caab8f211eaabbb28d244a5fdf0', '1568602420702', 'e4a351691df311e98de8e0d55edb21ed', '1593436608565');
INSERT INTO `msg_notice` VALUES ('a75fe40eba0e11eaabbb28d244a5fdf0', '1', '客户待(终审)通知', '需要(终审)的客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', null, '1', '2020-06-29 21:43:26', 'C', null, null, '972c9caab8f211eaabbb28d244a5fdf0', '1568602421726', 'e4a351691df311e98de8e0d55edb21ed', '1593436608565');
INSERT INTO `msg_notice` VALUES ('bd3ececbb57211eaabbb28d244a5fdf0', '1', '素材待(初)审通知', '需要(初)审的素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test', '1', null, '10', '2020-06-24 00:57:27', 'C', null, null, 'aeafa520b57211eaabbb28d244a5fdf0', '1566803722522', '1581d8fcb48b11eaabbb28d244a5fdf0', '1592931447152');
INSERT INTO `msg_notice` VALUES ('c5ee035bb57211eaabbb28d244a5fdf0', '4', '素材审核结果(\'非终审\'通过)通知', '审核流程: 平台素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: yes.<br>审核通过的素材详情: <br>素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test', '1', 'views/issueManage/materialManage/materialIndex', '10', '2020-06-24 00:57:41', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', 'aeafa520b57211eaabbb28d244a5fdf0', '1566803722522', '1581d8fcb48b11eaabbb28d244a5fdf0', '1592931447152');
INSERT INTO `msg_notice` VALUES ('c5f6fb26b57211eaabbb28d244a5fdf0', '1', '素材待(终审)通知', '需要(终审)的素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test', '1', null, '10', '2020-06-24 00:57:41', 'C', null, null, 'aeafa520b57211eaabbb28d244a5fdf0', '1566803724250', '1581d8fcb48b11eaabbb28d244a5fdf0', '1592931447152');
INSERT INTO `msg_notice` VALUES ('cfbdb13eba0e11eaabbb28d244a5fdf0', '4', '客户审核结果(\'终审\'通过)通知', '审核流程: 平台客户测试流程,<br>任务节点: 总经办审核,<br/>是否为终审: 是,<br>审核结果: 审核通过,<br/>审核说明: 2.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', 'pages/customer/updateCustomer.html?id=e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:44:33', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', '972c9caab8f211eaabbb28d244a5fdf0', '1568602421726', 'e4a351691df311e98de8e0d55edb21ed', '1593436608565');
INSERT INTO `msg_notice` VALUES ('d4f8f8cab49511eaabbb28d244a5fdf0', '1', '素材待(初)审通知', '需要(初)审的素材ID: 1031,<br/>素材类型: 图片,<br/>素材名称: timg', '1', null, '10', '2020-06-22 22:36:12', 'C', null, null, '8a61de25df3f11e99358e0d55edb21ed', '1566803722522', 'c2dc1b3ab48911eaabbb28d244a5fdf0', '1592836572698');
INSERT INTO `msg_notice` VALUES ('da9fc1cbb57211eaabbb28d244a5fdf0', '4', '素材审核结果(\'终审\'被驳回)通知', '审核流程: 平台素材审核流程,<br>任务节点: 总经办人员,<br/>是否为终审: 是,<br>审核结果: 审核被驳回,<br/>审核说明: no.<br>审核通过的素材详情: <br>素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test', '1', 'views/issueManage/materialManage/materialIndex', '10', '2020-06-24 00:58:16', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', 'aeafa520b57211eaabbb28d244a5fdf0', '1566803724250', '1581d8fcb48b11eaabbb28d244a5fdf0', '1592931447152');
INSERT INTO `msg_notice` VALUES ('dc44d88dba0a11eaabbb28d244a5fdf0', '4', '素材审核结果(\'非终审\'被驳回)通知', '审核流程: 平台素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核被驳回,<br/>审核说明: 为.<br>审核通过的素材详情: <br>素材ID: 1031,<br/>素材类型: 图片,<br/>素材名称: timg', '1', 'pages/adContent/showAdContent.html?id=c2dc1b3ab48911eaabbb28d244a5fdf0', '1', '2020-06-29 21:16:16', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', '8a61de25df3f11e99358e0d55edb21ed', '1566803722522', 'c2dc1b3ab48911eaabbb28d244a5fdf0', '1592836572698');
INSERT INTO `msg_notice` VALUES ('ddd200ebba0e11eaabbb28d244a5fdf0', '1', '客户信息被更新后待(初)审通知', '需要您(初)审的客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', null, '1', '2020-06-29 21:44:57', 'C', null, null, '972c9caab8f211eaabbb28d244a5fdf0', '1568602420702', 'e4a351691df311e98de8e0d55edb21ed', '1593438297372');
INSERT INTO `msg_notice` VALUES ('e66920dbba0e11eaabbb28d244a5fdf0', '4', '客户审核结果(\'非终审\'通过)通知', '审核流程: 平台客户测试流程,<br>任务节点: 媒介部审核,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: 3.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', 'pages/customer/updateCustomer.html?id=e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:45:11', 'C', '2020-06-30 15:57:44', '2020-06-30 15:57:44', '972c9caab8f211eaabbb28d244a5fdf0', '1568602420702', 'e4a351691df311e98de8e0d55edb21ed', '1593438297372');
INSERT INTO `msg_notice` VALUES ('e670a835ba0e11eaabbb28d244a5fdf0', '1', '客户待(终审)通知', '需要(终审)的客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', null, '1', '2020-06-29 21:45:11', 'C', null, null, '972c9caab8f211eaabbb28d244a5fdf0', '1568602421726', 'e4a351691df311e98de8e0d55edb21ed', '1593438297372');
INSERT INTO `msg_notice` VALUES ('ef3d3ba0ba0a11eaabbb28d244a5fdf0', '1', '客户信息被更新后待(初)审通知', '需要您(初)审的客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司', '5', null, '1', '2020-06-29 21:16:48', 'C', null, null, '972c9caab8f211eaabbb28d244a5fdf0', '1568602420702', 'e4a351691df311e98de8e0d55edb21ed', '1593436608565');

-- ----------------------------
-- Table structure for msg_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `msg_notice_read`;
CREATE TABLE `msg_notice_read` (
  `read_id` varchar(32) NOT NULL,
  `notice_id` varchar(32) NOT NULL,
  `read_user_id` varchar(32) NOT NULL,
  `read_time` datetime DEFAULT NULL,
  `status` char(1) NOT NULL,
  `flow_verify_status` char(1) DEFAULT NULL COMMENT '审核状态(2待审核 3已核准 4已驳回 6已转办)',
  `flow_verify_reason` text COMMENT '审核意见',
  PRIMARY KEY (`read_id`),
  UNIQUE KEY `read_id` (`read_id`) USING BTREE,
  KEY `sy_r_s` (`read_user_id`,`status`) USING BTREE,
  KEY `idx_flow_verify_status` (`flow_verify_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of msg_notice_read
-- ----------------------------
INSERT INTO `msg_notice_read` VALUES ('34f7415aba0711eaabbb28d244a5fdf0', '34f59b84ba0711eaabbb28d244a5fdf0', '10', null, '0', '3', 'en');
INSERT INTO `msg_notice_read` VALUES ('34ff3ccdba0711eaabbb28d244a5fdf0', '34fe1fe3ba0711eaabbb28d244a5fdf0', '859161d895ea11ea9e2a28d244a5fdf0', null, '0', '2', '上级审核节点审核通过,自动进入下一级素材(终审)节点');
INSERT INTO `msg_notice_read` VALUES ('6561ccf2b48b11eaabbb28d244a5fdf0', '655ef9b5b48b11eaabbb28d244a5fdf0', 'b81c30ce17db11e99d5300163e13e3ca', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('656536e5b48b11eaabbb28d244a5fdf0', '655ef9b5b48b11eaabbb28d244a5fdf0', '1', '2020-06-29 20:50:08', '1', '3', 'en');
INSERT INTO `msg_notice_read` VALUES ('88bed4aab49211eaabbb28d244a5fdf0', '88ab9b8cb49211eaabbb28d244a5fdf0', 'a05bcab598cc11eaaab1e0d55edb21ed', null, '0', '5', '素材被删除');
INSERT INTO `msg_notice_read` VALUES ('8cf814a7b49211eaabbb28d244a5fdf0', '8cf557f6b49211eaabbb28d244a5fdf0', 'a05bcab598cc11eaaab1e0d55edb21ed', null, '0', '5', '素材被删除');
INSERT INTO `msg_notice_read` VALUES ('a759a8fdba0e11eaabbb28d244a5fdf0', 'a757aba0ba0e11eaabbb28d244a5fdf0', '1', '2020-06-29 22:36:32', '1', '3', '1');
INSERT INTO `msg_notice_read` VALUES ('a75b29ddba0e11eaabbb28d244a5fdf0', 'a757aba0ba0e11eaabbb28d244a5fdf0', '859161d895ea11ea9e2a28d244a5fdf0', null, '0', '3', '1');
INSERT INTO `msg_notice_read` VALUES ('a760c858ba0e11eaabbb28d244a5fdf0', 'a75fe40eba0e11eaabbb28d244a5fdf0', '1', '2020-06-29 21:44:34', '1', '3', '2');
INSERT INTO `msg_notice_read` VALUES ('a761f621ba0e11eaabbb28d244a5fdf0', 'a75fe40eba0e11eaabbb28d244a5fdf0', 'd7e79858c7d211e99358e0d55edb21ed', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('a7630200ba0e11eaabbb28d244a5fdf0', 'a75fe40eba0e11eaabbb28d244a5fdf0', '10', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('bd41bd59b57211eaabbb28d244a5fdf0', 'bd3ececbb57211eaabbb28d244a5fdf0', '10', '2020-06-24 00:57:42', '1', '3', 'yes');
INSERT INTO `msg_notice_read` VALUES ('c5effa8db57211eaabbb28d244a5fdf0', 'c5ee035bb57211eaabbb28d244a5fdf0', '10', '2020-06-24 01:39:56', '1', '3', 'yes');
INSERT INTO `msg_notice_read` VALUES ('c5f85383b57211eaabbb28d244a5fdf0', 'c5f6fb26b57211eaabbb28d244a5fdf0', '1', null, '1', '4', '该任务已被他人(admin[平台])驳回');
INSERT INTO `msg_notice_read` VALUES ('c5f9a6bbb57211eaabbb28d244a5fdf0', 'c5f6fb26b57211eaabbb28d244a5fdf0', '10', '2020-06-24 00:58:17', '1', '4', 'no');
INSERT INTO `msg_notice_read` VALUES ('c5fb2065b57211eaabbb28d244a5fdf0', 'c5f6fb26b57211eaabbb28d244a5fdf0', '3c836a9d8f6511eabb0b28d244a5fdf0', null, '1', '4', '该任务已被他人(admin[平台])驳回');
INSERT INTO `msg_notice_read` VALUES ('cfbeb148ba0e11eaabbb28d244a5fdf0', 'cfbdb13eba0e11eaabbb28d244a5fdf0', '1', '2020-06-29 22:40:04', '1', '3', '2');
INSERT INTO `msg_notice_read` VALUES ('cfbfbe13ba0e11eaabbb28d244a5fdf0', 'cfbdb13eba0e11eaabbb28d244a5fdf0', '859161d895ea11ea9e2a28d244a5fdf0', null, '0', '3', '2');
INSERT INTO `msg_notice_read` VALUES ('d5051adab49511eaabbb28d244a5fdf0', 'd4f8f8cab49511eaabbb28d244a5fdf0', 'b81c30ce17db11e99d5300163e13e3ca', null, '1', '4', '该任务已被他人(administrator[平台])驳回');
INSERT INTO `msg_notice_read` VALUES ('d506d436b49511eaabbb28d244a5fdf0', 'd4f8f8cab49511eaabbb28d244a5fdf0', '1', '2020-06-29 21:16:17', '1', '4', '为');
INSERT INTO `msg_notice_read` VALUES ('daa13370b57211eaabbb28d244a5fdf0', 'da9fc1cbb57211eaabbb28d244a5fdf0', '10', '2020-06-24 01:39:20', '1', '4', 'no');
INSERT INTO `msg_notice_read` VALUES ('dc50b287ba0a11eaabbb28d244a5fdf0', 'dc44d88dba0a11eaabbb28d244a5fdf0', '10', null, '0', '4', '为');
INSERT INTO `msg_notice_read` VALUES ('ddd31c8fba0e11eaabbb28d244a5fdf0', 'ddd200ebba0e11eaabbb28d244a5fdf0', '1', '2020-06-29 21:45:12', '1', '3', '3');
INSERT INTO `msg_notice_read` VALUES ('ddd4508bba0e11eaabbb28d244a5fdf0', 'ddd200ebba0e11eaabbb28d244a5fdf0', 'a5133a9818a011e99d5300163e13e3ca', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('ddd52b98ba0e11eaabbb28d244a5fdf0', 'ddd200ebba0e11eaabbb28d244a5fdf0', '10', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('e66a3480ba0e11eaabbb28d244a5fdf0', 'e66920dbba0e11eaabbb28d244a5fdf0', '1', '2020-06-29 21:50:45', '1', '3', '3');
INSERT INTO `msg_notice_read` VALUES ('e66b5ca1ba0e11eaabbb28d244a5fdf0', 'e66920dbba0e11eaabbb28d244a5fdf0', '859161d895ea11ea9e2a28d244a5fdf0', null, '0', '3', '3');
INSERT INTO `msg_notice_read` VALUES ('e671fc51ba0e11eaabbb28d244a5fdf0', 'e670a835ba0e11eaabbb28d244a5fdf0', '1', null, '0', '2', '上级审核节点审核通过,自动进入下一级客户(终审)节点');
INSERT INTO `msg_notice_read` VALUES ('e6738c3fba0e11eaabbb28d244a5fdf0', 'e670a835ba0e11eaabbb28d244a5fdf0', 'd7e79858c7d211e99358e0d55edb21ed', null, '0', '2', '上级审核节点审核通过,自动进入下一级客户(终审)节点');
INSERT INTO `msg_notice_read` VALUES ('e674c2a9ba0e11eaabbb28d244a5fdf0', 'e670a835ba0e11eaabbb28d244a5fdf0', '10', null, '0', '2', '上级审核节点审核通过,自动进入下一级客户(终审)节点');
INSERT INTO `msg_notice_read` VALUES ('ef409177ba0a11eaabbb28d244a5fdf0', 'ef3d3ba0ba0a11eaabbb28d244a5fdf0', '1', '2020-06-29 21:43:26', '1', '3', '1');
INSERT INTO `msg_notice_read` VALUES ('ef42e024ba0a11eaabbb28d244a5fdf0', 'ef3d3ba0ba0a11eaabbb28d244a5fdf0', 'a5133a9818a011e99d5300163e13e3ca', null, '1', '3', '该任务已被他人(administrator[平台])核准');
INSERT INTO `msg_notice_read` VALUES ('ef44855cba0a11eaabbb28d244a5fdf0', 'ef3d3ba0ba0a11eaabbb28d244a5fdf0', '10', null, '1', '3', '该任务已被他人(administrator[平台])核准');

-- ----------------------------
-- Table structure for org
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `org_id` varchar(32) NOT NULL,
  `org_code` varchar(256) NOT NULL,
  `org_type_id` varchar(64) NOT NULL,
  `org_trade_type_id` varchar(64) DEFAULT NULL COMMENT '机构下面品牌了商业类型ids',
  `org_name` varchar(128) NOT NULL,
  `org_des` varchar(1024) DEFAULT NULL,
  `org_status` char(1) NOT NULL,
  `create_user_id` varchar(64) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `level` int(2) DEFAULT NULL,
  `create_org_id` varchar(32) DEFAULT NULL,
  `resource` char(1) DEFAULT NULL,
  `web_login_logo` varchar(255) DEFAULT NULL,
  `web_logo` varchar(255) DEFAULT NULL,
  `web_title` varchar(128) DEFAULT NULL,
  `follow_user_id` varchar(32) DEFAULT NULL,
  `follow_org_id` varchar(32) DEFAULT NULL,
  `index_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`index_id`,`org_id`),
  UNIQUE KEY `org_pk` (`org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='��֯����';

-- ----------------------------
-- Records of org
-- ----------------------------
INSERT INTO `org` VALUES ('1', '100001', '1', '1,2', '平台', '', 'C', '1', '2018-11-08 16:12:56', '0', '1', '1', 'N', null, null, null, null, null, '1');
INSERT INTO `org` VALUES ('4147819a8f7d11eabb0b28d244a5fdf0', 'jinkalianzhi3', '2', null, '测试公司', '', 'C', '1', '2020-05-06 17:37:52', '1', '1', '1', null, null, null, null, null, null, '20');
INSERT INTO `org` VALUES ('2', 'jinkalianzhi23', '2', null, '测试机构', null, 'C', '1', '2020-05-14 21:54:47', '1', '2', '1', null, null, null, null, null, null, '21');

-- ----------------------------
-- Table structure for org_type
-- ----------------------------
DROP TABLE IF EXISTS `org_type`;
CREATE TABLE `org_type` (
  `org_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `org_type_name` varchar(32) NOT NULL,
  `status` char(1) NOT NULL,
  UNIQUE KEY `ORG_TYPE_PK` (`org_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='机构类型';

-- ----------------------------
-- Records of org_type
-- ----------------------------
INSERT INTO `org_type` VALUES ('1', '平台方', 'C');
INSERT INTO `org_type` VALUES ('2', '鉴权供应方', 'C');

-- ----------------------------
-- Table structure for para_type
-- ----------------------------
DROP TABLE IF EXISTS `para_type`;
CREATE TABLE `para_type` (
  `para_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字典ID',
  `para_type_code` varchar(32) DEFAULT NULL COMMENT '字典编码',
  `para_type_name` varchar(32) NOT NULL COMMENT '字典名称',
  `create_user_id` varchar(32) DEFAULT NULL COMMENT '创建人员ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`para_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='参数类型表';

-- ----------------------------
-- Records of para_type
-- ----------------------------
INSERT INTO `para_type` VALUES ('13', 'company_nature', '公司性质', '1', '2018-11-05 14:09:23');
INSERT INTO `para_type` VALUES ('21', 'industry', '行业', '1', '2018-12-26 11:24:44');

-- ----------------------------
-- Table structure for para_value
-- ----------------------------
DROP TABLE IF EXISTS `para_value`;
CREATE TABLE `para_value` (
  `para_id` varchar(32) NOT NULL COMMENT '参数ID',
  `para_type_id` int(11) DEFAULT NULL COMMENT '字典ID',
  `para_code` varchar(32) NOT NULL COMMENT '参数编码',
  `para_name` varchar(128) NOT NULL COMMENT '参数名称',
  `para_value` varchar(256) DEFAULT NULL COMMENT '对应值',
  `is_del` char(1) NOT NULL DEFAULT 'Y' COMMENT '是否可删除',
  `is_update` char(1) NOT NULL DEFAULT 'Y' COMMENT '是否可修改',
  `order_no` int(11) DEFAULT NULL COMMENT '排序号',
  `create_user_id` varchar(32) NOT NULL COMMENT '创建人员id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user_id` varchar(32) DEFAULT NULL COMMENT '修改人员id',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`para_id`),
  UNIQUE KEY `para_value_pk` (`para_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='参数表';

-- ----------------------------
-- Records of para_value
-- ----------------------------
INSERT INTO `para_value` VALUES ('05675889e0c111e8b9cce0d55edb21ed', '13', 'company_nature_2', '民营', null, 'N', 'N', '1', '1', '2018-10-30 18:17:30', '1', '2018-10-30 18:17:30');
INSERT INTO `para_value` VALUES ('0c30eb88e0c111e8b9cce0d55edb21ed', '13', 'company_nature_3', '国企', null, 'N', 'N', '2', '1', '2018-10-30 18:17:30', '1', '2018-10-30 18:17:30');
INSERT INTO `para_value` VALUES ('120c0d3be0c111e8b9cce0d55edb21ed', '13', 'company_nature_4', '股份制', null, 'N', 'N', '3', '1', '2018-10-30 18:17:30', '1', '2018-10-30 18:17:30');
INSERT INTO `para_value` VALUES ('16f6c027e0c111e8b9cce0d55edb21ed', '13', 'company_nature_5', '上市公司', null, 'N', 'N', '4', '1', '2018-10-30 18:17:30', '1', '2018-10-30 18:17:30');
INSERT INTO `para_value` VALUES ('1721160b08c211e9a6d0e0d55edb21ed', '21', 'industry_20', '钟表首饰', null, 'Y', 'Y', '20', '1', '2019-02-21 09:13:42', '1', '2019-02-21 09:13:42');
INSERT INTO `para_value` VALUES ('1993e70a08be11e9a6d0e0d55edb21ed', '21', 'industry_4', '金融保险', null, 'Y', 'Y', '4', '1', '2018-12-26 11:27:59', '1', '2019-02-21 09:07:48');
INSERT INTO `para_value` VALUES ('1b9bc613357511e98a11e0d55edb21ed', '21', 'industry_8', '网服', null, 'Y', 'Y', '8', '1', '2019-02-21 09:09:07', null, '2019-02-21 09:09:07');
INSERT INTO `para_value` VALUES ('242ad88a08be11e9a6d0e0d55edb21ed', '21', 'industry_5', '家居', null, 'Y', 'Y', '5', '1', '2018-12-26 11:28:16', '1', '2019-02-21 09:08:02');
INSERT INTO `para_value` VALUES ('2f69fcdd08be11e9a6d0e0d55edb21ed', '21', 'industry_6', '数码家电', null, 'Y', 'Y', '6', '1', '2018-12-26 11:28:35', '1', '2019-02-21 09:08:21');
INSERT INTO `para_value` VALUES ('30ba0910357511e98a11e0d55edb21ed', '21', 'industry_9', '餐饮美食', null, 'Y', 'Y', '9', '1', '2019-02-21 09:09:42', null, '2019-02-21 09:09:42');
INSERT INTO `para_value` VALUES ('3ad45008357511e98a11e0d55edb21ed', '21', 'industry_10', '快消品', null, 'Y', 'Y', '10', '1', '2019-02-21 09:09:59', null, '2019-02-21 09:09:59');
INSERT INTO `para_value` VALUES ('3fd9ee7c08be11e9a6d0e0d55edb21ed', '21', 'industry_7', '教育培训', null, 'Y', 'Y', '7', '1', '2018-12-26 11:29:03', '1', '2019-02-21 09:08:33');
INSERT INTO `para_value` VALUES ('47a77d40357511e98a11e0d55edb21ed', '21', 'industry_11', '商超', null, 'Y', 'Y', '11', '1', '2019-02-21 09:10:20', null, '2019-02-21 09:10:20');
INSERT INTO `para_value` VALUES ('518f5264357511e98a11e0d55edb21ed', '21', 'industry_12', '运营商', null, 'Y', 'Y', '12', '1', '2019-02-21 09:10:37', null, '2019-02-21 09:10:37');
INSERT INTO `para_value` VALUES ('5adac7c8357511e98a11e0d55edb21ed', '21', 'industry_13', '文娱', null, 'Y', 'Y', '13', '1', '2019-02-21 09:10:53', null, '2019-02-21 09:10:53');
INSERT INTO `para_value` VALUES ('70738ee5357511e98a11e0d55edb21ed', '21', 'industry_14', '美妆', null, 'Y', 'Y', '14', '1', '2019-02-21 09:11:29', '1', '2019-02-21 09:11:38');
INSERT INTO `para_value` VALUES ('7fbdd2f3357511e98a11e0d55edb21ed', '21', 'industry_15', '游戏', null, 'Y', 'Y', '15', '1', '2019-02-21 09:11:55', null, '2019-02-21 09:11:55');
INSERT INTO `para_value` VALUES ('8a4b9b15357511e98a11e0d55edb21ed', '21', 'industry_16', '婚嫁', null, 'Y', 'Y', '16', '1', '2019-02-21 09:12:12', null, '2019-02-21 09:12:12');
INSERT INTO `para_value` VALUES ('98972ae3357511e98a11e0d55edb21ed', '21', 'industry_17', '机构协会', null, 'Y', 'Y', '17', '1', '2019-02-21 09:12:36', null, '2019-02-21 09:12:36');
INSERT INTO `para_value` VALUES ('ab10dba2357511e98a11e0d55edb21ed', '21', 'industry_18', '软件应用', null, 'Y', 'Y', '18', '1', '2019-02-21 09:13:07', null, '2019-02-21 09:13:07');
INSERT INTO `para_value` VALUES ('b5716559357511e98a11e0d55edb21ed', '21', 'industry_19', '生活服务', null, 'Y', 'Y', '19', '1', '2019-02-21 09:13:25', null, '2019-02-21 09:13:25');
INSERT INTO `para_value` VALUES ('c3344c9508bd11e9a6d0e0d55edb21ed', '21', 'industry_1', '地产', null, 'Y', 'Y', '3', '1', '2018-12-26 11:25:34', '1', '2019-02-21 09:07:12');
INSERT INTO `para_value` VALUES ('cbac0b1c357511e98a11e0d55edb21ed', '21', 'industry_21', '服饰鞋包', null, 'Y', 'Y', '20', '1', '2019-02-21 09:14:02', null, '2019-02-21 09:14:02');
INSERT INTO `para_value` VALUES ('cfcc5fd308bd11e9a6d0e0d55edb21ed', '21', 'industry_2', '汽车', null, 'Y', 'Y', '2', '1', '2018-12-26 11:25:55', '1', '2019-02-21 09:07:22');
INSERT INTO `para_value` VALUES ('d58df1e4357511e98a11e0d55edb21ed', '21', 'industry_22', '母婴儿童', null, 'Y', 'Y', '22', '1', '2019-02-21 09:14:19', null, '2019-02-21 09:14:19');
INSERT INTO `para_value` VALUES ('d88a1fa208bd11e9a6d0e0d55edb21ed', '21', 'industry_3', '旅游', null, 'Y', 'Y', '1', '1', '2018-12-26 11:26:09', '1', '2019-02-21 09:07:33');
INSERT INTO `para_value` VALUES ('e1cc0857357511e98a11e0d55edb21ed', '21', 'industry_23', '医疗', null, 'Y', 'Y', '23', '1', '2019-02-21 09:14:39', null, '2019-02-21 09:14:39');
INSERT INTO `para_value` VALUES ('e871e3ace0c011e8b9cce0d55edb21ed', '13', 'company_nature_1', '事业单位', null, 'N', 'N', '5', '1', '2018-10-30 18:17:30', '1', '2018-10-30 18:17:30');
INSERT INTO `para_value` VALUES ('f0835b3f357511e98a11e0d55edb21ed', '21', 'industry_24', '其他', null, 'Y', 'Y', '24', '1', '2019-02-21 09:15:04', null, '2019-02-21 09:15:04');

-- ----------------------------
-- Table structure for sys_audit_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit_logs`;
CREATE TABLE `sys_audit_logs` (
  `module_id` varchar(32) NOT NULL COMMENT '模块id',
  `user_id` varchar(32) NOT NULL COMMENT '操作人id',
  `op_time` datetime NOT NULL COMMENT '创建时间',
  `op_con` text,
  KEY `mm` (`module_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_audit_logs
-- ----------------------------
INSERT INTO `sys_audit_logs` VALUES ('c2dc1b3ab48911eaabbb28d244a5fdf0', '10', '2020-06-22 21:09:49', '素材-保存(入库)');
INSERT INTO `sys_audit_logs` VALUES ('1581d8fcb48b11eaabbb28d244a5fdf0', '10', '2020-06-22 21:19:17', '素材-保存(入库)');
INSERT INTO `sys_audit_logs` VALUES ('64fc1879b48b11eaabbb28d244a5fdf0', '10', '2020-06-22 21:21:30', '素材-保存(入库)');
INSERT INTO `sys_audit_logs` VALUES ('64fc1879b48b11eaabbb28d244a5fdf0', '10', '2020-06-22 21:21:31', '素材-提交(初)审<br/>流程归属机构: 平台,<br/>流程名称: 华扬素材审核流程,<br/>任务节点: 运营人员,<br/>节点归属: 用户[华扬运营(华扬视线),系统管理员(华扬视线)]');
INSERT INTO `sys_audit_logs` VALUES ('a612dfbc999c11eaaab1e0d55edb21ed', '10', '2020-06-22 22:12:37', '素材-逻辑删除');
INSERT INTO `sys_audit_logs` VALUES ('a612dfbc999c11eaaab1e0d55edb21ed', '10', '2020-06-22 22:12:44', '素材-逻辑删除');
INSERT INTO `sys_audit_logs` VALUES ('c2dc1b3ab48911eaabbb28d244a5fdf0', '10', '2020-06-22 22:36:14', '素材-提交(初)审<br/>流程归属机构: 平台,<br/>流程名称: 华扬素材审核流程,<br/>任务节点: 运营人员,<br/>节点归属: 用户[华扬运营(华扬视线),系统管理员(华扬视线)]');
INSERT INTO `sys_audit_logs` VALUES ('620ef0989b3811eaaab1e0d55edb21ed', '10', '2020-06-23 00:11:11', '客户-物理删除');
INSERT INTO `sys_audit_logs` VALUES ('3c3c80adb4a411eaabbb28d244a5fdf0', '10', '2020-06-23 00:19:19', '客户-保存(入库)');
INSERT INTO `sys_audit_logs` VALUES ('3c3c80adb4a411eaabbb28d244a5fdf0', '10', '2020-06-23 00:19:32', '客户-物理删除');
INSERT INTO `sys_audit_logs` VALUES ('1581d8fcb48b11eaabbb28d244a5fdf0', '10', '2020-06-24 00:57:28', '素材-提交(初)审<br/>流程归属机构: 平台,<br/>流程名称: 华扬素材审核流程,<br/>任务节点: 运营人员,<br/>节点归属: 用户[平台管理员(平台)]');
INSERT INTO `sys_audit_logs` VALUES ('1581d8fcb48b11eaabbb28d244a5fdf0', '10', '2020-06-24 00:57:43', '审核流程: 华扬素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: yes.<br>审核通过的素材详情: <br>素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test');
INSERT INTO `sys_audit_logs` VALUES ('1581d8fcb48b11eaabbb28d244a5fdf0', '10', '2020-06-24 00:58:18', '审核流程: 华扬素材审核流程,<br>任务节点: 总经办人员,<br/>是否为终审: 是,<br>审核结果: 审核被驳回,<br/>审核说明: no.<br>审核通过的素材详情: <br>素材ID: 1032,<br/>素材类型: 视频,<br/>素材名称: test');
INSERT INTO `sys_audit_logs` VALUES ('74da1360b8f211eaabbb28d244a5fdf0', '10', '2020-06-28 11:49:04', '客户-保存(入库)');
INSERT INTO `sys_audit_logs` VALUES ('74da1360b8f211eaabbb28d244a5fdf0', '10', '2020-06-28 11:49:05', '客户-提交(初)审<br/>流程归属机构: 平台,<br/>流程名称: 华扬客户测试流程,<br/>任务节点: 媒介部审核,<br/>节点归属: 用户[系统超管(华扬视线),李数里(华扬视线)]');
INSERT INTO `sys_audit_logs` VALUES ('64fc1879b48b11eaabbb28d244a5fdf0', '1', '2020-06-29 20:50:09', '审核流程: 华扬素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: en.<br>审核通过的素材详情: <br>素材ID: 1034,<br/>素材类型: 图片,<br/>素材名称: timg-1');
INSERT INTO `sys_audit_logs` VALUES ('c2dc1b3ab48911eaabbb28d244a5fdf0', '1', '2020-06-29 21:16:18', '审核流程: 华扬素材审核流程,<br>任务节点: 运营人员,<br/>是否为终审: 不是,<br>审核结果: 审核被驳回,<br/>审核说明: 为.<br>审核通过的素材详情: <br>素材ID: 1031,<br/>素材类型: 图片,<br/>素材名称: timg');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:16:48', '客户-更新客户信息');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:16:50', '客户-更新客户信息后提交(初)审流程<br/>流程归属机构: 平台,<br/>流程名称: 华扬客户测试流程,<br/>任务节点: 媒介部审核,<br/>节点归属: 用户[系统超管(华扬视线),李数里(华扬视线),平台管理员(平台)]');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:43:27', '审核流程: 华扬客户测试流程,<br>任务节点: 媒介部审核,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: 1.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:44:35', '审核流程: 华扬客户测试流程,<br>任务节点: 总经办审核,<br/>是否为终审: 是,<br>审核结果: 审核通过,<br/>审核说明: 2.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:44:57', '客户-更新客户信息');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:44:58', '客户-更新客户信息后提交(初)审流程<br/>流程归属机构: 平台,<br/>流程名称: 华扬客户测试流程,<br/>任务节点: 媒介部审核,<br/>节点归属: 用户[系统超管(华扬视线),李数里(华扬视线),平台管理员(平台)]');
INSERT INTO `sys_audit_logs` VALUES ('e4a351691df311e98de8e0d55edb21ed', '1', '2020-06-29 21:45:13', '审核流程: 华扬客户测试流程,<br>任务节点: 媒介部审核,<br/>是否为终审: 不是,<br>审核结果: 审核通过,<br/>审核说明: 3.<br>审核通过的客户详情: <br>客户ID: 20,<br/>客户名称: 重庆苏宁易购销售有限公司');

-- ----------------------------
-- Table structure for sys_list
-- ----------------------------
DROP TABLE IF EXISTS `sys_list`;
CREATE TABLE `sys_list` (
  `sys_id` int(10) NOT NULL AUTO_INCREMENT,
  `sys_code` varchar(22) NOT NULL,
  `sys_name` varchar(128) NOT NULL,
  `sys_url` varchar(255) NOT NULL,
  `sort` int(10) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'C' COMMENT '状态CRD',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`sys_id`),
  UNIQUE KEY `pk_sys_id` (`sys_id`) USING BTREE,
  KEY `idx_sys_id` (`sys_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_list
-- ----------------------------
INSERT INTO `sys_list` VALUES ('1', 'TOUR-PLATFOR', '运营系统', '/tourPlatf', '1', 'C', '2019-11-18 14:03:56');
INSERT INTO `sys_list` VALUES ('2', 'TOUR-SEND-SHOP', '分销商系统', '/tourSend', '2', 'C', '2019-11-18 14:04:35');

-- ----------------------------
-- Table structure for sys_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_logs`;
CREATE TABLE `sys_logs` (
  `LOG_ID` varchar(32) NOT NULL,
  `USER_ID` varchar(32) DEFAULT NULL,
  `LOG_TYPE` int(11) NOT NULL DEFAULT '1',
  `MODULE` varchar(32) DEFAULT NULL,
  `FLAG` int(11) DEFAULT NULL,
  `REMARK` text,
  `CREATE_TIME` datetime DEFAULT NULL,
  `index_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`index_id`,`LOG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8mb4 COMMENT='ϵͳ������־��';

-- ----------------------------
-- Records of sys_logs
-- ----------------------------
INSERT INTO `sys_logs` VALUES ('035f72dcb9cf11eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-29 14:07:52', '195');
INSERT INTO `sys_logs` VALUES ('2116d063b9e211eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-29 16:24:42', '196');
INSERT INTO `sys_logs` VALUES ('3926b91cb9e911eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-29 17:15:29', '197');
INSERT INTO `sys_logs` VALUES ('44d58266b9e911eaabbb28d244a5fdf0', '10', '1', '用户-修改密码', '1', null, '2020-06-29 17:15:49', '198');
INSERT INTO `sys_logs` VALUES ('53c373ecb9e911eaabbb28d244a5fdf0', '10', '1', '用户-修改密码', '1', null, '2020-06-29 17:16:14', '199');
INSERT INTO `sys_logs` VALUES ('57e388adb9e911eaabbb28d244a5fdf0', '10', '1', '用户-修改', '1', null, '2020-06-29 17:16:21', '200');
INSERT INTO `sys_logs` VALUES ('5add829eb9e911eaabbb28d244a5fdf0', '10', '1', '用户-修改', '1', null, '2020-06-29 17:16:26', '201');
INSERT INTO `sys_logs` VALUES ('5c301510b9e911eaabbb28d244a5fdf0', '10', '1', '用户-修改', '1', null, '2020-06-29 17:16:28', '202');
INSERT INTO `sys_logs` VALUES ('3ddc0ed6b9eb11eaabbb28d244a5fdf0', '10', '1', '用户-保存', '1', null, '2020-06-29 17:29:56', '203');
INSERT INTO `sys_logs` VALUES ('47c125c8b9eb11eaabbb28d244a5fdf0', '3dd5e0fcb9eb11eaabbb28d244a5fdf0', '1', '登陆', '1', null, '2020-06-29 17:30:13', '204');
INSERT INTO `sys_logs` VALUES ('5a75b94bb9eb11eaabbb28d244a5fdf0', '1', '1', '登陆', '1', null, '2020-06-29 17:30:44', '205');
INSERT INTO `sys_logs` VALUES ('d3935c30b9ef11eaabbb28d244a5fdf0', '1', '1', '角色-保存角色', '1', null, '2020-06-29 18:02:45', '206');
INSERT INTO `sys_logs` VALUES ('5e9905f8b9f011eaabbb28d244a5fdf0', '1', '1', '角色-保存角色', '1', null, '2020-06-29 18:06:39', '207');
INSERT INTO `sys_logs` VALUES ('35057047ba0711eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 20:50:07', '208');
INSERT INTO `sys_logs` VALUES ('dc5c91cdba0a11eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 21:16:16', '209');
INSERT INTO `sys_logs` VALUES ('ef4d8b60ba0a11eaabbb28d244a5fdf0', '1', '1', '客户-修改', '1', null, '2020-06-29 21:16:48', '210');
INSERT INTO `sys_logs` VALUES ('a76a1f3dba0e11eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 21:43:26', '211');
INSERT INTO `sys_logs` VALUES ('b5c3d812ba0e11eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 21:43:50', '212');
INSERT INTO `sys_logs` VALUES ('bd9b0e07ba0e11eaabbb28d244a5fdf0', '1', '1', '客户-修改', '1', null, '2020-06-29 21:44:03', '213');
INSERT INTO `sys_logs` VALUES ('cfc69a41ba0e11eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 21:44:33', '214');
INSERT INTO `sys_logs` VALUES ('ddd8ca5dba0e11eaabbb28d244a5fdf0', '1', '1', '客户-修改', '1', null, '2020-06-29 21:44:57', '215');
INSERT INTO `sys_logs` VALUES ('e67dca25ba0e11eaabbb28d244a5fdf0', '1', '1', '流程节点-审核（通过/驳回/转办）', '1', null, '2020-06-29 21:45:11', '216');
INSERT INTO `sys_logs` VALUES ('cd51af19ba1a11eaabbb28d244a5fdf0', '1', '1', '修改', '1', null, '2020-06-29 23:10:23', '217');
INSERT INTO `sys_logs` VALUES ('f344cfc3ba1a11eaabbb28d244a5fdf0', '1', '1', '修改', '1', null, '2020-06-29 23:11:27', '218');
INSERT INTO `sys_logs` VALUES ('023834a9ba1b11eaabbb28d244a5fdf0', '1', '1', '修改', '1', null, '2020-06-29 23:11:52', '219');
INSERT INTO `sys_logs` VALUES ('478026d1ba1b11eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-29 23:13:48', '220');
INSERT INTO `sys_logs` VALUES ('2848d93eba2411eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-30 00:17:21', '221');
INSERT INTO `sys_logs` VALUES ('349761b0ba2411eaabbb28d244a5fdf0', '10', '1', '用户-修改密码', '1', null, '2020-06-30 00:17:42', '222');
INSERT INTO `sys_logs` VALUES ('9c3ff110ba2411eaabbb28d244a5fdf0', '10', '1', '用户-修改密码', '1', null, '2020-06-30 00:20:36', '223');
INSERT INTO `sys_logs` VALUES ('ad488daaba2411eaabbb28d244a5fdf0', '10', '1', '用户-修改密码', '1', null, '2020-06-30 00:21:04', '224');
INSERT INTO `sys_logs` VALUES ('b54f3f42ba2411eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-30 00:21:18', '225');
INSERT INTO `sys_logs` VALUES ('c171dc34ba2411eaabbb28d244a5fdf0', '10', '1', '角色-保存角色', '1', null, '2020-06-30 00:21:38', '226');
INSERT INTO `sys_logs` VALUES ('d4f5b0ceba2411eaabbb28d244a5fdf0', '10', '1', '角色-保存角色', '1', null, '2020-06-30 00:22:11', '227');
INSERT INTO `sys_logs` VALUES ('e2134d77ba2411eaabbb28d244a5fdf0', '10', '1', '角色-保存角色', '1', null, '2020-06-30 00:22:33', '228');
INSERT INTO `sys_logs` VALUES ('0ceb6e40ba2511eaabbb28d244a5fdf0', '1', '1', '登陆', '1', null, '2020-06-30 00:23:45', '229');
INSERT INTO `sys_logs` VALUES ('242fd8b6ba2511eaabbb28d244a5fdf0', '1', '1', '用户-修改密码', '1', null, '2020-06-30 00:24:24', '230');
INSERT INTO `sys_logs` VALUES ('2fb38e2aba2511eaabbb28d244a5fdf0', '1', '1', '登陆', '1', null, '2020-06-30 00:24:43', '231');
INSERT INTO `sys_logs` VALUES ('3d3d3871ba2511eaabbb28d244a5fdf0', '1', '1', '用户-修改密码', '1', null, '2020-06-30 00:25:06', '232');
INSERT INTO `sys_logs` VALUES ('0e348972ba2911eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-30 00:52:25', '233');
INSERT INTO `sys_logs` VALUES ('24fcb390ba9811eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-30 14:07:35', '234');
INSERT INTO `sys_logs` VALUES ('81922885ba9911eaabbb28d244a5fdf0', '10', '1', '登陆', '1', null, '2020-06-30 14:17:20', '235');
INSERT INTO `sys_logs` VALUES ('e50fa4e8ba9a11eaabbb28d244a5fdf0', '10', '1', '生成代码', '1', null, '2020-06-30 14:27:16', '236');
INSERT INTO `sys_logs` VALUES ('87f0d5fdbaa411eaabbb28d244a5fdf0', '10', '1', '流程设计-走流程图-保存', '1', null, '2020-06-30 15:36:15', '237');

-- ----------------------------
-- Table structure for sys_para
-- ----------------------------
DROP TABLE IF EXISTS `sys_para`;
CREATE TABLE `sys_para` (
  `para_id` varchar(32) NOT NULL,
  `para_code` varchar(32) NOT NULL,
  `para_name` varchar(64) NOT NULL,
  `para_value` varchar(256) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`para_id`),
  UNIQUE KEY `para_code` (`para_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ϵͳ������';

-- ----------------------------
-- Records of sys_para
-- ----------------------------
INSERT INTO `sys_para` VALUES ('0', 'work_prefix', '工作前缀', '', 'C', '2019-10-12 15:43:56', '1');
INSERT INTO `sys_para` VALUES ('10', 'is_multilevel_approval', '是否启用多级审批(1是2否)', '1', 'C', '2018-10-22 15:34:09', '1');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `PERMISSION_ID` varchar(32) NOT NULL,
  `PERMISSION_NAME` varchar(32) NOT NULL,
  `PARENT_ID` varchar(32) DEFAULT NULL,
  `CSS` varchar(128) DEFAULT NULL,
  `HREF` varchar(1024) DEFAULT NULL,
  `TYPE` int(11) NOT NULL,
  `PERMISSION` varchar(64) DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER_ID` varchar(32) DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `UPDATE_USER_ID` varchar(32) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT NULL,
  `sys_id` int(10) DEFAULT NULL COMMENT '所属子系统id',
  PRIMARY KEY (`PERMISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ϵͳȨ�ޱ�';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('0aeb0d06588b21ea90cc00163e13e3me', '导出', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:export', '7', '2020-02-26 19:27:58', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('1', '欢迎页', '0', 'fa-tachometer', 'pages/dashboard.html', '1', null, '0', '2020-06-16 14:11:37', '1', '2020-06-16 14:11:42', null, '1', '1');
INSERT INTO `sys_permission` VALUES ('10', '字典管理', '2', 'fa-tags', 'pages/paraType/paraTypeList.html', '1', null, '4', '2018-09-18 20:36:01', null, '2020-06-24 11:33:47', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('11', '机构管理', '2', 'fa-tree', 'pages/org/orgList.html', '1', '', '3', '2018-09-18 23:53:19', null, '2018-09-20 21:08:14', '1', '2', '1');
INSERT INTO `sys_permission` VALUES ('12', '查询', '11', null, null, '2', 'sys:orgo:query', '100', '2018-09-18 23:55:00', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('19', '删除', '7', null, null, '2', 'sys:role:del', '100', '2018-09-18 20:41:25', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('1e9c4098141c11e91de8e0d55edb21ed', '新增', '20', '', '', '2', 'sys:flow:add', '2', '2019-01-09 22:38:06', '1', '2019-01-09 22:38:06', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('1e9c4098141c11e98de8e0d55edb21ed', '新增', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:add', '2', '2019-01-09 22:38:06', '1', '2019-01-09 22:38:06', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('2', '系统管理', '0', 'fa-gears', null, '1', null, '999', '2020-06-16 14:13:34', '1', null, null, '1', '1');
INSERT INTO `sys_permission` VALUES ('20', '流程设计管理', '21', 'fa-sitemap', 'pages/flowDesign/flowList.html', '1', '', '5', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '2', '1');
INSERT INTO `sys_permission` VALUES ('21', '流程模型', '0', 'fa-share-alt-square', '', '1', '', '1', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '1', '1');
INSERT INTO `sys_permission` VALUES ('22', '流程业务', '0', 'fa-tasks', '', '1', '', '1', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '1', '1');
INSERT INTO `sys_permission` VALUES ('23', '流程工作台', '0', 'fa-desktop', '', '1', '', '1', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '1', '1');
INSERT INTO `sys_permission` VALUES ('24', '流程业务类型', '21', 'fa-server', 'pages/flowTaskType/flowTaskTypeList.html', '1', '', '0', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '2', '1');
INSERT INTO `sys_permission` VALUES ('3', '菜单管理', '2', 'fa-cog', 'pages/menu/menuList.html', '1', null, '4', '2018-09-18 20:36:01', null, null, null, '2', '1');
INSERT INTO `sys_permission` VALUES ('39299e3f141c11e92de8e0d55edb21ed', '编辑', '20', '', '', '2', 'sys:flow:edit', '3', '2019-01-09 22:38:50', '1', '2019-01-09 22:38:50', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('39299e3f141c11e92de8e0d57edb21ed', '保存设计', '20', '', '', '2', 'sys:flow:design', '3', '2019-01-09 22:38:50', '1', '2019-01-09 22:38:50', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('39299e3f141c11e98de8e0d55edb21ed', '编辑', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:edit', '3', '2019-01-09 22:38:50', '1', '2019-01-09 22:38:50', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('4', '查询', '3', null, null, '2', 'sys:menu:query', '100', '2018-09-18 20:37:50', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('5', '新增', '3', null, null, '2', 'sys:menu:add', '100', '2018-09-18 20:38:24', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('50', '代码生成', '2', 'fa-recycle', 'pages/generate/edit.html', '1', '', '999', '2018-10-26 15:22:54', '1', '2020-04-09 09:01:20', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('52015205141c11e93de8e0d55edb21ed', '停用', '20', '', '', '2', 'sys:flow:stop', '4', '2019-01-09 22:39:32', '1', '2019-01-09 22:39:32', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('52015205141c11e98de8e0d55edb21ed', '停用', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:stop', '4', '2019-01-09 22:39:32', '1', '2019-01-09 22:39:32', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('5c62e9e3588a21ea90cc00163e13e3me', '客户管理', '22', 'fa-address-book-o', 'pages/customer/customerList.html', '1', '', '2', '2020-02-26 19:23:06', '10', '2020-03-17 17:33:14', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('5c62e9e3588a81ea90cc00163e13e3me', '审核任务', '23', 'fa-calendar', 'pages/workbench/flowWorkList.html', '1', '', '2', '2020-02-26 19:23:06', '10', '2020-03-17 17:33:14', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('5c62e9e3588a91ea90cc00163e13e3me', '业务消息', '23', 'fa-bell', 'pages/workbench/flowTaskStatusList.html', '1', '', '2', '2020-02-26 19:23:06', '10', '2020-03-17 17:33:14', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('6', '删除', '3', null, null, '2', 'sys:menu:del', '100', '2018-09-18 20:38:57', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('7', '角色管理', '2', 'fa-user-secret', 'pages/role/roleList.html', '1', null, '2', '2018-09-18 20:39:47', null, null, null, '2', '1');
INSERT INTO `sys_permission` VALUES ('7a32ccc6156c11e98de8e0d55edb21ed', '强制重置密码', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:resetPassword', '5', '2019-01-11 14:45:55', '1', '2019-01-11 14:45:55', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('7d435f57522311ea90cc00163e13e3ca', '素材管理', '22', 'fa-database', 'pages/adContent/adContentList.html', '1', '', '3', '2020-02-18 15:51:36', '10', '2020-03-23 17:57:49', '10', '2', '1');
INSERT INTO `sys_permission` VALUES ('8', '查询', '7', null, null, '2', 'sys:role:query', '100', '2018-09-18 20:40:53', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('9', '新增', '7', null, null, '2', 'sys:role:add', '100', '2018-09-18 20:41:25', null, null, null, null, '1');
INSERT INTO `sys_permission` VALUES ('9a387c61588a21ea90cc00163e13e3me', '查询', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:query', '1', '2020-02-26 19:24:49', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('9a387c61588a22ea90cc00163e13e3me', '查询', '24', '', '', '2', 'flowDesign:flowTaskType:query', '1', '2020-02-26 19:24:49', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('b16c190f588a21ea90cc00163e13e3me', '新增', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:add', '2', '2020-02-26 19:25:28', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('b16c190f588a23ea90cc00163e13e3me', '新增', '24', '', '', '2', 'flowDesign:flowTaskType:add', '2', '2020-02-26 19:25:28', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('b413aa4cbcb111e8913868f7284f5721', '日志管理', '2', 'fa-building', 'pages/log/logList.html', '1', 'sys:log:query', '998', '2018-09-20 16:46:06', '1', '2018-09-20 17:11:01', '1', '2', '1');
INSERT INTO `sys_permission` VALUES ('c5c41f58588a21ea90cc00163e13e3me', '编辑', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:edit', '3', '2020-02-26 19:26:02', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('c5c41f58588a24ea90cc00163e13e3me', '编辑', '24', '', '', '2', 'flowDesign:flowTaskType:edit', '3', '2020-02-26 19:26:02', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('cec055c8141b11e84de8e0d55edb21ed', '查询', '20', '', '', '2', 'sys:flow:query', '1', '2019-01-09 22:35:52', '1', '2019-01-09 22:35:52', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('cec055c8141b11e98de8e0d55edb21ed', '查询', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:query', '1', '2019-01-09 22:35:52', '1', '2019-01-09 22:35:52', null, '4', '1');
INSERT INTO `sys_permission` VALUES ('d5f24c01588a21ea90cc00163e13e3me', '删除', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:del', '4', '2020-02-26 19:26:30', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('d5f24c01588a25ea90cc00163e13e3me', '删除', '24', '', '', '2', 'flowDesign:flowTaskType:del', '4', '2020-02-26 19:26:30', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('ded174b2602211e860cae0d55edb21ed', '删除', '20', '', '', '2', 'sys:flow:del', '5', '2019-04-16 16:37:41', '1', '2019-04-16 16:37:41', null, '3', '1');
INSERT INTO `sys_permission` VALUES ('ded174b2602211e980cae0d55edb21ed', '删除', 'f4d05544141811e98de8e0d55edb21ed', '', '', '2', 'sys:user:del', '5', '2019-04-16 16:37:41', '1', '2019-04-16 16:37:41', null, '3', '1');
INSERT INTO `sys_permission` VALUES ('e6022149588a21ea90cc00163e13e3me', '审核', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:check', '5', '2020-02-26 19:26:57', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('f4d05544141811e98de8e0d55edb21ed', '用户管理', '2', 'fa-address-book', 'pages/user/userList.html', '1', '', '1', '2019-01-09 22:15:27', '1', '2019-01-09 22:15:27', null, '2', '1');
INSERT INTO `sys_permission` VALUES ('f6fed1b3588a21ea90cc00163e13e3me', '提交', '5c62e9e3588a21ea90cc00163e13e3me', '', '', '2', 'customer:customer:sub', '6', '2020-02-26 19:27:25', '10', '2020-03-17 17:33:14', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('rolad65a2e25f11e8b9cce0d55edb21e', '新增', '7d435f57522311ea90cc00163e13e3ca', '', '', '2', 'release:adContent:add', '1', '2018-11-07 15:29:36', '1', '2020-03-23 17:57:49', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('roled65a2e25f11e8b9cce0d55edb21e', '删除', '7d435f57522311ea90cc00163e13e3ca', '', '', '2', 'release:adContent:del', '4', '2018-11-07 15:30:57', '1', '2020-03-23 17:57:49', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('rolee65a2e25f11e8b9cce0d55edb21e', '修改', '7d435f57522311ea90cc00163e13e3ca', '', '', '2', 'release:adContent:edit', '2', '2018-11-07 15:31:43', '1', '2020-03-23 17:57:49', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('roles65a2e25f11e8b9cce0d55edb21e', '查询', '7d435f57522311ea90cc00163e13e3ca', '', '', '2', 'release:adContent:query', '3', '2018-11-07 15:30:30', '1', '2020-03-23 17:57:49', '10', '3', '1');
INSERT INTO `sys_permission` VALUES ('rolet65a2e25f11e8b9cce0d55edb21e', '提交', '7d435f57522311ea90cc00163e13e3ca', '', '', '2', 'release:adContent:sub', '2', '2018-11-07 15:31:43', '1', '2020-03-23 17:57:49', '10', '3', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(32) NOT NULL,
  `ORG_ID` varchar(32) DEFAULT NULL,
  `ROLE_NAME` varchar(32) NOT NULL,
  `DESCRIPTION` varchar(256) DEFAULT NULL,
  `STATUS` char(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER_ID` varchar(32) DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `UPDATE_USER_ID` varchar(32) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `level` int(2) DEFAULT NULL,
  `create_org_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='��ɫ��';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '1', '系统超级管理员', '拥有所有权限', '2', '2018-09-18 20:42:42', '1', '2020-06-29 18:06:39', '1', '0', '1', '1');
INSERT INTO `sys_role` VALUES ('2', '1', '鉴权录入人员', '鉴权录入人员', '1', '2019-01-18 14:30:34', '1', '2020-05-14 21:53:40', '10', '0', '1', '1');
INSERT INTO `sys_role` VALUES ('3', '2', '测试人员', '自主注册测试人员', '1', '2019-01-18 14:30:34', '1', '2020-06-30 00:22:33', '10', '0', '1', '1');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `ROLE_PERMISSION_ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) DEFAULT NULL,
  `PERMISSION_ID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ROLE_PERMISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='��ɫȨ�ޱ�';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('235881e0129411eabc92e0d55edb21ed', '23566847129411eabc92e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('235881ff129411eabc92e0d55edb21ed', '23566847129411eabc92e0d55edb21ed', '14');
INSERT INTO `sys_role_permission` VALUES ('23588202129411eabc92e0d55edb21ed', '23566847129411eabc92e0d55edb21ed', '12');
INSERT INTO `sys_role_permission` VALUES ('23588209129411eabc92e0d55edb21ed', '23566847129411eabc92e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a7600f08c11e99358e0d55edb21ed', '4', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a7630f08c11e99358e0d55edb21ed', '4', '11699ad2e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a7636f08c11e99358e0d55edb21ed', '4', '1');
INSERT INTO `sys_role_permission` VALUES ('298a763df08c11e99358e0d55edb21ed', '4', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a767bf08c11e99358e0d55edb21ed', '4', '8c1834aaf08711e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a767ef08c11e99358e0d55edb21ed', '4', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('298a7685f08c11e99358e0d55edb21ed', '4', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3a5dc4bd129411eabc92e0d55edb21ed', '93065725128b11eabc92e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3a5dc512129411eabc92e0d55edb21ed', '93065725128b11eabc92e0d55edb21ed', '14');
INSERT INTO `sys_role_permission` VALUES ('3a5dc527129411eabc92e0d55edb21ed', '93065725128b11eabc92e0d55edb21ed', '15');
INSERT INTO `sys_role_permission` VALUES ('3a5dc53b129411eabc92e0d55edb21ed', '93065725128b11eabc92e0d55edb21ed', '12');
INSERT INTO `sys_role_permission` VALUES ('3a5dc54c129411eabc92e0d55edb21ed', '93065725128b11eabc92e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc979eeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('3afc97a1effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc97d1effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '984d85c0e17c11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc97d8effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '5f20dcee752a11e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc988aeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9897effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc989beffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98a1effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98a5effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98a8effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98afeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98b6effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '43bff829c22c11e9a16fe0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98b9effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '5ee5def6c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98c0effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '7a711580c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98c4effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '9347f6b5c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98ceeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'a86a75bec31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98d1effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'b7fc03c1c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc98d8effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'e1ca8d71c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc995deffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '8f9431ddf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9961effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '1645ca35f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9967effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'c00bf9baf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc996eeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '0c6e38e5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9975effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '1901b113f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9978effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '105a3cfff7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc997feffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '1c2c7dfcf7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9983effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '12fc2fe0f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9986effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '1e975df5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc998aeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '3');
INSERT INTO `sys_role_permission` VALUES ('3afc9990effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '7e445701f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc9994effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'a18814a5f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3afc999beffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '4');
INSERT INTO `sys_role_permission` VALUES ('3afc99bdeffa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', '5');
INSERT INTO `sys_role_permission` VALUES ('3afc99c0effa11e99358e0d55edb21ed', '9c3fc709eff911e99358e0d55edb21ed', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('3cfee921effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('3cfee954effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3cfee95eeffb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3cfee976effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', '984d85c0e17c11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3cfee980effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', '5f20dcee752a11e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3cfeeb57effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('3cfeeb62effb11e99358e0d55edb21ed', 'd74b72f7d33d11e8a31ae0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5db89af695ea11ea9e2a28d244a5fdf0', '2', '15');
INSERT INTO `sys_role_permission` VALUES ('5db8a07b95ea11ea9e2a28d244a5fdf0', '2', '16');
INSERT INTO `sys_role_permission` VALUES ('5db8a14f95ea11ea9e2a28d244a5fdf0', '2', 'cec055c8141b11e98de8e0d55edb24ed');
INSERT INTO `sys_role_permission` VALUES ('5db8a1e795ea11ea9e2a28d244a5fdf0', '2', '1e9c4098141c11e98de8e0d55edb22ed');
INSERT INTO `sys_role_permission` VALUES ('5db8a25795ea11ea9e2a28d244a5fdf0', '2', '17');
INSERT INTO `sys_role_permission` VALUES ('5e948813b9f011eaabbb28d244a5fdf0', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('5e948da8b9f011eaabbb28d244a5fdf0', '1', '21');
INSERT INTO `sys_role_permission` VALUES ('5e948e5cb9f011eaabbb28d244a5fdf0', '1', '24');
INSERT INTO `sys_role_permission` VALUES ('5e948ec2b9f011eaabbb28d244a5fdf0', '1', '9a387c61588a22ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e948f2bb9f011eaabbb28d244a5fdf0', '1', 'b16c190f588a23ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e948f9bb9f011eaabbb28d244a5fdf0', '1', 'c5c41f58588a24ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e948ff6b9f011eaabbb28d244a5fdf0', '1', 'd5f24c01588a25ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e9495b8b9f011eaabbb28d244a5fdf0', '1', '20');
INSERT INTO `sys_role_permission` VALUES ('5e949636b9f011eaabbb28d244a5fdf0', '1', 'cec055c8141b11e84de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94969bb9f011eaabbb28d244a5fdf0', '1', '1e9c4098141c11e91de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e9496fcb9f011eaabbb28d244a5fdf0', '1', '39299e3f141c11e92de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e949769b9f011eaabbb28d244a5fdf0', '1', '39299e3f141c11e92de8e0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e9497bfb9f011eaabbb28d244a5fdf0', '1', '52015205141c11e93de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e949812b9f011eaabbb28d244a5fdf0', '1', 'ded174b2602211e860cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e949868b9f011eaabbb28d244a5fdf0', '1', '22');
INSERT INTO `sys_role_permission` VALUES ('5e9498beb9f011eaabbb28d244a5fdf0', '1', '5c62e9e3588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949915b9f011eaabbb28d244a5fdf0', '1', '9a387c61588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e94996eb9f011eaabbb28d244a5fdf0', '1', 'b16c190f588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e9499eeb9f011eaabbb28d244a5fdf0', '1', 'c5c41f58588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949a4ab9f011eaabbb28d244a5fdf0', '1', 'd5f24c01588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949aa1b9f011eaabbb28d244a5fdf0', '1', 'e6022149588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949af5b9f011eaabbb28d244a5fdf0', '1', 'f6fed1b3588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949b47b9f011eaabbb28d244a5fdf0', '1', '0aeb0d06588b21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949b9bb9f011eaabbb28d244a5fdf0', '1', '7d435f57522311ea90cc00163e13e3ca');
INSERT INTO `sys_role_permission` VALUES ('5e949becb9f011eaabbb28d244a5fdf0', '1', 'rolad65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('5e949c3eb9f011eaabbb28d244a5fdf0', '1', 'rolee65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('5e949c8fb9f011eaabbb28d244a5fdf0', '1', 'rolet65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('5e949d38b9f011eaabbb28d244a5fdf0', '1', 'roles65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('5e949d8eb9f011eaabbb28d244a5fdf0', '1', 'roled65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('5e949de0b9f011eaabbb28d244a5fdf0', '1', '23');
INSERT INTO `sys_role_permission` VALUES ('5e949e30b9f011eaabbb28d244a5fdf0', '1', '5c62e9e3588a81ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949e7eb9f011eaabbb28d244a5fdf0', '1', '5c62e9e3588a91ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('5e949ed6b9f011eaabbb28d244a5fdf0', '1', '2');
INSERT INTO `sys_role_permission` VALUES ('5e949f2cb9f011eaabbb28d244a5fdf0', '1', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e949f87b9f011eaabbb28d244a5fdf0', '1', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e949ffab9f011eaabbb28d244a5fdf0', '1', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a052b9f011eaabbb28d244a5fdf0', '1', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a0aab9f011eaabbb28d244a5fdf0', '1', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a118b9f011eaabbb28d244a5fdf0', '1', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a172b9f011eaabbb28d244a5fdf0', '1', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a1cab9f011eaabbb28d244a5fdf0', '1', '7');
INSERT INTO `sys_role_permission` VALUES ('5e94a224b9f011eaabbb28d244a5fdf0', '1', '8');
INSERT INTO `sys_role_permission` VALUES ('5e94a27bb9f011eaabbb28d244a5fdf0', '1', '9');
INSERT INTO `sys_role_permission` VALUES ('5e94a2d9b9f011eaabbb28d244a5fdf0', '1', '11');
INSERT INTO `sys_role_permission` VALUES ('5e94a333b9f011eaabbb28d244a5fdf0', '1', '12');
INSERT INTO `sys_role_permission` VALUES ('5e94a385b9f011eaabbb28d244a5fdf0', '1', '3');
INSERT INTO `sys_role_permission` VALUES ('5e94a3deb9f011eaabbb28d244a5fdf0', '1', '4');
INSERT INTO `sys_role_permission` VALUES ('5e94a434b9f011eaabbb28d244a5fdf0', '1', '5');
INSERT INTO `sys_role_permission` VALUES ('5e94a4a8b9f011eaabbb28d244a5fdf0', '1', '6');
INSERT INTO `sys_role_permission` VALUES ('5e94a502b9f011eaabbb28d244a5fdf0', '1', '10');
INSERT INTO `sys_role_permission` VALUES ('5e94a55bb9f011eaabbb28d244a5fdf0', '1', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('5e94a5beb9f011eaabbb28d244a5fdf0', '1', '50');
INSERT INTO `sys_role_permission` VALUES ('5e94a61ab9f011eaabbb28d244a5fdf0', '1', '15');
INSERT INTO `sys_role_permission` VALUES ('5e94a66fb9f011eaabbb28d244a5fdf0', '1', '16');
INSERT INTO `sys_role_permission` VALUES ('5e94a6c8b9f011eaabbb28d244a5fdf0', '1', 'cec055c8141b11e98de8e0d55edb24ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a71fb9f011eaabbb28d244a5fdf0', '1', '1e9c4098141c11e98de8e0d55edb22ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a7b3b9f011eaabbb28d244a5fdf0', '1', '39299e3f141c11e98de8e0d55edb23ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a810b9f011eaabbb28d244a5fdf0', '1', 'ded174b2602211e980cae0d55edb25ed');
INSERT INTO `sys_role_permission` VALUES ('5e94a874b9f011eaabbb28d244a5fdf0', '1', '17');
INSERT INTO `sys_role_permission` VALUES ('8707454e213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074569213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'af5c752a1b1b11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707456c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'f366b74f1cab11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074573213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '12');
INSERT INTO `sys_role_permission` VALUES ('8707457a213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707457d213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074581213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074588213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707458b213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074592213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074595213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '450931321ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707459c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '13');
INSERT INTO `sys_role_permission` VALUES ('8707459f213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745a3213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '41fd8a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745aa213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '52c387d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745ad213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '6ca08b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745b4213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '78028d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745b7213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '11');
INSERT INTO `sys_role_permission` VALUES ('870745bb213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745c2213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e11e8b4cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745c5213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e1e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745cc213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745cf213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b5bafa00cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745d3213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b6927ea0cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745d9213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b720fc80cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745dd213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b7b2e920cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745e4213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b827d820cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745e7213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e9e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745eb213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5b53fac50cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745f1213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e7e31e12e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745f5213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d37edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745fc213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870745ff213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074606213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d58edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074609213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0258edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707460d213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cca0258edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074614213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d35edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074617213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'da5a9cdbd36b11e8a31ae0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707461e213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '813ec19e1cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074621213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '45d96cf51cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074625213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '962630821cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707462b213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '561002571cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074639213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'a3780d0b1cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707463c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '830f75871cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074643213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'a1784ab11cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074647213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707464a213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e2e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074651213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e3e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074654213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('87074658213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707465f213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074662213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074665213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707466c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074670213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074673213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707467a213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707467d213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074688213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707468e213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074692213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'efcc36fa1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074699213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707469c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746a6213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746ad213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746b1213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746b4213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746bb213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746be213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746c2213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746c8213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746cc213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746d3213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'd1dac77f1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746d6213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746dd213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746e4213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746e7213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746eb213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746f1213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746f5213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746f8213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('870746ff213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '7c0a1924141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074702213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074709213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074714213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074717213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707471e213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '8f9431ddf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074721213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1645ca35f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707472b213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'c00bf9baf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707472f213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '0c6e38e5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074736213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1901b113f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074739213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '105a3cfff7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707473c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1c2c7dfcf7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074743213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '12fc2fe0f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074747213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '1e975df5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8707474a213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '3');
INSERT INTO `sys_role_permission` VALUES ('87074751213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '7e445701f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074754213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'a18814a5f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('87074758213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '4');
INSERT INTO `sys_role_permission` VALUES ('8707475f213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '5');
INSERT INTO `sys_role_permission` VALUES ('87074762213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('87074765213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '50');
INSERT INTO `sys_role_permission` VALUES ('8707476c213911ea9b06e0d55edb21ed', '8705da79213911ea9b06e0d55edb21ed', '645b37acf7a811e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887525cdeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752663effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'da5a9cdbd36b11e8a31ae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875266aeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'a5987858e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752671effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'f1e3144be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752677effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875267beffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752688effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '11699ad2e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887526c6effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '7c212564e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887526d4effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'ca24bb32e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887526deeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'd118c0b9e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887526e8effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'f4da0c45e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752703effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '1');
INSERT INTO `sys_role_permission` VALUES ('8875270aeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752711effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752718effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752722effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875272ceffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752730effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752955effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '1a6318111ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875295ceffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'd6d06968e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752963effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'def407ede33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752966effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'fe44786be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875296deffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '36be87d3e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752974effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '3174f05de31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875297beffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '18d5048ee33211e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752982effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '0f371f03e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752988effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '24ac40cce31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('8875298feffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752993effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752999effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887529a0effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887529deeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '706a3e3a204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887529e5effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'dcb0183ce3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887529ebeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'ef45135c204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('887529efeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '0af93a88e88211e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a03effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a0aeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a11effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a18effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a1feffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a22effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a29effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a30effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a36effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a3deffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a41effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a48effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a4eeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a55effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a5ceffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a5feffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a66effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a6deffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a74effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a7beffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a82effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a88effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a8feffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a96effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752a9deffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752aa4effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752aabeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752aaeeffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '43bff829c22c11e9a16fe0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752ab5effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '5ee5def6c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752abceffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '7a711580c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752ac2effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', '9347f6b5c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752ac9effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'a86a75bec31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752ad0effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'b7fc03c1c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752ad3effb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'e1ca8d71c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('88752b1feffb11e99358e0d55edb21ed', 'b81c30ce17db11e99d5300163e13e3ca', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('a09cd85ceffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('a09cd860effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cd866effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cd871effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '984d85c0e17c11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cd878effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '5f20dcee752a11e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcc3effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'da5a9cdbd36b11e8a31ae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcc6effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'a5987858e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdccdeffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'f1e3144be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcd0effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '1a6318111ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcd7effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '299137b41ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcdeeffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'd6d06968e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdce8effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'def407ede33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcefeffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'fe44786be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcf2effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '36be87d3e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdcf9effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '3174f05de31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd00effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '18d5048ee33211e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd03effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd0eeffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '0f371f03e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd11effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '24ac40cce31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd14effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd1beffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd29effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd2ceffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd33effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd37effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '450931321ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd7eeffa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a09cdd89effa11e99358e0d55edb21ed', '39f0da4701a111e98a32e0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e86f213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e886213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'af5c752a1b1b11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e88d213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'f366b74f1cab11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e891213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '12');
INSERT INTO `sys_role_permission` VALUES ('a3f0e898213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e89b213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8a2213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8a5213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8a9213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8af213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8b6213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '450931321ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8ba213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '13');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8c0213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8c4213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '41fd8a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8cb213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '52c387d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8ce213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '6ca08b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8d5213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '78028d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8dc213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '11');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8e3213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8e6213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e11e8b4cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8e9213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e1e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8f0213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8f4213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b5bafa00cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8fb213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b6927ea0cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e8fe213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b720fc80cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e901213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b7b2e920cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e908213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b827d820cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e90c213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e9e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e912213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5b53fac50cf611ea8da6e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e916213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e7e31e12e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e91d213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d37edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e920213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e923213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e92e213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d58edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e931213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0258edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e938213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cca0258edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e93b213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1d9b98e8e31e12e8b9cce0d35edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e942213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'da5a9cdbd36b11e8a31ae0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e946213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '813ec19e1cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e949213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '45d96cf51cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e950213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '962630821cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e953213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '561002571cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e961213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'a3780d0b1cba11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e968213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '830f75871cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e96b213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'a1784ab11cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e96f213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e1e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e975213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e2e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e979213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'ac3d003e1cbb11ea80e3e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e980213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('a3f0e983213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e986213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e98a213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e991213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e994213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e99b213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e99e213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9a2213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9a9213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9b3213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9b6213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9bd213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'efcc36fa1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9c0213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9c7213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9d2213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9d8213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9dc213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9e3213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9e6213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9e9213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9f0213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9f4213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9f7213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0e9fe213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'd1dac77f1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea01213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea08213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea0c213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea0f213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea12213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea19213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea1d213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea20213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea27213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '7c0a1924141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea2a213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea2e213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea38213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea3f213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea42213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '8f9431ddf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea46213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1645ca35f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea4c213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'c00bf9baf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea50213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '0c6e38e5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea53213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1901b113f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea5a213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '105a3cfff7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea5e213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1c2c7dfcf7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea64213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '12fc2fe0f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea68213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '1e975df5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea6b213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '3');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea72213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '7e445701f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea75213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'a18814a5f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea79213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '4');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea80213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '5');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea83213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea86213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '50');
INSERT INTO `sys_role_permission` VALUES ('a3f0ea8d213811ea9b06e0d55edb21ed', 'a3efab4f213811ea9b06e0d55edb21ed', '645b37acf7a811e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b1960b8f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('b6b199b88f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b200a78f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b201828f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b201c38f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b202008f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('b6b202398f4d11eabb0b28d244a5fdf0', '0342fa4beffb11e99358e0d55edb21ed', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8afefe6f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff00bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '984d85c0e17c11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff012f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '5f20dcee752a11e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff34cf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'da5a9cdbd36b11e8a31ae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff353f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'a5987858e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff356f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'f1e3144be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff35af0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1a6318111ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff361f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '299137b41ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff367f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'd6d06968e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff36bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'def407ede33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff36ef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'fe44786be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff375f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '36be87d3e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff378f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '3174f05de31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff37ff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '18d5048ee33211e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff383f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff386f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '0f371f03e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff38df0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '24ac40cce31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff394f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff397f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff39bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff3a1f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff3a5f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff3a8f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '450931321ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff3aff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '11699ad2e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff3b6f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '8c1834aaf08711e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff419f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7c212564e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff41cf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'ca24bb32e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff423f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '706a3e3a204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff42af0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'e574c40b204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff42df0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'dcb0183ce3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff431f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'd118c0b9e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff438f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'f4da0c45e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff43bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'ef45135c204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff442f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'f6ad58b9204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff445f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '0af93a88e88211e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff489f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1');
INSERT INTO `sys_role_permission` VALUES ('c8aff49ef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4a1f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4a5f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4acf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4aff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4b2f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4b9f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4bdf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4c3f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4caf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4cef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4d5f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'efcc36fa1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4d8f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4dbf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4e2f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4e6f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4ecf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4f0f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4f3f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4faf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff4fef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff501f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff508f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff50bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'd1dac77f1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff512f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff515f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff519f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff520f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff523f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff52af0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff52df0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff531f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff538f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7c0a1924141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff53bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff53ef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff545f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff564f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff56bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '43bff829c22c11e9a16fe0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff56ef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '5ee5def6c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff575f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7a711580c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff578f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '9347f6b5c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff57ff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'a86a75bec31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff583f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'b7fc03c1c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff586f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'e1ca8d71c31311e99358e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff60bf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '8f9431ddf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff60ff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1645ca35f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff615f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'c00bf9baf7b511e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff619f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '0c6e38e5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff61cf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1901b113f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff623f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '105a3cfff7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff626f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1c2c7dfcf7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff62af0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '12fc2fe0f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff631f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '1e975df5f7b611e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff634f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '3');
INSERT INTO `sys_role_permission` VALUES ('c8aff63ef0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '7e445701f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff645f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'a18814a5f79f11e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('c8aff64cf0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '4');
INSERT INTO `sys_role_permission` VALUES ('c8aff64ff0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', '5');
INSERT INTO `sys_role_permission` VALUES ('c8aff653f0a511e99358e0d55edb21ed', 'bf34f4ecf0a511e99358e0d55edb21ed', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('e20fd3b7ba2411eaabbb28d244a5fdf0', '3', '1');
INSERT INTO `sys_role_permission` VALUES ('e20fd734ba2411eaabbb28d244a5fdf0', '3', '21');
INSERT INTO `sys_role_permission` VALUES ('e20fd7e8ba2411eaabbb28d244a5fdf0', '3', '24');
INSERT INTO `sys_role_permission` VALUES ('e20fd84fba2411eaabbb28d244a5fdf0', '3', '9a387c61588a22ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fd8baba2411eaabbb28d244a5fdf0', '3', 'b16c190f588a23ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fd948ba2411eaabbb28d244a5fdf0', '3', 'c5c41f58588a24ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fd9c0ba2411eaabbb28d244a5fdf0', '3', 'd5f24c01588a25ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fda30ba2411eaabbb28d244a5fdf0', '3', '20');
INSERT INTO `sys_role_permission` VALUES ('e20fda9eba2411eaabbb28d244a5fdf0', '3', 'cec055c8141b11e84de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fdb2aba2411eaabbb28d244a5fdf0', '3', '1e9c4098141c11e91de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fded3ba2411eaabbb28d244a5fdf0', '3', '39299e3f141c11e92de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fdf6cba2411eaabbb28d244a5fdf0', '3', '39299e3f141c11e92de8e0d57edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fdfdbba2411eaabbb28d244a5fdf0', '3', '52015205141c11e93de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fe050ba2411eaabbb28d244a5fdf0', '3', 'ded174b2602211e860cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fe0c8ba2411eaabbb28d244a5fdf0', '3', '22');
INSERT INTO `sys_role_permission` VALUES ('e20fe12aba2411eaabbb28d244a5fdf0', '3', '5c62e9e3588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe6c7ba2411eaabbb28d244a5fdf0', '3', '9a387c61588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe76fba2411eaabbb28d244a5fdf0', '3', 'b16c190f588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe7e6ba2411eaabbb28d244a5fdf0', '3', 'c5c41f58588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe859ba2411eaabbb28d244a5fdf0', '3', 'd5f24c01588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe8c1ba2411eaabbb28d244a5fdf0', '3', 'e6022149588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe91cba2411eaabbb28d244a5fdf0', '3', 'f6fed1b3588a21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe979ba2411eaabbb28d244a5fdf0', '3', '0aeb0d06588b21ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fe9d5ba2411eaabbb28d244a5fdf0', '3', '7d435f57522311ea90cc00163e13e3ca');
INSERT INTO `sys_role_permission` VALUES ('e20fea31ba2411eaabbb28d244a5fdf0', '3', 'rolad65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('e20fea8fba2411eaabbb28d244a5fdf0', '3', 'rolee65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('e20feaebba2411eaabbb28d244a5fdf0', '3', 'rolet65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('e20feb45ba2411eaabbb28d244a5fdf0', '3', 'roles65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('e20feba2ba2411eaabbb28d244a5fdf0', '3', 'roled65a2e25f11e8b9cce0d55edb21e');
INSERT INTO `sys_role_permission` VALUES ('e20fec25ba2411eaabbb28d244a5fdf0', '3', '23');
INSERT INTO `sys_role_permission` VALUES ('e20fec89ba2411eaabbb28d244a5fdf0', '3', '5c62e9e3588a81ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20feceaba2411eaabbb28d244a5fdf0', '3', '5c62e9e3588a91ea90cc00163e13e3me');
INSERT INTO `sys_role_permission` VALUES ('e20fed4aba2411eaabbb28d244a5fdf0', '3', '2');
INSERT INTO `sys_role_permission` VALUES ('e20fedbdba2411eaabbb28d244a5fdf0', '3', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fee26ba2411eaabbb28d244a5fdf0', '3', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fee90ba2411eaabbb28d244a5fdf0', '3', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20feee4ba2411eaabbb28d244a5fdf0', '3', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fef3aba2411eaabbb28d244a5fdf0', '3', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fef91ba2411eaabbb28d244a5fdf0', '3', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20fefe6ba2411eaabbb28d244a5fdf0', '3', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e20ff044ba2411eaabbb28d244a5fdf0', '3', '7');
INSERT INTO `sys_role_permission` VALUES ('e20ff09aba2411eaabbb28d244a5fdf0', '3', '8');
INSERT INTO `sys_role_permission` VALUES ('e20ff0f0ba2411eaabbb28d244a5fdf0', '3', '9');
INSERT INTO `sys_role_permission` VALUES ('e20ff14aba2411eaabbb28d244a5fdf0', '3', '19');
INSERT INTO `sys_role_permission` VALUES ('e20ff1a0ba2411eaabbb28d244a5fdf0', '3', '11');
INSERT INTO `sys_role_permission` VALUES ('e20ff1f4ba2411eaabbb28d244a5fdf0', '3', '12');
INSERT INTO `sys_role_permission` VALUES ('e20ff24dba2411eaabbb28d244a5fdf0', '3', '3');
INSERT INTO `sys_role_permission` VALUES ('e20ff2acba2411eaabbb28d244a5fdf0', '3', '4');
INSERT INTO `sys_role_permission` VALUES ('e20ff304ba2411eaabbb28d244a5fdf0', '3', '5');
INSERT INTO `sys_role_permission` VALUES ('e20ff360ba2411eaabbb28d244a5fdf0', '3', '6');
INSERT INTO `sys_role_permission` VALUES ('e20ff3bfba2411eaabbb28d244a5fdf0', '3', '10');
INSERT INTO `sys_role_permission` VALUES ('e20ff41dba2411eaabbb28d244a5fdf0', '3', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('e20ff477ba2411eaabbb28d244a5fdf0', '3', '50');
INSERT INTO `sys_role_permission` VALUES ('e20ff4d3ba2411eaabbb28d244a5fdf0', '3', '15');
INSERT INTO `sys_role_permission` VALUES ('e20ff530ba2411eaabbb28d244a5fdf0', '3', '16');
INSERT INTO `sys_role_permission` VALUES ('e20ff58bba2411eaabbb28d244a5fdf0', '3', 'cec055c8141b11e98de8e0d55edb24ed');
INSERT INTO `sys_role_permission` VALUES ('e20ff5ebba2411eaabbb28d244a5fdf0', '3', '1e9c4098141c11e98de8e0d55edb22ed');
INSERT INTO `sys_role_permission` VALUES ('e20ff68cba2411eaabbb28d244a5fdf0', '3', '39299e3f141c11e98de8e0d55edb23ed');
INSERT INTO `sys_role_permission` VALUES ('e20ff6f9ba2411eaabbb28d244a5fdf0', '3', 'ded174b2602211e980cae0d55edb25ed');
INSERT INTO `sys_role_permission` VALUES ('e20ff759ba2411eaabbb28d244a5fdf0', '3', '17');
INSERT INTO `sys_role_permission` VALUES ('e9e21dcfeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e21e03effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '1');
INSERT INTO `sys_role_permission` VALUES ('e9e220a0effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'da5a9cdbd36b11e8a31ae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220a6effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'a5987858e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220aaeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'f1e3144be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220adeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '1a6318111ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220b4effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '299137b41ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220b7effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'd6d06968e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220beeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'def407ede33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220c2effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'fe44786be33111e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220c8effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '36be87d3e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220cfeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '3174f05de31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220d3effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '18d5048ee33211e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220d6effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '1d9b97d7e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220ddeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '0f371f03e31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220e0effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '24ac40cce31f11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220e4effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '41fd7a85e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220ebeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '52c377d2e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220eeeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '6ca02b60e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220f5effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '78025d14e31e11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220f8effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '366160081ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e220ffeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '450931321ef411e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22103effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '11699ad2e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22165effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '7c212564e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22169effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'ca24bb32e3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2216ceffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '706a3e3a204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22170effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'e574c40b204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22177effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'dcb0183ce3e511e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2217aeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'd118c0b9e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22181effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'f4da0c45e88111e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22192effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'ef45135c204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22199effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'f6ad58b9204e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2219ceffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '0af93a88e88211e8a03be0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221e0effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221e4effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221ebeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221eeeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '37eddaea6a3411e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221f5effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'bfdbd8fa723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221f8effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'd214d38c723011e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e221ffeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '9189ee2372c511e9ba07e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22202effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22209effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2220deffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22210effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22217effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'efcc36fa1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2221aeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2221eeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22225effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22228effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2222feffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22232effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22236effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2223deffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22240effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22247effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2224aeffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22251effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'd1dac77f1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22254effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22258effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2225beffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22262effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22265effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22269effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22270effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22273effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22277effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '7c0a1924141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2227deffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22281effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e22284effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e2228beffb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('e9e222e4effb11e99358e0d55edb21ed', '6d9a577f5c0511e9ad8f00163e040ce3', 'b413aa4cbcb111e8913868f7284f5721');
INSERT INTO `sys_role_permission` VALUES ('ebc6b3f5eff511e99358e0d55edb21ed', '5', '3b9567e6e17b11e8b9cce0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b414eff511e99358e0d55edb21ed', '5', '1');
INSERT INTO `sys_role_permission` VALUES ('ebc6b41beff511e99358e0d55edb21ed', '5', 'bafda0786a3311e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b425eff511e99358e0d55edb21ed', '5', '22cdeabe698d11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b42ceff511e99358e0d55edb21ed', '5', 'a78a20f4720b11e99aede0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b42feff511e99358e0d55edb21ed', '5', '8bf383ac141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b436eff511e99358e0d55edb21ed', '5', 'f4d05544141811e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b43aeff511e99358e0d55edb21ed', '5', 'cec055c8141b11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b43deff511e99358e0d55edb21ed', '5', 'dfb2b53d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b44beff511e99358e0d55edb21ed', '5', 'efcc36fa1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b44eeff511e99358e0d55edb21ed', '5', '1e9c4098141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b455eff511e99358e0d55edb21ed', '5', '39299e3f141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b458eff511e99358e0d55edb21ed', '5', '52015205141c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b45feff511e99358e0d55edb21ed', '5', '7a32ccc6156c11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b463eff511e99358e0d55edb21ed', '5', 'ded174b2602211e980cae0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b469eff511e99358e0d55edb21ed', '5', '5c743514141911e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b46deff511e99358e0d55edb21ed', '5', '18dabd95141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b474eff511e99358e0d55edb21ed', '5', '3b279c18141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b477eff511e99358e0d55edb21ed', '5', '59b5e527141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b481eff511e99358e0d55edb21ed', '5', '75eb7511141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b485eff511e99358e0d55edb21ed', '5', 'c3aa050d1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b48ceff511e99358e0d55edb21ed', '5', 'd1dac77f1f9e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b48feff511e99358e0d55edb21ed', '5', '2d6d603a141a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b496eff511e99358e0d55edb21ed', '5', 'bf09e8fe141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b499eff511e99358e0d55edb21ed', '5', '3a4d1e1c1f9a11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b49deff511e99358e0d55edb21ed', '5', 'd1d7a668141d11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4a3eff511e99358e0d55edb21ed', '5', '52a462d7141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4a7eff511e99358e0d55edb21ed', '5', '65f7d147141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4aaeff511e99358e0d55edb21ed', '5', '9ef2c284141e11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4b4eff511e99358e0d55edb21ed', '5', '69415652141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4b8eff511e99358e0d55edb21ed', '5', '7c0a1924141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4bfeff511e99358e0d55edb21ed', '5', '7c0a1925141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4c2eff511e99358e0d55edb21ed', '5', '8eeff21f141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4c6eff511e99358e0d55edb21ed', '5', 'a59d7b75141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('ebc6b4cceff511e99358e0d55edb21ed', '5', 'bbaab463141f11e98de8e0d55edb21ed');
INSERT INTO `sys_role_permission` VALUES ('f2daae4914b311eabc92e0d55edb21ed', 'f2d9072c14b311eabc92e0d55edb21ed', '16');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `ROLE_USER_ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) DEFAULT NULL,
  `USER_ID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ROLE_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='�û���ɫ��';

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('3c836a9d8f6511eabb0b28d244a5fdf0', '2', '3c836a9d8f6511eabb0b28d244a5fdf0');
INSERT INTO `sys_role_user` VALUES ('3dda18d4b9eb11eaabbb28d244a5fdf0', '3', '3dd5e0fcb9eb11eaabbb28d244a5fdf0');
INSERT INTO `sys_role_user` VALUES ('4163164b8f7d11eabb0b28d244a5fdf0', '2', '415281dd8f7d11eabb0b28d244a5fdf0');
INSERT INTO `sys_role_user` VALUES ('8594ed1895ea11ea9e2a28d244a5fdf0', '2', '859161d895ea11ea9e2a28d244a5fdf0');
INSERT INTO `sys_role_user` VALUES ('f40690de18a011e99d5300163e13e3ca', '1', '1');
INSERT INTO `sys_role_user` VALUES ('f40691de18a011e99d5300163e13e3ca', '1', '10');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(32) NOT NULL,
  `DEP_ID` varchar(32) DEFAULT NULL,
  `ORG_ID` varchar(32) DEFAULT NULL,
  `USER_NAME` varchar(32) NOT NULL,
  `USER_ACCT` varchar(32) NOT NULL,
  `PASSWORD` varchar(64) NOT NULL,
  `SEX` char(1) DEFAULT NULL,
  `EMAIL` varchar(64) DEFAULT NULL,
  `PHONE` varchar(16) DEFAULT NULL,
  `TELEPHONE` varchar(16) DEFAULT NULL,
  `FAXPHONE` varchar(16) DEFAULT NULL,
  `ADDR` varchar(128) DEFAULT NULL,
  `BIRTHDAY` date DEFAULT NULL,
  `HEAD_IMG_URL` varchar(256) DEFAULT NULL,
  `IS_LOGIN` char(1) NOT NULL DEFAULT 'Y',
  `IS_PHONE_LOGIN` char(1) DEFAULT 'Y',
  `ALLOW_MAC` varchar(256) DEFAULT NULL,
  `STATUS` char(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER_ID` varchar(32) NOT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `UPDATE_USER_ID` varchar(32) DEFAULT NULL,
  `LAST_LOGIN_TIME` datetime DEFAULT NULL,
  `current_login_time` datetime DEFAULT NULL,
  `is_edit_password` char(1) DEFAULT NULL,
  `last_edit_password_time` datetime DEFAULT NULL,
  `create_org_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `pk_USER_ID` (`USER_ID`) USING BTREE,
  KEY `idx_USER_ACCT` (`USER_ACCT`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='�û���';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '1', '平台系统超管', 'administrator', '$2a$10$XyOeT5OlhSaOYy8q5XRgjeM9qTfk07B1MPk4erzfS68r3MiEnSCby', '1', null, '13399854637', null, null, null, null, null, 'Y', 'Y', null, 'C', '2018-09-18 17:46:26', '1', '2020-06-30 00:25:06', '1', '2020-06-30 00:23:45', '2020-06-30 00:24:44', 'N', '2020-06-30 00:25:06', '1');
INSERT INTO `sys_user` VALUES ('10', '1', '1', '平台管理员', 'admin', '$2a$10$G0RB4OP3/4CybNOgKtf3ZOCsKwyF3jxlsgevLUkOWSt3uqzOyQbFG', '1', null, null, null, null, null, null, null, 'Y', 'Y', null, 'C', '2018-09-18 17:46:26', '1', '2020-06-30 14:17:21', '10', '2020-06-30 00:52:25', '2020-06-30 14:17:20', 'N', '2020-06-30 00:21:04', '1');
INSERT INTO `sys_user` VALUES ('3c836a9d8f6511eabb0b28d244a5fdf0', '1', '1', 'test22', 'test0506', '$2a$10$Ch9joDtUq17yNsMVx.TmX.EQMX.GtHnezLMG/NblUdB.VLCvPhnGC', '0', '', '', null, null, null, null, null, 'Y', 'Y', null, 'C', '2020-05-06 14:45:55', '10', '2020-05-06 14:45:55', null, null, null, 'Y', null, '1');
INSERT INTO `sys_user` VALUES ('3dd5e0fcb9eb11eaabbb28d244a5fdf0', null, '1', 'test3', 'test3', '$2a$10$J0AIR3PlevAmNl/V/Oqea.6vSgkGu1QgI281hnaYQLzNOnFZZ4LKC', '0', '', '', null, null, null, null, null, 'Y', 'Y', null, 'C', '2020-06-29 17:29:56', '10', '2020-06-29 17:30:13', null, null, '2020-06-29 17:30:13', 'Y', null, '1');
INSERT INTO `sys_user` VALUES ('859161d895ea11ea9e2a28d244a5fdf0', null, '2', '韩长长', 'test1', '$2a$10$xGdk7tR3hF.zXLFURy20L.i0NPwa7mUUTc2u4foSjJKoGERyouX4m', null, null, '18084037717', null, null, null, null, null, 'Y', 'Y', null, 'C', '2020-05-14 21:54:46', '1', '2020-05-14 21:55:41', null, null, '2020-05-14 21:55:41', 'Y', null, '1');

-- ----------------------------
-- Function structure for add_customer_brand_id
-- ----------------------------
DROP FUNCTION IF EXISTS `add_customer_brand_id`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `add_customer_brand_id`(`add_import_type` varchar(32)) RETURNS varchar(32) CHARSET utf8mb4
BEGIN 
		SET @c = (SELECT
				CONCAT(
					add_import_type,
					IFNULL(
						(
							SELECT
								(
									substring(
										customer_brand_id,
										1 + LENGTH(add_import_type)
									) + 1
								)
							FROM
								customer_brand t
							WHERE
								LEFT (
									customer_brand_id,
									LENGTH(add_import_type)
								) = add_import_type
							ORDER BY
								customer_brand_id DESC
							LIMIT 1
						),'100001'
					)
				));
    RETURN @c;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getChildOrg
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildOrg`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getChildOrg`(orgid VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN
DECLARE oTemp VARCHAR(4000);
DECLARE oTempChild VARCHAR(4000);

SET oTemp = '';
SET oTempChild = CAST(orgid AS CHAR);

WHILE oTempChild IS NOT NULL
DO
SET oTemp = CONCAT(oTemp,',',oTempChild);
SELECT GROUP_CONCAT(org_id) INTO oTempChild FROM org WHERE FIND_IN_SET(parent_id,oTempChild) > 0;
END WHILE;
SET oTemp = substring(oTemp,2);
RETURN oTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getChildOrgChr
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildOrgChr`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getChildOrgChr`(orgid VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN
DECLARE oTemp VARCHAR(4000);
DECLARE oTempChild VARCHAR(4000);
DECLARE allId VARCHAR(4000);
SET oTemp = '';
SET oTempChild = CAST(orgid AS CHAR);
SET allId = CONCAT('''',CAST(orgid AS CHAR),'''');

WHILE oTempChild IS NOT NULL
DO
SET oTemp = CONCAT(oTemp,',',allId);
SELECT GROUP_CONCAT('''',org_id,'''') INTO allId FROM org where FIND_IN_SET(parent_id,oTempChild) > 0;
SELECT GROUP_CONCAT(org_id) INTO oTempChild  FROM org where FIND_IN_SET(parent_id,oTempChild) > 0;

END WHILE;

SET oTemp = substring(oTemp,2);
RETURN oTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getChildRole
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildRole`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getChildRole`(roleids VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN
DECLARE oTemp VARCHAR(4000);
DECLARE oTempChild VARCHAR(4000);

SET oTemp = '';
SET oTempChild = CAST(roleids AS CHAR);

WHILE oTempChild IS NOT NULL
DO
SET oTemp = CONCAT(oTemp,',',oTempChild);
SELECT GROUP_CONCAT(role_id) INTO oTempChild FROM sys_role WHERE FIND_IN_SET(parent_id,oTempChild) > 0;
END WHILE;
SET oTemp = substring(oTemp,2);
RETURN oTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getParentOrg
-- ----------------------------
DROP FUNCTION IF EXISTS `getParentOrg`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getParentOrg`(orgid VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8mb4
BEGIN
DECLARE oTemp VARCHAR(4000);
DECLARE oTempParent VARCHAR(4000);

SET oTemp = '';
SET oTempParent = CAST(orgid AS CHAR);

WHILE oTempParent IS NOT NULL
DO
SET oTemp = CONCAT(oTemp,',',oTempParent);
SELECT GROUP_CONCAT(parent_id) INTO oTempParent FROM org WHERE FIND_IN_SET(org_id,oTempParent) > 0;
END WHILE;
SET oTemp = substring(oTemp,2);
RETURN oTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getUserByRole
-- ----------------------------
DROP FUNCTION IF EXISTS `getUserByRole`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getUserByRole`(roleid VARCHAR(1000)) RETURNS text CHARSET utf8mb4
begin 
    declare c text;
    select group_concat(user_id) from sys_role_user where FIND_IN_SET(role_id,getChildRole(roleid)) into c;
    return c;
end
;;
DELIMITER ;
