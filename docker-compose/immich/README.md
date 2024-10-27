
Automated Database Restore from backup: https://immich.app/docs/administration/backup-and-restore/

```sh
gunzip < db_dumps/last/immich-latest.sql.gz \
| sed "s/SELECT pg_catalog.set_config('search_path', '', false);/SELECT pg_catalog.set_config('search_path', 'public, pg_catalog', true);/g" \
| docker exec -i immich_postgres psql --username=postgres
```