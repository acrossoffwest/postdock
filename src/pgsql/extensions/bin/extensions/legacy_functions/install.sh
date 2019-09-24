#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE FUNCTION IF NOT EXISTS pg_current_xlog_location()\$\$
    BEGIN
        RETURN pg_current_wal_lsn();
    END;
    \$\$ LANGUAGE plpgsql;
    CREATE FUNCTION IF NOT EXISTS pg_last_xlog_receive_location()\$\$
    BEGIN
        RETURN pg_last_wal_receive_lsn();
    END;
    \$\$ LANGUAGE plpgsql;
EOSQL
