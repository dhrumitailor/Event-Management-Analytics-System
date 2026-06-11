USE SmartEventManagement;

-- =====================================================
-- 1. TOTAL EVENTS
-- =====================================================

SELECT COUNT(*) AS TotalEvents
FROM Event;

-- =====================================================
-- 2. TOTAL ATTENDEES
-- =====================================================

SELECT COUNT(*) AS TotalAttendees
FROM Attendee;

-- =====================================================
-- 3. TOTAL REVENUE
-- =====================================================

SELECT SUM(Amount) AS TotalRevenue
FROM Payment
WHERE PaymentStatus='SUCCESS';

-- =====================================================
-- 4. TOP 5 EVENTS BY REGISTRATION
-- =====================================================

SELECT
    E.EventName,
    COUNT(R.RegistrationID) AS Registrations
FROM Event E
JOIN Registration R
ON E.EventID = R.EventID
GROUP BY E.EventID
ORDER BY Registrations DESC
LIMIT 5;

-- =====================================================
-- 5. EVENT WITH HIGHEST REVENUE
-- =====================================================

SELECT
    E.EventName,
    SUM(P.Amount) AS Revenue
FROM Event E
JOIN Registration R
ON E.EventID = R.EventID
JOIN Payment P
ON R.RegistrationID = P.RegistrationID
GROUP BY E.EventID
ORDER BY Revenue DESC
LIMIT 1;

-- =====================================================
-- 6. AVERAGE EVENT RATING
-- =====================================================

SELECT
    E.EventName,
    ROUND(AVG(F.Rating),2) AS AvgRating
FROM Event E
JOIN Feedback F
ON E.EventID = F.EventID
GROUP BY E.EventID;

-- =====================================================
-- 7. ATTENDANCE PERCENTAGE
-- =====================================================

SELECT
    E.EventName,

    COUNT(
        CASE
        WHEN A.AttendanceStatus='PRESENT'
        THEN 1
        END
    ) * 100.0 /

    COUNT(*) AS AttendancePercentage

FROM Attendance A
JOIN Event E
ON A.EventID = E.EventID

GROUP BY E.EventID;

-- =====================================================
-- 8. BRANCH-WISE PARTICIPATION
-- =====================================================

SELECT
    Branch,
    COUNT(*) AS Students
FROM Attendee
GROUP BY Branch;

-- =====================================================
-- 9. EVENTS WITHOUT SPONSORS
-- =====================================================

SELECT
    EventName
FROM Event
WHERE EventID NOT IN
(
    SELECT EventID
    FROM EventSponsor
);

-- =====================================================
-- 10. STUDENTS WITH CERTIFICATES
-- =====================================================

SELECT
    CONCAT(
        A.FirstName,
        ' ',
        A.LastName
    ) AS StudentName,

    C.CertificateNumber

FROM Certificate C
JOIN Attendee A
ON C.AttendeeID=A.AttendeeID;

-- =====================================================
-- 11. MOST ACTIVE VOLUNTEERS
-- =====================================================

SELECT
    V.VolunteerID,
    COUNT(VA.AssignmentID)
    AS TotalAssignments
FROM Volunteer V
JOIN VolunteerAssignment VA
ON V.VolunteerID = VA.VolunteerID
GROUP BY V.VolunteerID
ORDER BY TotalAssignments DESC;

-- =====================================================
-- 12. EVENTS THIS MONTH
-- =====================================================

SELECT *
FROM Event
WHERE MONTH(EventDate)=MONTH(CURDATE())
AND YEAR(EventDate)=YEAR(CURDATE());

-- =====================================================
-- 13. PENDING PAYMENTS
-- =====================================================

SELECT *
FROM Payment
WHERE PaymentStatus='PENDING';

-- =====================================================
-- 14. SUCCESSFUL PAYMENTS
-- =====================================================

SELECT *
FROM Payment
WHERE PaymentStatus='SUCCESS';

-- =====================================================
-- 15. TOP SPONSORS
-- =====================================================

SELECT
    SponsorName,
    SponsorshipAmount
FROM Sponsor
ORDER BY SponsorshipAmount DESC;

-- =====================================================
-- 16. EVENT WITH MAX ATTENDANCE
-- =====================================================

SELECT
    E.EventName,
    COUNT(*) AS AttendanceCount
FROM Attendance A
JOIN Event E
ON A.EventID=E.EventID
WHERE A.AttendanceStatus='PRESENT'
GROUP BY E.EventID
ORDER BY AttendanceCount DESC
LIMIT 1;

-- =====================================================
-- 17. ATTENDEES NOT ATTENDING ANY EVENT
-- =====================================================

SELECT
    FirstName,
    LastName
FROM Attendee
WHERE AttendeeID NOT IN
(
    SELECT AttendeeID
    FROM Attendance
);

-- =====================================================
-- 18. EVENTS AND ORGANIZERS
-- =====================================================

SELECT
    E.EventName,
    O.OrganizerName
FROM Event E
JOIN Organizer O
ON E.OrganizerID=O.OrganizerID;

-- =====================================================
-- 19. REGISTRATIONS PER EVENT
-- =====================================================

SELECT
    EventID,
    COUNT(*) AS TotalRegistrations
FROM Registration
GROUP BY EventID;

-- =====================================================
-- 20. FEEDBACK COUNT PER EVENT
-- =====================================================

SELECT
    EventID,
    COUNT(*) AS FeedbackCount
FROM Feedback
GROUP BY EventID;

-- =====================================================
-- 21. RANK EVENTS BY REVENUE
-- MYSQL 8 WINDOW FUNCTION
-- =====================================================

SELECT
    EventName,
    Revenue,

    RANK() OVER(
        ORDER BY Revenue DESC
    ) AS RevenueRank

FROM
(
    SELECT
        E.EventName,
        SUM(P.Amount) AS Revenue

    FROM Event E
    JOIN Registration R
    ON E.EventID=R.EventID

    JOIN Payment P
    ON R.RegistrationID=P.RegistrationID

    GROUP BY E.EventID
) X;

-- =====================================================
-- 22. TOP RATED EVENT
-- =====================================================

SELECT
    E.EventName,
    AVG(F.Rating) AS Rating
FROM Event E
JOIN Feedback F
ON E.EventID=F.EventID
GROUP BY E.EventID
ORDER BY Rating DESC
LIMIT 1;

-- =====================================================
-- 23. STUDENT EVENT HISTORY
-- =====================================================

SELECT
    CONCAT(
        A.FirstName,
        ' ',
        A.LastName
    ) AS StudentName,

    E.EventName

FROM Registration R

JOIN Attendee A
ON R.AttendeeID=A.AttendeeID

JOIN Event E
ON R.EventID=E.EventID;

-- =====================================================
-- 24. EVENT COUNT BY CATEGORY
-- =====================================================

SELECT
    EC.CategoryName,
    COUNT(*) AS TotalEvents
FROM Event E
JOIN EventCategory EC
ON E.CategoryID=EC.CategoryID
GROUP BY EC.CategoryName;

-- =====================================================
-- 25. COMPLETE DASHBOARD QUERY
-- =====================================================

SELECT
(
SELECT COUNT(*) FROM Event
) AS TotalEvents,

(
SELECT COUNT(*) FROM Attendee
) AS TotalStudents,

(
SELECT COUNT(*) FROM Registration
) AS TotalRegistrations,

(
SELECT SUM(Amount)
FROM Payment
WHERE PaymentStatus='SUCCESS'
) AS Revenue;