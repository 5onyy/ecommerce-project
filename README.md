# GoalBox

GoalBox is a meal-prep storefront built on EverShop.

## Requirements

- Docker Desktop
- Git

## Installation (Docker)

Run from project root:

```powershell
docker compose down -v
docker compose up -d
docker compose exec app npm run seed -- --all
```

Done.

## Access

- Storefront: http://localhost:3000
- Admin: http://localhost:3000/admin

## Create admin user

```powershell
docker compose exec app npm run user:create -- --email "admin@goalbox.vn" --password "goalbox123" --name "GoalBox Admin"
```

## Verify setup

```powershell
docker compose ps
docker compose logs app --tail 100
docker compose exec database psql -U postgres -d postgres -c "SELECT COUNT(*) AS products FROM product;"
```

Expected: 37 products (30 meal boxes + 4 bundles + 3 add-ons).

## Reset

```powershell
docker compose down -v
docker compose up -d
docker compose exec app npm run seed -- --all
```

## Notes

- Product images are mapped automatically during DB initialization.
- If you changed [seed/db-init/01-goalbox-product-image-trigger.sql](seed/db-init/01-goalbox-product-image-trigger.sql), run reset to re-apply.
