-- SQL Project - Working on Hospital Database
-- Medium post: https://medium.com/@aadata/sql-project-working-on-hospital-database-8d1f0929c6f9

-- Hospital Database
-- https://miro.medium.com/max/1400/1*jfNZPVJvlBithdnVCzjvBw.png

-- Queries
-- 1. From the nurse table, find those nurses who are yet to be registered. Return all the fields of nurse table.
SELECT * FROM nurse
WHERE registered = ‘f’

-- 2. From the nurse table, find the nurse who is the head of their department. Return Nurse Name as “name”, Position as “Position”.
SELECT name AS “Name”, position AS “Position”
FROM nurse
WHERE position = ‘Head Nurse’

-- 3. From the department and physician tables, find those physicians who are the head of the department. Return Department name as “Department” and Physician name as “Physician”.
SELECT d.name AS “Department”, phy.name AS “Physician”
FROM department AS d
JOIN physician AS phy
ON d.head = phy.employeeid

-- 4. From the appointment table, count the number of patients who booked an appointment with at least one Physician. Return count as “Number of patients taken at least one appointment”.
SELECT COUNT(DISTINCT(patient)) AS “Number of patients taken at least one appointment”
FROM appointment

-- 5. From the room table, find the floor and block where the room number 212 belongs. Return block floor as “Floor” and block code as “Block”.
SELECT blockfloor AS “Floor”, blockcode AS “Block”
FROM room
WHERE roomnumber = 212

-- 6. From the room table, count the number available rooms. Return count as “Number of available rooms”.
SELECT COUNT(roomnumber) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’

-- 7. From the room table, count the number of unavailable rooms. Return count as “Number of unavailable rooms”.
SELECT COUNT(roomnumber) AS “Number of unavailable rooms”
FROM room
WHERE unavailable = ‘t’

-- 8. From the physician, affiliated_with, and department tables, find the physician and the departments they are affiliated with. Return Physician name as “Physician”, and department name as “Department”.
SELECT phy.name AS “Physician”, d.name AS “Department”
FROM physician AS phy
JOIN affiliated_with AS aw
ON phy.employeeid = aw.physician
JOIN department AS d
ON aw.department = d.departmentid

-- 9. From the physician, trained_in, and procedure tables, find those physicians who have trained for special treatment. Return Physician name as “Physician”, treatment procedure name as “Treatment”.
SELECT phy.name AS “Physician”, proc.name AS “Treatment”
FROM physician AS phy
JOIN trained_in AS ti
ON phy.employeeid = ti.physician
JOIN procedure AS proc
ON ti.treatment = proc.code

-- 10. From the physician, affiliated_with, and department tables, find those physicians who are yet to be affiliated. Return Physician name as “Physician”, Position, and department as “Department”.
SELECT phy.name AS “Physician”, phy.position AS “Position”, d.name AS “Department”
FROM physician AS phy
JOIN affiliated_with AS aw
ON phy.employeeid = aw.physician
JOIN department AS d
ON aw.department = d.departmentid
WHERE aw.primaryaffiliation = ‘f’

-- 11. From the physician and trained_in tables, find those physicians who are not a specialized physician. Return Physician name as “Physician”, position as “Designation”.
SELECT name AS “Physician”, position AS “Designation”
FROM physician
WHERE employeeid NOT IN
(
SELECT physician FROM trained_in
)

-- 12. From the patient and physician tables, find the patients with their physicians by whom they got their preliminary treatment. Return Patient name as “Patient”, address as “Address” and Physician name as “Physician”.
SELECT ptn.name AS “Patient”, ptn.address AS “Address”, phy.name AS “Physician”
FROM patient AS ptn
JOIN physician AS phy
ON ptn.pcp = phy.employeeid

-- 13. From the patient and appointment tables, find the patients and the number of physicians they have taken appointment. Return Patient name as “Patient”, number of Physicians as “Appointment for No. of Physicians”.
SELECT ptn.name AS “Patient”, COUNT(app.physician) AS “Appointment for No. of Physicians”
FROM patient AS ptn
JOIN appointment AS app
ON ptn.ssn = app.patient
GROUP BY ptn.ssn

