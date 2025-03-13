-- Creating a new database named 'ConsumerWasteAnalytics'
CREATE DATABASE ConsumerWasteAnalytics;

-- Selecting the newly created database for use
USE ConsumerWasteAnalytics;

-- Creating the Customers table to store customer details
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each customer
    Name VARCHAR(100) NOT NULL, -- Customer's name (mandatory)
    Age INT NOT NULL, -- Customer's age (mandatory)
    Region VARCHAR(50), -- Region where the customer resides
    PurchaseHistory TEXT, -- Stores details of past purchases
    AverageSpending DECIMAL(10, 2), -- Average spending amount by the customer
    PreferredCategory VARCHAR(50), -- Customer's preferred product category
    LoyaltyScore INT -- Score representing customer loyalty
);
-- Creating the Products table to store product details
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product
    Name VARCHAR(100) NOT NULL, -- Product name (mandatory)
    Category VARCHAR(50), -- Category of the product
    ReturnRate DECIMAL(5, 2), -- Percentage of product returns
    DisposalRate DECIMAL(5, 2), -- Percentage of product disposal
    Price DECIMAL(10, 2), -- Price of the product
    Supplier VARCHAR(100), -- Supplier providing the product
    SustainabilityScore DECIMAL(5, 2) -- Environmental sustainability rating of the product
);
-- Creating the Orders table to store customer purchase details
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order
    CustomerID INT, -- References the customer placing the order
    ProductID INT, -- References the purchased product
    OrderDate DATE NOT NULL, -- Date when the order was placed (mandatory)
    ReturnDate DATE, -- Date when the order was returned (if applicable)
    Quantity INT NOT NULL, -- Number of units purchased (mandatory)
    TotalPrice DECIMAL(10, 2) NOT NULL, -- Total price of the order (mandatory)
    PaymentMethod VARCHAR(50), -- Payment method used for the order
    OrderStatus VARCHAR(50), -- Current status of the order (e.g., Pending, Completed, Returned)
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Establishes relationship with Customers table
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) -- Establishes relationship with Products table
);
-- Creating the WasteMetrics table to track waste-related data for products
CREATE TABLE WasteMetrics (
    MetricID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each waste metric entry
    ProductID INT, -- References the associated product
    ReturnReason TEXT, -- Reason for product return (if applicable)
    EnvironmentalImpact TEXT, -- Description of the product's environmental impact
    CarbonFootprint DECIMAL(10, 2), -- Carbon footprint of the product (measured value)
    RecyclabilityScore DECIMAL(5, 2), -- Score indicating how recyclable the product is
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) -- Establishes relationship with Products table
);
-- Creating the Recommendations table to store personalized product recommendations for customers
CREATE TABLE Recommendations (
    RecommendationID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each recommendation
    CustomerID INT, -- References the associated customer
    ProductID INT, -- References the associated product
    SuggestedAction TEXT, -- Recommended action for the customer (e.g., buy, recycle, return)
    ActionImpact TEXT, -- Expected impact of the suggested action (e.g., cost savings, sustainability)
    ActionDate DATE, -- Date when the recommendation was generated
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Establishes relationship with Customers table
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) -- Establishes relationship with Products table
);
-- Creating the Suppliers table to store information about product suppliers
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each supplier
    Name VARCHAR(100) NOT NULL, -- Supplier's name (mandatory field)
    ContactInfo VARCHAR(200), -- Contact details of the supplier
    Region VARCHAR(50), -- Region where the supplier operates
    ProductSupplied VARCHAR(255), -- List of products supplied by the supplier
    SupplierRating DECIMAL(3, 2) CHECK (SupplierRating BETWEEN 0 AND 5) -- Supplier rating on a scale of 0 to 5
);
-- Creating the Inventory table to track product stock levels and restocking details
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each inventory record
    ProductID INT NOT NULL, -- References the product being stored
    StockLevel INT NOT NULL, -- Current quantity of the product in stock
    ReorderThreshold INT NOT NULL, -- Minimum stock level before reordering is required
    StorageLocation VARCHAR(100), -- Location where the product is stored
    RestockDate DATE, -- Date when the product was last restocked
    SupplierID INT NOT NULL, -- References the supplier providing the product
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID), -- Enforcing relationship with Products table
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) -- Enforcing relationship with Suppliers table
);
-- Creating the EnvironmentalImpactSummary table to track the environmental impact of products
CREATE TABLE EnvironmentalImpactSummary (
    ImpactID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each environmental impact entry
    ProductID INT NOT NULL, -- References the associated product
    AverageEnvironmentalImpact DECIMAL(5, 2), -- Numeric value representing the overall environmental impact
    KeyImpactAreas TEXT, -- Description of major environmental concerns related to the product
    RecommendationsForImprovement TEXT, -- Suggested actions to reduce environmental impact
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) -- Enforcing relationship with Products table
);
-- Displaying all tables in the current database  
SHOW TABLES; 

-- DUMMY TABLES INSERTION  
-- Inserting sample data into tables for testing and validation 

