# Ocean View Resort – Online Room Reservation System

## Project Overview

This project is developed as part of the CIS6003 Advanced Programming module.

Ocean View Resort is a web-based Online Room Reservation System designed using Java EE (Jakarta Servlets and JSP). The system follows structured software engineering principles including MVC architecture, layered design, and disciplined version control workflow.

Version 0.1 establishes the core system foundation including authentication, session security, and a modular dashboard framework.

---

## Current System Features (Version 0.1)

### Authentication Module
- Secure login functionality
- PRG (Post-Redirect-Get) pattern implementation
- Session-based authentication
- Access restriction using Servlet Filter
- Logout with session invalidation and confirmation

### Staff Dashboard Module
- Premium sidebar-based dashboard layout
- Dynamic navigation using request parameters (`?page=`)
- Active navigation highlighting
- Home overview section with operational placeholders
- Modular structure prepared for Reservations, Billing, and Reports

---

## Technology Stack

- Java (Jakarta Servlet & JSP)
- Apache Tomcat 11
- Maven (WAR packaging)
- MySQL (XAMPP)
- IntelliJ IDEA 2025
- GitHub (Version Control)

---

## Architecture and Design Principles

The system follows:

### 1. MVC Pattern
- Model: Java POJO classes
- View: JSP pages
- Controller: Servlet classes

### 2. Layered (3-Tier) Architecture
- Presentation Layer (JSP)
- Controller Layer (Servlets)
- Service Layer (Business logic)
- DAO Layer (Database access)
- Database Layer (MySQL)

### 3. Design Patterns Used
- Singleton Pattern (Database connection management)
- PRG Pattern (Prevention of duplicate form submission)
- Filter Pattern (Session-based access control)

This structure ensures maintainability, scalability, and adherence to SOLID principles.

---

## Branching Strategy

The repository follows a structured staged deployment model:

development → qa → uat → master

- Development: Active feature implementation
- QA: Functional verification
- UAT: Acceptance validation
- Master: Production-ready stable version

---

## Release Information

### Version 0.1
First stable production-ready release including:

- Authentication module
- Secure session management
- Professional dashboard framework
- Structured Git workflow implementation

---

## Upcoming Modules

The following modules will be implemented in future releases:

- Reservation Management
- Billing System
- Reporting and Analytics
- Database enhancements (foreign keys, structured relationships)

---

## How to Run the Project

1. Clone the repository
2. Import into IntelliJ IDEA
3. Configure Apache Tomcat 11
4. Ensure MySQL is running with database:
    - `ocean_view_resort`
5. Deploy WAR artifact
6. Access via:
   `http://localhost:8080/<context-path>/login`

---

© 2026 Ocean View Resort – Staff Reservation Management System