/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.3.66
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 192.168.3.66:3306
 Source Schema         : gzjz_wms

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 28/05/2020 21:07:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层图片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('ffffffffe56e8ef0ffffffff912af742', 1496, 568, 'areaMap', '一楼二层', '/img/ffffffffe56e8ef0ffffffff912af742.png');
INSERT INTO `images` VALUES ('ffffffffe56e8ef0ffffffff912af74a', 1496, 568, 'areaMap', '一楼一层', '/img/ffffffffe56e8ef0ffffffff912af74a.png');

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
INSERT INTO `images_maps` VALUES ('0000000010be1b7bffffffffcef67a25', 'ffffffffe56e8ef0ffffffff912af74a', '3-2B-01-03', '211,149,304,240', '2020-05-28 11:18:13');
INSERT INTO `images_maps` VALUES ('0000000029e2a350ffffffff9dc538fc', 'ffffffffe56e8ef0ffffffff912af742', 'rrr', 'rr', '2020-05-28 20:55:03');

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
INSERT INTO `storage_point` VALUES ('0000000000a1ec4affffffffe27a6c1c', '3-2B-05-01', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:04:58');
INSERT INTO `storage_point` VALUES ('000000000245c69afffffffff2ac5355', '3-2B-09-01', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:08:05');
INSERT INTO `storage_point` VALUES ('00000000025802dd000000001ea60522', '3-2B-05-03', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:05:26');
INSERT INTO `storage_point` VALUES ('0000000002f25476ffffffff9225d181', '3-2B-07-01', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:06:25');
INSERT INTO `storage_point` VALUES ('0000000007c3d4d7000000003b90f1f2', '3-2B-06-02', '{\"x1\": \"1464\", \"x2\": \"1524\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:05:57');
INSERT INTO `storage_point` VALUES ('0000000009492053ffffffff83ab9cc9', '3-2A-07-03', '{\"x1\": \"427\", \"x2\": \"487\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:01:30');
INSERT INTO `storage_point` VALUES ('000000000c7bb592000000003203983b', '3-2A-03-02', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-25 23:58:13');
INSERT INTO `storage_point` VALUES ('000000000d8b2d91fffffffffc1d0257', '3-2B-08-03', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:07:49');
INSERT INTO `storage_point` VALUES ('000000001059fc00000000006de81c01', '3-2A-07-02', '{\"x1\": \"427\", \"x2\": \"487\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:01:17');
INSERT INTO `storage_point` VALUES ('0000000010be1b7bffffffffcef67a25', '3-2B-01-03', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:02:15');
INSERT INTO `storage_point` VALUES ('00000000194654dbffffffff8ba792a1', '3-1A-05-01', '{\"x1\": \"430\", \"x2\": \"488\", \"y1\": \"600\", \"y2\": \"675\"}', '2020-05-25 23:55:21');
INSERT INTO `storage_point` VALUES ('000000001fbc5c6f000000003caadf21', '3-2A-05-02', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-25 23:59:45');
INSERT INTO `storage_point` VALUES ('000000002102dea4ffffffffa3edcfc9', '3-2C-05-02', '{\"x1\": \"2144\", \"x2\": \"2204\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:13:21');
INSERT INTO `storage_point` VALUES ('00000000235959590000000013de33b2', '3-2B-10-02', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:09:01');
INSERT INTO `storage_point` VALUES ('00000000257f5f6dffffffffd91afbd9', '3-2B-04-01', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:04:09');
INSERT INTO `storage_point` VALUES ('00000000274a266bffffffff993866a5', '3-1A-02-03', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"1234\", \"y2\": \"1308\"}', '2020-05-25 23:53:24');
INSERT INTO `storage_point` VALUES ('0000000027c4c9270000000074ee10a7', '3-2A-01-03', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-25 23:56:51');
INSERT INTO `storage_point` VALUES ('0000000028e97599000000004c86831a', '3-2B-09-03', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:08:31');
INSERT INTO `storage_point` VALUES ('000000002d9b72d7000000000a13c3c1', '3-2B-09-02', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:08:19');
INSERT INTO `storage_point` VALUES ('000000002eeda4650000000055dd693f', '3-2B-03-03', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:03:53');
INSERT INTO `storage_point` VALUES ('0000000032f1e813000000001bd485d8', '3-2B-07-03', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:06:57');
INSERT INTO `storage_point` VALUES ('0000000033170de3000000001ec76039', '3-1A-04-02', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"493\", \"y2\": \"568\"}', '2020-05-25 23:54:46');
INSERT INTO `storage_point` VALUES ('0000000039d357c50000000033771932', '3-2C-06-02', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:14:06');
INSERT INTO `storage_point` VALUES ('000000003b41e410000000003e35816e', '3-2B-03-01', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:03:19');
INSERT INTO `storage_point` VALUES ('000000003dab39cdffffffff81e3c04b', '3-2B-11-03', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:10:04');
INSERT INTO `storage_point` VALUES ('00000000433bd25c000000001670076f', '3-2B-08-01', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:07:20');
INSERT INTO `storage_point` VALUES ('000000004b71d5baffffffffc6cfc61c', '3-2C-03-02', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:12:03');
INSERT INTO `storage_point` VALUES ('000000004c5d4c4effffffffcb886ea9', '3-2A-03-03', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-25 23:58:26');
INSERT INTO `storage_point` VALUES ('000000004d9ebb540000000041358d19', '3-2B-06-03', '{\"x1\": \"1464\", \"x2\": \"1524\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:06:09');
INSERT INTO `storage_point` VALUES ('0000000058d64d3fffffffffb83c9e0b', '3-2B-04-02', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:04:26');
INSERT INTO `storage_point` VALUES ('0000000058ddb4b5ffffffff9ad6bb2d', '3-2C-02-03', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:11:35');
INSERT INTO `storage_point` VALUES ('000000005a06bf18ffffffffdc630015', '3-2B-11-01', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:09:36');
INSERT INTO `storage_point` VALUES ('000000005b94f9e7ffffffffba664082', '3-2A-06-02', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:00:33');
INSERT INTO `storage_point` VALUES ('000000005d2b565efffffffff294516e', '3-2A-06-03', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:00:46');
INSERT INTO `storage_point` VALUES ('000000005e289c130000000010db6c0d', '3-2A-02-01', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-25 23:57:08');
INSERT INTO `storage_point` VALUES ('000000005e41d97fffffffffbe78e753', '3-2C-06-03', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:14:24');
INSERT INTO `storage_point` VALUES ('0000000060dde417ffffffffc71bcaca', '3-1A-01-03', '{\"x1\": \"420\", \"x2\": \"488\", \"y1\": \"1234\", \"y2\": \"1308\"}', '2020-05-25 23:52:27');
INSERT INTO `storage_point` VALUES ('0000000060de26330000000009371274', '3-1A-03-01', '{\"x1\": \"647\", \"x2\": \"705\", \"y1\": \"1018\", \"y2\": \"1092\"}', '2020-05-25 23:53:40');
INSERT INTO `storage_point` VALUES ('00000000649d651600000000265d6c9e', '3-2B-06-01', '{\"x1\": \"1464\", \"x2\": \"1524\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:05:43');
INSERT INTO `storage_point` VALUES ('000000006a84e2c50000000048435c69', '3-1A-03-02', '{\"x1\": \"647\", \"x2\": \"705\", \"y1\": \"1126\", \"y2\": \"1200\"}', '2020-05-25 23:53:58');
INSERT INTO `storage_point` VALUES ('000000006bdc716e000000000f1405ae', '3-1A-02-02', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"1126\", \"y2\": \"1200\"}', '2020-05-25 23:53:08');
INSERT INTO `storage_point` VALUES ('00000000738a6e03fffffffff988037b', '3-2B-02-02', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:02:48');
INSERT INTO `storage_point` VALUES ('0000000074247767000000000eb14a15', '3-2B-05-02', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:05:13');
INSERT INTO `storage_point` VALUES ('0000000079e32502ffffffffdfa51b77', '3-2C-07-03', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:15:11');
INSERT INTO `storage_point` VALUES ('000000007b7bf048ffffffff952139b7', '3-2A-04-02', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-25 23:59:00');
INSERT INTO `storage_point` VALUES ('000000007f21a9e9ffffffffe842dbca', '3-2A-02-02', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-25 23:57:23');
INSERT INTO `storage_point` VALUES ('ffffffff82c67fb200000000545389ec', '3-2A-01-01', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-25 23:56:19');
INSERT INTO `storage_point` VALUES ('ffffffff86eb3507000000005c78aadf', '3-1A-04-03', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"387\", \"y2\": \"462\"}', '2020-05-25 23:55:01');
INSERT INTO `storage_point` VALUES ('ffffffff8981578affffffffd5d6bf0c', '3-2A-02-03', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-25 23:57:38');
INSERT INTO `storage_point` VALUES ('ffffffff8cd69e5affffffffc56e6b87', '3-1A-02-01', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"1018\", \"y2\": \"1092\"}', '2020-05-25 23:52:51');
INSERT INTO `storage_point` VALUES ('ffffffff8e29bdbdffffffffccf066f4', '3-2A-07-01', '{\"x1\": \"427\", \"x2\": \"487\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:01:02');
INSERT INTO `storage_point` VALUES ('ffffffff8f79f4e600000000715a630f', '3-2C-04-02', '{\"x1\": \"2036\", \"x2\": \"2096\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:12:42');
INSERT INTO `storage_point` VALUES ('ffffffff91f3fbe8ffffffff9b798d24', '3-1A-03-03', '{\"x1\": \"647\", \"x2\": \"705\", \"y1\": \"1234\", \"y2\": \"1308\"}', '2020-05-25 23:54:13');
INSERT INTO `storage_point` VALUES ('ffffffff9437b1a20000000068c99514', '3-2A-06-01', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:00:16');
INSERT INTO `storage_point` VALUES ('ffffffff96a2c84bfffffffff37fe03b', '3-2C-04-03', '{\"x1\": \"2036\", \"x2\": \"2096\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:12:53');
INSERT INTO `storage_point` VALUES ('ffffffff96d21739ffffffff83a3180c', '3-2B-10-01', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:08:47');
INSERT INTO `storage_point` VALUES ('ffffffff9a67c102ffffffff82964611', '3-2C-05-03', '{\"x1\": \"2144\", \"x2\": \"2204\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:13:33');
INSERT INTO `storage_point` VALUES ('ffffffff9a7c6df7000000002dadb202', '3-2B-07-02', '{\"x1\": \"1352\", \"x2\": \"1412\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:06:40');
INSERT INTO `storage_point` VALUES ('ffffffff9ddc80420000000028286d23', '3-2B-02-01', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:02:32');
INSERT INTO `storage_point` VALUES ('ffffffff9f90a36e000000000b45295c', '3-2C-08-01', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:15:26');
INSERT INTO `storage_point` VALUES ('ffffffffa2ef1806ffffffffaa744dda', '3-1A-04-01', '{\"x1\": \"535\", \"x2\": \"593\", \"y1\": \"600\", \"y2\": \"675\"}', '2020-05-25 23:54:28');
INSERT INTO `storage_point` VALUES ('ffffffffa38e72e0fffffffff421ad82', '3-2A-04-03', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-25 23:59:14');
INSERT INTO `storage_point` VALUES ('ffffffffa4547b8c0000000049a17172', '3-2C-04-01', '{\"x1\": \"2036\", \"x2\": \"2096\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:12:29');
INSERT INTO `storage_point` VALUES ('ffffffffa546f576ffffffff8bcb4e4f', '3-2C-05-01', '{\"x1\": \"2144\", \"x2\": \"2204\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:13:07');
INSERT INTO `storage_point` VALUES ('ffffffffa9e3f11affffffffbf1936e9', '3-2B-03-02', '{\"x1\": \"1142\", \"x2\": \"1202\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:03:39');
INSERT INTO `storage_point` VALUES ('ffffffffb42574a9ffffffffb6b52364', '3-2B-10-03', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:09:20');
INSERT INTO `storage_point` VALUES ('ffffffffbac25c46000000002c93ec5b', '3-2C-08-03', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-26 00:15:52');
INSERT INTO `storage_point` VALUES ('ffffffffbc095f48ffffffffa037d6f3', '3-1A-05-03', '{\"x1\": \"430\", \"x2\": \"488\", \"y1\": \"387\", \"y2\": \"462\"}', '2020-05-25 23:55:56');
INSERT INTO `storage_point` VALUES ('ffffffffbe1a8553000000000ed9073a', '3-2A-03-01', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-25 23:57:55');
INSERT INTO `storage_point` VALUES ('ffffffffbf35019b0000000047a11c6d', '3-2A-04-01', '{\"x1\": \"758\", \"x2\": \"818\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-25 23:58:43');
INSERT INTO `storage_point` VALUES ('ffffffffc1f67273fffffffff69acb5e', '3-2B-04-03', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:04:38');
INSERT INTO `storage_point` VALUES ('ffffffffc30e1f8dffffffffb17d76de', '3-2B-08-02', '{\"x1\": \"1248\", \"x2\": \"1308\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:07:36');
INSERT INTO `storage_point` VALUES ('ffffffffc7af81c8ffffffffa8339241', '3-2C-02-02', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:11:22');
INSERT INTO `storage_point` VALUES ('ffffffffcccf6f7100000000208ac954', '3-2A-01-02', '{\"x1\": \"538\", \"x2\": \"598\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-25 23:56:35');
INSERT INTO `storage_point` VALUES ('ffffffffccf65c0fffffffffd9805ba6', '3-2C-08-02', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:15:39');
INSERT INTO `storage_point` VALUES ('ffffffffcf977027ffffffffc462aef4', '3-1A-01-01', '{\"x1\": \"430\", \"x2\": \"488\", \"y1\": \"1018\", \"y2\": \"1092\"}', '2020-05-25 19:05:28');
INSERT INTO `storage_point` VALUES ('ffffffffd2d25c03ffffffffc8caaced', '3-2C-01-02', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:10:34');
INSERT INTO `storage_point` VALUES ('ffffffffd6bc7978ffffffffe5b151eb', '3-2C-07-02', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:14:58');
INSERT INTO `storage_point` VALUES ('ffffffffd78bfe25000000005d196ce7', '3-2C-03-03', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:12:16');
INSERT INTO `storage_point` VALUES ('ffffffffd79ab5f20000000067fa6832', '3-2C-06-01', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:13:50');
INSERT INTO `storage_point` VALUES ('ffffffffd9ff4d71ffffffff84c75f27', '3-2B-02-03', '{\"x1\": \"1032\", \"x2\": \"1092\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:03:02');
INSERT INTO `storage_point` VALUES ('ffffffffda42473e0000000020630be7', '3-2B-11-02', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"460\", \"y2\": \"534\"}', '2020-05-26 00:09:52');
INSERT INTO `storage_point` VALUES ('ffffffffe19d3d8600000000755dbad0', '3-2A-05-03', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"352\", \"y2\": \"426\"}', '2020-05-25 23:59:59');
INSERT INTO `storage_point` VALUES ('ffffffffe25c2ce7ffffffffa48e555e', '3-2C-07-01', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-26 00:14:44');
INSERT INTO `storage_point` VALUES ('ffffffffe807c46700000000508979f4', '3-2C-03-01', '{\"x1\": \"1928\", \"x2\": \"1988\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:11:49');
INSERT INTO `storage_point` VALUES ('ffffffffeb8754ce000000000e1eb045', '3-2B-01-01', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:01:48');
INSERT INTO `storage_point` VALUES ('ffffffffed09b4d0ffffffffefd28394', '3-1A-05-02', '{\"x1\": \"430\", \"x2\": \"488\", \"y1\": \"493\", \"y2\": \"568\"}', '2020-05-25 23:55:35');
INSERT INTO `storage_point` VALUES ('fffffffff0540935000000005de38728', '3-2C-02-01', '{\"x1\": \"1818\", \"x2\": \"1878\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:11:07');
INSERT INTO `storage_point` VALUES ('fffffffff05de6cd000000003ab3bd61', '3-2C-01-03', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"1201\", \"y2\": \"1275\"}', '2020-05-26 00:10:47');
INSERT INTO `storage_point` VALUES ('fffffffff88d92c4ffffffff975621f2', '3-2C-01-01', '{\"x1\": \"1708\", \"x2\": \"1768\", \"y1\": \"985\", \"y2\": \"1059\"}', '2020-05-26 00:10:19');
INSERT INTO `storage_point` VALUES ('fffffffffb9b03caffffffffcdf7246a', '3-1A-01-02', '{\"x1\": \"430\", \"x2\": \"488\", \"y1\": \"1126\", \"y2\": \"1200\"}', '2020-05-25 19:07:23');
INSERT INTO `storage_point` VALUES ('fffffffffc55f0640000000022890457', '3-2A-05-01', '{\"x1\": \"648\", \"x2\": \"708\", \"y1\": \"568\", \"y2\": \"642\"}', '2020-05-25 23:59:30');
INSERT INTO `storage_point` VALUES ('fffffffffe152711ffffffffeff1f5cd', '3-2B-01-02', '{\"x1\": \"924\", \"x2\": \"984\", \"y1\": \"1093\", \"y2\": \"1167\"}', '2020-05-26 00:02:00');

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
