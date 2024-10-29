{% macro fact_event_type(event_type, period) -%} 
SELECT
    repo_id,
    repo_name,
    DATE_TRUNC('{{ period }}', event_date) AS event_period,
    COUNT(*) AS event_count,
    SUM(event_count) OVER (PARTITION BY repo_id ORDER BY event_period ASC) AS cumul_count
FROM
    {{ ref('stg_gharchive') }}
WHERE
    LOWER(event_type) = LOWER('{{ event_type }}')
GROUP BY
    repo_id,
    repo_name,
    DATE_TRUNC('{{ period }}', event_date) 
ORDER BY
    event_period 
{%- endmacro %}