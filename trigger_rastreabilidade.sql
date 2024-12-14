DELIMITER //

CREATE TRIGGER tr_atualiza_rastreabilidade AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.status_ped <> OLD.status_ped THEN
        INSERT INTO rastreabilidade (num_pedido, status_ped, data_hora)
        VALUES (NEW.num_pedido, NEW.status_ped, NOW());
        
    END IF;
END //

DELIMITER ;
