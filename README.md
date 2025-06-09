# 🏭 Warehouse Management System

A modular, Python-based warehouse and inventory management system designed for product, supplier, customer, and employee record handling with SQL integration and reporting capabilities.

---

## 🧰 Features

### 📦 Inventory & Product Management
- Add/update product categories and track stock (`products.py`, `categories.py`)
- Supports store-specific product handling

### 🧑‍🤝‍🧑 Customer & Employee Management
- Create, edit, and manage customer (`customers.py`) and employee records (`employees.py`)

### 🛒 Store & Supplier Modules
- Maintain store data (`stores.py`) and link products to specific suppliers (`suppliers.py`)

### 🧾 Report Generation
- Auto-generate reports and summaries in the `Reports/` directory

### 🗄️ SQL Integration
- SQL database file: `wms.sql`
- Supports initialization of required tables and relationships

---

## 🚀 Tech Stack

- **Language:** Python 3.x
- **Database:** MySQL / SQLite (via SQL scripts)
- **Structure:** Modular `.py` files per entity
- **Reports:** File-based output in text or CSV
- **Environment Variables:** `.env` file for DB configuration

---

## 📁 Project Structure

warehouse-management-system/
├── Reports/ # Auto-generated reports
├── images/ # Optional: UI or report assets
├── .env # Environment variables
├── wms.sql # SQL schema file
├── main.py # Entry point
├── products.py # Product module
├── customers.py # Customer module
├── employees.py # Employee module
├── suppliers.py # Supplier module
├── stores.py # Store module
├── categories.py # Category module
├── test.py # For testing core logic
└── README.md

---

## 🧪 How to Run

1. Install dependencies (if any):
   
   Set up your .env file (using DB credentials)

   Initialize DB using:
    ```bash
    mysql -u root -p < wms.sql

2. Run the system:
```bash
python main.py

---

## 📜 License
Licensed under the MIT License.

---

## 👩‍💻 Author
Reem Ooka

Full Stack Java Developer | AI/ML Researcher
