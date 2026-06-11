USE SmartEventManagement;

DELIMITER $$

-- =====================================================
-- 1. AUTO CREATE ANALYTICS ROW FOR NEW EVENT
-- =====================================================

CREATE TRIGGER trg_create_event_analytics
AFTER INSERT ON Event
FOR EACH ROW
BEGIN

    INSERT INTO EventAnalytics(
        EventID,
        TotalRegistrations,
        TotalAttendance,
        RevenueGenerated,
        AverageRating
    )
    VALUES(
        NEW.EventID,
        0,
        0,
        0,
        0
    );

END $$

-- =====================================================
-- 2. UPDATE REGISTRATION COUNT
-- =====================================================

CREATE TRIGGER trg_registration_insert
AFTER INSERT ON Registration
FOR EACH ROW
BEGIN

    UPDATE EventAnalytics
    SET TotalRegistrations =
        TotalRegistrations + 1
    WHERE EventID = NEW.EventID;

END $$

-- =====================================================
-- 3. UPDATE REVENUE AFTER PAYMENT
-- =====================================================

CREATE TRIGGER trg_payment_success
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN

    DECLARE v_event_id INT;

    IF NEW.PaymentStatus = 'SUCCESS' THEN

        SELECT EventID
        INTO v_event_id
        FROM Registration
        WHERE RegistrationID =
              NEW.RegistrationID;

        UPDATE EventAnalytics
        SET RevenueGenerated =
            RevenueGenerated + NEW.Amount
        WHERE EventID = v_event_id;

    END IF;

END $$

-- =====================================================
-- 4. UPDATE ATTENDANCE COUNT
-- =====================================================

CREATE TRIGGER trg_attendance_update
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN

    IF NEW.AttendanceStatus = 'PRESENT' THEN

        UPDATE EventAnalytics
        SET TotalAttendance =
            TotalAttendance + 1
        WHERE EventID = NEW.EventID;

    END IF;

END $$

-- =====================================================
-- 5. AUTO GENERATE CERTIFICATE
-- =====================================================

CREATE TRIGGER trg_generate_certificate
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN

    IF NEW.AttendanceStatus = 'PRESENT' THEN

        INSERT INTO Certificate(
            EventID,
            AttendeeID,
            CertificateNumber,
            IssueDate,
            CertificateStatus
        )
        VALUES(
            NEW.EventID,
            NEW.AttendeeID,
            CONCAT(
                'CERT-',
                NEW.EventID,
                '-',
                NEW.AttendeeID,
                '-',
                FLOOR(RAND()*10000)
            ),
            CURDATE(),
            'ISSUED'
        );

    END IF;

END $$

-- =====================================================
-- 6. UPDATE EVENT RATING
-- =====================================================

CREATE TRIGGER trg_feedback_rating
AFTER INSERT ON Feedback
FOR EACH ROW
BEGIN

    UPDATE EventAnalytics EA
    SET AverageRating =
    (
        SELECT ROUND(
            AVG(Rating),
            2
        )
        FROM Feedback
        WHERE EventID = NEW.EventID
    )
    WHERE EA.EventID = NEW.EventID;

END $$

-- =====================================================
-- 7. PREVENT DUPLICATE REGISTRATION
-- =====================================================

CREATE TRIGGER trg_prevent_duplicate_registration
BEFORE INSERT ON Registration
FOR EACH ROW
BEGIN

    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM Registration
    WHERE AttendeeID = NEW.AttendeeID
    AND EventID = NEW.EventID;

    IF total > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Student already registered';

    END IF;

END $$

-- =====================================================
-- 8. PREVENT OVERBOOKING
-- =====================================================

CREATE TRIGGER trg_prevent_overbooking
BEFORE INSERT ON Registration
FOR EACH ROW
BEGIN

    DECLARE total_registered INT;
    DECLARE max_allowed INT;

    SELECT COUNT(*)
    INTO total_registered
    FROM Registration
    WHERE EventID = NEW.EventID;

    SELECT MaxParticipants
    INTO max_allowed
    FROM Event
    WHERE EventID = NEW.EventID;

    IF total_registered >= max_allowed THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Event capacity reached';

    END IF;

END $$

-- =====================================================
-- 9. AUDIT EVENT INSERT
-- =====================================================

CREATE TRIGGER trg_audit_event_insert
AFTER INSERT ON Event
FOR EACH ROW
BEGIN

    INSERT INTO AuditLog(
        TableName,
        ActionType,
        RecordID,
        ActionBy
    )
    VALUES(
        'Event',
        'INSERT',
        NEW.EventID,
        USER()
    );

END $$

-- =====================================================
-- 10. AUDIT EVENT DELETE
-- =====================================================

CREATE TRIGGER trg_audit_event_delete
AFTER DELETE ON Event
FOR EACH ROW
BEGIN

    INSERT INTO AuditLog(
        TableName,
        ActionType,
        RecordID,
        ActionBy
    )
    VALUES(
        'Event',
        'DELETE',
        OLD.EventID,
        USER()
    );

END $$

DELIMITER ;