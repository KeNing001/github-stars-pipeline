SELECT 
    CASE
        WHEN type = 'WatchEvent' THEN 'star'
        WHEN type = 'PushEvent' THEN 'commit'
        ELSE LOWER(REPLACE(type, 'Event', ''))
    END AS event_type,
    COALESCE(actor.login, 'unknown') AS user,
    repo.id AS repo_id, 
    repo.name AS repo_name, 
    created_at AS event_date 
FROM {{ source('gharchive', 'src_gharchive') }}
WHERE type IS NOT NULL