-- 14. From the appointment table, count number of unique patients who got an appointment for examination room ‘C’. Return unique patients as “No. of patients got appointment for room C”.
SELECT COUNT(DISTINCT(patient)) AS “No. of patients got appointment for room C”
FROM appointment
WHERE examinationroom = ‘C’

-- 15. From the patient and appointment tables, find the name of the patients and the number of the room where they have to go for their treatment. Return patient name as “Patient”, examination room as “Room No.”, and starting date time as Date “Date and Time of appointment”.
SELECT ptn.name AS “Patient”, app.examinationroom AS “Room No.”, app.start_dt_time AS “Date and Time of appointment”
FROM patient AS ptn
JOIN appointment AS app
ON ptn.ssn = app.patient

-- 16. From the nurse and appointment tables, find the name of the nurses and the room scheduled, where they will assist the physicians. Return Nurse Name as “Name of the Nurse” and examination room as “Room No.”.
SELECT n.name AS “Name of the Nurse”, app.examinationroom AS “Room No.”
FROM nurse AS n
JOIN appointment AS app
ON n.employeeid = app.prepnurse

-- 17. From the patient, appointment, nurse, and physician tables, find those patients who taken the appointment on the 25th of April at 10 am. Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as “Name of the physician”, examination room as “Room No.”, schedule date and approximate time to meet the physician.
SELECT ptn.name AS “Patient”, n.name AS “Nurse”, phy.name AS “Physician”, app.examinationroom AS “Room No.”, app.start_dt_time AS “Schedule”
FROM patient AS ptn
JOIN appointment AS app
ON ptn.ssn = app.patient
JOIN nurse AS n
ON app.prepnurse = n.employeeid
JOIN physician AS phy
ON app.physician = phy.employeeid
WHERE app.start_dt_time = ‘2008–04–25 10:00:00’

-- 18. From the patient, appointment, and physician tables, find those patients and their physicians who do not require any assistance of a nurse. Return Name of the patient as “Name of the patient”, Name of the Physician as “Name of the physician” and examination room as “Room No.”.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”, app.examinationroom AS “Room No.”
FROM patient AS ptn
JOIN appointment AS app
ON ptn.ssn = app.patient
JOIN physician AS phy
ON app.physician = phy.employeeid
WHERE app.prepnurse IS NULL

-- 19. From the patient, prescribes, physician, and medication tables, find the patients and their treating physicians and medication. Return Patient name as “Patient”, Physician name as “Physician”, Medication name as “Medication”.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”, med.name AS “Medication”
FROM patient AS ptn
JOIN prescribes AS pre
ON ptn.ssn = pre.patient
JOIN physician AS phy
ON pre.physician = phy.employeeid
JOIN medication AS med
ON pre.medication = med.code

-- 20. From the patient, presrcribes, physician, and medication tables, find those patients who have taken an advanced appointment. Return Patient name as “Patient”, Physician name as “Physician” and Medication name as “Medication”.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”, med.name AS “Medication”
FROM patient AS ptn
JOIN prescribes AS pre
ON ptn.ssn = pre.patient
JOIN physician AS phy
ON pre.physician = phy.employeeid
JOIN medication AS med
ON pre.medication = med.code
WHERE pre.appointment IS NOT NULL

-- 21. From the patient, presrcribes, physician, and medication tables, find those patients who did not take any appointment. Return Patient name as “Patient”, Physician name as “Physician” and Medication name as “Medication”.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”, med.name AS “Medication”
FROM patient AS ptn
JOIN prescribes AS pre
ON ptn.ssn = pre.patient
JOIN physician AS phy
ON pre.physician = phy.employeeid
JOIN medication AS med
ON pre.medication = med.code
WHERE pre.appointment IS NULL

-- 22. From the room table, count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the block as “Block”, count number of available rooms as “Number of available rooms”.
SELECT blockcode AS “Block”, COUNT(blockcode) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’
GROUP BY blockcode
ORDER BY blockcode

