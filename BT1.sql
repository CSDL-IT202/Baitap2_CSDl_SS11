-- Phần A: Tái hiện lỗi
CALL CancelAppointment(1001);
-- Giải thích:
-- Procedure hiện tại chỉ cập nhật status = 'Cancelled'
-- nhưng không kiểm tra trạng thái thanh toán/hoàn tất,
-- nên lịch đã hoàn tất vẫn bị hủy.
DROP PROCEDURE IF EXISTS CancelAppointment;
DELIMITER //
CREATE PROCEDURE CancelAppointment(IN p_appointment_id INT)
BEGIN
    DECLARE v_status VARCHAR(50);
    SELECT status
    INTO v_status
    FROM Appointments
    WHERE appointment_id = p_appointment_id;
    IF v_status <> 'Completed' THEN
        UPDATE Appointments
        SET status = 'Cancelled'
        WHERE appointment_id = p_appointment_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot cancel a completed appointment';
    END IF;
END //
DELIMITER ;