USE SmartEventManagement;

DELIMITER $$

-- =====================================================
-- 1. REGISTER STUDENT FOR EVENT
-- =====================================================

CREATE PROCEDURE RegisterStudent(
    IN p_AttendeeID INT,
    IN p_EventID INT
)
BEGIN

    DECLARE reg_count INT;

    SELECT COUNT(*)
    INTO reg_count
    FROM Registration
    WHERE AttendeeID = p_AttendeeID
    AND EventID = p_EventID;

    IF reg_count = 0 THEN

        INSERT INTO Registration(
            AttendeeID,
            EventID,
            RegistrationStatus
        )
        VALUES(
            p_AttendeeID,
            p_EventID,
            'CONFIRMED'
        );

    END IF;

END $$

-- =====================================================
-- 2. GENERATE CERTIFICATE
-- =====================================================

CREATE PROCEDURE GenerateCertificate(
    IN p_EventID INT,
    IN p_AttendeeID INT
)
BEGIN

    INSERT INTO Certificate(
        EventID,
        AttendeeID,
        CertificateNumber,
        IssueDate,
        CertificateStatus
    )
    VALUES(
        p_EventID,
        p_AttendeeID,
        CONCAT(
            'CERT',
            p_EventID,
            p_AttendeeID,
            FLOOR(RAND()*1000)
        ),
        CURDATE(),
        'ISSUED'
    );

END $$

-- =====================================================
-- 3. CALCULATE EVENT REVENUE
-- =====================================================

CREATE PROCEDURE CalculateRevenue(
    IN p_EventID INT
)
BEGIN

    SELECT
        E.EventName,
        SUM(P.Amount) AS TotalRevenue
    FROM Event E
    JOIN Registration R
        ON E.EventID = R.EventID
    JOIN Payment P
        ON R.RegistrationID = P.RegistrationID
    WHERE E.EventID = p_EventID
    AND P.PaymentStatus = 'SUCCESS'
    GROUP BY E.EventName;

END $$

-- =====================================================
-- 4. ATTENDANCE REPORT
-- =====================================================

CREATE PROCEDURE AttendanceReport(
    IN p_EventID INT
)
BEGIN

    SELECT
        A.AttendeeID,
        CONCAT(
            ATD.FirstName,
            ' ',
            ATD.LastName
        ) AS StudentName,
        A.AttendanceStatus
    FROM Attendance A
    JOIN Attendee ATD
        ON A.AttendeeID = ATD.AttendeeID
    WHERE A.EventID = p_EventID;

END $$

-- =====================================================
-- 5. TOP EVENTS
-- =====================================================

CREATE PROCEDURE TopEvents()
BEGIN

    SELECT
        E.EventName,
        COUNT(R.RegistrationID)
        AS TotalParticipants
    FROM Event E
    LEFT JOIN Registration R
        ON E.EventID = R.EventID
    GROUP BY E.EventID
    ORDER BY TotalParticipants DESC;

END $$

-- =====================================================
-- 6. FEEDBACK ANALYTICS
-- =====================================================

CREATE PROCEDURE FeedbackAnalytics()
BEGIN

    SELECT
        E.EventName,
        ROUND(
            AVG(F.Rating),
            2
        ) AS AverageRating,
        COUNT(F.FeedbackID)
        AS TotalFeedbacks
    FROM Event E
    JOIN Feedback F
        ON E.EventID = F.EventID
    GROUP BY E.EventID
    ORDER BY AverageRating DESC;

END $$

-- =====================================================
-- 7. BRANCH PARTICIPATION REPORT
-- =====================================================

CREATE PROCEDURE BranchParticipation()
BEGIN

    SELECT
        Branch,
        COUNT(*) AS TotalStudents
    FROM Attendee
    GROUP BY Branch
    ORDER BY TotalStudents DESC;

END $$

-- =====================================================
-- 8. SPONSOR CONTRIBUTION REPORT
-- =====================================================

CREATE PROCEDURE SponsorReport()
BEGIN

    SELECT
        SponsorName,
        SponsorshipAmount
    FROM Sponsor
    ORDER BY SponsorshipAmount DESC;

END $$

-- =====================================================
-- 9. EVENT SUMMARY REPORT
-- =====================================================

CREATE PROCEDURE EventSummary()
BEGIN

    SELECT
        E.EventName,
        E.EventDate,
        V.VenueName,
        O.OrganizerName
    FROM Event E
    JOIN Venue V
        ON E.VenueID = V.VenueID
    JOIN Organizer O
        ON E.OrganizerID = O.OrganizerID
    ORDER BY E.EventDate;

END $$

-- =====================================================
-- 10. CERTIFICATE REPORT
-- =====================================================

CREATE PROCEDURE CertificateReport()
BEGIN

    SELECT
        CertificateNumber,
        IssueDate,
        CertificateStatus
    FROM Certificate
    ORDER BY IssueDate DESC;

END $$

DELIMITER ;