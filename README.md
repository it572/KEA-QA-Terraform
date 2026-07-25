## ⚠️ Before replacing the EC2 instance (terraform apply -replace)
QA's Postgres database runs in-container and is NOT backed by RDS (cost decision).
Any instance replacement destroys the database unless backed up first:
  docker exec kea-postgres pg_dump -U postgres kea_erp_db > backup.sql
  aws s3 cp backup.sql s3://kea-erp-terraform-state/db-backups/
