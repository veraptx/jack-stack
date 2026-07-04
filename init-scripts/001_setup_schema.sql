-- Runs as SYS against the root container by default; switch to the app PDB
ALTER SESSION SET CONTAINER = FREEPDB1;

-- Grant extra privileges to the app_user created via APP_USER env vars
GRANT DB_DEVELOPER_ROLE TO appuser;
GRANT UNLIMITED TABLESPACE TO appuser;

-- Connect as the app user to create objects in its own schema
CONNECT appuser/YourAppPass123@localhost/FREEPDB1;

CREATE TABLE clients (
    id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(150) NOT NULL,
    email         VARCHAR2(150),
    created_at    TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE equipment (
    id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label         VARCHAR2(150) NOT NULL,
    category      VARCHAR2(80),
    purchase_date DATE,
    price         NUMBER(10,2)
);

COMMIT;