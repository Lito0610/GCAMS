# Project Brief: ParSU - GCAMS: Guidance Counseling, Appointment, and Monitoring System

## 1. The problem

Who has the problem, and what is hard for them today? (2–3 sentences)
Guidance Office is currently no existing system. They still uses paper files to store students' data and sending physical letters when inviting students at the guidance office. This traditional way of storing data can cause duplication, and sending physical letters can't be gurranteed that the student will receive it.

## 2. Users and what they need to do

| User role | What they need to do in the app                                                           |
| --------- | ----------------------------------------------------------------------------------------- |
| Student   | Request appointment, send anonymous report                                                |
| Counselor | Review appointment and referral request, set appointment, manage and monitor student data |

## 3. The database behind it

schema.sql, 10 tables.

1. users - Stores every account (counselor, faculty, or student) with its email, bcrypt password hash, role, and status, and allows only one counselor account.
2. students - Holds the student profile (student number, course, year level, section, contact number) linked to one student user.
3. appointments - Records each counseling appointment from request to completion, including concern type, status, date, start time, and follow-up date.
4. session_notes - Stores the counselor’s private note and concern level for one appointment.
5. referrals - Stores faculty referrals of students, with reasons, urgency, status, and school year.
6. concern_reports - Stores anonymous concern reports, linked to a student only after the counselor confirms them, with no reporter identity.
7. risk_rules - Holds the editable points for each risk indicator used by the risk engine.
8. risk_scores - Stores each student’s computed risk score, level, and reasons.
9. notifications - Keeps in-system messages for users and whether the matching email was sent.
10. audit_log - Records which user performed which action on which record and when.

## 4. Must-have features (for the final project)

1. Protect sensitive records with bcrypt-hashed passwords, role-based access, CSRF checks, and rate limits.
2. Calculate each student's risk level from faculty referrals, no-shows, confirmed reports, and counselor concern levels, with a “why flagged” explanation.
3. Collect anonymous concern reports that store no reporter identity.
4. Notify users through in-system notification and emails.

## 5. Nice-to-have features (only if there's time)

1. Add mood check-ins where students log how they feel.
2. Import grades and attendance from the registrar so the risk engine can flag students using academic data too.

## 6. Similar apps I looked at
N/A
