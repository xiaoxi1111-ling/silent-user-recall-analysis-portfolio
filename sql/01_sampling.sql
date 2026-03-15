-- 01_sampling.sql
USE taobao_project;

DROP TABLE IF EXISTS user_behavior_proj;

CREATE TABLE user_behavior_proj (
    user_id BIGINT,
    item_id BIGINT,
    category_id BIGINT,
    behavior_type VARCHAR(10),
    ts BIGINT
);

-- Replace the file path with your local sample file path
LOAD DATA LOCAL INFILE 'Replace with your local file path before running'
INTO TABLE user_behavior_proj
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(user_id, item_id, category_id, behavior_type, ts);

SELECT COUNT(*) AS total_rows
FROM user_behavior_proj;