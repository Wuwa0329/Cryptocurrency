-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS gold_tracker_db;
USE gold_tracker_db;


-- Create the Metals table 
CREATE TABLE Metals (
    metal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    symbol VARCHAR(10),
    unit VARCHAR(20)
);

-- Create the Price_History table
CREATE TABLE Price_History (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    metal_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    change_24h DECIMAL(6, 2),
    FOREIGN KEY (metal_id) REFERENCES Metals(metal_id)
);

-- Insert the static commodity data once
INSERT INTO Metals (name, symbol, unit) VALUES ('Gold', 'XAU', 'Ounce');