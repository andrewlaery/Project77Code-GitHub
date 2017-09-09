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

-- Set key variables.
SET @currentclubs = 'Corporate Toastmasters';
SET @Club = 'Corporate Toastmasters';
SET @ClubsID = '2';
SET @currentmember = 'Yes';
SET @MeetingDate = '2017-08-30';

-- Create selection forecast table to hold selections.
DROP TABLE IF EXISTS TX_FORECAST_SELECTIONS0;
CREATE TABLE TX_FORECAST_SELECTIONS0 (id SERIAL , MembersID bigint(40) unsigned , NameFull VARCHAR(255) , RolesID bigint(40) unsigned , Role VARCHAR(255) , clubsID bigint(40) unsigned , meetingdate DATE);
SELECT * FROM TX_FORECAST_SELECTIONS0;

-- ========================================================

SET @Role1 = 'Speaker';
SET @RolesID = '1';

-- Create a member/role counter from the Forecast Table
DROP TEMPORARY TABLE IF EXISTS TX_TX_FORECAST_SELECTION_COUNT0;
CREATE TEMPORARY TABLE TX_TX_FORECAST_SELECTION_COUNT0 AS
	SELECT
        MembersID ,
        NameFull ,
        COUNT(*)*100000000 AS RankAdder
    FROM TX_FORECAST_SELECTIONS0
    WHERE
        (ClubsID = @ClubsID)
        AND (meetingdate = @MeetingDate)
    GROUP BY NameFull;
SELECT * FROM TX_TX_FORECAST_SELECTION_COUNT0;

-- Lists members who are UNAVAILABILE for this meeting for this role.
DROP TEMPORARY TABLE IF EXISTS TX_RECORDS_MEMBER_UNAVAILABILITY1;
CREATE TEMPORARY TABLE TX_RECORDS_MEMBER_UNAVAILABILITY1 AS
	SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY0
	WHERE
		StartDate <= @MeetingDate
		AND  EndDate >= @MeetingDate
		AND (RolesID = '41' OR Role = @Role1);
SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY1;

-- Lists members who are AVAILABILE for this meeting for this role.
DROP TEMPORARY TABLE IF EXISTS TX_RECORDS_MEMBER_AVAILABLE1;
CREATE TEMPORARY TABLE TX_RECORDS_MEMBER_AVAILABLE1 AS
	SELECT
		MembersID ,
        NameFull
	FROM TX_ALLMEMBERS0
	WHERE
		currentclubs = @currentclubs
		AND currentmember = @currentmember
		AND (NameFull NOT IN (SELECT NameFull FROM TX_RECORDS_MEMBER_UNAVAILABILITY1));
SELECT * FROM TX_RECORDS_MEMBER_AVAILABLE1;

-- Lists ALL members for this role, ranked by date.
DROP TEMPORARY TABLE IF EXISTS TX_MOSTRECENTROLE_ALLRANK0;
CREATE TEMPORARY TABLE TX_MOSTRECENTROLE_ALLRANK0 AS
	SELECT
		TX_MOSTRECENTROLE0.MembersID AS MembersID ,
        TX_MOSTRECENTROLE0.NameFull AS NameFull ,
        TX_MOSTRECENTROLE0.Club AS Club ,
		TX_MOSTRECENTROLE0.Date1 AS Date1 ,
        IFNULL(TX_TX_FORECAST_SELECTION_COUNT0.RankAdder,'1') AS RankAdder ,
        TX_MOSTRECENTROLE0.Date1 + IFNULL(TX_TX_FORECAST_SELECTION_COUNT0.RankAdder,'1') AS DateToRank
	FROM TX_MOSTRECENTROLE0
    LEFT JOIN TX_TX_FORECAST_SELECTION_COUNT0 ON TX_TX_FORECAST_SELECTION_COUNT0.MembersID = TX_MOSTRECENTROLE0.MembersID
	WHERE
		Role = @Role1
		AND Club = @Club
    ORDER BY DateToRank;
SELECT * FROM TX_MOSTRECENTROLE_ALLRANK0;

-- Lists members who are AVAILABILE for this meeting for this role, ranked by date.
DROP TEMPORARY TABLE IF EXISTS TX_MOSTRECENTROLE_AVAILABLERANK0;
CREATE TEMPORARY TABLE TX_MOSTRECENTROLE_AVAILABLERANK0 AS
	SELECT
		TX_RECORDS_MEMBER_AVAILABLE1.MembersID AS MembersID ,
        TX_RECORDS_MEMBER_AVAILABLE1.NameFull AS NameFull ,
        TX_MOSTRECENTROLE_ALLRANK0.Date1 AS Date1 ,
        TX_MOSTRECENTROLE_ALLRANK0.RankAdder AS RankAdder ,
        TX_MOSTRECENTROLE_ALLRANK0.Date1 + TX_MOSTRECENTROLE_ALLRANK0.RankAdder AS DateToRank
	FROM TX_RECORDS_MEMBER_AVAILABLE1
	LEFT JOIN TX_MOSTRECENTROLE_ALLRANK0 ON TX_RECORDS_MEMBER_AVAILABLE1.NameFull = TX_MOSTRECENTROLE_ALLRANK0.NameFull
	ORDER BY DateToRank , NameFull;
SELECT * FROM TX_MOSTRECENTROLE_AVAILABLERANK0;

DROP TEMPORARY TABLE IF EXISTS TX_ROLESELECTION0;
CREATE TEMPORARY TABLE TX_ROLESELECTION0 AS
	SELECT
		MembersID ,
    NameFull
	FROM TX_MOSTRECENTROLE_AVAILABLERANK0
    ORDER BY DateToRank
    LIMIT 3;
SELECT * FROM TX_ROLESELECTION0;

INSERT INTO TX_FORECAST_SELECTIONS0 (MembersID , NameFull , RolesID , Role, clubsID , meetingdate)
	SELECT
		MembersID AS MembersID,
		NameFull as NameFull,
		@RolesID AS RolesID,
		@Role1 AS Role,
		@ClubsID AS ClubsID,
		@MeetingDate AS MeetingDate
	FROM TX_ROLESELECTION0;

SELECT * FROM TX_FORECAST_SELECTIONS0;