-- 23. From the room table, count the number of available rooms in each floor. Sort the result-set on block floor. Return floor ID as “Floor” and count the number of available rooms as “Number of available rooms”.
SELECT blockfloor AS “Floor”, COUNT(blockfloor) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’
GROUP BY blockfloor
ORDER BY blockfloor

-- 24. From the room table, count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. Return the floor ID as “Floor”, ID of the block as “Block”, and number of available rooms as “Number of available rooms”.
SELECT blockfloor AS “Floor”, blockcode AS “Block”, COUNT(*) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode

-- 25. From the room table, count the number of unavailable rooms for each block in each floor. Sort the result-set on block floor, block code. Return the floor ID as “Floor”, block ID as “Block”, and number of unavailable as “Number of unavailable rooms”.
SELECT blockfloor AS “Floor”, blockcode AS “Block”, COUNT(*) AS “Number of unavailable rooms”
FROM room
WHERE unavailable = ‘t’
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode

-- 26. From the room table, find the floor where the maximum numbers of rooms are available. Return floor ID as “Floor”, count “Number of available rooms”.
SELECT blockfloor AS “Floor”, COUNT(blockfloor) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’
GROUP BY blockfloor
HAVING COUNT(blockfloor) =
(
SELECT COUNT(blockfloor) FROM room WHERE unavailable = ‘f’ GROUP BY blockfloor ORDER BY COUNT(blockfloor) DESC LIMIT 1
)
ORDER BY blockfloor

-- 27. From the room table, find the floor where the minimum numbers of rooms are available. Return floor ID as “Floor”, Number of available rooms.
SELECT blockfloor AS “Floor”, COUNT(blockfloor) AS “Number of available rooms”
FROM room
WHERE unavailable = ‘f’
GROUP BY blockfloor
HAVING COUNT(blockfloor) =
(
SELECT COUNT(blockfloor) FROM room WHERE unavailable = ‘f’ GROUP BY blockfloor ORDER BY COUNT(blockfloor) ASC LIMIT 1
)
ORDER BY blockfloor

-- 28. From the patient, stay, and room tables, find the name of the patients, their block, floor, and room number where they admitted.
SELECT ptn.name AS “Patient”, room.blockcode AS “Block”, room.blockfloor AS “Floor”, stay.room AS “Room”
FROM patient AS ptn
JOIN stay
ON ptn.ssn = stay.patient
JOIN room
ON stay.room = room.roomnumber

-- 29. From the nurse and on_call tables, find the nurses and the block where they are booked for attending the patients on call. Return Nurse Name as “Nurse”, Block code as “Block”.
SELECT n.name AS “Nurse”, oc.blockcode AS “Block”
FROM nurse AS n
JOIN on_call AS oc
ON n.employeeid = oc.nurse

-- 30. From the patient, undergoes, physician, nurse, stay, and room tables, get
-- a) name of the patient,
-- b) name of the physician who is treating him or her,
-- c) name of the nurse who is attending him or her,
-- d) the date of release,
-- e) in which room the patient has admitted and which floor and block the room belongs to respectively.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”, n.name AS “Nurse”, stay.end_time AS “Date of release”, stay.room AS “Room”, room.blockfloor AS “Floor”, room.blockcode AS “Block”
FROM patient AS ptn
JOIN undergoes AS u
ON ptn.ssn = u.patient
JOIN physician AS phy
ON u.physician = phy.employeeid
JOIN nurse AS n
ON u.assistingnurse = n.employeeid
JOIN stay
ON u.stay = stay.stayid
JOIN room
ON stay.room = room.roomnumber

-- 31. From the patient, undergoes, trained_in, procedure, and patient tables, find all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not certified for that procedure. Return Physician Name as “Physician”, Procedure Name as “Procedure”, date, and Patient. Name as “Patient”.
SELECT phy.name AS “Physician”, proc.name AS “Procedure”, u.date, ptn.name AS “Patient”
FROM physician AS phy
JOIN undergoes AS u
ON phy.employeeid = u.physician
LEFT JOIN trained_in AS ti
ON phy.employeeid = ti.physician
AND u.procedure = ti.treatment
JOIN procedure AS proc
ON u.procedure = proc.code
JOIN patient AS ptn
ON u.patient = ptn.ssn
WHERE ti.treatment IS NULL

