-- SQL  for the e-commerce database


-

-- Create database
CREATE DATABASE ecommerce_platform;
USE ecommerce_platform;

-- 
-- CORE PRODUCT TABLES


-- Product table
-- Core product information (master product data)
CREATE TABLE product (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the product',
    name VARCHAR(255) NOT NULL COMMENT 'Product name',
    base_price DECIMAL(10, 2) NOT NULL COMMENT 'Base price of the product before variations',
    description TEXT COMMENT 'Detailed description of the product',
    sku VARCHAR(100) COMMENT 'Stock Keeping Unit - standard product identifier',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the product was created',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when the product was last updated',
    brand_id VARCHAR(36) COMMENT 'Reference to the brand of this product',
    product_category_id VARCHAR(36) COMMENT 'Reference to the primary category of this product'
);

-- Product Variation table
-- Specific variations of products (e.g. "Blue, Size M")
CREATE TABLE product_variation (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the product variation',
    product_id VARCHAR(36) NOT NULL COMMENT 'Reference to the parent product',
    color_id VARCHAR(36) COMMENT 'Reference to the color of this variation',
    size_option_id VARCHAR(36) COMMENT 'Reference to the size option of this variation',
    variation_sku VARCHAR(100) NOT NULL COMMENT 'SKU specific to this variation',
    image_id VARCHAR(36) COMMENT 'Reference to the primary image for this variation',
    FOREIGN KEY (product_id) REFERENCES product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
