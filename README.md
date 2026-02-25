# 🏠 Student Housing Platform

> A full-stack Java EE web application for student accommodation rental management

## 📋 Overview

This project is a comprehensive web platform that connects students looking for housing with property owners. It provides features for listing properties, searching accommodations, managing favorites, and communication between users.

**Status:** Academic project | Actively seeking internship opportunities

## 🎯 Key Features

- **User Management**: Registration, authentication, and profile management with email verification
- **Property Listings**: Create, view, edit, and delete housing announcements
- **Search & Filter**: Advanced search functionality for finding accommodations by location, price, and specifications
- **Messaging System**: Built-in messaging between students and property owners
- **Favorites**: Save and manage favorite listings
- **Dashboard**: Statistics and management interface for property owners

## 🛠️ Technologies Used

### Backend

- **Java EE** - Core application framework
- **Hibernate 7.1** - ORM for database management
- **Jakarta Servlet API 6.0** - Web servlets
- **MySQL** - Database
- **Maven** - Dependency management

### Frontend

- **JSP** - Dynamic web pages
- **HTML/CSS** - User interface
- **JavaScript** - Client-side interactivity

### Additional

- **Jakarta Mail API** - Email notifications
- **CORS Filter** - Cross-origin resource handling

## 📁 Project Architecture

```
src/main/java/
├── controller/     # Servlets handling HTTP requests
├── dao/           # Data Access Objects
├── model/         # Entity classes (JPA)
├── service/       # Business logic layer
└── util/          # Utility classes (Hibernate, Email)
```

**Architecture Pattern:** MVC (Model-View-Controller) with layered architecture

## 🚀 Setup & Installation

### Prerequisites

- Java 17 or higher
- MySQL 8.0+
- Apache Tomcat 10+
- Maven 3.6+

### Steps

1. Clone the repository
2. Configure database connection in `src/main/resources/hibernate.cfg.xml`
3. Build the project:
   ```bash
   mvn clean install
   ```
4. Deploy the generated WAR file to Tomcat
5. Access the application at `http://localhost:8080/locationEtudiant`

## 💡 Skills Demonstrated

- **Backend Development**: RESTful servlets, business logic implementation
- **Database Design**: Entity modeling, relationships, and ORM configuration
- **Software Architecture**: MVC pattern, separation of concerns, layered architecture
- **Email Integration**: Automated notifications and verification system
- **Full-Stack Development**: End-to-end feature implementation
- **Version Control**: Git & GitHub

## 📊 Database Schema

Key entities:

- **Utilisateur** (User): Students and property owners
- **Annonce** (Listing): Housing properties
- **Message**: Communication system
- **Favori** (Favorite): Saved listings

## 📫 Contact

Currently seeking **Software Engineering Internship** opportunities.

---

_This project was developed as part of Java EE architecture coursework_
