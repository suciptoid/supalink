

-- Create PostgreSQL Table for orgs, use UUID v4 (uuid-ossp) as primary key
CREATE TABLE orgs (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL
);

-- Create PostgreSQL Table for links, use UUID as primary key, and add org_id column
CREATE TABLE links (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    org_id uuid NOT NULL,
    slug varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    url text NOT NULL,
    clicks int NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);