-- Inserting dummy data into the Customers table for testing purposes
INSERT INTO Customers (CustomerID, Name, Age, Region, PurchaseHistory, AverageSpending, PreferredCategory, LoyaltyScore) VALUES
    -- Each record represents a customer with their details including name, age, region, purchase history, 
    -- average spending, preferred shopping category, and loyalty score.
    
    -- Customer from North region, prefers Electronics, high loyalty score
    (1, 'Amit Sharma', 32, 'North', 'Laptop, Phone, Headphones', 25000.50, 'Electronics', 85),
    
    -- Customer from West region, prefers Fashion, moderate spending
    (2, 'Priya Verma', 27, 'West', 'Shoes, Handbag', 12000.75, 'Fashion', 70),
    
    -- Customer from East region, prefers Home Appliances, high spending
    (3, 'Rajesh Gupta', 40, 'East', 'Refrigerator, Washing Machine', 45000.00, 'Home Appliances', 90),
    
    -- Customer from South region, prefers Beauty products, lower loyalty score
    (4, 'Neha Mehta', 29, 'South', 'Skincare, Perfume', 8000.30, 'Beauty', 60),
    
    -- High-spending customer from North, loyal to Electronics
    (5, 'Vikram Singh', 35, 'North', 'LED TV, Home Theater', 50000.00, 'Electronics', 95),

    -- Additional records covering different regions, preferences, and spending behaviors
    (6, 'Anjali Das', 31, 'West', 'Makeup Kit, Hair Dryer', 15000.20, 'Beauty', 78),
    (7, 'Suresh Reddy', 38, 'East', 'Treadmill, Dumbbells', 22000.00, 'Fitness', 85),
    (8, 'Kavita Iyer', 26, 'South', 'Sarees, Jewelry', 18000.60, 'Fashion', 75),
    (9, 'Manoj Nair', 45, 'North', 'Sofa Set, Dining Table', 70000.90, 'Home Decor', 98),
    (10, 'Sunita Pillai', 30, 'West', 'Books, Stationery', 6000.40, 'Books', 55),
    
    -- Covering a mix of spending patterns, age groups, and shopping preferences
    (11, 'Deepak Kumar', 34, 'East', 'Smartphone, Laptop', 40000.25, 'Electronics', 92),
    (12, 'Swati Bhatt', 28, 'South', 'Dress, Heels', 14000.80, 'Fashion', 68),
    (13, 'Arjun Malhotra', 41, 'North', 'Car Accessories, Helmets', 20000.50, 'Automobile', 88),
    (14, 'Reema Shah', 33, 'West', 'Organic Food, Supplements', 9500.90, 'Health', 72),
    (15, 'Rohan Deshmukh', 37, 'East', 'Shoes, Gym Equipment', 26000.60, 'Fitness', 80),
    (16, 'Meena Yadav', 25, 'South', 'Lipstick, Foundation', 8500.40, 'Beauty', 62),
    (17, 'Tarun Ghosh', 46, 'North', 'Luxury Watches, Sunglasses', 55000.00, 'Fashion', 94),
    (18, 'Pooja Saxena', 29, 'West', 'Curtains, Bedsheets', 11000.20, 'Home Decor', 70),
    (19, 'Ashok Patil', 36, 'East', 'Fan, Air Cooler', 18000.00, 'Home Appliances', 76),
    (20, 'Nidhi Agarwal', 31, 'South', 'Yoga Mat, Dumbbells', 9000.30, 'Fitness', 65),

    -- Additional sample customers from various regions with diverse purchasing habits
    (21, 'Harish Menon', 43, 'North', 'Power Bank, Smart Watch', 22000.40, 'Electronics', 89),
    (22, 'Sonal Kapoor', 27, 'West', 'Bags, Earrings', 13000.00, 'Fashion', 74),
    (23, 'Gopal Srinivasan', 39, 'East', 'Grocery Items, Kitchen Tools', 10500.50, 'Groceries', 68),
    (24, 'Ritika Sinha', 28, 'South', 'Face Cream, Shampoo', 7500.60, 'Beauty', 58),
    (25, 'Sandeep Joshi', 42, 'North', 'Trekking Gear, Travel Accessories', 28000.20, 'Travel', 87),
    (26, 'Alok Mishra', 34, 'West', 'Guitar, Headphones', 15000.90, 'Music', 77),
    (27, 'Shruti Chatterjee', 30, 'East', 'Formal Shoes, Watches', 19000.00, 'Fashion', 79),
    (28, 'Parth Raj', 45, 'South', 'Smart TV, Gaming Console', 60000.00, 'Electronics', 99),
    (29, 'Vinay Thakur', 38, 'North', 'Coffee Machine, Blender', 20000.60, 'Home Appliances', 82),
    (30, 'Tanya Sehgal', 25, 'West', 'Hoodies, Sneakers', 12000.40, 'Fashion', 67),

    -- Covering all major product categories, including electronics, fashion, home decor, fitness, and more
    (31, 'Ravi Shetty', 37, 'East', 'Bicycles, Helmets', 25000.00, 'Fitness', 84),
    (32, 'Pallavi Kulkarni', 29, 'South', 'Makeup Brushes, Compact', 9500.30, 'Beauty', 66),
    (33, 'Sameer Khan', 44, 'North', 'Gold Jewelry, Luxury Bags', 85000.50, 'Luxury', 100),
    (34, 'Jyoti Bansal', 32, 'West', 'Office Chair, Desk', 19000.20, 'Home Decor', 71),
    (35, 'Aniket Banerjee', 41, 'East', 'Printers, Hard Drives', 29000.90, 'Electronics', 85),
    (36, 'Komal Joshi', 26, 'South', 'Nail Polish, Perfume', 7000.80, 'Beauty', 57),
    (37, 'Karan Arora', 39, 'North', 'Books, Kindle', 11000.40, 'Books', 63),
    (38, 'Rhea Das', 28, 'West', 'Body Wash, Essential Oils', 8000.30, 'Beauty', 60),
    (39, 'Abhinav Tyagi', 47, 'East', 'Car Tires, Car Perfume', 32000.50, 'Automobile', 90),
    (40, 'Smita Rao', 30, 'South', 'Dining Set, Wall Art', 17000.20, 'Home Decor', 73),
    (41, 'Mohit Chawla', 36, 'North', 'Gym Bag, Dumbbells', 15000.00, 'Fitness', 75),
    (42, 'Sneha Nair', 29, 'West', 'Handmade Crafts, Candles', 9500.70, 'Home Decor', 68),
    (43, 'Umesh Patil', 42, 'East', 'Tablet, Power Bank', 21000.30, 'Electronics', 86),
    (44, 'Simran Kapoor', 31, 'South', 'Designer Saree, Necklace', 25000.40, 'Fashion', 81),
    (45, 'Nitin Saxena', 35, 'North', 'Motorbike Gear, Gloves', 28000.00, 'Automobile', 88),
    (46, 'Payal Grover', 27, 'West', 'Sunscreen, Night Cream', 9000.50, 'Beauty', 61),
    (47, 'Ashish Mehta', 44, 'East', 'Action Figures, Toys', 13000.60, 'Toys', 69),
    (48, 'Ritika Arora', 33, 'South', 'Kurtis, Dupattas', 14000.90, 'Fashion', 72),
    (49, 'Yashwant Rao', 38, 'North', 'Camping Gear, Sleeping Bag', 30000.50, 'Travel', 89),
    (50, 'Preeti Sinha', 29, 'West', 'Earrings, Makeup Kit', 11000.30, 'Beauty', 64);
    
    -- Inserting dummy data into the Products table for testing purposes
