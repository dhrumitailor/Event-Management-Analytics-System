CREATE DATABASE IF NOT EXISTS SmartEventManagement;
USE SmartEventManagement;

-- =====================================================
-- ORGANIZER
-- =====================================================

CREATE TABLE Organizer (
    OrganizerID INT AUTO_INCREMENT PRIMARY KEY,
    OrganizerName VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- FACULTY COORDINATOR
-- =====================================================

CREATE TABLE FacultyCoordinator (
    FacultyID INT AUTO_INCREMENT PRIMARY KEY,
    FacultyName VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Designation VARCHAR(100)
);

-- =====================================================
-- EVENT CATEGORY
-- =====================================================

CREATE TABLE EventCategory (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE NOT NULL,
    Description VARCHAR(255)
);

-- =====================================================
-- VENUE
-- =====================================================

CREATE TABLE Venue (
    VenueID INT AUTO_INCREMENT PRIMARY KEY,
    VenueName VARCHAR(150) NOT NULL,
    Capacity INT NOT NULL,
    Address VARCHAR(255),
    VenueType VARCHAR(50)
);

-- =====================================================
-- EVENT
-- =====================================================

CREATE TABLE Event (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(150) NOT NULL,
    Description TEXT,
    EventDate DATE NOT NULL,
    StartTime TIME,
    EndTime TIME,
    MaxParticipants INT,
    RegistrationFee DECIMAL(10,2) DEFAULT 0,
    Status ENUM(
        'UPCOMING',
        'ONGOING',
        'COMPLETED',
        'CANCELLED'
    ) DEFAULT 'UPCOMING',

    OrganizerID INT,
    FacultyID INT,
    VenueID INT,
    CategoryID INT,

    FOREIGN KEY (OrganizerID)
        REFERENCES Organizer(OrganizerID),

    FOREIGN KEY (FacultyID)
        REFERENCES FacultyCoordinator(FacultyID),

    FOREIGN KEY (VenueID)
        REFERENCES Venue(VenueID),

    FOREIGN KEY (CategoryID)
        REFERENCES EventCategory(CategoryID)
);

-- =====================================================
-- ATTENDEE
-- =====================================================

CREATE TABLE Attendee (
    AttendeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('MALE','FEMALE','OTHER'),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),

    Branch VARCHAR(50),
    Semester INT,
    EnrollmentNo VARCHAR(50) UNIQUE,

    RegistrationDate DATE DEFAULT (CURRENT_DATE)
);

-- =====================================================
-- REGISTRATION
-- =====================================================

CREATE TABLE Registration (
    RegistrationID INT AUTO_INCREMENT PRIMARY KEY,

    AttendeeID INT NOT NULL,
    EventID INT NOT NULL,

    RegistrationDate DATETIME
        DEFAULT CURRENT_TIMESTAMP,

    RegistrationStatus ENUM(
        'PENDING',
        'CONFIRMED',
        'CANCELLED'
    ) DEFAULT 'PENDING',

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID),

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    UNIQUE (AttendeeID, EventID)
);

-- =====================================================
-- PAYMENT
-- =====================================================

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,

    RegistrationID INT NOT NULL,

    Amount DECIMAL(10,2),
    PaymentDate DATETIME
        DEFAULT CURRENT_TIMESTAMP,

    PaymentMethod ENUM(
        'UPI',
        'CARD',
        'NETBANKING',
        'CASH'
    ),

    PaymentStatus ENUM(
        'PENDING',
        'SUCCESS',
        'FAILED'
    ) DEFAULT 'PENDING',

    TransactionReference VARCHAR(100),

    FOREIGN KEY (RegistrationID)
        REFERENCES Registration(RegistrationID)
);

-- =====================================================
-- ATTENDANCE
-- =====================================================

CREATE TABLE Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,

    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,

    CheckInTime DATETIME,
    CheckOutTime DATETIME,

    AttendanceStatus ENUM(
        'PRESENT',
        'ABSENT'
    ) DEFAULT 'ABSENT',

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID)
);

