DROP FUNCTION IF EXISTS get_orders;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP
);

CREATE FUNCTION get_orders() 
RETURNS TABLE(order_id INT, customer VARCHAR, total DECIMAL) AS $$
BEGIN
    RETURN QUERY 
    SELECT o.id, o.customer_name, o.total_amount 
    FROM orders o;
END;
$$ LANGUAGE plpgsql;