INSERT INTO Products (Name, Category, ReturnRate, DisposalRate, Price, Supplier, SustainabilityScore) VALUES
    -- Dairy products with low return and disposal rates
    ('Amul Butter', 'Dairy', 2.50, 1.20, 50.00, 'Amul India Pvt Ltd', 8.5),
    ('Britannia Cheese Slices', 'Dairy', 2.20, 1.00, 110.00, 'Britannia Industries', 8.9),

    -- Grocery and snack items with moderate return rates
    ('Tata Salt', 'Groceries', 1.80, 0.90, 25.00, 'Tata Consumer Products', 9.0),
    ('Parle-G Biscuits', 'Snacks', 3.20, 2.00, 10.00, 'Parle Products Ltd', 8.0),
    ('Haldiram’s Kaju Katli', 'Sweets', 5.00, 3.00, 550.00, 'Haldiram Snacks Pvt Ltd', 7.0),

    -- Beverages and health products with relatively lower disposal rates
    ('Brooke Bond Red Label Tea', 'Beverages', 2.00, 1.50, 150.00, 'Hindustan Unilever Ltd', 7.5),
    ('Dabur Honey', 'Health', 1.50, 1.00, 250.00, 'Dabur India Ltd', 9.2),

    -- Personal care products with moderate sustainability scores
    ('Patanjali Aloe Vera Gel', 'Personal Care', 4.50, 3.00, 80.00, 'Patanjali Ayurveda', 8.8),
    ('Godrej No.1 Soap', 'Personal Care', 2.80, 1.50, 35.00, 'Godrej Consumer Products', 8.3),
    ('Himalaya Neem Face Wash', 'Beauty', 3.50, 2.20, 120.00, 'Himalaya Herbals', 8.7),
    ('Lakme Kajal', 'Beauty', 3.80, 2.50, 180.00, 'Hindustan Unilever Ltd', 8.4),
    ('Santoor Sandalwood Soap', 'Personal Care', 2.30, 1.50, 40.00, 'Wipro Consumer Care', 8.6),
    ('Boroline Antiseptic Cream', 'Healthcare', 1.70, 1.00, 40.00, 'GD Pharmaceuticals', 9.5),

    -- Home decor and stationery items with high sustainability scores
    ('Fevicol Adhesive', 'Stationery', 1.20, 0.80, 50.00, 'Pidilite Industries', 9.3),
    ('Asian Paints Royale', 'Home Decor', 1.00, 0.50, 900.00, 'Asian Paints Ltd', 9.8),

    -- Fashion and clothing products with low disposal rates
    ('Raymond Suit Fabric', 'Clothing', 0.90, 0.40, 2500.00, 'Raymond Ltd', 9.7),

    -- Electronics and automobile products with varied return rates
    ('Bajaj LED Bulb', 'Electronics', 1.50, 0.80, 220.00, 'Bajaj Electricals', 9.1),
    ('Samsung Galaxy M14', 'Electronics', 5.50, 4.00, 18000.00, 'Samsung India', 8.0),
    ('Bose SoundLink Speaker', 'Electronics', 0.90, 0.40, 12000.00, 'Bose Corporation India', 9.4),
    ('Hero Splendor Bike', 'Automobile', 0.50, 0.20, 70000.00, 'Hero MotoCorp', 9.0),
    ('Royal Enfield Classic 350', 'Automobile', 0.30, 0.10, 195000.00, 'Royal Enfield India', 9.5),
    ('Maruti Swift Car', 'Automobile', 0.40, 0.20, 800000.00, 'Maruti Suzuki India', 9.6),

    -- Accessories and fashion items with medium return rates
    ('Titan Raga Watch', 'Accessories', 1.10, 0.70, 5500.00, 'Titan Company Ltd', 9.2),
    ('Linc Gel Pen', 'Stationery', 3.00, 1.80, 20.00, 'Linc Pens Ltd', 8.1);
    
-- Inserting dummy data into the Orders table to simulate real transactions
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, TotalPrice, PaymentMethod, OrderStatus) VALUES
    -- Orders with various statuses and payment methods
    (1, 3, 1, '2024-02-01', 124999.00, 'Credit Card', 'Delivered'), -- High-value order, successfully delivered
    (2, 7, 2, '2024-02-02', 29998.00, 'Debit Card', 'Delivered'), -- Two items delivered to customer
    (3, 15, 1, '2024-02-03', 59999.00, 'UPI', 'Shipped'), -- Order is still in transit
    (4, 20, 3, '2024-02-04', 897.00, 'Net Banking', 'Pending'), -- Awaiting processing confirmation
    (5, 1, 1, '2024-02-05', 79999.00, 'Credit Card', 'Delivered'), -- Order completed successfully
    (6, 10, 1, '2024-02-06', 12999.00, 'Debit Card', 'Cancelled'), -- Customer canceled order
    (7, 5, 1, '2024-02-07', 44999.00, 'Cash on Delivery', 'Shipped'), -- COD order still in transit
    (8, 12, 2, '2024-02-08', 39998.00, 'Credit Card', 'Delivered'), -- Order completed successfully
    
    -- More sample transactions with a mix of delivery statuses
    (11, 6, 2, '2024-02-11', 25998.00, 'Debit Card', 'Delivered'), -- Two items delivered
    (12, 14, 1, '2024-02-12', 7999.00, 'UPI', 'Shipped'), -- Order shipped but not yet delivered
    (13, 21, 1, '2024-02-13', 13999.00, 'Credit Card', 'Pending'), -- Pending processing
    (14, 19, 3, '2024-02-14', 897.00, 'Net Banking', 'Delivered'), -- Successfully completed
    (15, 8, 1, '2024-02-15', 4999.00, 'Cash on Delivery', 'Delivered'), -- COD successfully completed
    (16, 22, 1, '2024-02-16', 6999.00, 'Debit Card', 'Shipped'), -- Order dispatched
    (17, 11, 1, '2024-02-17', 22999.00, 'Credit Card', 'Delivered'), -- Order delivered
    (18, 2, 1, '2024-02-18', 69999.00, 'Credit Card', 'Delivered'), -- Large order completed
    (19, 9, 2, '2024-02-19', 17998.00, 'UPI', 'Pending'), -- Payment awaiting confirmation
    (20, 16, 3, '2024-02-20', 2397.00, 'Cash on Delivery', 'Delivered'), -- COD transaction completed
    
    -- Additional orders across different products and customers
    (21, 4, 1, '2024-02-21', 29999.00, 'Credit Card', 'Cancelled'), -- Order was canceled
    (22, 13, 2, '2024-02-22', 65998.00, 'Debit Card', 'Delivered'), -- Successfully processed
    (23, 24, 1, '2024-02-23', 499.00, 'UPI', 'Shipped'), -- In transit
    (24, 23, 1, '2024-02-24', 499.00, 'Credit Card', 'Delivered'), -- Successfully completed
    (25, 17, 1, '2024-02-25', 3999.00, 'Cash on Delivery', 'Pending'), -- Awaiting confirmation
    (26, 2, 1, '2024-02-26', 69999.00, 'Credit Card', 'Shipped'), -- High-value order in transit
    (27, 10, 2, '2024-02-27', 25998.00, 'Debit Card', 'Delivered'), -- Two items delivered
    (28, 5, 1, '2024-02-28', 44999.00, 'Net Banking', 'Delivered'), -- Successfully completed
    (29, 15, 1, '2024-02-29', 59999.00, 'UPI', 'Cancelled'), -- Customer canceled order
    (30, 7, 2, '2024-03-01', 29998.00, 'Credit Card', 'Delivered'), -- Order delivered
    
    -- Final batch of transactions
    (41, 1, 1, '2024-03-12', 79999.00, 'Credit Card', 'Shipped'), -- In transit
    (42, 23, 1, '2024-03-13', 499.00, 'UPI', 'Cancelled'), -- Order canceled
    (43, 16, 2, '2024-03-14', 1598.00, 'Net Banking', 'Delivered'), -- Successfully completed
    (44, 18, 3, '2024-03-15', 17997.00, 'Debit Card', 'Delivered'), -- Order processed and delivered
    (45, 4, 1, '2024-03-16', 29999.00, 'Credit Card', 'Shipped'), -- Order in transit
    (46, 13, 1, '2024-03-17', 32999.00, 'UPI', 'Delivered'), -- Successfully completed
    (47, 7, 1, '2024-03-18', 14999.00, 'Cash on Delivery', 'Delivered'), -- COD transaction completed
    (48, 3, 2, '2024-03-19', 249998.00, 'Credit Card', 'Pending'), -- Large order awaiting processing
    (49, 22, 1, '2024-03-20', 6999.00, 'Debit Card', 'Delivered'), -- Successfully delivered
    (50, 9, 1, '2024-03-21', 8999.00, 'Credit Card', 'Delivered'); -- Completed transaction



