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

-- Size Category table
-- Groups of size options (e.g. Clothing Sizes, Shoe Sizes)
CREATE TABLE size_category (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the size category',
    name VARCHAR(255) NOT NULL COMMENT 'Name of the size category (e.g. "Clothing Sizes")',
    description TEXT COMMENT 'Description of the size category'
);

-- Size Option table
-- Individual size options within a category
CREATE TABLE size_option (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the size option',
    size_category_id VARCHAR(36) NOT NULL COMMENT 'Reference to the size category this option belongs to',
    label VARCHAR(50) NOT NULL COMMENT 'Display label for the size (e.g. "Small", "42")',
    value VARCHAR(50) NOT NULL COMMENT 'Value for the size (may be same as label)',
    sort_order INT DEFAULT 0 COMMENT 'Order for displaying sizes (smaller number = higher priority)',
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Attribute Type table
-- Types of attributes (e.g. "Material", "Pattern", "Feature")
CREATE TABLE attribute_type (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the attribute type',
    name VARCHAR(100) NOT NULL COMMENT 'Name of the attribute type',
    data_type VARCHAR(50) NOT NULL COMMENT 'Data type of the attribute (string, number, boolean, etc.)',
    description TEXT COMMENT 'Description of the attribute type'
);

-- Attribute Category table
-- Categories for grouping attributes
CREATE TABLE attribute_category (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the attribute category',
    name VARCHAR(100) NOT NULL COMMENT 'Name of the attribute category',
    description TEXT COMMENT 'Description of the attribute category'
);

-- Product Attribute table
-- Specific attributes assigned to products
CREATE TABLE product_attribute (
    id VARCHAR(36) PRIMARY KEY COMMENT 'Unique identifier for the product attribute',
    product_id VARCHAR(36) NOT NULL COMMENT 'Reference to the associated product',
    attribute_category_id VARCHAR(36) NOT NULL COMMENT 'Reference to the attribute category',
    attribute_type_id VARCHAR(36) NOT NULL COMMENT 'Reference to the attribute type',
    name VARCHAR(100) NOT NULL COMMENT 'Attribute name',
    value TEXT NOT NULL COMMENT 'Attribute value',
    FOREIGN KEY (product_id) REFERENCES product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ADDING FOREIGN KEYS TO COMPLETE RELATIONSHIPS

-- Add foreign keys to product table after referenced tables are created
ALTER TABLE product
ADD CONSTRAINT fk_product_brand
FOREIGN KEY (brand_id) REFERENCES brand(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE product
ADD CONSTRAINT fk_product_category
FOREIGN KEY (product_category_id) REFERENCES product_category(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- Add foreign keys to product_variation after referenced tables are created
ALTER TABLE product_variation
ADD CONSTRAINT fk_product_variation_color
FOREIGN KEY (color_id) REFERENCES color(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE product_variation
ADD CONSTRAINT fk_product_variation_size
FOREIGN KEY (size_option_id) REFERENCES size_option(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE product_variation
ADD CONSTRAINT fk_product_variation_image
FOREIGN KEY (image_id) REFERENCES product_image(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

--INDEXES FOR PERFORMANCE

--Core product index
CREATE INDEX idx_product_brand ON product(brand_id);
CREATE INDEX idx_product_category ON product(product_category_id);
CREATE INDEX idx_product_variation_product ON product_variation(product_id);
CREATE INDEX idx_product_item_variation ON product_item(product_variation_id);
CREATE INDEX idx_product_item_product ON product_item(product_id);

--index for classification(size..)
CREATE INDEX idx_size_option_category ON size_option(size_category_id);
CREATE INDEX idx_product_category_parent ON product_category(parent_category_id);

--image and attributes indexes
CREATE INDEX idx_product_image_product ON product_image(product_id);
CREATE INDEX idx_product_attribute_product ON product_attribute(product_id);
CREATE INDEX idx_product_attribute_category ON product_attribute(attribute_category_id);
CREATE INDEX idx_product_attribute_type ON product_attribute(attribute_type_id);














