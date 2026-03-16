# 🛒 E-commerce SQL Analytics Project

## 📋 Project Description
A comprehensive SQL-based analytics solution for an e-commerce platform, featuring complete database design, data population, and advanced analytical queries. This project demonstrates end-to-end SQL skills from schema design to complex business intelligence queries.

## 🏗️ Database Architecture

### **Entities & Relationships**


Customers (1) → (M) Orders (1) → (M) Order_Items (M) → (1) Products
↑ ↓
└────── Payments (1:1) ──────┘




### **Schema Overview**
| Table | Columns | Purpose |
|-------|---------|---------|
| `customers` | customer_id, name, city, state | Customer master data |
| `products` | product_id, name, category, price | Product catalog |
| `orders` | order_id, customer_id, date, status | Order transactions |
| `order_items` | order_item_id, order_id, product_id, quantity | Line items per order |
| `payments` | payment_id, order_id, method, amount | Payment transactions |

## 🛠️ **SQL Skills Demonstrated**

### **📌 Data Definition Language (DDL)**
- `CREATE TABLE` with proper data types and constraints
- Schema design with normalization principles
- Table relationships and foreign key concepts

### **📌 Data Manipulation Language (DML)**
- `INSERT` with sample data generation
- Multi-row insertion techniques
- Realistic test data creation

### **📌 Querying & Analysis**
- **Basic Queries:** `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`
- **Joins:** `INNER JOIN`, `LEFT JOIN`, multiple table joins
- **Aggregations:** `SUM()`, `COUNT()`, `AVG()`, `MAX()`
- **Advanced Functions:** Window functions (`RANK()`, `OVER()`), CTEs (Common Table Expressions)
- **Filtering:** `HAVING` clause, subqueries, conditional logic with `CASE`

## 📊 **Analytical Tasks Performed**

### **Task 1: Data Validation & Quality Checks**
- Row count verification across all tables
- Identifying orphan records (orders without payments)
- Data consistency validation

### **Task 2: Customer-Order Analysis**
- Customer-order mapping with join operations
- Order status distribution analysis
- Customer segmentation by order frequency
- Identification of cancelled orders and affected customers

### **Task 3: Revenue Analytics**
- Order-level revenue calculation
- Delivered vs pending revenue analysis
- Revenue validation against payment records
- Price-quantity aggregation logic

### **Task 4: Customer Spending Behavior**
- Total spending per customer calculation
- Customer ranking by expenditure
- Spending segmentation (High/Medium/Low)
- Geographic spending analysis

### **Task 5: Product Performance Metrics**
- Quantity sold per product/category
- Revenue contribution by category
- Product ranking within categories
- Best-selling product identification

### **Task 6: Time Series Analysis**
- Peak order date identification
- Daily order volume patterns
- Recent customer activity tracking

### **Task 7: Advanced Business Insights**
- Window functions for ranking and partitioning
- Moving averages and comparative analysis
- Customer lifetime value estimation
- Product performance benchmarking

## 🔍 **Key Business Insights Generated**

### **💰 Financial Insights**
- Total revenue from delivered orders: **₹1,54,500**
- Highest revenue category: **Electronics** (₹84,000)
- Average order value: **₹15,450**
- Payment method distribution: UPI (40%), Card (40%), NetBanking (20%)

### **👥 Customer Insights**
- Top spender: **Amit** (₹55,000 on Laptop)
- Cities with highest spending: **Hyderabad, Bangalore, Mumbai**
- 10% cancellation rate (1 out of 10 orders)
- All customers have at least one order

### **📈 Product Insights**
- Best-selling category by quantity: **Education** (4 units of Books)
- Highest revenue product: **Laptop** (₹55,000)
- Category revenue ranking: Electronics > Furniture > Accessories > Fashion > Education
- Average product price: **₹11,020**


### **Installation & Execution**
1. Clone this repository:
   ```bash
   git clone https://github.com/saicharan8855/ecommerce-sql-analysis.git

 -- Run the complete script
SOURCE SQL_ECOMMERCE_GIT.sql;

2.-- Run the complete script
SOURCE SQL_ECOMMERCE_GIT.sql;


### **File Structure**
ecommerce-sql-analysis/
├── SQL_ECOMMERCE_GIT.sql  # Complete SQL implementation
├── README.md              # This documentation

### **📝 Technical Notes**
Database Compatibility: ANSI SQL - works with most RDBMS

Data Volume: 10 customers, 10 products, 10 orders (sample dataset)

Time Period: January 2025 (demonstration dates)

Currency: Indian Rupees (₹) - easily adaptable to other currencies


### **🎯 Learning Outcomes**
This project demonstrates:

Database Design: Creating normalized schemas

Data Manipulation: CRUD operations with SQL

Business Analytics: Translating business questions to SQL queries

Data Visualization through SQL: Generating insights directly from database

Version Control Integration: Managing SQL projects with Git


### **📚 SQL Concepts Covered**
• Data Types & Constraints • Aggregate Functions
• Table Relationships • Window Functions
• CRUD Operations • CTEs (WITH clauses)
• Joins  • Subqueries
• Grouping & Filtering • Conditional Logic
• Sorting & Limiting • Set Operations


### **👨‍💻 Author**
Sai Charan
[GitHub Profile](https://github.com/saicharan8855)