-- Inserting return reasons and their environmental impacts into WasteMetrics table
INSERT INTO WasteMetrics (ProductID, ReturnReason, EnvironmentalImpact, CarbonFootprint, RecyclabilityScore) VALUES
-- Product damaged on arrival leads to high plastic waste from packaging
(1, 'Damaged on Arrival', 'High plastic waste due to packaging', 12.5, 7.8),  

-- Defective electronic products contribute significantly to e-waste
(2, 'Defective Product', 'Electronic waste concerns', 18.2, 5.6),  

-- Delivering wrong items results in extra transportation emissions from returns
(3, 'Wrong Item Delivered', 'Excess transportation emissions', 10.3, 8.2),  

-- Customer returns due to change of mind cause unnecessary resource usage
(4, 'Customer Changed Mind', 'Unnecessary resource utilization', 5.6, 9.1),  

-- Expired products contribute to food waste and methane emissions
(5, 'Expired Product', 'Food waste and methane emissions', 20.8, 6.5),  

-- Size mismatches increase return rates, leading to higher logistics emissions
(6, 'Size Mismatch', 'High return rate increases emissions', 8.4, 7.2),  

-- Price sensitivity leads to unnecessary returns, adding to logistics emissions
(7, 'Better Price Found Elsewhere', 'Returns increase logistics emissions', 6.7, 9.0),  

-- Perceived low product quality may indicate issues in materials and recyclability
(8, 'Quality Not as Expected', 'Materials not fully recyclable', 13.1, 6.2),  

-- Incomplete products lead to additional production and material wastage
(9, 'Incomplete Product', 'Extra production needed for replacements', 15.5, 7.3),  

-- Packaging issues, especially non-biodegradable materials, increase environmental impact
(10, 'Packaging Issues', 'Non-biodegradable packaging waste', 9.8, 8.5);



-- Inserting summarized environmental impact data and recommendations into EnvironmentalImpactSummary table
INSERT INTO EnvironmentalImpactSummary (ProductID, AverageEnvironmentalImpact, KeyImpactAreas, RecommendationsForImprovement) VALUES
-- ProductID 1: High plastic waste and emissions due to packaging; recommendation focuses on sustainable packaging
(1, 8.2, 'Plastic waste, transportation emissions', 'Reduce packaging waste, use biodegradable materials'),  

-- ProductID 2: Electronic waste and toxic chemicals are major concerns; suggests implementing e-waste recycling
(2, 7.5, 'Electronic waste, toxic chemicals', 'Implement e-waste recycling program, improve durability'),  

-- ProductID 3: Transportation-related emissions due to incorrect deliveries; recommends optimizing routes
(3, 6.8, 'Transportation, fuel emissions', 'Optimize delivery routes, use electric vehicles'),  

-- ProductID 4: Unnecessary returns lead to resource wastage; suggests improving product descriptions
(4, 5.3, 'Resource wastage from returns', 'Improve product descriptions to reduce returns'),  

-- ProductID 5: High food waste and methane emissions; recommends better storage and composting programs
(5, 9.1, 'Food waste, methane emissions', 'Enhance storage conditions, introduce composting initiatives'),  

-- ProductID 6: High return rates due to size mismatches; AR fitting solutions can help
(6, 7.0, 'High return rate, emissions', 'Provide better size guides, AR-based fitting solutions'),  

-- ProductID 7: Returns increase logistics-related emissions; suggests sourcing locally
(7, 6.5, 'Logistics emissions', 'Encourage local sourcing, reduce return incentives'),  

-- ProductID 8: Issues with non-recyclable materials; suggests using sustainable alternatives
(8, 8.0, 'Material non-recyclability', 'Switch to sustainable materials, improve production methods'),  

-- ProductID 9: Extra waste due to defective or incomplete products; focus on improving quality control
(9, 7.4, 'Extra production waste', 'Improve quality control, minimize defective rates'),  

-- ProductID 10: Non-biodegradable packaging causes environmental issues; proposes recycled or returnable packaging
(10, 8.9, 'Non-biodegradable packaging', 'Use recycled packaging, offer returnable packaging options');



-- Inserting supplier details into the Suppliers table  
INSERT INTO Suppliers (Name, ContactInfo, Region, ProductSupplied, SupplierRating) VALUES  

-- Supplier specializing in solar panels for North America  
('GreenTech Supplies', 'contact@greentech.com', 'North America', 'Solar Panels', 4.5),  

-- European supplier providing biodegradable packaging solutions  
('EcoPlast Industries', 'support@ecoplast.com', 'Europe', 'Biodegradable Packaging', 4.2),  

-- Asian supplier of recycled aluminum, promoting sustainable metal usage  
('Sustainable Metals Ltd.', 'info@susmetals.com', 'Asia', 'Recycled Aluminum', 4.7),  

-- Supplier from South America offering organic cotton fabrics for sustainable textiles  
('Organic Textiles Co.', 'hello@organictextiles.com', 'South America', 'Organic Cotton Fabrics', 4.1),  

-- North American supplier specializing in sustainable timber products  
('Renewable Woodworks', 'contact@renewablewood.com', 'North America', 'Sustainable Timber', 4.6),  

-- European supplier focusing on recycled electronic components for e-waste management  
('E-Waste Solutions', 'support@ewastesolutions.com', 'Europe', 'Recycled Electronic Components', 3.9),  

-- African supplier of compostable agricultural products to promote sustainable farming  
('BioAgro Corp.', 'info@bioagro.com', 'Africa', 'Compostable Agricultural Products', 4.3),  

