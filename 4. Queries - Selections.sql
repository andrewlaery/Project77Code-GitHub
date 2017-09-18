-- SELECT * FROM RECORDS_MEMBERS;
-- SELECT * FROM TX_TMI_STRUCTURE0;
-- SELECT * FROM TMI_ROLES;
-- SELECT * FROM TMI_MANUALS;
-- SELECT * FROM TMI_PROJECTS;
-- SELECT * FROM RECORDS_MEMBER_UNAVAILABILITY ;
-- SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY0;
/*
SET @currentclubs = 'Corporate Toastmasters';
SET @currentmember = 'Yes';
SET @MeetingDate = '2017-08-30';
SET @Role1 = 'Speaker';
SET @Role2 = 'Toastmaster';
SET @Role3 = 'Speech Evaluator';
SET @Role4 = 'General Evaluator';
SET @Role5 = 'Table Topics Master';
SET @Role6 = 'Grammarian';
SET @Role7 = 'Ah-Counter';
SET @Role8 = 'Timer';
SET @Role9 = 'Table Topics Speaker';
SET @Limit1 = '3';
SET @Limit2 = '2';
SET @Limit3 = '5';
SET @Limit4 = '1';
SET @Limit5 = '1';
SET @Limit6 = '1';
SET @Limit7 = '1';
SET @Limit8 = '1';
SET @Limit9 = '6';
*/


-- ========================  SET UP ========================


-- Create selection forecast table to hold selections.
DROP TABLE IF EXISTS TX_FORECAST_SELECTIONS0;
CREATE TABLE TX_FORECAST_SELECTIONS0
(
		id SERIAL ,

		MembersID INT ,
		NameFull VARCHAR(255) ,
		QualificationsID INT ,
		Qualification VARCHAR(255) ,
		ProjectsID  INT ,
		Project VARCHAR(255) ,
		RolesID INT ,
		Role VARCHAR(255) ,
		ClubsID INT ,
		ItemStatus VARCHAR(255) NOT NULL DEFAULT 'forecast'	,
		ProjectDate DATE ,
		Comments VARCHAR(255) ,

		Created DATE ,
		CreatedBy VARCHAR(255) ,
		Updated DATE ,
		UpdatedBy VARCHAR(255)
);
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

-- ======================================================================================================================

-- Set key variables.
SET @currentclubs = 'Corporate Toastmasters';
SET @Club = @currentclubs;
SET @ClubsID = '2';
SET @CurrentMember = 'Yes';
SET @ProjectDate = '2017-09-13';
SET @UnavailableAllRoles = '41';




SET @Role1 = 'Speaker';
SET @RolesID = '1';

-- Create a count of how many roles a member is doing at ths forecast meeting from the Forecast Table and uses the count as a RankAdder.
-- THe SET statement solves Error 1140 and 1155.

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
SELECT * FROM TX_FORECAST_SELECTION_COUNT0;

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
SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY1;


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
SELECT * FROM TX_RECORDS_MEMBER_AVAILABLE1;


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
SELECT * FROM TX_MOSTRECENTROLE_ALLRANK0;

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
SELECT * FROM TX_MOSTRECENTROLE_AVAILABLERANK0;



DROP TABLE IF EXISTS TX_ROLESELECTION0;
CREATE TABLE TX_ROLESELECTION0
	(
		id SERIAL ,

		MembersID INT ,
		NameFull VARCHAR(255)
	);

INSERT INTO TX_ROLESELECTION0
	(
		MembersID ,
		NameFull
	)
	SELECT
		MembersID ,
    NameFull
	FROM TX_MOSTRECENTROLE_AVAILABLERANK0
    ORDER BY DateToRank
    LIMIT 3;
SELECT * FROM TX_ROLESELECTION0;

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


	-- ======================================================================================================================


	SET @Role1 = 'Toastmaster';
	SET @RolesID = '2';

	-- Create a count of how many roles a member is doing at ths forecast meeting from the Forecast Table and uses the count as a RankAdder.
	-- THe SET statement solves Error 1140 and 1155.
	-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

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
	SELECT * FROM TX_FORECAST_SELECTION_COUNT0;

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
	SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY1;


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
	SELECT * FROM TX_RECORDS_MEMBER_AVAILABLE1;


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
	SELECT * FROM TX_MOSTRECENTROLE_ALLRANK0;

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
	SELECT * FROM TX_MOSTRECENTROLE_AVAILABLERANK0;



	DROP TABLE IF EXISTS TX_ROLESELECTION0;
	CREATE TABLE TX_ROLESELECTION0
		(
			id SERIAL ,

			MembersID INT ,
			NameFull VARCHAR(255)
		);

	INSERT INTO TX_ROLESELECTION0
		(
			MembersID ,
			NameFull
		)
		SELECT
			MembersID ,
	    NameFull
		FROM TX_MOSTRECENTROLE_AVAILABLERANK0
	    ORDER BY DateToRank
	    LIMIT 3;
	SELECT * FROM TX_ROLESELECTION0;

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


SELECT * FROM TX_FORECAST_SELECTIONS0;