-- 32. From the physician, undergoes, trained_in, procedure, and patient tables, find all those physicians who completed a medical procedure with certification after the date of expiration of their certificate. Return Physician Name as “Physician”, Position as “Position”, Procedure Name as “Procedure”, Date of Procedure as “Date of Procedure”, expiry date of certification as “Expiry Date of Certificate”, and Patient Name as “Patient”.
SELECT phy.name AS “Physician”, phy.position AS “Position”, proc.name AS “Procedure”, u.date AS “Date of Procedure”, ti.certificationexpires AS “Expiry Date of Certificate”, ptn.name AS “Patient”
FROM physician AS phy
JOIN undergoes AS u
ON phy.employeeid = u.physician
JOIN trained_in AS ti
ON phy.employeeid = ti.physician
AND u.procedure = ti.treatment
AND u.date > ti.certificationexpires
JOIN procedure AS proc
ON u.procedure = proc.code
JOIN patient AS ptn
ON u.patient = ptn.ssn

-- 33. From the nurse, on_call, and room tables, find those nurses who have ever been on call for room 122. Return name of the nurses.
SELECT n.name
FROM nurse AS n
JOIN on_call AS oc
ON n.employeeid = oc.nurse
JOIN room AS r
ON oc.blockfloor = r.blockfloor
AND oc.blockcode = r.blockcode
WHERE r.roomnumber = 122

-- 34. From the patient, prescribes, and physician tables, find those patients who have been prescribed by some medication by his/her physician who has carried out primary care. Return Patient name as “Patient”, and Physician Name as “Physician”.
SELECT ptn.name AS “Patient”, phy.name AS “Physician”
FROM patient AS ptn
JOIN prescribes AS pre
ON ptn.ssn = pre.patient
JOIN physician AS phy
ON pre.physician = phy.employeeid
WHERE ptn.pcp = pre.physician

-- 35. From the patient, physician, undergoes, and procedure tables, find those patients who have been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care. Return name of the patient as “Patient”, name of the physician as “Primary Physician”, and cost for the procedure as “Procedure Cost”.
SELECT ptn.name AS “Patient”, phy.name AS “Primary Physician”, proc.cost AS “Procedure Cost”
FROM patient AS ptn
JOIN physician AS phy
ON ptn.pcp = phy.employeeid
JOIN undergoes AS u
ON ptn.ssn = u.patient
JOIN procedure AS proc
ON u.procedure = proc.code
WHERE proc.cost > 5000

-- 36. From the patient, physician, appointment, and nurse tables, find those patients who had at least two appointments where the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care. Return Patient name as “Patient”, Physician name as “Primary Physician”, and Nurse Name as “Nurse”.
SELECT ptn.name AS “Patient”, phy.name AS “Primary Physician”, n.name AS “Nurse”
FROM patient AS ptn
JOIN physician AS phy
ON ptn.pcp = phy.employeeid
JOIN appointment AS app
ON ptn.ssn = app.patient
JOIN nurse AS n
ON app.prepnurse = n.employeeid
WHERE n.registered = ‘t’
AND ptn.ssn IN
(
SELECT patient FROM appointment GROUP BY patient HAVING COUNT(patient) > 1
)
ORDER BY ptn.name, phy.name, n.name

-- 37. From the patient, physician, and department tables, find those patients whose primary care a physician who is not the head of any department takes. Return Patient name as “Patient”, Physician Name as “Primary Physician”.
SELECT ptn.name AS “Patient”, phy.name AS “Primary Physician”
FROM patient AS ptn
JOIN physician AS phy
ON ptn.pcp = phy.employeeid
WHERE ptn.pcp NOT IN
(
SELECT head FROM department
)
ORDER BY ptn.name, phy.name