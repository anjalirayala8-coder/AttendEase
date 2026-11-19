CREATE DATABASE IF NOT EXISTS attendease_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE attendease_db;

CREATE TABLE IF NOT EXISTS admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(120),
    department VARCHAR(80) NOT NULL DEFAULT 'CSE',
    year_level TINYINT NOT NULL DEFAULT 3,
    section_name VARCHAR(10) NOT NULL DEFAULT 'A',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS attendance (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('PRESENT','ABSENT','LATE') NOT NULL DEFAULT 'PRESENT',
    marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id)
      REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT uq_student_day UNIQUE (student_id, attendance_date)
);

-- Demo login only. Change this password after your first successful login.
INSERT INTO admins(username, password)
VALUES ('admin', 'Admin@123')
ON DUPLICATE KEY UPDATE username = VALUES(username);

INSERT IGNORE INTO students(roll_no, full_name, email, department, year_level, section_name) VALUES
('23CS001', 'Aarav Kumar', 'aarav@example.com', 'CSE', 3, 'A'),
('23CS002', 'Ananya Reddy', 'ananya@example.com', 'CSE', 3, 'A'),
('23CS003', 'Sai Teja', 'saiteja@example.com', 'CSE', 3, 'A'),
('23CS004', 'Keerthana Rao', 'keerthana@example.com', 'CSE', 3, 'A'),
('23CS005', 'Rahul Varma', 'rahul@example.com', 'CSE', 3, 'A');
