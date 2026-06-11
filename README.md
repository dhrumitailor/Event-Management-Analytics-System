# 🎯 Smart Event Management & Analytics System

## 📌 Overview

The Smart Event Management & Analytics System is a MySQL-based Database Management System (DBMS) project designed to streamline and automate event-related operations within educational institutions and organizations.

The system provides a centralized platform for managing events, attendees, registrations, payments, attendance, certificates, sponsors, volunteers, and analytics. It leverages relational database concepts such as normalization, primary keys, foreign keys, triggers, stored procedures, views, and advanced SQL queries to ensure data integrity and efficient reporting.

---

## 🚀 Features

### Event Management

* Create and manage events
* Categorize events by type
* Assign organizers and faculty coordinators
* Manage venues and event schedules

### Attendee Management

* Store participant information
* Track registration history
* Maintain academic details

### Registration System

* Event registration and confirmation
* Duplicate registration prevention
* Capacity management

### Payment Management

* Record event fees
* Track payment methods and statuses
* Generate revenue reports

### Attendance Tracking

* Monitor participant attendance
* Maintain attendance records
* Generate attendance reports

### Certificate Management

* Automatic certificate generation
* Certificate issuance tracking

### Feedback System

* Collect participant feedback
* Event rating analysis
* Performance evaluation

### Sponsor & Volunteer Management

* Manage sponsorship information
* Assign volunteers to events
* Track volunteer responsibilities

### Analytics & Reporting

* Event participation statistics
* Revenue analysis
* Attendance analytics
* Feedback analytics
* Branch-wise participation reports

---

## 🛠 Technologies Used

| Technology        | Purpose                    |
| ----------------- | -------------------------- |
| MySQL 8.0         | Database Management System |
| SQL               | Database Queries           |
| Stored Procedures | Business Logic Automation  |
| Triggers          | Event-Based Automation     |
| Views             | Reporting & Analytics      |
| Indexes           | Query Optimization         |

---

## 🗄 Database Architecture

### Core Entities

* Organizer
* FacultyCoordinator
* EventCategory
* Venue
* Event
* Attendee
* Registration
* Payment
* Attendance
* Certificate
* Feedback
* Sponsor
* EventSponsor
* Volunteer
* VolunteerAssignment
* Notification
* EventAnalytics
* AuditLog

### Database Statistics

| Component         | Count |
| ----------------- | ----- |
| Tables            | 18    |
| Stored Procedures | 10    |
| Triggers          | 10    |
| Views             | 10    |
| Advanced Queries  | 25+   |

---

## 📂 Project Structure

```text
Smart_Event_Management_System
│
├── database
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── procedures.sql
│   ├── triggers.sql
│   ├── views.sql
│   └── advanced_queries.sql
│
├── documentation
│   ├── Smart_Event_ER_Diagram.png
│   ├── Objectives.pdf
│   ├── System Modules Overview.pdf
│   └── Abstract.pdf
│
└── README.md
```

---

## ⚙️ Installation & Execution

### 1. Clone Repository

```bash
git clone https://github.com/your-username/Smart_Event_Management_System.git
cd Smart_Event_Management_System
```

### 2. Open MySQL

```bash
mysql -u root -p
```

### 3. Execute Files

```sql
SOURCE database/schema.sql;
SOURCE database/sample_data.sql;
SOURCE database/procedures.sql;
SOURCE database/triggers.sql;
SOURCE database/views.sql;
```

---

## 📊 Sample Reports

### Event Summary

```sql
SELECT * FROM vw_EventSummary;
```

### Revenue Report

```sql
SELECT * FROM vw_RevenueReport;
```

### Top Events

```sql
CALL TopEvents();
```

### Feedback Analytics

```sql
CALL FeedbackAnalytics();
```

---

## 🔑 Key DBMS Concepts Implemented

* Relational Database Design
* Entity Relationship Modeling
* Primary & Foreign Keys
* Data Normalization
* Constraints
* Stored Procedures
* Triggers
* Views
* Aggregate Functions
* Subqueries
* Window Functions
* Indexing
* Analytics Reporting

---

## 🎓 Academic Relevance

This project was developed as a Database Management System (DBMS) Major Project for Computer Science / Information Technology studies and demonstrates practical implementation of advanced database concepts using MySQL.

---

## 🔮 Future Enhancements

* Web-based frontend integration
* Authentication and authorization
* Real-time notifications
* QR-based attendance system
* Online payment gateway integration
* Dashboard visualization using Power BI or Tableau
* Mobile application support

---

## 👨‍💻 Author

Dhrumi

Database Management System Project
Information Technology

---

## 📜 License

This project is intended for educational and learning purposes.
