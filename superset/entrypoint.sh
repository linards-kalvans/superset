#! /bin/sh

# Upgrade database if /app/superset-init-lock/supperset-db-init.lock does not exist
if [ ! -f /app/superset-init-lock/supperset-db-init.lock ]; then
    uv run superset db upgrade && \
    touch /app/superset-init-lock/supperset-db-init.lock
fi

# Create admin user if /app/superset-init-lock/supperset-admin-init.lock does not exist
if [ ! -f /app/superset-init-lock/supperset-admin-init.lock ]; then
    uv run superset fab create-admin \
        --username $ADMIN_USERNAME \
        --password $ADMIN_PASSWORD && \
    touch /app/superset-init-lock/supperset-admin-init.lock
fi

# # Load examples if /app/superset-init-lock/supperset-examples-init.lock does not exist
# if [ ! -f /app/superset-init-lock/supperset-examples-init.lock ]; then
#     uv run superset load_examples && \
#     touch /app/superset-init-lock/supperset-examples-init.lock
# fi

# Initialize Superset if /app/superset-init-lock/supperset-init.lock does not exist
if [ ! -f /app/superset-init-lock/supperset-init.lock ]; then
    uv run superset init && \
    touch /app/superset-init-lock/supperset-init.lock
fi

# Run Superset
uv run superset run -p 8088 --with-threads --reload --debugger