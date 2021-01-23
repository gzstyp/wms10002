
添加了新的字段

floor.code

添加了新表

-- 直接采用数据传输那两个表即可

CREATE TABLE `gzjz_wms`.`floor_code`  (
  `kid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '区域跳转详情主键',
  `floorId` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层名称id(floor.kid)',
  `target_code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '楼层编码(02-1A)跳转时的参数c',
  `block_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '按钮名称(A区B区C区)点击改名称跳转页面',
  `target_label` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跳转时的参数t(x号仓库x楼x区)',
  `floor_humiture` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转时的参数h楼层所有温湿度标识',
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '楼层仓库编码' ROW_FORMAT = Dynamic;
