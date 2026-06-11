USE SmartEventManagement;

-- =====================================================
-- ORGANIZERS
-- =====================================================

INSERT INTO Organizer
(OrganizerName, Department, Email, Phone)
VALUES
('Rahul Sharma','CSE','rahul@college.edu','9876543210'),
('Priya Patel','IT','priya@college.edu','9876543211'),
('Amit Singh','ECE','amit@college.edu','9876543212'),
('Neha Shah','CSE','neha@college.edu','9876543213'),
('Karan Mehta','IT','karan@college.edu','9876543214');

-- =====================================================
-- FACULTY
-- =====================================================

INSERT INTO FacultyCoordinator
(FacultyName, Department, Email, Phone, Designation)
VALUES
('Dr. Rajesh Patel','CSE','rajesh@college.edu','9000000001','Professor'),
('Dr. Kavita Shah','IT','kavita@college.edu','9000000002','Associate Professor'),
('Dr. Rakesh Joshi','ECE','rakesh@college.edu','9000000003','Professor'),
('Dr. Meena Patel','CSE','meena@college.edu','9000000004','Assistant Professor');

-- =====================================================
-- CATEGORIES
-- =====================================================

INSERT INTO EventCategory
(CategoryName, Description)
VALUES
('Workshop','Hands-on learning'),
('Hackathon','Coding competition'),
('Seminar','Technical seminar'),
('Sports','Sports events'),
('Cultural','Cultural festival'),
('Placement','Career development');

-- =====================================================
-- VENUES
-- =====================================================

INSERT INTO Venue
(VenueName, Capacity, Address, VenueType)
VALUES
('Auditorium',500,'Main Campus','Indoor'),
('Seminar Hall A',150,'Block A','Indoor'),
('Seminar Hall B',150,'Block B','Indoor'),
('Computer Lab 1',80,'IT Building','Lab'),
('Ground',2000,'Sports Complex','Outdoor');

-- =====================================================
-- EVENTS
-- =====================================================

INSERT INTO Event
(
EventName,
Description,
EventDate,
StartTime,
EndTime,
MaxParticipants,
RegistrationFee,
Status,
OrganizerID,
FacultyID,
VenueID,
CategoryID
)
VALUES
(
'AI Workshop',
'Introduction to AI',
'2026-07-10',
'09:00:00',
'16:00:00',
200,
500,
'UPCOMING',
1,
1,
2,
1
),
(
'Hackathon 2026',
'24 hour coding challenge',
'2026-08-15',
'08:00:00',
'23:59:00',
300,
1000,
'UPCOMING',
2,
2,
1,
2
),
(
'Cloud Seminar',
'Cloud computing technologies',
'2026-07-25',
'10:00:00',
'14:00:00',
250,
200,
'UPCOMING',
3,
1,
1,
3
),
(
'Tech Fest',
'Annual technology festival',
'2026-09-05',
'09:00:00',
'18:00:00',
1000,
300,
'UPCOMING',
4,
3,
5,
5
);

-- =====================================================
-- ATTENDEES
-- =====================================================

INSERT INTO Attendee
(
FirstName,
LastName,
Gender,
Email,
Phone,
Branch,
Semester,
EnrollmentNo
)
VALUES
('Arjun','Patel','MALE','arjun1@gmail.com','9000010001','CSE',5,'CSE001'),
('Riya','Shah','FEMALE','riya1@gmail.com','9000010002','IT',5,'IT001'),
('Dev','Patel','MALE','dev1@gmail.com','9000010003','CSE',3,'CSE002'),
('Anjali','Joshi','FEMALE','anjali@gmail.com','9000010004','ECE',7,'ECE001'),
('Harsh','Mehta','MALE','harsh@gmail.com','9000010005','IT',5,'IT002'),
('Sneha','Patel','FEMALE','sneha@gmail.com','9000010006','CSE',1,'CSE003'),
('Yash','Shah','MALE','yash@gmail.com','9000010007','IT',3,'IT003'),
('Krupa','Patel','FEMALE','krupa@gmail.com','9000010008','ECE',5,'ECE002'),
('Rahul','Joshi','MALE','rahulj@gmail.com','9000010009','CSE',7,'CSE004'),
('Pooja','Mehta','FEMALE','pooja@gmail.com','9000010010','IT',1,'IT004');

-- =====================================================
-- REGISTRATIONS
-- =====================================================

INSERT INTO Registration
(AttendeeID, EventID, RegistrationStatus)
VALUES
(1,1,'CONFIRMED'),
(2,1,'CONFIRMED'),
(3,1,'CONFIRMED'),
(4,2,'CONFIRMED'),
(5,2,'CONFIRMED'),
(6,3,'CONFIRMED'),
(7,3,'CONFIRMED'),
(8,4,'CONFIRMED'),
(9,4,'CONFIRMED'),
(10,1,'CONFIRMED');