-- Asian supplier providing energy-efficient LED bulbs to reduce power consumption  
('EcoLighting Ltd.', 'hello@ecolighting.com', 'Asia', 'Energy-Efficient LED Bulbs', 4.8),  

-- Australian supplier of water filtration systems for clean water solutions  
('Pure Water Systems', 'support@purewatersys.com', 'Australia', 'Water Filtration Systems', 4.0),  

-- North American supplier of recyclable packaging materials to support zero-waste initiatives  
('ZeroWaste Packaging', 'contact@zerowastepack.com', 'North America', 'Recyclable Packaging Materials', 4.5),  

-- European supplier of low-carbon steel, contributing to reduced carbon footprints  
('GreenSteel Inc.', 'info@greensteel.com', 'Europe', 'Low-Carbon Steel', 4.4),  

-- South American supplier offering non-toxic cleaning agents for eco-friendly cleaning solutions  
('EcoChemicals Ltd.', 'support@ecochemicals.com', 'South America', 'Non-Toxic Cleaning Agents', 3.8),  

-- Asian supplier specializing in solar battery storage for renewable energy solutions  
('Solar Innovators', 'hello@solarinnovators.com', 'Asia', 'Solar Battery Storage', 4.6),  

-- African supplier providing eco-friendly transportation services to minimize carbon emissions  
('Green Logistics Co.', 'contact@greenlogistics.com', 'Africa', 'Eco-Friendly Transport Services', 4.2),  

-- Australian supplier focusing on recycled plastic components to promote circular economy  
('Sustainable Plastics', 'support@susplastics.com', 'Australia', 'Recycled Plastic Components', 3.9),  

-- North American supplier of wind turbines supporting renewable energy projects  
('Green Energy Solutions', 'info@greenenergy.com', 'North America', 'Wind Turbines', 4.7),  

-- European supplier providing compostable food containers to reduce plastic waste  
('EcoPackaging Corp.', 'hello@ecopackaging.com', 'Europe', 'Compostable Food Containers', 4.3);



-- Inserting recommendations for customers based on product usage and potential improvements
INSERT INTO Recommendations (CustomerID, ProductID, SuggestedAction, ActionImpact, ActionDate) VALUES
-- Encourages bulk purchases, leading to increased sales and reduced packaging waste
(1, 3, 'Offer discounts for bulk purchases', 'Increases sales and reduces packaging waste', '2025-02-01'),

-- Enhances product descriptions to help customers make informed choices, reducing return rates
(2, 5, 'Improve product descriptions', 'Reduces return rates and customer dissatisfaction', '2025-02-02'),

-- Introduces a loyalty program to improve customer engagement and retention
(3, 8, 'Introduce a loyalty program', 'Enhances customer retention and engagement', '2025-02-03'),

-- Suggests switching to biodegradable packaging to reduce environmental impact
(4, 2, 'Switch to biodegradable packaging', 'Minimizes environmental impact', '2025-02-04'),

-- Optimizes delivery logistics to minimize carbon footprint and improve efficiency
(5, 7, 'Optimize delivery logistics', 'Reduces carbon footprint from transportation', '2025-02-05'),

-- Uses AI-powered recommendations for personalized marketing and improved sales
(6, 10, 'Use AI-powered recommendations', 'Improves personalized marketing and sales', '2025-02-06'),

-- Partners with eco-friendly suppliers to enhance sustainability efforts
(7, 4, 'Partner with eco-friendly suppliers', 'Strengthens sustainability efforts', '2025-02-07'),

-- Provides detailed size guides to reduce return rates due to incorrect sizing
(8, 6, 'Provide detailed size guides', 'Reduces return rates due to sizing issues', '2025-02-08'),

-- Implements a trade-in program to encourage recycling and reusability of products
(9, 1, 'Implement a trade-in program', 'Encourages recycling and reusability', '2025-02-09'),

-- Introduces AR-based try-on features to enhance customer experience and minimize product returns
(10, 9, 'Introduce AR-based try-on features', 'Enhances customer experience and reduces returns', '2025-02-10');


-- Inserting inventory details for various products with stock levels, reorder thresholds, storage locations, restock dates, and supplier information
INSERT INTO Inventory (ProductID, StockLevel, ReorderThreshold, StorageLocation, RestockDate, SupplierID) VALUES
-- Product 1: Stock of 150 units, reorder at 50 units, stored in Warehouse A - Shelf 3, restock expected on 2025-02-20, supplied by Supplier 3
(1, 150, 50, 'Warehouse A - Shelf 3', '2025-02-20', 3),

-- Product 2: Stock of 80 units, reorder at 30 units, stored in Warehouse B - Section 2, restock expected on 2025-02-18, supplied by Supplier 5
(2, 80, 30, 'Warehouse B - Section 2', '2025-02-18', 5),

-- Product 3: Stock of 200 units, reorder at 60 units, stored in Warehouse C - Rack 1, restock expected on 2025-02-22, supplied by Supplier 8
(3, 200, 60, 'Warehouse C - Rack 1', '2025-02-22', 8),

-- Product 4: Stock of 50 units, reorder at 20 units, stored in Warehouse A - Shelf 5, restock expected on 2025-02-15, supplied by Supplier 2
(4, 50, 20, 'Warehouse A - Shelf 5', '2025-02-15', 2),

-- Product 5: Stock of 120 units, reorder at 40 units, stored in Warehouse D - Bay 4, restock expected on 2025-02-25, supplied by Supplier 6
(5, 120, 40, 'Warehouse D - Bay 4', '2025-02-25', 6),

-- Product 6: Stock of 30 units, reorder at 15 units, stored in Warehouse B - Section 6, restock expected on 2025-02-12, supplied by Supplier 10
(6, 30, 15, 'Warehouse B - Section 6', '2025-02-12', 10),

-- Product 7: Stock of 90 units, reorder at 35 units, stored in Warehouse E - Zone 3, restock expected on 2025-02-19, supplied by Supplier 4
(7, 90, 35, 'Warehouse E - Zone 3', '2025-02-19', 4),

-- Product 8: Stock of 175 units, reorder at 55 units, stored in Warehouse F - Shelf 7, restock expected on 2025-02-24, supplied by Supplier 7
(8, 175, 55, 'Warehouse F - Shelf 7', '2025-02-24', 7),

-- Product 9: Stock of 60 units, reorder at 25 units, stored in Warehouse C - Rack 2, restock expected on 2025-02-16, supplied by Supplier 12
(9, 60, 25, 'Warehouse C - Rack 2', '2025-02-16', 12),

-- Product 10: Stock of 110 units, reorder at 45 units, stored in Warehouse A - Shelf 8, restock expected on 2025-02-28, supplied by Supplier 9
(10, 110, 45, 'Warehouse A - Shelf 8', '2025-02-28', 9),

