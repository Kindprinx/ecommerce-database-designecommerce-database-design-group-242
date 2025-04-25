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


-- Product Item table (Inventory)
-- Actual inventory items corresponding to product variations
CREATE TABLE product_item (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the inventory item',
    product_id VARCHAR(36) NOT NULL COMMENT 'Reference to the parent product',
    product_variation_id VARCHAR(36) NOT NULL COMMENT 'Reference to the associated product variation',
    price DECIMAL(10, 2) NOT NULL COMMENT 'Specific price for this item (may differ from base price)',
    stock_quantity INT NOT NULL DEFAULT 0 COMMENT 'Available quantity in stock',
    sku VARCHAR(100) NOT NULL COMMENT 'Stock Keeping Unit for this specific item',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Flag indicating if this item is active/available for purchase',
    FOREIGN KEY (product_id) REFERENCES product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_variation_id) REFERENCES product_variation(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Product Image table
-- Images associated with products
CREATE TABLE product_image (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the product image',
    product_id VARCHAR(36) NOT NULL COMMENT 'Reference to the associated product',
    url VARCHAR(255) NOT NULL COMMENT 'URL to the image file',
    alt_text VARCHAR(255) COMMENT 'Alternative text for accessibility',
    is_primary BOOLEAN DEFAULT FALSE COMMENT 'Flag indicating if this is the primary/featured image',
    FOREIGN KEY (product_id) REFERENCES product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE color (  
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the color',  
    name VARCHAR(50) NOT NULL COMMENT 'Color name',  
    hex_code VARCHAR(7) COMMENT 'Hex code for the color (e.g., #FFFFFF)',  
);  

CREATE TABLE product_category (  
    parent_category_id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the category',  
    name VARCHAR(255) NOT NULL COMMENT 'Name of the product category',  
    description TEXT COMMENT 'Description of the category',  
); 

CREATE TABLE brand (  
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the brand',  
    name VARCHAR(255) NOT NULL COMMENT 'Brand name',  
    description TEXT COMMENT 'Description of the brand',  
    logo_url VARCHAR(255) COMMENT 'URL to the brand logo',
    website VARCHAR(255) COMMENT 'URL to the brand website',
);