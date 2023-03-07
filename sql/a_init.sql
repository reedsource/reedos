-- 项目数据库初始化
-- 删除数据库
DROP DATABASE IF EXISTS reedos;
-- 创建数据库
create schema reedos collate utf8mb4_bin;
-- 切换到数据库
USE reedos;