-- Product 11: Stock of 200 units, reorder at 75 units, stored in Warehouse D - Bay 1, restock expected on 2025-02-22, supplied by Supplier 15
(11, 200, 75, 'Warehouse D - Bay 1', '2025-02-22', 15),

-- Product 12: Stock of 140 units, reorder at 50 units, stored in Warehouse G - Zone 2, restock expected on 2025-02-21, supplied by Supplier 14
(12, 140, 50, 'Warehouse G - Zone 2', '2025-02-21', 14),

-- Product 13: Stock of 95 units, reorder at 30 units, stored in Warehouse H - Section 4, restock expected on 2025-02-17, supplied by Supplier 11
(13, 95, 30, 'Warehouse H - Section 4', '2025-02-17', 11),

-- Product 14: Stock of 180 units, reorder at 65 units, stored in Warehouse B - Section 5, restock expected on 2025-02-23, supplied by Supplier 13
(14, 180, 65, 'Warehouse B - Section 5', '2025-02-23', 13),

-- Product 15: Stock of 75 units, reorder at 30 units, stored in Warehouse F - Shelf 9, restock expected on 2025-02-20, supplied by Supplier 1
(15, 75, 30, 'Warehouse F - Shelf 9', '2025-02-20', 1);

-- Display the list of all available databases
SHOW DATABASES;

-- Show all tables in the currently selected database
SHOW TABLES;

-- Show all data from the Customers table
SELECT * FROM Customers;

-- Show all data from the Products table
SELECT * FROM Products;

-- Show all data from the Orders table
SELECT * FROM Orders;

-- Show all data from the WasteMetrics table
SELECT * FROM WasteMetrics;

-- Show all data from the Recommendations table
SELECT * FROM Recommendations;

-- Show all data from the Suppliers table
SELECT * FROM Suppliers;

-- Show all data from the Inventory table
SELECT * FROM Inventory;

-- Show all data from the EnvironmentalImpactSummary table
SELECT * FROM EnvironmentalImpactSummary;

-- QUERY 1 --
-- Fetch the most ordered product categories by different age groups
SELECT C.Age, P.Category, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.Age, P.Category
ORDER BY TotalOrders DESC;

-- QUERY 2 --
-- Identify products with the highest return rates
SELECT P.Name AS ProductName, P.Category, COUNT(W.MetricID) AS ReturnCount
FROM WasteMetrics W
JOIN Products P ON W.ProductID = P.ProductID
GROUP BY P.Name, P.Category
ORDER BY ReturnCount DESC
LIMIT 5;

-- Query3 --
-- Retrieve the most valuable customers based on their spending
SELECT C.Name, C.AverageSpending, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name, C.AverageSpending
ORDER BY C.AverageSpending DESC
LIMIT 10;

-- Query 4--
-- Find top-selling product categories in each region
SELECT C.Region, P.Category, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.Region, P.Category
ORDER BY C.Region, TotalOrders DESC;

-- Query 5 --
-- Retrieve products with the highest sustainability score
SELECT Name, Category, SustainabilityScore 
FROM Products 
WHERE SustainabilityScore > 8
ORDER BY SustainabilityScore DESC
LIMIT 10;

-- Query 6 --
-- Identify suppliers with frequent late deliveries
SELECT S.Name AS SupplierName, COUNT(O.OrderID) AS LateDeliveries
FROM Orders O
JOIN Suppliers S ON O.ProductID IN 
    (SELECT ProductID FROM Products WHERE Supplier = S.Name)
WHERE O.OrderStatus = 'Delayed'
GROUP BY S.Name
ORDER BY LateDeliveries DESC;

SELECT S.Name AS SupplierName, COUNT(O.OrderID) AS LateDeliveries
FROM Suppliers S
JOIN Products P ON S.Name = P.Supplier
JOIN Orders O ON O.ProductID = P.ProductID
WHERE O.OrderStatus = 'Pending'
GROUP BY S.Name
HAVING LateDeliveries > 0
ORDER BY LateDeliveries DESC;

 SELECT S.Name AS SupplierName, COUNT(O.OrderID) AS LateDeliveries
FROM Orders O
JOIN Suppliers S ON O.ProductID IN 
    (SELECT ProductID FROM Products WHERE Supplier = S.Name)
WHERE O.OrderStatus = 'Pending'  -- Change 'Delayed' to 'Pending'
GROUP BY S.Name
ORDER BY LateDeliveries DESC;


SELECT COUNT(*) FROM Orders WHERE OrderStatus = 'Delayed';
SELECT DISTINCT OrderStatus FROM Orders;



-- Query 7 --
-- Detect customers with sudden spikes in order activity
SELECT C.Name, COUNT(O.OrderID) AS OrdersPlaced
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate >= CURDATE() - INTERVAL 7 DAY
GROUP BY C.Name
HAVING OrdersPlaced > (SELECT AVG(TotalOrders) * 3 
                        FROM (SELECT COUNT(OrderID) AS TotalOrders 
                              FROM Orders 
                              GROUP BY CustomerID) AS AvgOrders)
ORDER BY OrdersPlaced DESC;

-- Query 8 --
SELECT 
    i.ProductID, 
    i.StockLevel, 
    i.ReorderThreshold,
    COALESCE(AVG(o.Quantity), 0) AS Avg_Sales_Per_Month
FROM `inventory` i
LEFT JOIN `orders` o 
    ON i.ProductID = o.ProductID
GROUP BY i.ProductID, i.StockLevel, i.ReorderThreshold;


-- Query 9 --
USE ConsumerWasteAnalytics;

SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,  -- Extract Year-Month
    SUM(p.Price * o.Quantity) AS Total_Revenue   -- Calculate revenue
FROM `orders` o
JOIN `products` p 
    ON o.ProductID = p.ProductID  -- Join to get product prices
GROUP BY Month
ORDER BY Month;

-- Query 10 --
-- Identify products in high demand but low supply
SELECT P.Name, I.StockLevel, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Inventory I ON O.ProductID = I.ProductID
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY P.Name, I.StockLevel
HAVING I.StockLevel < 10
ORDER BY TotalOrders DESC;

-- Query 11 --
-- Detect customers with high return rates
SELECT C.Name, COUNT(W.MetricID) AS ReturnCount
FROM WasteMetrics W
JOIN Customers C ON W.ProductID IN 
    (SELECT ProductID FROM Orders WHERE Orders.CustomerID = C.CustomerID)
GROUP BY C.Name
ORDER BY ReturnCount DESC
LIMIT 5;


-- Query alternative for 6 ----
-- 1 ---

-- Query --
-- Selecting the average number of days since order placement for all pending orders
SELECT AVG(DATEDIFF(NOW(), O.OrderDate)) AS AvgPendingDays
FROM Orders O
-- Filtering only orders that are still pending
WHERE O.OrderStatus = 'Pending';


