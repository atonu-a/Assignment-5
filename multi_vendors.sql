-- Active: 1791385942957@@127.0.0.1@5432@postgres

-- Subscription Table
CREATE TABLE Subscription (
    id INTEGER PRIMARY KEY,
    plan_name VARCHAR(20),
    price DECIMAL(10,2),
    duration VARCHAR(10),
    features TEXT
);

-- Vendor Table
CREATE TABLE Vendor (
    id INTEGER PRIMARY KEY,
    business_name VARCHAR(50),
    contact_person VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    phone_number VARCHAR(11) UNIQUE,
    business_address VARCHAR(100),
    plan_id INTEGER,
    FOREIGN KEY (plan_id) REFERENCES Subscription(id)
);

-- Product Table
CREATE TABLE Product (
    id INTEGER PRIMARY KEY,
    vendor_id INTEGER,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(id),
    product_name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INTEGER,
    status VARCHAR(10)
);

-- Category Table
CREATE TABLE Category (
    id INTEGER PRIMARY KEY,
    category_name VARCHAR(20) UNIQUE,
    description TEXT
);


-- ProductCategory Table
CREATE TABLE Product_Category (
    product_id INTEGER,
    category_id INTEGER,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Product(id),
    FOREIGN KEY (category_id) REFERENCES Category(id)

);

-- Customer Table
CREATE TABLE Customer (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    phone_number VARCHAR(50) UNIQUE,
    address VARCHAR(100)
);

-- Order Table
CREATE TABLE Orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customer(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(20)
);


-- Order_Item Table
CREATE TABLE Order_Item (
    id INTEGER PRIMARY KEY,
    product_id INTEGER,
    FOREIGN KEY (product_id) REFERENCES Product(id),
    order_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2)
);


-- Payment Table
CREATE TABLE Payment (
    id INTEGER PRIMARY KEY,
    order_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    method VARCHAR(20),
    amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status VARCHAR(20)
);



-- DML Operations 
-- subscription data
INSERT INTO Subscription ( id, plan_name, price, duration, features )
VALUES 
(   1,
    'Basic Plan',
    999.00,
    '1 Month',
    'Limited Products'
),
(   2,
    'Premium Plan',
    1999.00,
    '3 Months',
    'Unlimited Products'
),
(   3,
    'Gold Plan',
    2999.00,
    '6 Months',
    'All + Priority Support'
);


INSERT INTO
    Vendor (
        id,
        business_name,
        contact_person,
        email,
        phone_number,
        business_address,
        plan_id
    )
VALUES (101,
        'SmartTech Ltd.',
        'Rahim Khan',
        'rahim@gmail.com',
        '01711111111',
        'Dhaka, Bangladesh',
        1
    );



--  Product data
INSERT INTO
    Product (id,
        vendor_id,
        product_name,
        description,
        price,
        stock_quantity,
        status
    )
VALUES (
        1002,
        101,
        'Smartphone',
        'Android Phone',
        25000,
        30,
        'active'
    ),
    (   1001,
        101,
        'Laptop',
        'Gaming Laptop',
        75000,
        10,
        'active'
    );

-- Updating Laptop stock to 15
UPDATE Product 
SET stock_quantity = 15
WHERE product_name = 'Laptop';


--  Category data
INSERT INTO
    Category (id, category_name, description)
VALUES ( 1,
        'Electronics',
        'Electronic devices'
    );



-- Product M:N Category
INSERT INTO
    Product_Category (product_id, category_id)
VALUES (1001, 1),(1002, 1);



-- Customer Table
INSERT INTO
    Customer ( id,
        name,
        email,
        phone_number,
        address
    )
VALUES ( 101,
        'Atonu Roy Chowdhury',
        'atonu@gmail.com',
        '01744444444',
        'Dhaka, Bangladesh'
    ),
    (   102,
        'Refat Hossain',
        'oldcustomer@gmail.com',
        '01755555555',
        'Chittagong, Bangladesh'
    );


-- Deleting example
DELETE FROM Customer WHERE email = 'oldcustomer@gmail.com';



