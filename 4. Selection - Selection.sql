
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



-- ======================================================================================================================

SET @Role1 = 'Speaker';
SET @RolesID = '1';
SET @st1 = 0;
SET @st2 = 3;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;



SET @Role1 = 'Toastmaster';
SET @RolesID = '2';
SET @st1 = 0;
SET @st2 = 2;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Speech Evaluator';
SET @RolesID = '3';
SET @st1 = 0;
SET @st2 = 3;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'General Evaluator';
SET @RolesID = '4';
SET @st1 = 0;
SET @st2 = 1;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Table Topics Master';
SET @RolesID = '5';
SET @st1 = 0;
SET @st2 = 1;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Grammarian';
SET @RolesID = '6';
SET @st1 = 0;
SET @st2 = 1;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Ah-Counter';
SET @RolesID = '7';
SET @st1 = 0;
SET @st2 = 1;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Timer';
SET @RolesID = '8';
SET @st1 = 0;
SET @st2 = 1;
CALL P_SELECTIONS0 ();
-- SELECT * FROM TX_FORECAST_SELECTIONS0;

SET @Role1 = 'Table Topiocs Speaker';
SET @RolesID = '9';
SET @st1 = 0;
SET @st2 = 10;
CALL P_SELECTIONS0 ();
SELECT * FROM TX_FORECAST_SELECTIONS0;
