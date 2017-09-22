

-- ======================================================================================================================

-- Set key variables.
SET @currentclubs = 'Corporate Toastmasters';
SET @Club = @currentclubs;
SET @ClubsID = '2';
SET @CurrentMember = 'Yes';
SET @ProjectDate = '2017-09-27';
SET @UnavailableAllRoles = '41';
SET @ItemStatus = 'Forecast';

-- ======================================================================================================================

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

INSERT INTO TX_FORECAST_SELECTIONS0
		(
			MembersID ,
			QualificationsID ,
			ProjectsID ,
			RolesID ,
			ClubsID ,
			ItemStatus ,
			ProjectDate ,
			Comments
		)
		SELECT
			MembersID ,
			QualificationsID ,
			ProjectsID ,
			RolesID ,
			ClubsID ,
			ItemStatus ,
			ProjectDate ,
			Comments
		FROM RECORDS_PROJECTS
		WHERE ItemStatus <> 'Actual'
		AND ProjectDate = @ProjectDate
		AND ClubsID = @ClubsID;

SET SQL_SAFE_UPDATES = 0;
	UPDATE TX_FORECAST_SELECTIONS0
		INNER JOIN RECORDS_MEMBERS ON TX_FORECAST_SELECTIONS0.membersID = RECORDS_MEMBERS.id
		SET TX_FORECAST_SELECTIONS0.NameFull = CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast);
SET SQL_SAFE_UPDATES = 1;


-- ======================================================================================================================

SET @Role1 = 'Speaker';
SET @RolesID = '1';
SET @st1 = 0;
SET @st2 = 3 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '1');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;



SET @Role1 = 'Toastmaster';
SET @RolesID = '2';
SET @st1 = 0;
SET @st2 = 2 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '2');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Speech Evaluator';
SET @RolesID = '3';
SET @st1 = 0;
SET @st2 = 3 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '3');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'General Evaluator';
SET @RolesID = '4';
SET @st1 = 0;
SET @st2 = 1 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '4');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Table Topics Master';
SET @RolesID = '5';
SET @st1 = 0;
SET @st2 = 1 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '5');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Grammarian';
SET @RolesID = '6';
SET @st1 = 0;
SET @st2 = 1 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '6');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Ah-Counter';
SET @RolesID = '7';
SET @st1 = 0;
SET @st2 = 1 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '7');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Timer';
SET @RolesID = '8';
SET @st1 = 0;
SET @st2 = 1 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '8');
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Table Topiocs Speaker';
SET @RolesID = '9';
SET @st1 = 0;
SET @st2 = 10 - (SELECT COUNT(*) FROM TX_FORECAST_SELECTIONS0 WHERE RolesID = '9');
CALL P_SELECTIONS0 ();


SET SQL_SAFE_UPDATES = 0;
	UPDATE TX_FORECAST_SELECTIONS0
		INNER JOIN TMI_ROLES ON TMI_ROLES.id = TX_FORECAST_SELECTIONS0.RolesID
		SET TX_FORECAST_SELECTIONS0.Role = TMI_ROLES.Role
		WHERE TX_FORECAST_SELECTIONS0.Role IS NULL;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM TX_FORECAST_SELECTIONS0;
