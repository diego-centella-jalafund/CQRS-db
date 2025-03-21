DROP FUNCTION IF EXISTS create_order;
DROP FUNCTION IF EXISTS update_order;
DROP FUNCTION IF EXISTS delete_order;

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO orders (customer_name, total_amount) VALUES ('Cliente 1', 100.00);

CREATE FUNCTION create_order(_customer_name VARCHAR, _total_amount DECIMAL) RETURNS VOID AS $$
BEGIN
    INSERT INTO orders (customer_name, total_amount) VALUES (_customer_name, _total_amount);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_order(order_id INT, new_customer_name TEXT, new_total_amount DECIMAL)
RETURNS VOID AS $$
BEGIN
    UPDATE orders 
    SET customer_name = new_customer_name, total_amount = new_total_amount 
    WHERE id = order_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_order(order_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM orders WHERE id = order_id;
END;
$$ LANGUAGE plpgsql;