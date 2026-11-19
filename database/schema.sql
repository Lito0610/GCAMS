CREATE DATABASE IF NOT EXISTS gcams CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gcams;

CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  status ENUM('active','pending','deactivated') NOT NULL DEFAULT 'pending',
  role ENUM('counselor','faculty','student') NOT NULL,
  name VARCHAR(150) NOT NULL,
  faculty_id VARCHAR(50) UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  counselor_guard TINYINT GENERATED ALWAYS AS (IF(role = 'counselor', 1, NULL)) STORED,
  CONSTRAINT ck_users_bcrypt CHECK (password_hash REGEXP '^\\$2[aby]\\$[0-9]{2}\\$[./A-Za-z0-9]{53}$'),
  UNIQUE KEY uq_one_counselor (counselor_guard)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  student_number VARCHAR(50) NOT NULL UNIQUE,
  course VARCHAR(120) NOT NULL,
  year_level TINYINT UNSIGNED NOT NULL,
  section VARCHAR(30) NOT NULL,
  contact_number VARCHAR(30),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  counselor_id INT NULL,
  concern_type ENUM('academic','personal','career','financial','mental health','other') NOT NULL,
  student_message VARCHAR(500),
  status ENUM('requested','scheduled','completed','cancelled','no-show') NOT NULL DEFAULT 'requested',
  appointment_date DATE,
  start_time TIME,
  follow_up_date DATE,
  date_requested TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_appt_status_date (status, appointment_date),
  INDEX idx_appt_student_status (student_id, status),
  FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (counselor_id) REFERENCES users(user_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS session_notes (
  note_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NOT NULL UNIQUE,
  notes TEXT NOT NULL,
  concern_level ENUM('stable','monitoring','serious') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS referrals (
  referral_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  faculty_id INT NOT NULL,
  reasons TEXT NOT NULL,
  urgency ENUM('routine','urgent') NOT NULL DEFAULT 'routine',
  comment TEXT,
  status ENUM('pending','acknowledged','closed') NOT NULL DEFAULT 'pending',
  school_year CHAR(9) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_ref_student_sy_status (student_id, school_year, status),
  INDEX idx_ref_faculty (faculty_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (faculty_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS concern_reports (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  concern_type ENUM('bullying','harassment','mental health','academic pressure','safety','other') NOT NULL,
  description TEXT NOT NULL,
  subject_student_id INT NULL,
  is_confirmed BOOLEAN NOT NULL DEFAULT FALSE,
  status ENUM('new','reviewed','resolved') NOT NULL DEFAULT 'new',
  date_submitted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_report_student_confirmed (subject_student_id, is_confirmed),
  INDEX idx_report_status (status),
  FOREIGN KEY (subject_student_id) REFERENCES students(student_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS risk_rules (
  rule_id INT AUTO_INCREMENT PRIMARY KEY,
  indicator_name VARCHAR(50) NOT NULL UNIQUE,
  points TINYINT UNSIGNED NOT NULL
) ENGINE=InnoDB;

INSERT INTO risk_rules (indicator_name, points) VALUES
  ('referral', 5), ('multipleReferral', 15), ('urgent', 5), ('missed', 15),
  ('concern', 10), ('monitoring', 5), ('serious', 15)
ON DUPLICATE KEY UPDATE points = VALUES(points);

CREATE TABLE IF NOT EXISTS risk_scores (
  score_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  school_year CHAR(9) NOT NULL,
  total_score TINYINT UNSIGNED NOT NULL,
  risk_level ENUM('green','yellow','red') NOT NULL,
  risk_indicators TEXT NOT NULL,
  date_computed TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY student_school_year (student_id, school_year),
  FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  CONSTRAINT ck_risk_level_matches_score CHECK (
    (risk_level = 'green' AND total_score < 30)
    OR (risk_level = 'yellow' AND total_score >= 30 AND total_score < 60)
    OR (risk_level = 'red' AND total_score >= 60)
  )
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notifications (
  notification_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  message VARCHAR(500) NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  email_sent BOOLEAN NOT NULL DEFAULT FALSE,
  email_sent_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_notif_user_read (user_id, is_read),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS audit_logs (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  action VARCHAR(150) NOT NULL,
  record_id VARCHAR(50),
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
) ENGINE=InnoDB;
