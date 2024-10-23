SELECT
    repo_id,
    repo_name,
    DATE_TRUNC('day', event_date) AS date_day,
    COUNT(*) AS push_count,
    SUM(COUNT(*)) OVER (PARTITION BY repo_id ORDER BY DATE_TRUNC('day', event_date) ASC) AS cumul_push_count
FROM {{ ref("stg_gharchive")}}
WHERE event_type = 'Push'
GROUP BY 1, 2, 3
