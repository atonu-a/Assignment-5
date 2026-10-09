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



