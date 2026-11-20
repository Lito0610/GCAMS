    # GCAMS CRUD Map

| Table           | C   | R   | U   | D   | Pages                                                                                                                                                            | Who                                                                                                                                                          |
| --------------- | --- | --- | --- | --- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| users           | ✓   | ✓   | ✓   | –   | login, counselor-dashboard (User management); accounts are created by the guidance office outside the browser                                                    | Guidance office: C · Self: R (login) · Counselor: R, U status (activate/deactivate non-counselor accounts). Deactivated, not deleted.                        |
| students        | ✓   | ✓   | –   | –   | counselor-dashboard (At-risk student list, Student profile), faculty-dashboard (Refer a student lookup)                                                          | Guidance office: C with the account · Counselor: R all · Faculty: R by student number only · Student: R own. No edit page yet. Kept as history, not deleted. |
| appointments    | ✓   | ✓   | ✓   | –   | student-dashboard (Request appointment, My appointments, Upcoming appointment), counselor-dashboard (New requests, Today's and upcoming, Appointments to update) | Student: C request, R own · Counselor: C direct schedule, R all, U date, status, follow-up date. Cancelled by status, not deleted.                           |
| session_notes   | ✓   | ✓   | –   | –   | counselor-dashboard (Student profile, appointment update)                                                                                                        | Counselor only: C one note per appointment, R. Private to the counselor. No edit page, and kept as a record.                                                 |
| referrals       | ✓   | ✓   | ✓   | –   | faculty-dashboard (Refer a student, My referrals), counselor-dashboard (Referral inbox)                                                                          | Faculty: C, R own only · Counselor: R all, U acknowledge or close. Closed by status, not deleted.                                                            |
| concern_reports | ✓   | ✓   | ✓   | –   | anonymous-report form (opened from student-dashboard), counselor-dashboard (Concern report inbox)                                                                | Student (anonymous): C, no reporter stored · Counselor: R, U review, confirm and link, unlink, resolve. Resolved by status, not deleted.                     |
| risk_rules      | –   | ✓   | ✓   | –   | counselor-dashboard (Risk rule settings)                                                                                                                         | Counselor: R, U points. Rows are seeded by `schema.sql` and never created or deleted in the app.                                                             |
| risk_scores     | ✓   | ✓   | ✓   | –   | counselor-dashboard (Risk overview, At-risk list, Student profile)                                                                                               | Risk engine: C, U (recalculated, one row per student per school year) · Counselor: R. Students and faculty never see it. Old years kept as history.          |
| notifications   | ✓   | ✓   | ✓   | –   | student-dashboard, faculty-dashboard, counselor-dashboard (Notifications)                                                                                        | System: C, U email status · Each user: R own, mark as read. Kept as a record.                                                                                |
| audit_logs      | ✓   | –   | –   | –   | none (written by the server on sensitive views and changes)                                                                                                      | System: C only. Append-only, never edited or deleted, and no page reads it yet.                                                                              |

## Form fields for the two most important tables

### appointments

**Student request form** (student-dashboard, Request appointment)

| Column          | Form control                                                          | Required? |
| --------------- | --------------------------------------------------------------------- | --------- |
| concern_type    | Dropdown: academic, personal, career, financial, mental health, other | Yes       |
| student_message | Textarea, max 500 characters                                          | No        |

**Counselor scheduling form** (counselor-dashboard, New requests or Schedule appointment)

| Column           | Form control                                                       | Required?                                                          |
| ---------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------ |
| student_id       | Text input for an existing student number, looked up by the server | Yes when scheduling directly, not needed when fulfilling a request |
| concern_type     | Dropdown (same list as above)                                      | Yes when scheduling directly                                       |
| appointment_date | Date picker                                                        | Yes                                                                |
| follow_up_date   | Date picker                                                        | No                                                                 |
| status           | Buttons: mark completed, mark no-show, cancel                      | Yes when updating                                                  |

Set by the system, not typed: `student_id` (from the session on the request form), `counselor_id`, `date_requested`, and the default status `requested`. `start_time` is in the schema, but the current screen schedules a date only.

### referrals

**Faculty referral form** (faculty-dashboard, Refer a student)

| Column     | Form control                                                       | Required? |
| ---------- | ------------------------------------------------------------------ | --------- |
| student_id | Text input for an existing student number, looked up by the server | Yes       |
| reasons    | Checkboxes, one or more reasons                                    | Yes       |
| urgency    | Radio buttons: routine (default), urgent                           | Yes       |
| comment    | Textarea                                                           | No        |
 
## Schema changes

None.
