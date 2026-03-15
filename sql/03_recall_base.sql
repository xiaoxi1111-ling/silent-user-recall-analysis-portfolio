-- 03_recall_base.sql
USE taobao_project;

DROP TABLE IF EXISTS user_active_1201_1202;
CREATE TABLE user_active_1201_1202 AS
SELECT DISTINCT user_id
FROM user_behavior_proj
WHERE ts >= 1512086400
  AND ts < 1512259200;

DROP TABLE IF EXISTS user_return_1203;
CREATE TABLE user_return_1203 AS
SELECT DISTINCT user_id, 1 AS returned_1203
FROM user_behavior_proj
WHERE ts >= 1512259200
  AND ts < 1512345600;

DROP TABLE IF EXISTS recall_base;
CREATE TABLE recall_base AS
SELECT
    a.*,
    CASE WHEN b.user_id IS NULL THEN 1 ELSE 0 END AS is_silent,
    COALESCE(c.returned_1203, 0) AS returned_1203
FROM user_feature_hist a
LEFT JOIN user_active_1201_1202 b
    ON a.user_id = b.user_id
LEFT JOIN user_return_1203 c
    ON a.user_id = c.user_id;

SELECT is_silent, COUNT(*) AS user_cnt
FROM recall_base
GROUP BY is_silent;