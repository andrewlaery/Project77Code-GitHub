


SET @Role = 'General Evaluator';

DELIMITER //
	CREATE PROCEDURE P_TEST()
		BEGIN
			SELECT
				  MembersID ,
				  NameFull ,
				  Track ,
				  QualificationsID ,
				  QualificationsOrder ,
				  Qualification ,
				  ManualGroupsOrder ,
				  ManualGroup ,
				  ManualsOrder ,
				  Manual ,
				  ProjectsOrder ,
				  ProjectsID ,
				  Project ,
				  Role ,
				  Date1 ,
				  QualificationStatus
			  FROM V_MOSTRECENTPROJECT0
              WHERE Role = @Role
			  ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
		END //
DELIMITER ;

CALL P_TEST;

DROP PROCEDURE P_TEST;
