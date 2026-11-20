-- ============================================================================
-- GCAMS: Guidance Counseling, Appointment, and Monitoring System
-- seed.sql: Comprehensive Seed Data for Testing & Prototype
-- ============================================================================

USE gcams;

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- 1. USERS
-- Password for all accounts is 'Password123!' (valid 60-char bcrypt hash)
-- ----------------------------------------------------------------------------
INSERT INTO users (user_id, email, password_hash, status, role, name, faculty_id) VALUES
  -- Guidance Counselor (Only 1 allowed by schema unique constraint)
  (1, 'counselor@parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'counselor', 'Maria Clara', NULL),

  -- Faculty Members
  (2, 'elena.santos@parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'faculty', 'Dr. Elena Santos', 'FAC-2020-001'),
  (3, 'aris.thorne@parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'faculty', 'Prof. Aris Thorne', 'FAC-2018-042'),

  -- Students (Matching prototype appointment list & dashboard rows)
  (4, 'maria.santos@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Maria Santos', NULL),
  (5, 'john.cruz@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'John Cruz', NULL),
  (6, 'ana.reyes@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Ana Reyes', NULL),
  (7, 'carlos.mendoza@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Carlos Mendoza', NULL),
  (8, 'sofia.garcia@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Sofia Garcia', NULL),
  (9, 'miguel.torres@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Miguel Torres', NULL),
  (10, 'angela.torres@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Angela Torres', NULL),
  (11, 'juan.delacruz@student.parsu.edu.ph', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4L5.b1iJ6e', 'active', 'student', 'Juan Dela Cruz', NULL)
ON DUPLICATE KEY UPDATE 
  email = VALUES(email),
  name = VALUES(name),
  status = VALUES(status);

-- ----------------------------------------------------------------------------
-- 2. STUDENTS PROFILE
-- ----------------------------------------------------------------------------
INSERT INTO students (student_id, user_id, student_number, course, year_level, section, contact_number) VALUES
  (1, 4, '2024-00142', 'BS Information Technology', 3, 'B', '0917-111-2233'),
  (2, 5, '2024-00215', 'BS Computer Science', 2, 'A', '0918-222-3344'),
  (3, 6, '2023-00089', 'BS Information Technology', 4, 'A', '0919-333-4455'),
  (4, 7, '2024-00331', 'BS Entertainment & Multimedia Computing', 2, 'B', '0920-444-5566'),
  (5, 8, '2025-00104', 'BS Information Technology', 1, 'A', '0921-555-6677'),
  (6, 9, '2023-00412', 'BS Computer Science', 3, 'A', '0922-666-7788'),
  (7, 10, '2024-00188', 'BS Entertainment & Multimedia Computing', 3, 'A', '0923-777-8899'),
  (8, 11, '2025-00055', 'BS Information Technology', 1, 'A', '0924-888-9900')
ON DUPLICATE KEY UPDATE
  course = VALUES(course),
  year_level = VALUES(year_level),
  section = VALUES(section),
  contact_number = VALUES(contact_number);

-- ----------------------------------------------------------------------------
-- 3. APPOINTMENTS
-- Matches rows in list.html and counselor dashboard upcoming appointments
-- ----------------------------------------------------------------------------
INSERT INTO appointments (appointment_id, student_id, counselor_id, concern_type, student_message, status, appointment_date, start_time, follow_up_date) VALUES
  -- 1. Maria Santos: Academic exam anxiety
  (1, 1, 1, 'academic', 'Struggling with upcoming midterms and major programming deliverables. Requesting coping advice.', 'scheduled', '2026-11-25', '09:00:00', NULL),

  -- 2. John Cruz: Mental health support
  (2, 2, NULL, 'mental health', 'Feeling overwhelmed with isolation and anxiety. Would appreciate speaking with a counselor.', 'requested', '2026-11-26', '14:00:00', NULL),

  -- 3. Ana Reyes: Career pathway
  (3, 3, 1, 'career', 'Inquiring regarding graduating career pathways and industry internship requirements.', 'scheduled', '2026-11-27', '10:30:00', NULL),

  -- 4. Carlos Mendoza: Personal & family (Completed session with follow-up)
  (4, 4, 1, 'personal', 'Family personal hardship affecting class focus and continuous attendance.', 'completed', '2026-11-24', '15:00:00', '2026-12-08'),

  -- 5. Sofia Garcia: Financial assistance
  (5, 5, NULL, 'financial', 'Requesting guidance regarding scholarship continuation and tuition installment options.', 'requested', '2026-11-28', '11:00:00', NULL),

  -- 6. Miguel Torres: Academic attendance
  (6, 6, 1, 'academic', 'Catching up on missed laboratory assignments following consecutive sickness absences.', 'scheduled', '2026-11-29', '13:30:00', NULL),

  -- 7. Angela Torres: Urgent retention check
  (7, 7, 1, 'personal', 'Counselor-initiated counseling session due to multiple missed classes.', 'scheduled', '2026-11-20', '16:00:00', '2026-12-04')
ON DUPLICATE KEY UPDATE
  concern_type = VALUES(concern_type),
  student_message = VALUES(student_message),
  status = VALUES(status),
  appointment_date = VALUES(appointment_date),
  start_time = VALUES(start_time),
  follow_up_date = VALUES(follow_up_date);

-- ----------------------------------------------------------------------------
-- 4. SESSION NOTES (Confidential Counselor Notes)
-- ----------------------------------------------------------------------------
INSERT INTO session_notes (note_id, appointment_id, notes, concern_level) VALUES
  (1, 4, 'Student shared details regarding family financial challenges and distress. Coping mechanisms discussed and time-management sheet provided. Recommended follow-up check-in in two weeks.', 'monitoring')
ON DUPLICATE KEY UPDATE
  notes = VALUES(notes),
  concern_level = VALUES(concern_level);

-- ----------------------------------------------------------------------------
-- 5. REFERRALS (Faculty Referrals)
-- Matches counselor dashboard "Needs your review" items
-- ----------------------------------------------------------------------------
INSERT INTO referrals (referral_id, student_id, faculty_id, reasons, urgency, comment, status, school_year) VALUES
  (1, 4, 3, 'Consecutive unexcused absences, noticeable drop in quiz submissions', 'routine', 'Student appeared withdrawn during lectures. Recommending guidance session.', 'pending', '2026-2027'),
  (2, 7, 2, 'Multiple missed assessments and non-responsiveness to group work', 'urgent', 'Student has not attended last 4 laboratory sessions. Immediate outreach needed.', 'pending', '2026-2027'),
  (3, 5, 2, 'Financial constraints hindering required course software access', 'routine', 'Referred to guidance office for possible scholarship and institutional aid assistance.', 'acknowledged', '2026-2027')
ON DUPLICATE KEY UPDATE
  reasons = VALUES(reasons),
  urgency = VALUES(urgency),
  comment = VALUES(comment),
  status = VALUES(status);

-- ----------------------------------------------------------------------------
-- 6. CONCERN REPORTS (Anonymous Student Reports)
-- Matches counselor dashboard review item
-- ----------------------------------------------------------------------------
INSERT INTO concern_reports (report_id, concern_type, description, subject_student_id, is_confirmed, status) VALUES
  (1, 'academic pressure', 'Peer displaying signs of severe anxiety, panic, and prolonged fatigue before laboratory exams.', NULL, FALSE, 'new'),
  (2, 'bullying', 'Observed verbal bullying and exclusion targeting a 1st year student during class break.', NULL, FALSE, 'reviewed')
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  status = VALUES(status);

-- ----------------------------------------------------------------------------
-- 7. RISK SCORES
-- Matches counselor dashboard retention risk tiers (Green, Yellow, Red)
-- ----------------------------------------------------------------------------
INSERT INTO risk_scores (score_id, student_id, school_year, total_score, risk_level, risk_indicators) VALUES
  -- Red Tier (Score >= 60)
  (1, 7, '2026-2027', 85, 'red', 'Multiple Referrals, Missed Sessions'),
  (2, 4, '2026-2027', 78, 'red', 'Faculty Referral, Urgent Concern'),

  -- Yellow Tier (30 <= Score < 60)
  (3, 8, '2026-2027', 45, 'yellow', 'Frequent Absences, Grade Drop'),
  (4, 2, '2026-2027', 35, 'yellow', 'Academic Warning'),

  -- Green Tier (Score < 30)
  (5, 1, '2026-2027', 10, 'green', 'Routine check-in, Stable'),
  (6, 3, '2026-2027', 5, 'green', 'No risk indicators, Good standing'),
  (7, 5, '2026-2027', 15, 'green', 'Financial inquiry, Good attendance'),
  (8, 6, '2026-2027', 20, 'green', 'Excused medical absences')
ON DUPLICATE KEY UPDATE
  total_score = VALUES(total_score),
  risk_level = VALUES(risk_level),
  risk_indicators = VALUES(risk_indicators);

-- ----------------------------------------------------------------------------
-- 8. NOTIFICATIONS
-- ----------------------------------------------------------------------------
INSERT INTO notifications (notification_id, user_id, message, is_read, email_sent) VALUES
  (1, 1, 'New appointment request received from Maria Santos.', FALSE, TRUE),
  (2, 1, 'Faculty referral submitted by Prof. Aris Thorne for Carlos Mendoza.', FALSE, TRUE),
  (3, 1, 'Anonymous concern report submitted regarding academic pressure.', FALSE, FALSE),
  (4, 4, 'Your counseling appointment with Counselor Maria Clara has been scheduled for Nov 25, 2026 at 09:00 AM.', TRUE, TRUE),
  (5, 7, 'Your counseling session has been recorded. Follow-up is set for Dec 08, 2026.', FALSE, TRUE)
ON DUPLICATE KEY UPDATE
  message = VALUES(message),
  is_read = VALUES(is_read);

SET FOREIGN_KEY_CHECKS = 1;
