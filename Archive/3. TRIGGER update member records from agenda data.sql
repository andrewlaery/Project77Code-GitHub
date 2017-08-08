/*========================================================================================
CREATE A TRIGGER TO UPDATE MEMBER RECORDS ON UPDATING AGENDA DATA
=========================================================================================*/

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS trg_agenda_to_records;
DELIMITER //
	CREATE TRIGGER trg_agenda_to_records AFTER INSERT ON data_agendas FOR EACH ROW
	BEGIN
		INSERT INTO records_projects (membersID , qualificationsID , projectsID , rolesID , itemstatus , projectdate, createdby , created)
		VALUES (new.membersID , new.qualificationsID , new.projectsID , new.rolesID , new.itemstatus , new.meetingdate , 'a_to_r_trigger' , now());	
	END//
DELIMITER ;


/*========================================================================================
DELETE INSERTED ROWS CREATED BY THE TRIGGER ABOVE
=========================================================================================*/

/*
SET SQL_SAFE_UPDATES=0;
SELECT * FROM  records_projects;
DELETE FROM records_projects WHERE createdby = 'a_to_r_trigger';
SELECT * FROM  records_projects;
SET SQL_SAFE_UPDATES=1;
*/