-- =====================================================
-- PAYMENTS
-- =====================================================

INSERT INTO Payment
(
RegistrationID,
Amount,
PaymentMethod,
PaymentStatus,
TransactionReference
)
VALUES
(1,500,'UPI','SUCCESS','TXN1001'),
(2,500,'UPI','SUCCESS','TXN1002'),
(3,500,'CARD','SUCCESS','TXN1003'),
(4,1000,'UPI','SUCCESS','TXN1004'),
(5,1000,'CARD','SUCCESS','TXN1005'),
(6,200,'UPI','SUCCESS','TXN1006'),
(7,200,'UPI','SUCCESS','TXN1007'),
(8,300,'CARD','SUCCESS','TXN1008'),
(9,300,'UPI','SUCCESS','TXN1009'),
(10,500,'CARD','SUCCESS','TXN1010');

-- =====================================================
-- ATTENDANCE
-- =====================================================

INSERT INTO Attendance
(
EventID,
AttendeeID,
AttendanceStatus
)
VALUES
(1,1,'PRESENT'),
(1,2,'PRESENT'),
(1,3,'PRESENT'),
(2,4,'PRESENT'),
(2,5,'ABSENT'),
(3,6,'PRESENT'),
(3,7,'PRESENT'),
(4,8,'PRESENT'),
(4,9,'PRESENT'),
(1,10,'PRESENT');

-- =====================================================
-- CERTIFICATES
-- =====================================================

INSERT INTO Certificate
(
EventID,
AttendeeID,
CertificateNumber,
IssueDate,
CertificateStatus
)
VALUES
(1,1,'CERT1001','2026-07-11','ISSUED'),
(1,2,'CERT1002','2026-07-11','ISSUED'),
(1,3,'CERT1003','2026-07-11','ISSUED'),
(3,6,'CERT1004','2026-07-26','ISSUED'),
(3,7,'CERT1005','2026-07-26','ISSUED');

-- =====================================================
-- FEEDBACK
-- =====================================================

INSERT INTO Feedback
(
EventID,
AttendeeID,
Rating,
Comments
)
VALUES
(1,1,5,'Excellent workshop'),
(1,2,4,'Very informative'),
(1,3,5,'Great session'),
(2,4,5,'Amazing hackathon'),
(2,5,4,'Good event'),
(3,6,5,'Loved cloud topics'),
(3,7,4,'Useful seminar'),
(4,8,5,'Fantastic festival'),
(4,9,4,'Enjoyed a lot');

-- =====================================================
-- SPONSORS
-- =====================================================

INSERT INTO Sponsor
(
SponsorName,
ContactPerson,
Email,
Phone,
SponsorshipAmount
)
VALUES
('TCS','Amit Verma','tcs@tcs.com','8000011111',50000),
('Infosys','Neha Gupta','infosys@infosys.com','8000011112',40000),
('Wipro','Rakesh Shah','wipro@wipro.com','8000011113',30000);

-- =====================================================
-- EVENT SPONSORS
-- =====================================================

INSERT INTO EventSponsor
(EventID,SponsorID)
VALUES
(1,1),
(2,2),
(3,3),
(4,1);

-- =====================================================
-- VOLUNTEERS
-- =====================================================

INSERT INTO Volunteer
(
AttendeeID,
SkillSet,
ExperienceLevel
)
VALUES
(1,'Management','Intermediate'),
(2,'Photography','Advanced'),
(3,'Technical Support','Intermediate'),
(4,'Anchoring','Advanced');

-- =====================================================
-- VOLUNTEER ASSIGNMENTS
-- =====================================================

INSERT INTO VolunteerAssignment
(
VolunteerID,
EventID,
AssignedRole
)
VALUES
(1,1,'Coordinator'),
(2,2,'Photographer'),
(3,3,'Technical Assistant'),
(4,4,'Anchor');

-- =====================================================
-- NOTIFICATIONS
-- =====================================================

INSERT INTO Notification
(
AttendeeID,
Title,
Message
)
VALUES
(1,'Registration Confirmed','Your registration is confirmed'),
(2,'Payment Successful','Payment completed'),
(3,'Workshop Reminder','AI Workshop tomorrow'),
(4,'Hackathon Reminder','Hackathon starts tomorrow');

-- =====================================================
-- ANALYTICS
-- =====================================================

INSERT INTO EventAnalytics
(
EventID,
TotalRegistrations,
TotalAttendance,
RevenueGenerated,
AverageRating
)
VALUES
(1,4,4,2000,4.67),
(2,2,1,2000,4.50),
(3,2,2,400,4.50),
(4,2,2,600,4.50);