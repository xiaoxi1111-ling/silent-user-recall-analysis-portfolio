-- 04_segmentation.sql
USE taobao_project;

DROP TABLE IF EXISTS recall_segment;

CREATE TABLE recall_segment AS
SELECT
    *,
    CASE
        WHEN is_silent = 1 AND buy_cnt >= 2 THEN '高价值沉默用户'
        WHEN is_silent = 1 AND buy_cnt = 0 AND (cart_cnt > 0 OR fav_cnt > 0) THEN '高意向未购沉默用户'
        WHEN is_silent = 1 AND pv_cnt >= 20 AND cart_cnt = 0 AND fav_cnt = 0 AND buy_cnt = 0 THEN '高浏览低转化沉默用户'
        ELSE '其他用户'
    END AS segment
FROM recall_base;

SELECT
    segment,
    COUNT(*) AS silent_user_cnt,
    ROUND(COUNT(*) * 100.0 / (
        SELECT COUNT(*)
        FROM recall_segment
        WHERE is_silent = 1
    ), 2) AS pct_in_silent
FROM recall_segment
WHERE is_silent = 1
GROUP BY segment
ORDER BY silent_user_cnt DESC;

SELECT
    segment,
    COUNT(*) AS user_cnt,
    SUM(returned_1203) AS returned_cnt,
    ROUND(SUM(returned_1203) * 1.0 / COUNT(*), 4) AS natural_return_rate
FROM recall_segment
WHERE is_silent = 1
GROUP BY segment
ORDER BY natural_return_rate;