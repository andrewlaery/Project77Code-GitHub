-- Role Selector procedure.


DROP PROCEDURE IF EXISTS P_SELECTIONS1;
DELIMITER //
	CREATE PROCEDURE P_SELECTIONS1 (IN _START INTEGER , IN _LIMIT INTEGER)
		BEGIN
			PREPARE STMT FROM
				"INSERT INTO TX_ROLESELECTION0 ( MembersID , NameFull ) SELECT MembersID , NameFull FROM TX_MOSTRECENTROLE_AVAILABLERANK0 ORDER BY DateToRank LIMIT ? , ? ;" ;
  		SET @START = _START;
      SET @LIMIT = _LIMIT;
      EXECUTE STMT USING @START, @LIMIT;
      DEALLOCATE PREPARE STMT;
		END //
DELIMITER ;


-- =================================================================


DROP PROCEDURE IF EXISTS P_SELECTIONS0;

DELIMITER //
CREATE PROCEDURE P_SELECTIONS0 ()
BEGIN



	SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
	DROP TABLE IF EXISTS TX_FORECAST_SELECTION_COUNT0;
	CREATE TABLE TX_FORECAST_SELECTION_COUNT0
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255),
			RankAdder INT
		);

	INSERT INTO TX_FORECAST_SELECTION_COUNT0
		(
			MembersID ,
			NameFull ,
			RankAdder
		)
		SELECT
	        MembersID ,
	        NameFull ,
	        COUNT(*)*100000000 AS RankAdder
	    FROM TX_FORECAST_SELECTIONS0
	    WHERE
	        (ClubsID = @ClubsID)
	        AND (ProjectDate = @ProjectDate)
					AND ItemStatus <> 'Actual'
	    GROUP BY NameFull;
	-- SELECT * FROM TX_FORECAST_SELECTION_COUNT0;

	-- Lists members who are UNAVAILABILE for this meeting for this role.

	DROP TABLE IF EXISTS TX_RECORDS_MEMBER_UNAVAILABILITY1;
	CREATE TABLE TX_RECORDS_MEMBER_UNAVAILABILITY1
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255) ,
			RolesID INT ,
			Role VARCHAR(255) ,
			StartDate DATE ,
			EndDate DATE ,
			Notes VARCHAR(255) ,
			NameFull_Role VARCHAR(255) ,
			NameFull_RoleID VARCHAR(255)
		);

	INSERT INTO TX_RECORDS_MEMBER_UNAVAILABILITY1
		(
			MembersID ,
			NameFull ,
			RolesID ,
			Role ,
			StartDate ,
			EndDate ,
			Notes ,
			NameFull_Role ,
			NameFull_RoleID
		)
		SELECT
			MembersID ,
			NameFull ,
			RolesID ,
			Role ,
			StartDate ,
			EndDate ,
			Notes ,
			NameFull_Role ,
			NameFull_RoleID
		 FROM TX_RECORDS_MEMBER_UNAVAILABILITY0
			WHERE
				StartDate <= @ProjectDate
				AND  EndDate >= @ProjectDate
				AND (RolesID = @UnavailableAllRoles OR Role = @Role1);
	-- SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY1;


	-- Lists members who are AVAILABILE for this meeting for this role.

	DROP TABLE IF EXISTS TX_RECORDS_MEMBER_AVAILABLE1;
	CREATE TABLE TX_RECORDS_MEMBER_AVAILABLE1
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255)
		);

	INSERT INTO TX_RECORDS_MEMBER_AVAILABLE1
		(
			MembersID ,
			NameFull
		)
		SELECT
			MembersID ,
			NameFull
		FROM TX_ALLMEMBERS0
		WHERE
			Currentclubs = @CurrentClubs
			AND CurrentMember = @CurrentMember
			AND (NameFull NOT IN (SELECT NameFull FROM TX_RECORDS_MEMBER_UNAVAILABILITY1));
	-- SELECT * FROM TX_RECORDS_MEMBER_AVAILABLE1;


	-- Lists ALL members for this role, ranked by date.

	DROP TABLE IF EXISTS TX_MOSTRECENTROLE_ALLRANK0;
	CREATE TABLE TX_MOSTRECENTROLE_ALLRANK0
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255) ,
			Club VARCHAR(255) ,
			Date1 Date ,
			RankAdder INT ,
			DateToRank INT
		);

	INSERT INTO TX_MOSTRECENTROLE_ALLRANK0
		(
			MembersID ,
			NameFull ,
			Club ,
			Date1 ,
			RankAdder ,
			DateToRank
		)
		SELECT
			TX_CURRENTMEMBERS1.MembersID AS MembersID ,
			TX_CURRENTMEMBERS1.NameFull AS NameFull ,
			TX_CURRENTMEMBERS1.CurrentClub AS Club ,
			IFNULL(TX_MOSTRECENTROLE1.Date1,'1900-01-01') AS Date1 ,
			IFNULL(TX_FORECAST_SELECTION_COUNT0.RankAdder,'1') AS RankAdder ,
			IFNULL(TX_MOSTRECENTROLE1.Date1 + IFNULL(TX_FORECAST_SELECTION_COUNT0.RankAdder,'1'),'1') AS DateToRank
		FROM TX_CURRENTMEMBERS1
		LEFT JOIN TX_MOSTRECENTROLE1 ON CONCAT(TX_MOSTRECENTROLE1.NameFull, ' - ' , Role) = CONCAT(TX_CURRENTMEMBERS1.NameFull, ' - ' , @Role1)
		LEFT JOIN TX_FORECAST_SELECTION_COUNT0 ON TX_FORECAST_SELECTION_COUNT0.MembersID = TX_CURRENTMEMBERS1.MembersID
		-- WHERE
			-- Role = @Role1
			-- AND Club = @Club
		ORDER BY DateToRank , NameFull;
	-- SELECT * FROM TX_MOSTRECENTROLE_ALLRANK0;

	-- Lists members who are AVAILABILE for this meeting for this role, ranked by date.

	DROP TABLE IF EXISTS TX_MOSTRECENTROLE_AVAILABLERANK0;
	CREATE TABLE TX_MOSTRECENTROLE_AVAILABLERANK0
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255) ,
			Date1 Date ,
			RankAdder INT ,
			DateToRank INT
		);

	INSERT INTO TX_MOSTRECENTROLE_AVAILABLERANK0
		(
			MembersID ,
			NameFull ,
			Date1 ,
			RankAdder ,
			DateToRank
		)
		SELECT
			TX_RECORDS_MEMBER_AVAILABLE1.MembersID AS MembersID ,
			TX_RECORDS_MEMBER_AVAILABLE1.NameFull AS NameFull ,
			TX_MOSTRECENTROLE_ALLRANK0.Date1 AS Date1 ,
			TX_MOSTRECENTROLE_ALLRANK0.RankAdder AS RankAdder ,
			TX_MOSTRECENTROLE_ALLRANK0.Date1 + TX_MOSTRECENTROLE_ALLRANK0.RankAdder AS DateToRank
		FROM TX_RECORDS_MEMBER_AVAILABLE1
		LEFT JOIN TX_MOSTRECENTROLE_ALLRANK0 ON TX_MOSTRECENTROLE_ALLRANK0.NameFull = TX_RECORDS_MEMBER_AVAILABLE1.NameFull
		ORDER BY DateToRank , NameFull;
	-- SELECT * FROM TX_MOSTRECENTROLE_AVAILABLERANK0;



	DROP TABLE IF EXISTS TX_ROLESELECTION0;
	CREATE TABLE TX_ROLESELECTION0
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255)
		);

	CALL P_SELECTIONS1 (@st1 , @st2);


	-- Insert results in to forecast table.
	INSERT INTO TX_FORECAST_SELECTIONS0
		(
			MembersID ,
			NameFull ,
			RolesID ,
			Role,
			clubsID ,
			ProjectDate
		)
		SELECT
			MembersID AS MembersID,
			NameFull as NameFull,
			@RolesID AS RolesID,
			@Role1 AS Role,
			@ClubsID AS ClubsID,
			@ProjectDate AS ProjectDate
		FROM TX_ROLESELECTION0;

END //
DELIMITER ;
