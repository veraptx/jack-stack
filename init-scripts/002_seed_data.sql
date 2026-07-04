ALTER SESSION SET CONTAINER = FREEPDB1;
CONNECT appuser/YourAppPass123@localhost/FREEPDB1;

INSERT INTO clients (name, email) VALUES ('Client Demo', 'demo@example.com');

INSERT INTO equipment (label, category, purchase_date, price)
VALUES ('Micro-tracteur Kubota', 'agricole', DATE '2026-05-10', 4500.00);

COMMIT;

EXIT;