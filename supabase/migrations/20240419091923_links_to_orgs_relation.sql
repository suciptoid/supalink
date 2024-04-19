-- create migration to add foreign key to links table on existing org_id column

ALTER TABLE links
ADD CONSTRAINT links_org_id_fkey FOREIGN KEY (org_id)
REFERENCES orgs (id);