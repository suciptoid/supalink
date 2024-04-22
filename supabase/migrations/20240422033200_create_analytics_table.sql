-- create analytics table, foreign key to links table, cascade on delete & update

CREATE TABLE analytics (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    link_id uuid NOT NULL,
    clicks int NOT NULL DEFAULT 0,
    tracked_at timestamptz NOT NULL DEFAULT now(), -- hourly time span
    updated_at timestamptz NOT NULL DEFAULT now()
);

-- add index to tracked_at column
CREATE INDEX analytics_tracked_at_idx ON analytics (tracked_at);


ALTER TABLE analytics
ADD CONSTRAINT analytics_link_id_fkey FOREIGN KEY (link_id)
REFERENCES links (id)
ON DELETE CASCADE
ON UPDATE CASCADE;