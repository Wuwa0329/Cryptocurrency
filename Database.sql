-- Create the database if it doesn't exist
CREATE Cryptocurrency IF NOT EXISTS Cryptocurrency;
USE Cryptocurrency;


-- Create the Price table 
CREATE TABLE Price (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Date datetime NOT NULL,
    Asset VARCHAR(50) NOT NULL,
    Price DECIMAL(20, 10) NOT NULL
);

-- Insert the static commodity data once
INSERT INTO Metals (name, symbol, unit) VALUES ('Gold', 'XAU', 'Ounce');