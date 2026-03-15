-- 05_strategy_map.sql
USE taobao_project;

DROP TABLE IF EXISTS strategy_map;

CREATE TABLE strategy_map AS
SELECT '高价值沉默用户' AS segment, '高' AS business_value, '高' AS recall_priority, '老客回访券 / 满减券' AS strategy
UNION ALL
SELECT '高意向未购沉默用户', '中高', '中', '加购提醒 / 小额促单券'
UNION ALL
SELECT '高浏览低转化沉默用户', '低', '低', '低成本提醒'
UNION ALL
SELECT '其他用户', '中低', '低', '不优先补贴';

SELECT *
FROM strategy_map;