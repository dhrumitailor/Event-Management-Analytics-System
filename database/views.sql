USE SmartEventManagement;

-- =====================================================
-- 1. EVENT SUMMARY VIEW
-- =====================================================

CREATE VIEW vw_EventSummary AS
SELECT
    E.EventID,
    E.EventName,
    E.EventDate,
    E.StartTime,
    E.EndTime,
    E.Status,

    O.OrganizerName,

    F.FacultyName,

    V.VenueName,

    EC.CategoryName

FROM Event E

LEFT JOIN Organizer O
ON E.OrganizerID = O.OrganizerID

LEFT JOIN FacultyCoordinator F
ON E.FacultyID = F.FacultyID

LEFT JOIN Venue V
ON E.VenueID = V.VenueID

LEFT JOIN EventCategory EC
ON E.CategoryID = EC.CategoryID;

-- =====================================================
-- 2. REVENUE REPORT VIEW
-- =====================================================

CREATE VIEW vw_RevenueReport AS
SELECT
    E.EventID,
    E.EventName,

    COUNT(R.RegistrationID)
    AS TotalRegistrations,

    SUM(P.Amount)
    AS TotalRevenue

FROM Event E

LEFT JOIN Registration R
ON E.EventID = R.EventID

LEFT JOIN Payment P
ON R.RegistrationID = P.RegistrationID

WHERE P.PaymentStatus = 'SUCCESS'

GROUP BY
    E.EventID,
    E.EventName;

-- =====================================================
-- 3. ATTENDANCE REPORT VIEW
-- =====================================================

CREATE VIEW vw_AttendanceReport AS
SELECT

    E.EventName,

    A.AttendeeID,

    CONCAT(
        ATD.FirstName,
        ' ',
        ATD.LastName
    ) AS StudentName,

    A.AttendanceStatus,

    A.CheckInTime

FROM Attendance A

JOIN Event E
ON A.EventID = E.EventID

JOIN Attendee ATD
ON A.AttendeeID = ATD.AttendeeID;

-- =====================================================
-- 4. TOP EVENTS VIEW
-- =====================================================

CREATE VIEW vw_TopEvents AS
SELECT

    E.EventID,

    E.EventName,

    COUNT(R.RegistrationID)
    AS TotalParticipants

FROM Event E

LEFT JOIN Registration R
ON E.EventID = R.EventID

GROUP BY
    E.EventID,
    E.EventName;

-- =====================================================
-- 5. FEEDBACK ANALYTICS VIEW
-- =====================================================

CREATE VIEW vw_FeedbackAnalytics AS
SELECT

    E.EventID,

    E.EventName,

    ROUND(
        AVG(F.Rating),
        2
    ) AS AverageRating,

    COUNT(F.FeedbackID)
    AS FeedbackCount

FROM Event E

LEFT JOIN Feedback F
ON E.EventID = F.EventID

GROUP BY
    E.EventID,
    E.EventName;

-- =====================================================
-- 6. CERTIFICATE REPORT VIEW
-- =====================================================

CREATE VIEW vw_CertificateReport AS
SELECT

    C.CertificateID,

    C.CertificateNumber,

    CONCAT(
        A.FirstName,
        ' ',
        A.LastName
    ) AS StudentName,

    E.EventName,

    C.IssueDate,

    C.CertificateStatus

FROM Certificate C

JOIN Attendee A
ON C.AttendeeID = A.AttendeeID

JOIN Event E
ON C.EventID = E.EventID;

-- =====================================================
-- 7. SPONSOR REPORT VIEW
-- =====================================================

CREATE VIEW vw_SponsorReport AS
SELECT

    S.SponsorID,

    S.SponsorName,

    S.ContactPerson,

    S.SponsorshipAmount,

    E.EventName

FROM Sponsor S

JOIN EventSponsor ES
ON S.SponsorID = ES.SponsorID

JOIN Event E
ON ES.EventID = E.EventID;

-- =====================================================
-- 8. BRANCH PARTICIPATION VIEW
-- =====================================================

CREATE VIEW vw_BranchParticipation AS
SELECT

    Branch,

    COUNT(*)
    AS TotalStudents

FROM Attendee

GROUP BY Branch;

-- =====================================================
-- 9. EVENT ANALYTICS VIEW
-- =====================================================

CREATE VIEW vw_EventAnalytics AS
SELECT

    E.EventName,

    EA.TotalRegistrations,

    EA.TotalAttendance,

    EA.RevenueGenerated,

    EA.AverageRating

FROM EventAnalytics EA

JOIN Event E
ON EA.EventID = E.EventID;

-- =====================================================
-- 10. VOLUNTEER REPORT VIEW
-- =====================================================

CREATE VIEW vw_VolunteerReport AS
SELECT

    V.VolunteerID,

    CONCAT(
        A.FirstName,
        ' ',
        A.LastName
    ) AS VolunteerName,

    V.SkillSet,

    VA.AssignedRole,

    E.EventName

FROM Volunteer V

JOIN Attendee A
ON V.AttendeeID = A.AttendeeID

LEFT JOIN VolunteerAssignment VA
ON V.VolunteerID = VA.VolunteerID

LEFT JOIN Event E
ON VA.EventID = E.EventID;