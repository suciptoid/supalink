-- create org_users table to store user_ids for each org, add foreign key to orgs table

-- create enum for user roles
CREATE TYPE user_role AS ENUM ('owner', 'admin', 'member');

CREATE TABLE org_users (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    org_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role user_role NOT NULL DEFAULT 'member',
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE org_users
ADD CONSTRAINT org_users_org_id_fkey FOREIGN KEY (org_id)
REFERENCES orgs (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE org_users
ADD CONSTRAINT org_users_user_id_fkey FOREIGN KEY (user_id)
REFERENCES auth.users (id)
ON DELETE CASCADE
ON UPDATE CASCADE;
;