-- 🔹 Identify suppliers with the most pending orders
SELECT P.Supplier, COUNT(O.OrderID) AS PendingOrders
FROM Orders O
-- 🔹 Joining the Products table to fetch supplier details for each order
JOIN Products P ON O.ProductID = P.ProductID
-- 🔹 Filtering only orders that are still pending
WHERE O.OrderStatus = 'Pending'
-- 🔹 Grouping by supplier to count how many pending orders each supplier has
GROUP BY P.Supplier
-- 🔹 Sorting results in descending order to highlight suppliers with the highest pending orders
ORDER BY PendingOrders DESC;



-- 🔹 Query to calculate the total value of pending orders per supplier
SELECT P.Supplier, SUM(O.TotalPrice) AS TotalPendingValue
FROM Orders O
-- 🔹 Joining the Products table to get the supplier details for each product ordered
JOIN Products P ON O.ProductID = P.ProductID
-- 🔹 Filtering only orders that are still in 'Pending' status
WHERE O.OrderStatus = 'Pending'
-- 🔹 Grouping by supplier to sum the total value of all pending orders for each supplier
GROUP BY P.Supplier
-- 🔹 Sorting the results in descending order to highlight suppliers with the highest pending order value
ORDER BY TotalPendingValue DESC;

-- 🔹 Query to find products with the highest number of pending orders
SELECT P.Name AS ProductName, COUNT(O.OrderID) AS PendingOrders
FROM Orders O
-- 🔹 Joining the Products table to fetch product details for each order
JOIN Products P ON O.ProductID = P.ProductID
-- 🔹 Filtering only orders that are still in 'Pending' status
WHERE O.OrderStatus = 'Pending'
-- 🔹 Grouping by product name to count how many pending orders exist for each product
GROUP BY P.Name
-- 🔹 Sorting the results in descending order to highlight products with the highest pending orders
ORDER BY PendingOrders DESC;

-- -- --- -- --- --- ---- -- -- -- -- -- -- - ---- -- -- -- - -- - -- --

-- Fraud Detection Queries
-- This set of queries is designed to detect potential fraudulent behavior in customer transactions.
-- It identifies suspicious activities such as multiple high-value orders, frequent cancellations, 
-- use of multiple payment methods, and orders placed from different locations.

-- 🔹 Query to detect customers placing multiple high-value orders in a short time (potential fraud)
SELECT CustomerID, COUNT(OrderID) AS HighValueOrders, SUM(TotalPrice) AS TotalSpent
FROM Orders
-- 🔹 Filtering orders where the total price is higher than the average order value
WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM Orders)  
-- 🔹 Considering only orders placed in the last 7 days to identify short-term bulk buying behavior
AND OrderDate >= DATE_SUB(NOW(), INTERVAL 7 DAY)  
-- 🔹 Grouping results by customer to analyze their order behavior
GROUP BY CustomerID
-- 🔹 Filtering for customers who have placed more than 3 high-value orders in the selected time frame
HAVING HighValueOrders > 3  
-- 🔹 Sorting the results in descending order to prioritize customers who have spent the most
ORDER BY TotalSpent DESC;


-- 🔹 Query to identify customers with frequent order cancellations (potential refund abuse)
SELECT CustomerID, COUNT(OrderID) AS CancelledOrders
FROM Orders
-- 🔹 Filtering only orders that were canceled
WHERE OrderStatus = 'Cancelled'
-- 🔹 Grouping by customer to count the number of canceled orders per customer
GROUP BY CustomerID
-- 🔹 Flagging customers with more than 5 cancellations, which may indicate suspicious behavior
HAVING CancelledOrders > 5  
-- 🔹 Sorting the results in descending order to highlight customers with the highest cancellations
ORDER BY CancelledOrders DESC;


-- 🔹 Query to identify customers using multiple payment methods in a short period (possible fraud)
SELECT CustomerID, COUNT(DISTINCT PaymentMethod) AS UniquePaymentMethods, COUNT(OrderID) AS TotalOrders
FROM Orders
-- 🔹 Considering only orders placed in the last 30 days for recent fraud patterns
WHERE OrderDate >= DATE_SUB(NOW(), INTERVAL 30 DAY)  
-- 🔹 Grouping by customer to analyze their order behavior
GROUP BY CustomerID
-- 🔹 Flagging customers who have used more than 2 different payment methods in 30 days
HAVING UniquePaymentMethods > 2  
-- 🔹 Sorting results in descending order to highlight customers with the most orders
ORDER BY TotalOrders DESC;

-- 🔹 Query to find customers who placed orders in multiple regions (possible fraud)
SELECT O.CustomerID, C.Region, COUNT(DISTINCT C.Region) AS UniqueRegions, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
-- 🔹 Grouping by customer to track their order behavior across regions
GROUP BY O.CustomerID, C.Region
-- 🔹 Flagging customers who have orders in more than 1 region
HAVING UniqueRegions > 1  
-- 🔹 Sorting in descending order to highlight customers with the most orders across regions
ORDER BY TotalOrders DESC;


-- 🔹 Query to find customers whose spending is unusually high or low for their loyalty score
SELECT C.CustomerID, C.LoyaltyScore, SUM(O.TotalPrice) AS TotalSpent, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
-- 🔹 Grouping by customer to analyze spending behavior
GROUP BY C.CustomerID, C.LoyaltyScore
-- 🔹 Flagging customers with high spending but low loyalty score (potential fraud or abuse)
HAVING (TotalSpent > 50000 AND LoyaltyScore < 50)  
   OR (TotalSpent < 5000 AND LoyaltyScore > 80)
-- 🔹 Sorting to prioritize suspicious cases
ORDER BY TotalSpent DESC;


-- Query to identify customers with unusual spending behavior relative to their loyalty scores.
SELECT C.CustomerID, C.LoyaltyScore, SUM(O.TotalPrice) AS TotalSpent, COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.LoyaltyScore
-- It categorizes customers into two groups:
HAVING (TotalSpent > 20000 AND LoyaltyScore < 60)  -- 1. High spenders with low loyalty (TotalSpent > 20,000 AND LoyaltyScore < 60).
   OR (TotalSpent < 10000 AND LoyaltyScore > 70)  -- 2. Low spenders with high loyalty (TotalSpent < 10,000 AND LoyaltyScore > 70).
ORDER BY TotalSpent DESC;


