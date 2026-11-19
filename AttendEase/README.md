# AttendEase — Attendance Management System

A purple-and-white Java Servlet + JDBC + MySQL attendance web application for Apache Tomcat 10.1.

## Features
- Admin login and session-based route protection
- Responsive dashboard with live database counts
- Student directory: search, add, delete
- Date-based attendance: Present, Absent, Late; bulk marking; duplicate-safe updates
- Student-wise attendance percentage report; highlights below 75%
- Prepared statements and HTML escaping for user-entered values

## Requirements
- JDK 17 or later (JDK 26 can compile Java 17-targeted bytecode)
- IntelliJ IDEA
- MySQL Server 8.x
- Apache Tomcat 10.1.x
- Maven support enabled in IntelliJ

## Setup
1. Start MySQL.
2. Open `database/attendease.sql` in MySQL Workbench or the MySQL command line and execute it.
3. Open `src/main/java/com/attendease/util/DBUtil.java` and replace `YOUR_MYSQL_PASSWORD` with your local MySQL root password.
4. In IntelliJ choose **File → Open** and select this project's `pom.xml` (or open the project root and load it as Maven).
5. Wait for Maven to download dependencies. Set Project SDK to your installed JDK (17 or newer).
6. Add a local Tomcat 10.1 server: **Run → Edit Configurations → + → Tomcat Server → Local**. Set the Tomcat installation directory.
7. In the Deployment tab, add **Artifact → AttendEase:war exploded**. Set application context to `/AttendEase`.
8. Run Tomcat and open `http://localhost:8080/AttendEase/login`.
9. Demo login: username `admin`, password `Admin@123`.

## MySQL connection note
The default JDBC URL is `localhost:3306/attendease_db`. If MySQL uses a different port, update `DBUtil.java`. Do not upload your real database password to GitHub.

## Important
This is an educational demo. The initial admin password is stored as plain text to keep the first setup easy. Before real use, replace this with a password-hashing solution (e.g. BCrypt), use a least-privilege database user, use HTTPS, add CSRF protection, and review authorization rules. Never use the demo credentials for a public deployment.

## Common fixes
- `jakarta.servlet` errors: use Tomcat 10.1, not Tomcat 9; reload Maven after opening `pom.xml`.
- `Access denied for user 'root'`: fix username/password in `DBUtil.java`.
- `Unknown database`: run `database/attendease.sql`.
- Port 8080 in use: change the Tomcat HTTP port in its server configuration.
- Maven command not recognized: use IntelliJ's Maven tool window; Maven does not need to be installed globally.
- If your JDK is 26, keep compiler release at 17; install JDK 17 if your IntelliJ/Maven setup cannot resolve a compiler toolchain.

## Project structure
```text
AttendEase/
├── pom.xml
├── database/attendease.sql
├── src/main/java/com/attendease/
│   ├── filter/AuthFilter.java
│   ├── servlet/
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── DashboardServlet.java
│   │   ├── StudentsServlet.java
│   │   ├── AttendanceServlet.java
│   │   └── ReportsServlet.java
│   └── util/DBUtil.java
│       util/HtmlUtil.java
└── src/main/webapp/
    ├── index.jsp
    ├── assets/css/style.css
    ├── assets/js/app.js
    └── WEB-INF/views/
        ├── login.jsp
        ├── dashboard.jsp
        ├── students.jsp
        ├── attendance.jsp
        ├── reports.jsp
        ├── _layout-top.jsp
        └── _layout-bottom.jsp
```
