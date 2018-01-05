





DROP PROCEDURE IF EXISTS P_TESTXXX;
DELIMITER //
	CREATE PROCEDURE P_TESTXXX (IN _START INTEGER , IN _LIMIT INTEGER)
		BEGIN
			PREPARE STMT FROM
				"SELECT MembersID , NameFull FROM TTX_MOSTRECENTROLE_AVAILABLERANK0 ORDER BY DateToRank LIMIT ? , ? ;" ;
  		SET @START = _START;
      SET @LIMIT = _LIMIT;
      EXECUTE STMT USING @START, @LIMIT;
      DEALLOCATE PREPARE STMT;
		END //
DELIMITER ;

SET @st1 = 0;
SET @st2 = 5;
CALL P_TESTXXX (@st1 , @st2);