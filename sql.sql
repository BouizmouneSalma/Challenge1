-- Création de la base de données (avec vérification)
DROP DATABASE IF EXISTS SaleOrderQuiz;
CREATE DATABASE SaleOrderQuiz;

-- Utilisation de la base de données
USE SaleOrderQuiz;

-- Table Customer (Client)
CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerFirstName VARCHAR(50) NOT NULL,
    CustomerLastName VARCHAR(50) NOT NULL,
    CustomerAddress VARCHAR(50) NOT NULL,
    CustomerCity VARCHAR(50) NOT NULL,
    CustomerPostCode VARCHAR(10), -- Plus flexible pour les codes postaux internationaux
    CustomerPhoneNumber CHAR(12) -- Format fixe pour les numéros de téléphone
);

-- Table Inventory (Inventaire)
CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID TINYINT AUTO_INCREMENT PRIMARY KEY,
    InventoryName VARCHAR(50) NOT NULL,
    InventoryDescription VARCHAR(255)
);

-- Table Employee (Employé)
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID TINYINT AUTO_INCREMENT PRIMARY KEY,
    EmployeeFirstName VARCHAR(50) NOT NULL,
    EmployeeLastName VARCHAR(50) NOT NULL,
    EmployeeExtension CHAR(4) -- Code d'extension fixe
);

-- Table Sale (Vente)
CREATE TABLE IF NOT EXISTS Sale (
    SaleID TINYINT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    InventoryID TINYINT NOT NULL,
    EmployeeID TINYINT NOT NULL,
    SaleDate DATE NOT NULL,
    SaleQuantity INT NOT NULL,
    SaleUnitPrice DECIMAL(10, 2) NOT NULL, -- Correction du type pour MySQL
    CONSTRAINT FK_Sale_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Sale_Inventory FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
    CONSTRAINT FK_Sale_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Insertion de données exemples
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerAddress, CustomerCity, CustomerPostCode, CustomerPhoneNumber)
VALUES ('John', 'Doe', '123 Rue Principale', 'Paris', '75001', '0123456789');

INSERT INTO Customer (CustomerID, CustomerFirstName, CustomerLastName, CustomerAddress, CustomerCity, CustomerPostCode, CustomerPhoneNumber)
VALUES
(2, 'Jane', 'Smith', '456 Elm St', 'Los Angeles', '9001', '987654321098'),
(3, 'Alice', 'Brown', '789 Maple Ave', 'Chicago', '6061', '564738291045'),
(4, 'Bob', 'Davis', '101 Oak Rd', 'Houston', '7701', '564738920134'),
(5, 'Mary', 'Johnson', '202 Pine St', 'Phoenix', '8501', '908765432198');

INSERT INTO Inventory (InventoryID, InventoryName, InventoryDescription)
VALUES
(1, 'Laptop', 'High-performance laptop with 16GB RAM'),
(2, 'Smartphone', 'Latest model smartphone with 5G support'),
(3, 'Tablet', '10-inch tablet with high-resolution display'),
(4, 'Monitor', '24-inch Full HD monitor'),
(5, 'Printer', 'All-in-one wireless printer');


INSERT INTO Sale (SaleID, CustomerID, InventoryID, EmployeeID, SaleDate, SaleQuantity, SaleUnitPrice)
VALUES
(1, 1, 1, 1, '2024-12-01', 2, 1200.50),
(2, 2, 2, 2, '2024-12-02', 1, 899.99),
(3, 3, 3, 3, '2024-12-03', 3, 300.00),
(4, 4, 4, 4, '2024-12-04', 1, 150.75),
(5, 5, 5, 5, '2024-12-05', 2, 450.00);

select  * from customer join Sale where 
---------------------------------- Manipulation des Données:
-- Afficher tous les clients depuis la table CustomerAddress
select * from customer;

-- Lister toutes les ventes avec leurs montants totaux (SaleQuantity * SaleUnitPrice) par ordre décroissant
select (SaleQuantity * SaleUnitPrice) as MontonsTotale from Sale 
order by MontonsTotale;

-- Afficher tous les employés ayant réalisé au moins une vente, ainsi que le montant total des ventes pour chacun.

SELECT 
    E.EmployeeID,
    E.EmployeeFirstName,
    E.EmployeeLastName,
    COUNT(S.SaleID) AS TotalSalesCount,
    SUM(S.SaleQuantity * S.SaleUnitPrice) AS TotalSalesAmount
FROM 
    Employee E
JOIN 
    Sale S
ON 
    E.EmployeeID = S.EmployeeID
GROUP BY 
    E.EmployeeID, E.EmployeeFirstName, E.EmployeeLastName
HAVING 
    COUNT(S.SaleID) > 0;


-- Partie 4 : Modifications des Tables
-- Ajoutez une nouvelle colonne CustomerEmail à la table Customer.

ALTER TABLE Customer ADD CustomerEmail VARCHAR(100);

-- Mettez à jour la colonne CustomerEmail pour l’un des clients.

UPDATE Customer SET CustomerEmail = 'salma@gmail.com' WHERE CustomerID = 1;

-- Supprimez un enregistrement client dont la ville (CustomerCity) est "New York

DELETE FROM Customer WHERE CustomerCity = 'New York';

-- Partie 5 : Requêtes Avancées

-- Écrivez une requête pour afficher toutes les ventes réalisées au cours des 30 derniers jours.

SELECT * FROM Sale WHERE SaleDate >= CURDATE() - INTERVAL 30 DAY;

-- Affichez tous les clients ayant acheté plus de 5 articles en une seule vente.








