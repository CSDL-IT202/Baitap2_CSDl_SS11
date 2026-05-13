DROP PROCEDURE IF EXISTS AddInventory;
    DELIMITER $$
    CREATE PROCEDURE AddInventory(IN p_item_id INT, IN p_quantity INT)
    BEGIN
        IF p_quantity > 0 THEN
            UPDATE Inventory
            SET stock_quantity = stock_quantity + p_quantity
            WHERE item_id = p_item_id;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lỗi: Số lượng vật tư nhập kho bắt buộc phải lớn hơn 0.';
        END IF;
    END $$
    DELIMITER ;