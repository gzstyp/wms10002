/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.3.66
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 192.168.3.66:3306
 Source Schema         : gzjz_wms

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 28/07/2020 12:02:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for floor_area
-- ----------------------------
DROP TABLE IF EXISTS `floor_area`;
CREATE TABLE `floor_area`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层区域主键',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层区域名称',
  `suffix` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位区域位置',
  PRIMARY KEY (`kid`) USING BTREE,
  UNIQUE INDEX `index_name`(`name`, `suffix`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层区域(分南北边)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of floor_area
-- ----------------------------
INSERT INTO `floor_area` VALUES ('ffffffffc57e558cffffffff863e4b69', '三号仓库一楼', '北区');
INSERT INTO `floor_area` VALUES ('ffffffffc6c03de30000000026331e6a', '三号仓库一楼', '南区');
INSERT INTO `floor_area` VALUES ('ffffffffc77c1766000000003ea332a9', '三号仓库二楼', '北区');
INSERT INTO `floor_area` VALUES ('ffffffffc83d7c02000000005238066b', '三号仓库二楼', '南区');
INSERT INTO `floor_area` VALUES ('ffffffffc8983885ffffffffce33afe2', '二号仓库一楼', '北区');
INSERT INTO `floor_area` VALUES ('ffffffffc8eecc21ffffffff9b471517', '二号仓库一楼', '南区');
INSERT INTO `floor_area` VALUES ('ffffffffc902ca15000000006be3dcd8', '二号仓库二楼', '北区');
INSERT INTO `floor_area` VALUES ('ffffffffcd9ea289000000001199540b', '二号仓库二楼', '南区');

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片的id主键',
  `width` int(0) UNSIGNED NOT NULL COMMENT '图片的宽度',
  `height` int(0) UNSIGNED NOT NULL COMMENT '图片的高度',
  `usemap` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'usemap值(含map节点的name和id)',
  `floor_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层平面图名称',
  `img_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层平面图的路径',
  `add_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层图片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('ffffffffe56e8ef0ffffffff912af742', 1496, 568, 'areaMap', '一楼二层', '/images/ffffffffe56e8ef0ffffffff912af742.png', '2020-05-30 14:07:27');
INSERT INTO `images` VALUES ('ffffffffe56e8ef0ffffffff912af74a', 1496, 568, 'areaMap', '一楼一层', '/images/ffffffffe56e8ef0ffffffff912af74a.png', '2020-05-30 14:07:27');

-- ----------------------------
-- Table structure for images_maps
-- ----------------------------
DROP TABLE IF EXISTS `images_maps`;
CREATE TABLE `images_maps`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片货位号id',
  `images_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层图片的id',
  `item_storage_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位号',
  `coords` varchar(667) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'coords值',
  `add_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`kid`) USING BTREE,
  UNIQUE INDEX `index_storage_code`(`item_storage_code`) USING BTREE,
  UNIQUE INDEX `index_coords`(`coords`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层图片货位号信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images_maps
-- ----------------------------
INSERT INTO `images_maps` VALUES ('0000000021812f24ffffffff8807676b', 'ffffffffe56e8ef0ffffffff912af74a', '3-1A-01-03', '212,331,304,422', '2020-05-29 16:53:39');
INSERT INTO `images_maps` VALUES ('000000004716af5fffffffffdad4ef63', 'ffffffffe56e8ef0ffffffff912af742', '3-1A-01-02', '211,149,304,240', '2020-05-29 16:52:34');
INSERT INTO `images_maps` VALUES ('0000000063c207f0ffffffffa1fa6840', 'ffffffffe56e8ef0ffffffff912af742', '3-1A-01-01', '237,102,307,125', '2020-05-29 12:43:20');
INSERT INTO `images_maps` VALUES ('ffffffffcf21f3a700000000110faaca', 'ffffffffe56e8ef0ffffffff912af74a', '3-1A-02-01', '375,137,393,152', '2020-05-29 16:54:50');

-- ----------------------------
-- Table structure for layer_grid
-- ----------------------------
DROP TABLE IF EXISTS `layer_grid`;
CREATE TABLE `layer_grid`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位号主键id',
  `floor_area_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层区域id',
  `grids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层区域货位信息',
  PRIMARY KEY (`kid`) USING BTREE,
  UNIQUE INDEX `index_area_id`(`floor_area_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层区域货位信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of layer_grid
-- ----------------------------
INSERT INTO `layer_grid` VALUES ('00000000160278a1ffffffffa30820ae', 'ffffffffc77c1766000000003ea332a9', '[{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:1},{\"LAYER\":\"03\",TYPE:1}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\",TYPE:2},{\"LAYER\":\"03\",TYPE:3}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\",TYPE:2},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\",TYPE:3}]}]}]');
INSERT INTO `layer_grid` VALUES ('000000006252bfe1ffffffffd35d3f57', 'ffffffffc8983885ffffffffce33afe2', '[{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\",\"TYPE\":1},{\"LAYER\":\"02\",\"TYPE\":2},{\"LAYER\":\"03\",\"TYPE\":2}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\",\"TYPE\":2},{\"LAYER\":\"02\",\"TYPE\":3},{\"LAYER\":\"03\",\"TYPE\":2}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\",\"TYPE\":2},{\"LAYER\":\"02\",\"TYPE\":1},{\"LAYER\":\"03\",\"TYPE\":1}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]}]');
INSERT INTO `layer_grid` VALUES ('ffffffffe19e6e29000000002faf8f92', 'ffffffffcd9ea289000000001199540b', '[{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\",TYPE:1},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\",TYPE:3}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:1},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\",TYPE:2},{\"LAYER\":\"03\",TYPE:3}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]}]');
INSERT INTO `layer_grid` VALUES ('fffffffff92d3686ffffffffc751093d', 'ffffffffc83d7c02000000005238066b', '[{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\",TYPE:1},{\"LAYER\":\"02\",TYPE:2},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:3},{\"LAYER\":\"03\",TYPE:2}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\",TYPE:2},{\"LAYER\":\"02\",TYPE:1},{\"LAYER\":\"03\",TYPE:1}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\",TYPE:2},{\"LAYER\":\"03\",TYPE:3}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-03-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-01-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]},{\"jkzbh\":\"2-2A-02-\",\"list\":[{\"GRID\":\"-01\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-02\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-03\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-04\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-05\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]},{\"GRID\":\"-06\",\"list\":[{\"LAYER\":\"01\"},{\"LAYER\":\"02\"},{\"LAYER\":\"03\"}]}]}]');

-- ----------------------------
-- Table structure for storage_point
-- ----------------------------
DROP TABLE IF EXISTS `storage_point`;
CREATE TABLE `storage_point`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库货柜位置id',
  `item_storage_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位号',
  `point` json NOT NULL COMMENT '坐标',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`kid`) USING BTREE,
  UNIQUE INDEX `index_storage_code`(`item_storage_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storage_point
-- ----------------------------
INSERT INTO `storage_point` VALUES ('000000000291ef63ffffffffca210dd1', '3-2C-03-03', '{\"x1\": \"1875\", \"x2\": \"1935\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 20:04:29');
INSERT INTO `storage_point` VALUES ('000000000677ab7e000000005d90beb0', '3-2B-02-02', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:36:12');
INSERT INTO `storage_point` VALUES ('0000000008e04eadffffffffefc3d3e5', '2-1A-07-02', '{\"x1\": \"1863\", \"x2\": \"1923\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 18:16:04');
INSERT INTO `storage_point` VALUES ('00000000095bf063000000002f30e233', '2-1A-10-02', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 18:19:37');
INSERT INTO `storage_point` VALUES ('000000000be6d9ce000000000c9bc8c1', '3-2A-04-03', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:19:55');
INSERT INTO `storage_point` VALUES ('000000000cbcc34fffffffff8c740925', '2-1A-07-01', '{\"x1\": \"1863\", \"x2\": \"1923\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 18:15:33');
INSERT INTO `storage_point` VALUES ('000000000daa669bffffffffafd4076e', '3-1A-04-02', '{\"x1\": \"485\", \"x2\": \"545\", \"y1\": \"530\", \"y2\": \"600\"}', '2020-06-23 19:04:01');
INSERT INTO `storage_point` VALUES ('000000000f0f1eaa0000000003db997b', '3-1A-05-01', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"635\", \"y2\": \"705\"}', '2020-06-23 19:04:52');
INSERT INTO `storage_point` VALUES ('000000000f2916b6ffffffffa589aceb', '3-2A-07-02', '{\"x1\": \"377\", \"x2\": \"437\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:28:36');
INSERT INTO `storage_point` VALUES ('000000001056e368000000007f0aed80', '3-2A-04-01', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:18:23');
INSERT INTO `storage_point` VALUES ('00000000120f71b0ffffffffcaf6e0e2', '2-2A-07-01', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:44:12');
INSERT INTO `storage_point` VALUES ('00000000141d6a2c000000005b0c5420', '2-2A-05-03', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:41:17');
INSERT INTO `storage_point` VALUES ('000000001454ac2b00000000388c4aaa', '2-2B-06-02', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:29:26');
INSERT INTO `storage_point` VALUES ('0000000016df9541fffffffff03d0061', '2-2B-08-03', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:31:25');
INSERT INTO `storage_point` VALUES ('00000000170c145cfffffffffbfc7829', '3-2A-02-02', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:13:41');
INSERT INTO `storage_point` VALUES ('000000001b27a09b0000000046815f3b', '3-2C-03-02', '{\"x1\": \"1875\", \"x2\": \"1935\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 20:04:04');
INSERT INTO `storage_point` VALUES ('000000001c3c59330000000065f256ec', '3-1A-04-03', '{\"x1\": \"485\", \"x2\": \"545\", \"y1\": \"420\", \"y2\": \"490\"}', '2020-06-23 19:04:19');
INSERT INTO `storage_point` VALUES ('000000001cb3a33500000000165acba2', '2-1A-10-03', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 18:19:54');
INSERT INTO `storage_point` VALUES ('000000001fc11b7c00000000056869fb', '2-2B-05-02', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:28:08');
INSERT INTO `storage_point` VALUES ('0000000021161d0b000000006ad04f6c', '3-2A-07-01', '{\"x1\": \"377\", \"x2\": \"437\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:28:00');
INSERT INTO `storage_point` VALUES ('0000000022fe74fc000000000b0fe2c4', '2-2B-02-02', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:23:18');
INSERT INTO `storage_point` VALUES ('000000002381bb1effffffffe26fd486', '2-2B-01-02', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 17:37:14');
INSERT INTO `storage_point` VALUES ('0000000024a18de300000000316611fa', '2-1B-03-02', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 17:50:09');
INSERT INTO `storage_point` VALUES ('00000000255b388d00000000363cd08a', '2-1B-06-01', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 17:56:06');
INSERT INTO `storage_point` VALUES ('0000000025b74105ffffffffcb4de3e2', '3-2C-01-02', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 20:01:44');
INSERT INTO `storage_point` VALUES ('0000000028506f06000000007a57626e', '3-1A-02-01', '{\"x1\": \"485\", \"x2\": \"545\", \"y1\": \"1055\", \"y2\": \"1125\"}', '2020-06-23 18:59:54');
INSERT INTO `storage_point` VALUES ('000000002bdce3340000000032d58a38', '2-2A-07-02', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:44:27');
INSERT INTO `storage_point` VALUES ('000000002ef78ca7ffffffffb7c89721', '3-1A-03-03', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"1270\", \"y2\": \"1340\"}', '2020-06-23 19:01:35');
INSERT INTO `storage_point` VALUES ('000000002ef7e6cfffffffff96586c15', '3-2B-11-01', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:53:03');
INSERT INTO `storage_point` VALUES ('000000002fdd923a0000000035127f34', '2-2B-06-03', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:29:37');
INSERT INTO `storage_point` VALUES ('0000000031573bb4000000003e6efa57', '3-2C-08-03', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 20:10:05');
INSERT INTO `storage_point` VALUES ('0000000031756226ffffffffe4a0db1b', '3-2B-08-02', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:50:16');
INSERT INTO `storage_point` VALUES ('000000003179e205ffffffffc9eb7b81', '2-2B-01-03', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 17:39:51');
INSERT INTO `storage_point` VALUES ('0000000032126629000000004a9d1426', '3-2B-07-01', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:48:08');
INSERT INTO `storage_point` VALUES ('0000000033fbd14b000000003b5fe8ed', '3-2A-06-01', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:26:35');
INSERT INTO `storage_point` VALUES ('0000000034aa5819000000000b01843f', '2-2B-04-02', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:27:05');
INSERT INTO `storage_point` VALUES ('0000000035a4520a00000000587ba004', '3-2B-02-03', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:36:26');
INSERT INTO `storage_point` VALUES ('000000003798f54a0000000014a53ef4', '3-2B-10-03', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:52:22');
INSERT INTO `storage_point` VALUES ('00000000388ab944ffffffff9703b24c', '2-1A-03-01', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 18:08:04');
INSERT INTO `storage_point` VALUES ('0000000038da3cc3000000004088866c', '2-2A-03-03', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:39:24');
INSERT INTO `storage_point` VALUES ('000000003a03a0b2ffffffffaac2acc9', '3-2B-05-03', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:45:47');
INSERT INTO `storage_point` VALUES ('000000003dd1a618ffffffff8902a83c', '3-2C-07-02', '{\"x1\": \"1767\", \"x2\": \"1826\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 20:08:47');
INSERT INTO `storage_point` VALUES ('000000004123818c00000000645ef4be', '3-2C-05-02', '{\"x1\": \"2093\", \"x2\": \"2154\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 20:06:33');
INSERT INTO `storage_point` VALUES ('0000000041692d57ffffffffc0fc215b', '2-1A-01-01', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 18:02:07');
INSERT INTO `storage_point` VALUES ('0000000042d193450000000046ade9ec', '2-2B-01-01', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"1070\", \"y2\": \"1145\"}', '2020-06-23 17:11:19');
INSERT INTO `storage_point` VALUES ('0000000042e87f450000000070ea40ee', '3-2B-04-03', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:44:35');
INSERT INTO `storage_point` VALUES ('0000000043273695ffffffff9d36776a', '2-2A-08-03', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:45:49');
INSERT INTO `storage_point` VALUES ('0000000043648c7f000000004419c4d9', '2-2B-09-01', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:32:01');
INSERT INTO `storage_point` VALUES ('000000004484a799ffffffffbaed252d', '2-2A-06-01', '{\"x1\": \"2077\", \"x2\": \"2137\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:41:43');
INSERT INTO `storage_point` VALUES ('0000000044d712d4000000005472c54f', '3-2B-10-01', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:51:49');
INSERT INTO `storage_point` VALUES ('0000000045cc40ad0000000007882fa9', '3-2C-02-01', '{\"x1\": \"1767\", \"x2\": \"1826\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 20:02:42');
INSERT INTO `storage_point` VALUES ('0000000045ed7891ffffffffb29d3f96', '3-2C-06-03', '{\"x1\": \"1875\", \"x2\": \"1935\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 20:08:07');
INSERT INTO `storage_point` VALUES ('00000000467600f70000000037cc9ce6', '2-2A-09-02', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:46:28');
INSERT INTO `storage_point` VALUES ('0000000047c6d1c2ffffffffcb1ca28e', '2-1A-06-02', '{\"x1\": \"2010\", \"x2\": \"2070\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 18:14:09');
INSERT INTO `storage_point` VALUES ('0000000047ed4cb300000000388d4947', '2-1A-04-01', '{\"x1\": \"1902\", \"x2\": \"1962\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 18:09:27');
INSERT INTO `storage_point` VALUES ('000000004812f8a0000000007384e362', '3-2B-01-01', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:34:02');
INSERT INTO `storage_point` VALUES ('000000004842ffa4ffffffffe4e29a87', '2-1B-01-02', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 17:05:52');
INSERT INTO `storage_point` VALUES ('000000004a14a4190000000041e1ff6f', '3-2C-06-02', '{\"x1\": \"1875\", \"x2\": \"1935\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 20:07:49');
INSERT INTO `storage_point` VALUES ('000000004a81da21ffffffffeb116787', '2-1B-04-02', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 17:51:52');
INSERT INTO `storage_point` VALUES ('000000004ae2b68f000000004aacb8d2', '2-2A-11-01', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:48:43');
INSERT INTO `storage_point` VALUES ('000000004bd72dfa00000000189fe6f9', '2-1A-07-03', '{\"x1\": \"1863\", \"x2\": \"1923\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 18:16:27');
INSERT INTO `storage_point` VALUES ('000000004cd0f3e7ffffffff84c0a669', '3-2C-05-03', '{\"x1\": \"2093\", \"x2\": \"2154\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 20:06:51');
INSERT INTO `storage_point` VALUES ('000000004d026c9cffffffff8dd905e0', '2-1B-05-01', '{\"x1\": \"890\", \"x2\": \"950\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 17:54:33');
INSERT INTO `storage_point` VALUES ('000000004d48d5e6ffffffffa771ba1a', '2-1B-05-02', '{\"x1\": \"890\", \"x2\": \"950\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 17:54:57');
INSERT INTO `storage_point` VALUES ('000000004d8cb974ffffffffd296a543', '2-1A-03-02', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 18:08:22');
INSERT INTO `storage_point` VALUES ('000000004e25e949000000000edddd04', '2-1B-01-03', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 17:07:30');
INSERT INTO `storage_point` VALUES ('000000004e95a4a0ffffffffb24a304f', '2-1A-09-03', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 18:19:05');
INSERT INTO `storage_point` VALUES ('000000004fe8d4570000000013b3e074', '3-2A-03-03', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:17:32');
INSERT INTO `storage_point` VALUES ('0000000050186528000000003e5bc5ad', '2-1A-09-02', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 18:18:49');
INSERT INTO `storage_point` VALUES ('000000005198bd35fffffffffe3b6f91', '3-2C-07-03', '{\"x1\": \"1767\", \"x2\": \"1826\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 20:09:04');
INSERT INTO `storage_point` VALUES ('0000000051f85950ffffffffd3acd793', '2-2B-09-02', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:32:24');
INSERT INTO `storage_point` VALUES ('00000000538b69bb000000005de64057', '2-2B-03-03', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:26:27');
INSERT INTO `storage_point` VALUES ('0000000053a042d100000000094331b1', '3-1A-01-01', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"1055\", \"y2\": \"1125\"}', '2020-06-23 18:51:25');
INSERT INTO `storage_point` VALUES ('0000000053e0fc95ffffffffae75cf5f', '2-2B-04-01', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:26:52');
INSERT INTO `storage_point` VALUES ('0000000056d5029100000000355fdddc', '2-2A-11-03', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:49:35');
INSERT INTO `storage_point` VALUES ('00000000584052f5fffffffffb220805', '3-2B-03-01', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:40:37');
INSERT INTO `storage_point` VALUES ('000000005c6910d5fffffffff0f5f5c8', '2-1B-03-03', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 17:50:32');
INSERT INTO `storage_point` VALUES ('000000005cba6486000000007609828d', '2-1B-06-03', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 17:57:14');
INSERT INTO `storage_point` VALUES ('000000005d10cf460000000046d067fc', '3-1A-01-02', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"1160\", \"y2\": \"1230\"}', '2020-06-23 18:59:11');
INSERT INTO `storage_point` VALUES ('000000005d294ea1ffffffff9247af46', '3-2A-01-02', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:11:35');
INSERT INTO `storage_point` VALUES ('000000005df85197ffffffffb7cc60d9', '3-1A-04-01', '{\"x1\": \"485\", \"x2\": \"545\", \"y1\": \"635\", \"y2\": \"705\"}', '2020-06-23 19:03:34');
INSERT INTO `storage_point` VALUES ('000000005f80c262fffffffffc803e22', '3-2A-01-01', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:06:35');
INSERT INTO `storage_point` VALUES ('0000000061d99e30ffffffffa1dbcbb5', '2-1A-02-03', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 18:07:10');
INSERT INTO `storage_point` VALUES ('0000000063116595ffffffffecbefd2d', '2-1B-02-01', '{\"x1\": \"892\", \"x2\": \"952\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 17:44:07');
INSERT INTO `storage_point` VALUES ('00000000633efdefffffffffafaaa71d', '3-2C-01-01', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:59:47');
INSERT INTO `storage_point` VALUES ('0000000063a837430000000031069a9f', '2-1B-02-03', '{\"x1\": \"892\", \"x2\": \"952\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 17:46:22');
INSERT INTO `storage_point` VALUES ('00000000644e5f95000000005d57eced', '2-1B-05-03', '{\"x1\": \"890\", \"x2\": \"950\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 17:55:36');
INSERT INTO `storage_point` VALUES ('00000000648f9d82000000001ba0ac75', '3-2C-05-01', '{\"x1\": \"2093\", \"x2\": \"2154\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 20:06:13');
INSERT INTO `storage_point` VALUES ('0000000065a5d463ffffffff983c8f38', '3-2B-01-03', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:35:34');
INSERT INTO `storage_point` VALUES ('0000000067cc691dffffffffdf6e1189', '2-1B-07-02', '{\"x1\": \"557\", \"x2\": \"617\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 17:59:29');
INSERT INTO `storage_point` VALUES ('0000000068fb6880ffffffffc490b061', '2-2A-02-01', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:37:40');
INSERT INTO `storage_point` VALUES ('000000006a9faa56ffffffff9bcf17d2', '2-2B-10-02', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:34:38');
INSERT INTO `storage_point` VALUES ('000000006d8cc658ffffffffaaa648a1', '2-1A-08-01', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 18:16:45');
INSERT INTO `storage_point` VALUES ('000000006dcc8ba50000000077c85ba3', '2-2A-02-02', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:38:11');
INSERT INTO `storage_point` VALUES ('000000006fff766d00000000694aa4c1', '3-2A-05-02', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:25:35');
INSERT INTO `storage_point` VALUES ('00000000738832840000000069926718', '3-2A-04-02', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:19:10');
INSERT INTO `storage_point` VALUES ('0000000074ae84ee000000006ce47748', '2-2A-06-03', '{\"x1\": \"2077\", \"x2\": \"2137\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:43:20');
INSERT INTO `storage_point` VALUES ('0000000074c2a584ffffffffc529ea71', '3-2B-01-02', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:35:19');
INSERT INTO `storage_point` VALUES ('0000000075cb64ee00000000499ac629', '3-2C-04-02', '{\"x1\": \"1984\", \"x2\": \"2045\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 20:05:19');
INSERT INTO `storage_point` VALUES ('000000007720d483ffffffffcdcc7545', '3-2B-11-02', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:53:17');
INSERT INTO `storage_point` VALUES ('000000007767e402ffffffff8b049ec3', '3-2B-06-03', '{\"x1\": \"1414\", \"x2\": \"1472\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:47:37');
INSERT INTO `storage_point` VALUES ('00000000791eb037000000001f2f29c3', '3-2A-03-01', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:14:30');
INSERT INTO `storage_point` VALUES ('000000007927c985ffffffffd64df6bf', '2-2B-07-02', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:30:23');
INSERT INTO `storage_point` VALUES ('000000007ac30f0bffffffff984bd144', '3-2C-08-01', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 20:09:36');
INSERT INTO `storage_point` VALUES ('000000007c4d026dffffffff8ade769a', '2-1B-07-01', '{\"x1\": \"557\", \"x2\": \"617\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 17:58:39');
INSERT INTO `storage_point` VALUES ('000000007c783c6900000000678184d7', '2-1A-06-01', '{\"x1\": \"2010\", \"x2\": \"2070\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 18:13:53');
INSERT INTO `storage_point` VALUES ('000000007c92e10300000000373f62e6', '2-2A-05-02', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:41:04');
INSERT INTO `storage_point` VALUES ('000000007e76d706000000001779f305', '3-1A-02-02', '{\"x1\": \"485\", \"x2\": \"545\", \"y1\": \"1160\", \"y2\": \"1230\"}', '2020-06-23 19:00:26');
INSERT INTO `storage_point` VALUES ('000000007ef1cb98ffffffffe5f06a7e', '3-1A-02-03', '{\"x1\": \"485\", \"x2\": \"440\", \"y1\": \"1270\", \"y2\": \"1340\"}', '2020-06-23 19:00:43');
INSERT INTO `storage_point` VALUES ('ffffffff8140c73fffffffffe400255e', '2-2B-02-03', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:23:33');
INSERT INTO `storage_point` VALUES ('ffffffff822f0b53ffffffffaecf9efa', '2-1A-01-02', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 18:02:42');
INSERT INTO `storage_point` VALUES ('ffffffff830e361bffffffff8ebabf37', '2-1A-01-03', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 18:03:11');
INSERT INTO `storage_point` VALUES ('ffffffff8386c11c0000000011416fca', '2-1B-06-02', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 17:56:29');
INSERT INTO `storage_point` VALUES ('ffffffff88ba98fe000000007c105b3f', '2-1A-02-02', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 18:06:45');
INSERT INTO `storage_point` VALUES ('ffffffff88fe9ada000000003408d9ab', '3-1A-05-03', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"420\", \"y2\": \"490\"}', '2020-06-23 19:05:21');
INSERT INTO `storage_point` VALUES ('ffffffff8972f8a6000000000c99c60b', '2-2A-04-01', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:39:57');
INSERT INTO `storage_point` VALUES ('ffffffff8d234ea5fffffffff85448a6', '2-2A-01-03', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:36:45');
INSERT INTO `storage_point` VALUES ('ffffffff8dd98a17ffffffffd1729fe2', '3-2A-02-01', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:13:26');
INSERT INTO `storage_point` VALUES ('ffffffff915dd91200000000064cb128', '2-2A-08-01', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:45:16');
INSERT INTO `storage_point` VALUES ('ffffffff9217a3ee0000000074c5c671', '3-2B-06-01', '{\"x1\": \"1414\", \"x2\": \"1472\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:46:52');
INSERT INTO `storage_point` VALUES ('ffffffff92a49d6bffffffffbcd2bfbf', '3-2B-09-03', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:51:19');
INSERT INTO `storage_point` VALUES ('ffffffff953a4e2c000000004fe56bac', '2-1A-05-01', '{\"x1\": \"2050\", \"x2\": \"2110\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 18:12:41');
INSERT INTO `storage_point` VALUES ('ffffffff9579c42cffffffffca31c15b', '3-2C-02-02', '{\"x1\": \"1767\", \"x2\": \"1828\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 20:02:58');
INSERT INTO `storage_point` VALUES ('ffffffff9691726fffffffff9e3c3d16', '3-2B-09-01', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:50:49');
INSERT INTO `storage_point` VALUES ('ffffffff96c21787ffffffff8cc5e4bf', '3-2C-04-03', '{\"x1\": \"1984\", \"x2\": \"2045\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 20:05:43');
INSERT INTO `storage_point` VALUES ('ffffffff96f2531bffffffff98bd457f', '2-2A-07-03', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:44:49');
INSERT INTO `storage_point` VALUES ('ffffffff974c1b440000000003d59746', '3-2B-06-02', '{\"x1\": \"1414\", \"x2\": \"1472\", \"y1\": \"1130\", \"y2\": \"1240\"}', '2020-06-23 19:47:23');
INSERT INTO `storage_point` VALUES ('ffffffff9916f688fffffffff6dd18c2', '2-2A-05-01', '{\"x1\": \"1930\", \"x2\": \"1990\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:40:51');
INSERT INTO `storage_point` VALUES ('ffffffff9a2de965ffffffff9d67c693', '2-2B-06-01', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:28:59');
INSERT INTO `storage_point` VALUES ('ffffffff9aa3ba46000000006e6694f2', '3-2B-03-03', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:43:23');
INSERT INTO `storage_point` VALUES ('ffffffff9b3e3896ffffffffd6b469d3', '3-2B-07-02', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:48:57');
INSERT INTO `storage_point` VALUES ('ffffffff9b7dc469000000001b4461ca', '3-2A-06-03', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:27:17');
INSERT INTO `storage_point` VALUES ('ffffffff9bc20d4f000000001eab48d5', '2-2A-09-01', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:46:11');
INSERT INTO `storage_point` VALUES ('ffffffff9bdae0f6ffffffff8567c31f', '3-2B-08-03', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:50:30');
INSERT INTO `storage_point` VALUES ('ffffffff9e928ea5ffffffff89560826', '2-2B-10-01', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:32:52');
INSERT INTO `storage_point` VALUES ('ffffffffa14f93c700000000112db1bc', '3-2A-05-03', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:26:08');
INSERT INTO `storage_point` VALUES ('ffffffffa346474000000000001f388d', '2-1A-08-02', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"535\", \"y2\": \"605\"}', '2020-06-23 18:17:14');
INSERT INTO `storage_point` VALUES ('ffffffffa482b13f00000000454ce8f5', '2-2A-10-03', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:48:12');
INSERT INTO `storage_point` VALUES ('ffffffffa562f5e2ffffffffd2ea1fa3', '2-2B-02-01', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:22:47');
INSERT INTO `storage_point` VALUES ('ffffffffa623b250ffffffff9e748813', '3-2A-01-03', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:12:01');
INSERT INTO `storage_point` VALUES ('ffffffffa737e0baffffffffd3dd6854', '2-1A-05-03', '{\"x1\": \"2050\", \"x2\": \"2110\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 18:13:27');
INSERT INTO `storage_point` VALUES ('ffffffffa7ffeac8ffffffffe3526924', '2-2B-07-03', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:30:36');
INSERT INTO `storage_point` VALUES ('ffffffffa862aaa4ffffffffaa27150e', '2-2A-01-01', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:35:57');
INSERT INTO `storage_point` VALUES ('ffffffffa94b71b5ffffffffe0c6733c', '2-1A-09-01', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 18:18:06');
INSERT INTO `storage_point` VALUES ('ffffffffaa81d83b0000000051779ece', '2-1A-04-02', '{\"x1\": \"1902\", \"x2\": \"1962\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 18:10:28');
INSERT INTO `storage_point` VALUES ('ffffffffabad0cc8fffffffff6f012ab', '2-2A-11-02', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:49:15');
INSERT INTO `storage_point` VALUES ('ffffffffabfdec1500000000134f1b75', '3-2C-01-03', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 20:01:57');
INSERT INTO `storage_point` VALUES ('ffffffffaf5a12c30000000021e791a4', '2-2A-04-02', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:40:14');
INSERT INTO `storage_point` VALUES ('ffffffffb23f03f1ffffffffecf84dd4', '3-2A-03-02', '{\"x1\": \"710\", \"x2\": \"770\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:17:20');
INSERT INTO `storage_point` VALUES ('ffffffffb2e5295affffffff97f83de4', '3-2C-08-02', '{\"x1\": \"1660\", \"x2\": \"1718\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 20:09:50');
INSERT INTO `storage_point` VALUES ('ffffffffb57d3c87ffffffffe90f9a75', '2-2B-05-03', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:28:21');
INSERT INTO `storage_point` VALUES ('ffffffffb6b23e8a00000000096ae145', '2-2A-06-02', '{\"x1\": \"2077\", \"x2\": \"2137\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:42:15');
INSERT INTO `storage_point` VALUES ('ffffffffb6d70854ffffffffe6d67055', '3-2B-02-01', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:35:59');
INSERT INTO `storage_point` VALUES ('ffffffffb7291172ffffffff8a220f9f', '2-2B-03-01', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:25:57');
INSERT INTO `storage_point` VALUES ('ffffffffb8d993f8fffffffff94bfb51', '2-2A-10-02', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:47:57');
INSERT INTO `storage_point` VALUES ('ffffffffbaa7779b000000006ebc07a4', '3-2C-06-01', '{\"x1\": \"1875\", \"x2\": \"1935\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 20:07:11');
INSERT INTO `storage_point` VALUES ('ffffffffbbeedd59ffffffffb68d1a85', '3-1A-01-03', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"1270\", \"y2\": \"1340\"}', '2020-06-23 18:59:39');
INSERT INTO `storage_point` VALUES ('ffffffffbcae6db1000000001c6b91ac', '3-2C-07-01', '{\"x1\": \"1767\", \"x2\": \"1826\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 20:08:31');
INSERT INTO `storage_point` VALUES ('ffffffffbd443213000000001731bcf2', '2-1B-04-03', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 17:53:40');
INSERT INTO `storage_point` VALUES ('ffffffffbef35046ffffffffb853d95f', '2-2A-01-02', '{\"x1\": \"1340\", \"x2\": \"1395\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:36:28');
INSERT INTO `storage_point` VALUES ('ffffffffbf38029fffffffff89df8200', '2-2B-10-03', '{\"x1\": \"450\", \"x2\": \"510\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:34:51');
INSERT INTO `storage_point` VALUES ('ffffffffc06754d9ffffffff85dd6467', '2-2B-07-01', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"610\", \"y2\": \"670\"}', '2020-06-23 18:30:07');
INSERT INTO `storage_point` VALUES ('ffffffffc0cf3912ffffffff893a241c', '3-2B-08-01', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:49:43');
INSERT INTO `storage_point` VALUES ('ffffffffc130e455ffffffffc5e5fcd9', '2-1A-04-03', '{\"x1\": \"1902\", \"x2\": \"1962\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 18:12:17');
INSERT INTO `storage_point` VALUES ('ffffffffc1934eaf000000006160b65b', '2-1B-01-01', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 17:04:31');
INSERT INTO `storage_point` VALUES ('ffffffffc1c96493ffffffffc83e0ca5', '3-2B-05-01', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:45:06');
INSERT INTO `storage_point` VALUES ('ffffffffc1efc4b4000000004089ebac', '2-1A-10-01', '{\"x1\": \"1420\", \"x2\": \"1480\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 18:19:22');
INSERT INTO `storage_point` VALUES ('ffffffffc3dec60c000000003543fa17', '2-2A-04-03', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:40:26');
INSERT INTO `storage_point` VALUES ('ffffffffc57e558cffffffff863e4b69', '2-1A-08-03', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 18:17:30');
INSERT INTO `storage_point` VALUES ('ffffffffc6c03de30000000026331e6a', '2-2A-10-01', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:47:26');
INSERT INTO `storage_point` VALUES ('ffffffffc77c1766000000003ea332a9', '2-1B-02-02', '{\"x1\": \"892\", \"x2\": \"952\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 17:44:40');
INSERT INTO `storage_point` VALUES ('ffffffffc83d7c02000000005238066b', '3-2A-06-02', '{\"x1\": \"490\", \"x2\": \"550\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:26:52');
INSERT INTO `storage_point` VALUES ('ffffffffc8983885ffffffffce33afe2', '3-1A-03-01', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"1055\", \"y2\": \"1125\"}', '2020-06-23 19:01:03');
INSERT INTO `storage_point` VALUES ('ffffffffc8eecc21ffffffff9b471517', '2-2B-09-03', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:32:37');
INSERT INTO `storage_point` VALUES ('ffffffffc902ca15000000006be3dcd8', '2-2B-04-03', '{\"x1\": \"890\", \"x2\": \"960\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:27:19');
INSERT INTO `storage_point` VALUES ('ffffffffcd9ea289000000001199540b', '3-1A-03-02', '{\"x1\": \"595\", \"x2\": \"655\", \"y1\": \"1160\", \"y2\": \"1230\"}', '2020-06-23 19:01:19');
INSERT INTO `storage_point` VALUES ('ffffffffcfbbcc0ffffffffffcc91148', '3-2B-10-02', '{\"x1\": \"980\", \"x2\": \"1040\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:52:04');
INSERT INTO `storage_point` VALUES ('ffffffffcfd1295cffffffff89f75fbf', '2-2B-08-01', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"610\", \"y2\": \"680\"}', '2020-06-23 18:30:53');
INSERT INTO `storage_point` VALUES ('ffffffffd3466ef4ffffffff91b86050', '2-2A-03-01', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:38:51');
INSERT INTO `storage_point` VALUES ('ffffffffd41027bd000000002a3af54d', '2-1A-02-01', '{\"x1\": \"1568\", \"x2\": \"1628\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 18:06:07');
INSERT INTO `storage_point` VALUES ('ffffffffd48547f4000000005b5a319c', '3-2A-05-01', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"605\", \"y2\": \"675\"}', '2020-06-23 19:24:59');
INSERT INTO `storage_point` VALUES ('ffffffffd8706e16ffffffffd1660f46', '3-2B-07-03', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:49:15');
INSERT INTO `storage_point` VALUES ('ffffffffd9f32a0fffffffffbd111f81', '2-2B-08-02', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:31:09');
INSERT INTO `storage_point` VALUES ('ffffffffda9ce98e000000007a19c57d', '2-1B-07-03', '{\"x1\": \"557\", \"x2\": \"617\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 17:59:48');
INSERT INTO `storage_point` VALUES ('ffffffffdc2f071f0000000070df2557', '3-2A-02-03', '{\"x1\": \"600\", \"x2\": \"660\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 19:13:56');
INSERT INTO `storage_point` VALUES ('ffffffffdc4a9ce00000000059b99f34', '2-2A-09-03', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"400\", \"y2\": \"470\"}', '2020-06-23 18:46:44');
INSERT INTO `storage_point` VALUES ('ffffffffdef48b58ffffffffd3d7c579', '2-2A-02-03', '{\"x1\": \"1485\", \"x2\": \"1545\", \"y1\": \"1285\", \"y2\": \"1355\"}', '2020-06-23 18:38:29');
INSERT INTO `storage_point` VALUES ('ffffffffdf3238daffffffffccfae4ec', '3-2C-03-01', '{\"x1\": \"1875\", \"x2\": \"1953\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 20:03:43');
INSERT INTO `storage_point` VALUES ('ffffffffdf44d78cffffffffaee066f6', '3-2B-04-02', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:44:22');
INSERT INTO `storage_point` VALUES ('ffffffffe09f57a600000000409b84fb', '2-1B-04-01', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"640\", \"y2\": \"710\"}', '2020-06-23 17:51:15');
INSERT INTO `storage_point` VALUES ('ffffffffe18e5382000000007cc3fb0e', '3-2B-09-02', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"495\", \"y2\": \"565\"}', '2020-06-23 19:51:06');
INSERT INTO `storage_point` VALUES ('ffffffffe1cdd566ffffffffe79aaf3f', '2-2B-05-01', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1075\", \"y2\": \"1145\"}', '2020-06-23 18:27:50');
INSERT INTO `storage_point` VALUES ('ffffffffe2d261a1fffffffff6dfc6fb', '3-1A-05-02', '{\"x1\": \"380\", \"x2\": \"440\", \"y1\": \"530\", \"y2\": \"600\"}', '2020-06-23 19:05:08');
INSERT INTO `storage_point` VALUES ('ffffffffe3b2f59affffffffea8fd7f6', '3-2C-04-01', '{\"x1\": \"1984\", \"x2\": \"2045\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 20:04:52');
INSERT INTO `storage_point` VALUES ('ffffffffe4b85bbbffffffffa9234b72', '2-2A-03-02', '{\"x1\": \"1635\", \"x2\": \"1695\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:39:10');
INSERT INTO `storage_point` VALUES ('ffffffffe6953fbaffffffff8f77a99b', '3-2B-03-02', '{\"x1\": \"1090\", \"x2\": \"1150\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:43:05');
INSERT INTO `storage_point` VALUES ('ffffffffe7072804000000003834b69b', '2-1A-03-03', '{\"x1\": \"1715\", \"x2\": \"1775\", \"y1\": \"1300\", \"y2\": \"1370\"}', '2020-06-23 18:08:55');
INSERT INTO `storage_point` VALUES ('ffffffffe7875f42000000002257f2ee', '2-1A-06-03', '{\"x1\": \"2010\", \"x2\": \"2070\", \"y1\": \"430\", \"y2\": \"500\"}', '2020-06-23 18:14:26');
INSERT INTO `storage_point` VALUES ('ffffffffe8be35afffffffffc61c21af', '3-2A-07-03', '{\"x1\": \"377\", \"x2\": \"437\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:28:53');
INSERT INTO `storage_point` VALUES ('ffffffffee342d42ffffffffeabb4e84', '2-1A-05-02', '{\"x1\": \"2050\", \"x2\": \"2110\", \"y1\": \"1195\", \"y2\": \"1265\"}', '2020-06-23 18:13:11');
INSERT INTO `storage_point` VALUES ('fffffffff41549fb00000000211ef1bf', '3-2B-05-02', '{\"x1\": \"1305\", \"x2\": \"1365\", \"y1\": \"1130\", \"y2\": \"1200\"}', '2020-06-23 19:45:21');
INSERT INTO `storage_point` VALUES ('fffffffff55d7faefffffffff43b8cd4', '2-2A-08-02', '{\"x1\": \"1780\", \"x2\": \"1840\", \"y1\": \"505\", \"y2\": \"575\"}', '2020-06-23 18:45:33');
INSERT INTO `storage_point` VALUES ('fffffffff7915fcf0000000024abc91e', '3-2B-11-03', '{\"x1\": \"875\", \"x2\": \"930\", \"y1\": \"386\", \"y2\": \"456\"}', '2020-06-23 19:53:33');
INSERT INTO `storage_point` VALUES ('fffffffff818752d0000000030ee44c0', '2-2B-03-02', '{\"x1\": \"745\", \"x2\": \"805\", \"y1\": \"1180\", \"y2\": \"1250\"}', '2020-06-23 18:26:13');
INSERT INTO `storage_point` VALUES ('fffffffffc61020fffffffffc8511052', '2-1B-03-01', '{\"x1\": \"1040\", \"x2\": \"1100\", \"y1\": \"1090\", \"y2\": \"1160\"}', '2020-06-23 17:49:28');
INSERT INTO `storage_point` VALUES ('fffffffffcff13f0ffffffffc2d61055', '3-2C-02-03', '{\"x1\": \"1767\", \"x2\": \"1826\", \"y1\": \"1240\", \"y2\": \"1310\"}', '2020-06-23 20:03:26');
INSERT INTO `storage_point` VALUES ('ffffffffffecaa26000000006d396f09', '3-2B-04-01', '{\"x1\": \"1195\", \"x2\": \"1255\", \"y1\": \"1020\", \"y2\": \"1090\"}', '2020-06-23 19:43:55');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务主键',
  `invoices_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务单号|编号',
  `type` smallint(0) UNSIGNED NOT NULL COMMENT '指令类型(1入库;2出库;)',
  `total` int(0) UNSIGNED NOT NULL COMMENT '任务数量',
  `status` smallint(0) UNSIGNED NOT NULL DEFAULT 1 COMMENT '任务状态(1待执行;2进行中;3完成;)',
  `flag` smallint(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已推送(0未推送;1已推送)',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('0000000035bcf27dffffffffc8866b02', 'IN202004130002', 1, 20, 1, 0, '2020-05-18 10:06:56');
INSERT INTO `task` VALUES ('0000000074bc26850000000037574d9a', 'IN2020041300081', 2, 10, 1, 0, '2020-05-22 12:08:21');

-- ----------------------------
-- Table structure for task_detail
-- ----------------------------
DROP TABLE IF EXISTS `task_detail`;
CREATE TABLE `task_detail`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务明细id',
  `task_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务id',
  `invoices_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务单号|编号',
  `item_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物资编号',
  `item_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物资名称',
  `item_total` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物资数量',
  `item_storage_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位号',
  `status` smallint(0) UNSIGNED NOT NULL DEFAULT 1 COMMENT '任务状态(1待执行;2进行中;3完成;)',
  `falg` smallint(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '任务是否已被接(0未接;1已接)',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`kid`) USING BTREE,
  UNIQUE INDEX `index_invoices_item`(`invoices_code`, `item_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_detail
-- ----------------------------
INSERT INTO `task_detail` VALUES ('000000003bbc4f64fffffffff9310a46', '0000000074bc26850000000037574d9a', 'IN2020041300081', 'WZ478455414', '棉3被', '5', '3-1C-01-01-01', 3, 1, '2020-05-22 12:08:21');
INSERT INTO `task_detail` VALUES ('ffffffffc92eb0dbffffffffa4a7fece', '0000000035bcf27dffffffffc8866b02', 'IN202004130002', 'WZ478455444001', '棉被', '20床', '3-1C-01-01-01', 1, 0, '2020-05-18 10:06:56');
INSERT INTO `task_detail` VALUES ('ffffffffcdc03ad900000000741f0c90', '0000000035bcf27dffffffffc8866b02', 'IN202004130002', 'WZ478562512202', '帐篷', '40个', '3-1C-01-02-02', 1, 0, '2020-05-18 10:06:56');
INSERT INTO `task_detail` VALUES ('ffffffffd7bdf1f0ffffffffc090a664', '0000000074bc26850000000037574d9a', 'IN2020041300081', 'WZ47856252048', '帐2篷', '12', '3-1C-01-02-02', 3, 1, '2020-05-22 12:08:21');

SET FOREIGN_KEY_CHECKS = 1;
