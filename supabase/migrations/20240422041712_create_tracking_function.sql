-- DROP FUNCTION track_link(uuid);
CREATE OR REPLACE FUNCTION track_link(link_id uuid) RETURNS INT AS $$
DECLARE
    updated_clicks INT;
BEGIN
    -- Update links counter
    UPDATE links SET clicks = links.clicks + 1
    WHERE links.id = track_link.link_id;

    -- Check if a record exists for the given link_id within the same hour
    IF NOT EXISTS (
        SELECT 1 FROM analytics AS a
        WHERE a.link_id = track_link.link_id
        AND a.tracked_at = date_trunc('hour', now())
    ) THEN
        -- If no record exists, insert a new record with current hour and minute set to 0
        INSERT INTO analytics (link_id, tracked_at, clicks)
        VALUES (link_id, date_trunc('hour', now()), 1)
        RETURNING 1 INTO updated_clicks;
    ELSE
        -- If a record already exists, increment the clicks by 1
        UPDATE analytics
        SET clicks = analytics.clicks + 1, updated_at = now()
        WHERE analytics.link_id = track_link.link_id
        AND tracked_at = date_trunc('hour', now())
        RETURNING clicks INTO updated_clicks;

    END IF;

    RETURN updated_clicks;
END;
$$ LANGUAGE plpgsql;
