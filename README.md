# ecommerce-database-designecommerce-database-design-group-242
# 🛍️ E-commerce Database Design

Welcome to our group project for designing and building an e-commerce database from scratch! This repository contains our ERD design, SQL schema, and documentation to support our project work.

---

## 🎯 Objective

This project is part of our Peer Group Assignment and focuses on:

- Designing a clear and normalized **Entity-Relationship Diagram (ERD)**
- Implementing an **SQL schema** for a full-featured e-commerce system
- Collaborating effectively as a team using **GitHub** best practices
This repository contains the SQL schema for a comprehensive e-commerce platform database.
 The database is designed to support a robust product management system with flexible categorization, detailed product variations,
inventory tracking, and extensive attribute management  

---

## 🧑‍🤝‍🧑 Team Members

<<<<<<< HEAD
- [Kindness Ebeneza](https://github.com/kindprinx)
- [Risper Njeri](https://github.com/RisperNJW)
- [Teammate 3](https://github.com/teammate3)
- [Teammate 4](https://github.com/teammate4)
- [Teammate 5](https://github.com/teammate5)
- [Teammate 6](https://github.com/teammate6)
=======
- [Kindness Ebeneza]
- [risper	njeri]
- [shadrack	musembi]
- [imoleayo	ogunbekun]
- [sarah	wanjiku]
  
>>>>>>> 4537e0c71abd87a7f0ba273795068343397a3452

---

## 📁 Repository Structure

| Folder/File        | Description                             |
|--------------------|-----------------------------------------|
| `/diagrams/`       | Contains the exported ERD diagram       |       
| `/sql/ecommerce.sql` | The full SQL schema                    |
| `README.md`        | You're reading it!                      |

---

Database Structure
The database follows a core-first design approach, with the main product-related tables at the center and supporting tables built around them.
Core Product Tables

product - The central entity containing basic product information:

Core product details (name, description, base price)
Creation and update timestamps
References to brand and category


product_variation - Specific variations of products:

Links to parent product
References to color and size options
Variation-specific SKU


product_item - Inventory-level items with stock tracking:

Stock quantity and pricing information
Active status
Links to product and its variation


product_image - Images associated with products:

Image URL and alt text
Primary image flag



Classification & Attribute Tables

brand - Product manufacturers/brands
product_category - Hierarchical product categorization
color - Color options for product variations
size_category & size_option - Size classification system
attribute_type - Types of attributes (material, pattern, etc.)
attribute_category - Categories for grouping attributes
product_attribute - Specific attributes assigned to products

Entity Relationships

A product can have multiple product_variations
Each product_variation can have multiple product_items in inventory
products are categorized into product_categories (which form a hierarchy)
products belong to brands
product_variations have specific colors and size_options
size_options belong to size_categories
products can have multiple product_attributes
product_attributes have attribute_types and belong to attribute_categories
products can have multiple product_images

Technical Details

All IDs use VARCHAR(36) format to support UUID implementation
Foreign key constraints maintain data integrity between related tables
Detailed comments document the purpose of each table and column
Strategic indexing improves query performance for common operations
Appropriate data types for different kinds of information (DECIMAL for prices, TEXT for descriptions)

Installation

Ensure you have MySQL installed and running
Connect to your MySQL server
Execute the SQL script to create the database and tables:

bashmysql -u username -p < ecommerce_platform_schema.sql
Usage Examples
Adding a new product
sql-- Insert a brand
INSERT INTO brand (id, name, website) 
VALUES (UUID(), 'Example Brand', 'https://example.com');

-- Insert a product category
INSERT INTO product_category (id, name) 
VALUES (UUID(), 'Example Category');

-- Insert a product
INSERT INTO product (id, name, base_price, description, sku, brand_id, product_category_id) 
VALUES (
    UUID(), 
    'Example Product', 
    99.99, 
    'This is an example product description', 
    'PROD-001',
    (SELECT id FROM brand WHERE name = 'Example Brand'),
    (SELECT id FROM product_category WHERE name = 'Example Category')
);
Creating a product variation
sql-- Insert a color
INSERT INTO color (id, name, hex_code) 
VALUES (UUID(), 'Blue', '#0000FF');

-- Insert a size category
INSERT INTO size_category (id, name) 
VALUES (UUID(), 'Clothing Sizes');

-- Insert a size option
INSERT INTO size_option (id, size_category_id, label, value) 
VALUES (
    UUID(), 
    (SELECT id FROM size_category WHERE name = 'Clothing Sizes'), 
    'Medium', 
    'M'
);

-- Insert a product variation
INSERT INTO product_variation (id, product_id, color_id, size_option_id, variation_sku) 
VALUES (
    UUID(),
    (SELECT id FROM product WHERE name = 'Example Product'),
    (SELECT id FROM color WHERE name = 'Blue'),
    (SELECT id FROM size_option WHERE label = 'Medium'),
    'PROD-001-BLUE-M'
);





---

## 🛠️ Tools Used

- [dbdiagram.io](https://dbdiagram.io/) for ERD
- [MySQL](https://www.mysql.com/) for SQL database design
- [Git & GitHub](https://github.com/) for version control and collaboration







## 📬 Contact & Questions

Got suggestions, questions, or want to contribute? Open an issue or reach out via GitHub discussions.

Happy building! 🧱
