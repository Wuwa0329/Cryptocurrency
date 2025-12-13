-- Create the database if it doesn't exist
CREATE Cryptocurrency IF NOT EXISTS Cryptocurrency;
USE Cryptocurrency;


-- Create the Price table 
CREATE TABLE Price (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Date datetime NOT NULL,
    Asset VARCHAR(50) NOT NULL,
    Volume DECIMAL(20, 10) NOT NULL,
    Price DECIMAL(20, 10) NOT NULL,
    Max_Price DECIMAL(20, 10) NOT NULL,
    Min_Price DECIMAL(20, 10) NOT NULL
);
