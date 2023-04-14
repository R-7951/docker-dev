#!/bin/bash
set -e


#for Device reg
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER pgdevregsvc PASSWORD 'pgdevregpass';
    CREATE DATABASE device_registry;
    GRANT ALL PRIVILEGES ON DATABASE device_registry TO pgdevregsvc;
EOSQL



psql -U postgres -d 'device_registry' -c "CREATE SCHEMA deviceregistry AUTHORIZATION pgdevregsvc;"





#for Clas
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER pgclassvc PASSWORD 'pgclaspass';
    CREATE DATABASE clas;
    GRANT ALL PRIVILEGES ON DATABASE clas TO pgclassvc;
EOSQL



psql -U postgres -d 'clas' -c "CREATE SCHEMA clas AUTHORIZATION pgclassvc;"


#for init
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER pginitsvc PASSWORD 'pginitpass';
    CREATE DATABASE device_initializer;
    GRANT ALL PRIVILEGES ON DATABASE device_initializer TO pginitsvc;
EOSQL



psql -U postgres -d 'device_initializer' -c "CREATE SCHEMA deviceinitializer AUTHORIZATION pginitsvc;"



#for sonar
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER sonaruser PASSWORD 'sonarpass';
    CREATE DATABASE sonar_db;
    GRANT ALL PRIVILEGES ON DATABASE sonar_db TO sonaruser;
EOSQL



psql -U postgres -d 'sonar_db' -c "CREATE SCHEMA sonar_schema AUTHORIZATION sonaruser;"

psql -U postgres -d 'sonar_db' -c "GRANT USAGE, CREATE ON SCHEMA public TO sonaruser"