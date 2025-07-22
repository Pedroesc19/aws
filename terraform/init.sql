CREATE DATABASE IF NOT EXISTS store;
USE store;
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    quantity INT
);
INSERT INTO products (name, quantity) VALUES
('Football', 10),
('Basketball', 15),
('Tennis Racket', 5);
