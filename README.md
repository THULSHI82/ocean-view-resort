# Ocean View Resort – Reservation Management System

![Version](https://img.shields.io/badge/version-1.0-blue)
![Java](https://img.shields.io/badge/java-jakarta--servlet-orange)
![Database](https://img.shields.io/badge/database-mysql-blue)
![License](https://img.shields.io/badge/license-academic-green)

A web-based **Hotel Reservation Management System** developed using **Java (Jakarta Servlets & JSP)** and **MySQL**.

This project was created for the **CIS6003 Advanced Programming module** and demonstrates modern software engineering practices including **MVC architecture, layered design, validation mechanisms, and structured Git workflow.**

Final System Release: **Version 1.0**

---

# Key System Features

### Authentication
- Secure staff login
- Session-based authentication
- Access protection using servlet filters
- Logout with session invalidation
- PRG pattern to prevent duplicate form submissions

### Staff Dashboard
- Sidebar-based navigation interface
- Operational statistics overview
- Quick navigation to system modules

### Reservation Management
- Create reservations with guest information
- Select rooms from inventory
- Automatic stay price calculation
- Room availability validation
- Reservation search and filtering
- Reservation deletion functionality

### Billing System
- Invoice generation using reservation ID
- Service charge (10%) and tax (2%) calculation
- Printable invoice layout
- Payment settlement (Cash / Card)
- Payment status tracking (Pending / Paid)

### Staff Help Section
- Guidelines for using the reservation system
- Instructions for reservation and billing operations

---

# Technology Stack

- **Java (Jakarta Servlets & JSP)**
- **Apache Tomcat 11**
- **Maven**
- **MySQL (XAMPP)**
- **IntelliJ IDEA**
- **Git & GitHub**

---

# System Architecture

The application follows a **3-Tier Layered Architecture**.

### Presentation Layer
Handles user interaction using:
- JSP pages
- HTML / CSS interface
- JavaScript components

### Business Logic Layer
Implemented using Service classes:
- `AuthService`
- `ReservationService`
- `BillingService`
- `DashboardService`

These services enforce business rules such as reservation validation and billing calculations.

### Data Access Layer
Database communication is handled using DAO classes:
- `ReservationDAO`
- `BillingDAO`
- `RoomDAO`
- `CustomerDAO`

DAO classes isolate SQL queries from application logic to improve maintainability.

---

# Design Patterns Implemented

The system uses several design patterns:

### MVC Pattern
Separates application components into Model, View, and Controller.

### Singleton Pattern
Used for database connection management.

### Front Controller Pattern
Centralized dashboard routing using a single servlet.

### PRG Pattern (Post-Redirect-Get)
Prevents duplicate form submission and improves request handling.

---

# Database Structure

The system uses a **MySQL relational database**.

Main tables include:

| Table | Description |
|------|-------------|
users | Staff authentication credentials |
customers | Guest information |
rooms | Room inventory |
reservations | Booking records |

---

# Git Workflow

The repository follows a staged development workflow:


development → qa → uat → master


Branch roles:

- **development** – active feature development
- **qa** – feature verification
- **uat** – acceptance testing
- **master** – production-ready releases

---

# Release History

### Version 0.1
- Authentication module
- Dashboard framework

### Version 0.2
- Reservation management system

### Version 0.3
- Billing and payment module

### Version 1.0
Final integrated system including:
- Authentication
- Reservation management
- Billing system
- Dashboard statistics
- Staff help documentation

---

# Running the Project

### 1. Clone the Repository


git clone <repository-url>


### 2. Open in IntelliJ IDEA
Import the project as a **Maven project**.

### 3. Configure Apache Tomcat
Add **Tomcat 11** as the application server.

### 4. Setup Database

Create MySQL database:


ocean_view_resort


Import the required tables.

### 5. Deploy the Application
Build and deploy the **WAR artifact** to Tomcat.

### 6. Access the System


http://localhost:8080/ocean-view-resort/login


---

# Default Login Credentials

Example staff account:


Username: admin
Password: admin123


---


# Author

Manaw  
CIS6003 – Advanced Programming  
Ocean View Resort Reservation System

© 2026 Ocean View Resort
