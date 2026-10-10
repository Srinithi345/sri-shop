cd "C:\Users\acer\Desktop\sri shop\sri-shop"

@'
# SRI SHOP – Online Dress Shopping System

## Project Overview

SRI SHOP is a full-stack e-commerce web application developed as a capstone project. It provides an online shopping platform where customers can browse dresses, manage their shopping cart, and access order-related information through a buyer dashboard.

The application follows a Java Servlet and JSP-based MVC-style layered architecture, with PostgreSQL for data storage.

## Objectives

- Provide a convenient online dress-shopping experience.
- Organize product, user, cart, and order information.
- Implement server-side request handling using Java Servlets.
- Store application data in a PostgreSQL database.
- Provide a responsive and user-friendly web interface.

## Technology Stack

| Component | Technology |
|---|---|
| Backend | Java |
| Frontend | JSP, HTML, CSS, JavaScript |
| Architecture | MVC-style layered architecture |
| Build Tool | Apache Maven |
| Web Server | Apache Tomcat 11 |
| Database | PostgreSQL |
| Database Connectivity | JDBC |
| Project Packaging | WAR |
| Development Environment | Visual Studio Code |

## Main Features

### User Management
- User registration
- User login and session management
- Role-based navigation for buyers and sellers, where configured

### Product Management
- Browse available dresses
- View product information
- Select product options such as size and color, where available

### Shopping Cart
- Add products to the cart
- Update product quantities
- Remove products from the cart
- View cart totals
- Preview cart items from the buyer dashboard

### Buyer Dashboard
- View order summaries
- View total items and product varieties from order information
- View total spending
- Preview cart items and cart total
- Access shopping and order-related pages

### Order Management
- Access order-related information
- View recent orders on the buyer dashboard, where available

## Application Architecture

The application uses a layered Java web architecture:

- **Controller Layer:** Java Servlets handle incoming HTTP requests.
- **Service Layer:** Business logic is organized into service classes where implemented.
- **DAO Layer:** Data Access Objects interact with PostgreSQL using JDBC.
- **Model Layer:** Java model classes represent application entities.
- **View Layer:** JSP pages render application screens.
- **Database Layer:** PostgreSQL stores application data.

## Project Structure

```text
sri-shop/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── srimart/
        │           ├── controller/
        │           ├── dao/
        │           ├── dto/
        │           ├── exception/
        │           ├── filter/
        │           ├── listener/
        │           ├── model/
        │           ├── service/
        │           └── util/
        └── webapp/
            ├── WEB-INF/
            └── JSP and static web resources