-- =====================================================
-- CERTIFICATE
-- =====================================================

CREATE TABLE Certificate (
    CertificateID INT AUTO_INCREMENT PRIMARY KEY,

    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,

    CertificateNumber VARCHAR(100) UNIQUE,

    IssueDate DATE,

    CertificateStatus ENUM(
        'PENDING',
        'ISSUED'
    ) DEFAULT 'PENDING',

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID)
);

-- =====================================================
-- FEEDBACK
-- =====================================================

CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,

    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,

    Rating INT CHECK (
        Rating BETWEEN 1 AND 5
    ),

    Comments TEXT,

    FeedbackDate DATETIME
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID)
);
-- =====================================================
-- SPONSOR
-- =====================================================

CREATE TABLE Sponsor (
    SponsorID INT AUTO_INCREMENT PRIMARY KEY,

    SponsorName VARCHAR(150) NOT NULL,
    ContactPerson VARCHAR(100),

    Email VARCHAR(100),
    Phone VARCHAR(15),

    SponsorshipAmount DECIMAL(12,2)
);

-- =====================================================
-- EVENT SPONSOR
-- =====================================================

CREATE TABLE EventSponsor (
    EventSponsorID INT AUTO_INCREMENT PRIMARY KEY,

    EventID INT NOT NULL,
    SponsorID INT NOT NULL,

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    FOREIGN KEY (SponsorID)
        REFERENCES Sponsor(SponsorID)
);

-- =====================================================
-- VOLUNTEER
-- =====================================================

CREATE TABLE Volunteer (
    VolunteerID INT AUTO_INCREMENT PRIMARY KEY,

    AttendeeID INT UNIQUE,

    SkillSet VARCHAR(255),
    ExperienceLevel VARCHAR(50),

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID)
);

-- =====================================================
-- VOLUNTEER ASSIGNMENT
-- =====================================================

CREATE TABLE VolunteerAssignment (
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,

    VolunteerID INT,
    EventID INT,

    AssignedRole VARCHAR(100),

    FOREIGN KEY (VolunteerID)
        REFERENCES Volunteer(VolunteerID),

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);

-- =====================================================
-- NOTIFICATION
-- =====================================================

CREATE TABLE Notification (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,

    AttendeeID INT,

    Title VARCHAR(255),
    Message TEXT,

    SentDate DATETIME
        DEFAULT CURRENT_TIMESTAMP,

    ReadStatus BOOLEAN
        DEFAULT FALSE,

    FOREIGN KEY (AttendeeID)
        REFERENCES Attendee(AttendeeID)
);

-- =====================================================
-- EVENT ANALYTICS
-- =====================================================

CREATE TABLE EventAnalytics (
    AnalyticsID INT AUTO_INCREMENT PRIMARY KEY,

    EventID INT UNIQUE,

    TotalRegistrations INT DEFAULT 0,
    TotalAttendance INT DEFAULT 0,
    RevenueGenerated DECIMAL(12,2) DEFAULT 0,

    AverageRating DECIMAL(4,2) DEFAULT 0,

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);

-- =====================================================
-- AUDIT LOG
-- =====================================================

CREATE TABLE AuditLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,

    TableName VARCHAR(100),
    ActionType VARCHAR(50),

    RecordID INT,

    ActionDate DATETIME
        DEFAULT CURRENT_TIMESTAMP,

    ActionBy VARCHAR(100)
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_event_date
ON Event(EventDate);

CREATE INDEX idx_event_status
ON Event(Status);

CREATE INDEX idx_attendee_branch
ON Attendee(Branch);

CREATE INDEX idx_registration_event
ON Registration(EventID);

CREATE INDEX idx_payment_status
ON Payment(PaymentStatus);

CREATE INDEX idx_feedback_rating
ON Feedback(Rating);

CREATE INDEX idx_attendance_status
ON Attendance(AttendanceStatus);
