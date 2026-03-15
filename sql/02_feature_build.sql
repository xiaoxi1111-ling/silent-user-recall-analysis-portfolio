-- 02_feature_build.sql
USE taobao_project;

DROP TABLE IF EXISTS user_feature_hist;

CREATE TABLE user_feature_hist AS
SELECT
    user_id,
    MAX(FROM_UNIXTIME(ts)) AS last_active_time,
    COUNT(*) AS total_actions,
    SUM(CASE WHEN behavior_type = 'pv' THEN 1 ELSE 0 END) AS pv_cnt,
    SUM(CASE WHEN behavior_type = 'cart' THEN 1 ELSE 0 END) AS cart_cnt,
    SUM(CASE WHEN behavior_type = 'fav' THEN 1 ELSE 0 END) AS fav_cnt,
    SUM(CASE WHEN behavior_type = 'buy' THEN 1 ELSE 0 END) AS buy_cnt,
    COUNT(DISTINCT DATE(FROM_UNIXTIME(ts))) AS active_days,
    COUNT(DISTINCT item_id) AS item_cnt,
    COUNT(DISTINCT category_id) AS cate_cnt
FROM user_behavior_proj
WHERE ts >= 1511568000
  AND ts < 1512086400
GROUP BY user_id;

SELECT COUNT(*) AS user_cnt
FROM user_feature_hist;