-- 🔹 Query to find customers whose purchase behavior doesn't match their preferred category
SELECT C.CustomerID, C.PreferredCategory, GROUP_CONCAT(DISTINCT P.Category) AS CategoriesBought
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
JOIN Customers C ON O.CustomerID = C.CustomerID
-- 🔹 Grouping by customer to compare what they buy vs. their preference
GROUP BY C.CustomerID, C.PreferredCategory
-- 🔹 Filtering customers who have purchased more than 3 different categories
HAVING LENGTH(CategoriesBought) - LENGTH(REPLACE(CategoriesBought, ',', '')) + 1 > 3
-- 🔹 Sorting to identify cases with the most mismatches
ORDER BY LENGTH(CategoriesBought) DESC;


-- Important Note:
-- If any of these queries return empty results, it suggests that there are no significant fraud patterns 
-- detected in the data, meaning the risk of fraud is currently low. 
-- However, regular monitoring and analysis are recommended to proactively identify any emerging risks.



-------------------------------------------------------------------------------------------- 


-- Stress Testing --
-- 1 Measure Query Performance Using EXPLAIN ANALYZE
-- This helps analyze how the SQL engine processes the query, identifying bottlenecks.
-- It checks if the query is using indexes efficiently or performing full table scans.

EXPLAIN 
SELECT C.CustomerID, C.LoyaltyScore, SUM(O.TotalPrice) AS TotalSpent, COUNT(O.OrderID) AS TotalOrders  
FROM Orders O  
JOIN Customers C ON O.CustomerID = C.CustomerID  
GROUP BY C.CustomerID, C.LoyaltyScore  
HAVING (TotalSpent > 20000 AND LoyaltyScore < 60)  
   OR (TotalSpent < 10000 AND LoyaltyScore > 70)  
ORDER BY TotalSpent DESC;

---------------------------------------------------

-- 2 Run Queries Repeatedly & Monitor Performance
 -- This helps track database load and performance over time. 
-- Checking session status to detect slow queries, temporary tables, and inefficient scans. 
SHOW SESSION STATUS LIKE 'Created_tmp_tables'; -- Shows temporary tables created, which impact performance. 
SHOW SESSION STATUS LIKE 'Handler_read_rnd_next'; -- Measures table scans (higher values indicate inefficiencies).
 SHOW STATUS LIKE 'Slow_queries'; -- Tracks slow-running queries. 
 
 ---------------------------------------------------
 
 -- 3️ Checking for Edge Cases (Handling Empty Tables and Extreme Values)
-- This ensures queries work correctly even if data is missing or contains extreme values.

-- (A) Running queries on an empty table (to ensure they don’t break)
DELETE FROM Orders; -- WARNING:This deletes all records in Orders. It was run in a test environment only.
SELECT * FROM Orders; -- This returns 0 rows (ensuring the query doesn’t fail on empty tables).

-- (B) Insert extreme values for testing.
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, TotalPrice, PaymentMethod, OrderStatus)  
VALUES (1, 3, 9999, '2025-01-01', 999999.99, 'Credit Card', 'Delivered'); -- Extreme high order

SELECT * FROM Orders WHERE TotalPrice > 900000; -- Check if extreme values are handled correctly.
-- Note: If queries return incorrect results or crash, consider handling edge cases in the logic.

---------------------------------------------------

-- 4️ Simulate Concurrent Users (Check for Locking Issues)
-- This helps detect performance drops when multiple users query the database simultaneously.

SHOW ENGINE INNODB STATUS; -- Checks for transaction locks, row locks, and deadlocks.
SHOW PROCESSLIST; -- Displays currently running queries and their states.

-- Note: If too many locks or waiting queries appear, investigate and optimize table indexes or use connection pooling.

---------------------------------------------------

-- NORMALIZATION 

-- Selecting specific columns from the "Orders" table to check for normalization compliance
SELECT 
    OrderID,         -- Unique identifier for each order (should be atomic)
    CustomerID,      -- Unique identifier for each customer (should not contain multiple values)
    ProductID,       -- Unique identifier for each product (should be atomic and not store multiple products)
    OrderDate,       -- Date when the order was placed (should be a single value, not a list)
    ReturnDate,      -- Date when the order was returned (should be NULL if not returned)
    Quantity,        -- Number of units ordered (should be a single value, not a list)
    TotalPrice,      -- Total price for the order (should not be a calculated field in a normalized form)
    PaymentMethod,   -- Mode of payment used (should be a single value like "Credit Card" or "Cash")
    OrderStatus      -- Status of the order (e.g., "Delivered", "Pending", etc.)
FROM Orders;        -- Fetching data from the "Orders" table to check if it follows First Normal Form (1NF)

-- Purpose of This Query:
-- Verifies Atomicity – Ensures that each column contains only one value per row.
-- Checks for Repeating Groups – Confirms that there are no multiple values in a single field.
-- Determines if Data is Already in 1NF – If all columns have atomic values, then the table is in First Normal Form.

-- Observation: The dataset is already in First Normal Form (1NF).
-- Each column contains atomic values, and there are no repeating groups.
-- Therefore, no further normalization is required.

--------------------------------------

-- Checking if the relationships between tables comply with First Normal Form (1NF).
-- 1NF ensures that:
--    - Each column contains atomic (indivisible) values.
--    - There are no repeating groups or arrays.
--    - Each row has a unique identifier (Primary Key).
-- If the relationships are already in 1NF, no further normalization is needed.

Use ConsumerWasteAnalytics;

-- Display the structure of the Orders table to check column types.
DESC Orders;

-- Display the structure of the Products table to check if columns store atomic values.
DESC Products;

-- Display the structure of the Suppliers table to verify proper relationships.
DESC Suppliers;

----------------------------------------------
-- Identifying if any column has multiple values in a single field.
SELECT OrderID, ProductID
FROM Orders
WHERE ProductID LIKE '%,%'; -- Searches for values containing commas (e.g., "3,5,7")
-------------------

-- Check if the Orders table has a Primary Key.
SHOW KEYS FROM Orders WHERE Key_name = 'PRIMARY';

-- Check if the Customers table has a Primary Key.
SHOW KEYS FROM Customers WHERE Key_name = 'PRIMARY';

-- Check if the Products table has a Primary Key.
SHOW KEYS FROM Products WHERE Key_name = 'PRIMARY';
--------------------

-- Check if any column has multiple words or values stored together.
SELECT CustomerID, PurchaseHistory
FROM Customers
WHERE PurchaseHistory LIKE '% %'; -- Identifies fields with multiple values stored in one column.
---------------------

-- Display a few records from the Orders table to confirm atomicity.
SELECT * FROM Orders LIMIT 10;

-- Display a few records from the Products table to confirm no multi-valued attributes exist.
SELECT * FROM Products LIMIT 10;
---------------------------------------------------------------------------------------------

-- Observation: The database is already in First Normal Form (1NF).
-- All attributes contain atomic values, there are no repeating groups, 
-- and every table has a primary key.
-- No further normalization is required for 1NF.






















 
