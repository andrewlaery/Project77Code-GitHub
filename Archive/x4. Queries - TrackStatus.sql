-- QUALIFICATION STATUS

-- SET UP VARIABLES

SET @NameFull = 'Natalie Hayter';

-- SET UP VIEW

-- Shows what TMI international indicates if the current status of a member.
DROP TEMPORARY TABLE IF EXISTS TX_MEMBER_TMIQUALIFICATIONS0;
CREATE TEMPORARY TABLE TX_MEMBER_TMIQUALIFICATIONS0 AS
  SELECT
  	-- NameFull ,
      Qualification ,
      QualificationStatus
  FROM TX_QUALIFICATIONS0
  WHERE NameFull = @NameFull
  ORDER BY QualificationsOrder;
SELECT * FROM TX_MEMBER_TMIQUALIFICATIONS0;

-- Creates a view of all most recent projects. Could refer directly to the underlying table. ALL MEMBERS, ALL QUALIFICATIONS.
DROP TEMPORARY TABLE IF EXISTS TX_MEMBER_MOSTRECENTPROJECT0;
CREATE TEMPORARY TABLE TX_MEMBER_MOSTRECENTPROJECT0 AS
  SELECT
      MembersID ,
      NameFull ,
      Track ,
      QualificationsID ,
      QualificationsOrder ,
      Qualification ,
      ManualGroupsOrder ,
      ManualGroup ,
      ManualsID ,
      ManualsOrder ,
      Manual ,
      ProjectsOrder ,
      ProjectsID ,
      Project ,
      Role ,
      Date1 ,
      QualificationStatus
  FROM TX_MOSTRECENTPROJECT0
  -- WHERE
    -- (QualificationStatus = 'In progress' OR QualificationStatus = 'Completed')
    -- AND Qualification <> 'No qualification'
    -- AND Role <> 'No role'
  ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
-- SELECT * FROM TX_MEMBER_MOSTRECENTPROJECT0;

DROP TEMPORARY TABLE IF EXISTS TX_MEMBER_MOSTRECENTPROJECT1;
CREATE TEMPORARY TABLE TX_MEMBER_MOSTRECENTPROJECT1 AS
  SELECT
    Qualification ,
    Manual ,
    Project ,
    Role ,
    Date1
  FROM TX_MEMBER_MOSTRECENTPROJECT0
  WHERE
    NameFull = @NameFull
    AND (QualificationStatus = 'In progress' OR QualificationStatus = 'Completed')
    AND Qualification <> 'No qualification'
    AND Role <> 'No role'
  ORDER BY QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_MEMBER_MOSTRECENTPROJECT1;



-- --------- COMMUNICATION TRACKS --------------

-- 1) COMPETENT COMMUNICATOR: Requires all 10 speeches to be complted.

-- CREATE TEMPORARY TABLE of all Competent Communicator speeches.
DROP TEMPORARY TABLE IF EXISTS TX_CC_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_CC_PROJECT_STATUS0 AS
  SELECT *
  FROM TX_MEMBER_MOSTRECENTPROJECT0
  WHERE
    NameFull = @NameFull
    AND QualificationsID = '1'
    AND QualificationStatus = 'In progress'
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
-- SELECT * FROM TX_CC_PROJECT_STATUS0;

-- COMPETENT COMMUNICATOR (CC): Percent Complete

-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_CC_PROJECT_STATUS_PCENT0_SETUP1;
CREATE TEMPORARY TABLE TX_CC_PROJECT_STATUS_PCENT0_SETUP1 AS
	SELECT
		(SELECT QualificationsID FROM TX_MEMBER_MOSTRECENTPROJECT0 WHERE QualificationsID = '1' GROUP BY QualificationsID) AS QualificationsID;
-- SELECT * FROM TX_CC_PROJECT_STATUS_PCENT0_SETUP1;

-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_CC_PROJECT_STATUS_PCENT0_SETUP2;
CREATE TEMPORARY TABLE TX_CC_PROJECT_STATUS_PCENT0_SETUP2 AS
	SELECT
		(SELECT Qualification FROM TX_MEMBER_MOSTRECENTPROJECT0 WHERE QualificationsID = '1' GROUP BY Qualification) AS Qualification ;
-- SELECT * FROM TX_CC_PROJECT_STATUS_PCENT0_SETUP2;

-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_CC_PROJECT_STATUS_PCENT0_SETUP3;
CREATE TEMPORARY TABLE TX_CC_PROJECT_STATUS_PCENT0_SETUP3 AS
	SELECT
		(SELECT COUNT(*)/10 FROM TX_MEMBER_MOSTRECENTPROJECT0 WHERE NameFull = @NameFull AND QualificationsID = '1' AND QualificationStatus = 'In progress') AS Percentage;
-- SELECT * FROM TX_CC_PROJECT_STATUS_PCENT0_SETUP3;

-- Aggregate table from above queries
DROP TEMPORARY TABLE IF EXISTS TX_CC_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_CC_PROJECT_STATUS_PCENT0 AS
	SELECT
			TX_CC_PROJECT_STATUS_PCENT0_SETUP1.QualificationsID ,
			TX_CC_PROJECT_STATUS_PCENT0_SETUP2.Qualification ,
			TX_CC_PROJECT_STATUS_PCENT0_SETUP3.Percentage
	FROM TX_CC_PROJECT_STATUS_PCENT0_SETUP1
	CROSS JOIN TX_CC_PROJECT_STATUS_PCENT0_SETUP2
	CROSS JOIN TX_CC_PROJECT_STATUS_PCENT0_SETUP3;
SELECT * FROM TX_CC_PROJECT_STATUS_PCENT0;


-- 2) ADVANCED COMMUNICATOR BRONZE (ACB): Requires CC Qualification and 2 AC Manuals to be completed.

-- TEST FOR THE COMPLETION OF THE COMPETENT COMMUNICATOR QUALIFICATION FROM THE QUALIFICATIONS TABLE
-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_ACB_CC_STATUS_SETUP1;
CREATE TEMPORARY TABLE TX_ACB_CC_STATUS_SETUP1 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS QualificationsID;
-- SELECT * FROM TX_ACB_CC_STATUS_SETUP1;

-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_ACB_CC_STATUS_SETUP2;
CREATE TEMPORARY TABLE TX_ACB_CC_STATUS_SETUP2 AS
	SELECT
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS Qualification;
-- SELECT * FROM TX_ACB_CC_STATUS_SETUP2;

-- Setup table
DROP TEMPORARY TABLE IF EXISTS TX_ACB_CC_STATUS_SETUP3;
CREATE TEMPORARY TABLE TX_ACB_CC_STATUS_SETUP3 AS
	SELECT
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1' AND QualificationDate > '1900-01-01 00:00:00' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
-- SELECT * FROM TX_ACB_CC_STATUS_SETUP3;

-- Aggregate table from above queries
DROP TEMPORARY TABLE IF EXISTS TX_ACB_CC_STATUS0;
CREATE TEMPORARY TABLE TX_ACB_CC_STATUS0 AS
	SELECT * FROM TX_ACB_CC_STATUS_SETUP1
  CROSS JOIN TX_ACB_CC_STATUS_SETUP2
  CROSS JOIN TX_ACB_CC_STATUS_SETUP3;
-- SELECT * FROM TX_ACB_CC_STATUS0;

-- Creates a view of the current Advanced Communictor Bronze projects for each member.
DROP TEMPORARY TABLE IF EXISTS TX_ACB_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_ACB_PROJECT_STATUS0 AS
	SELECT *
	FROM TX_MEMBER_MOSTRECENTPROJECT0
	WHERE
		NameFull = @NameFull
		AND QualificationsID = '2'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
-- SELECT * FROM TX_ACB_PROJECT_STATUS0;

-- Shows the percentage of each manual completed (limited to the top 2 manuals)
DROP TEMPORARY TABLE IF EXISTS TX_ACB_AC_MANUAL_STATUS_PCENT1;
CREATE TEMPORARY TABLE TX_ACB_AC_MANUAL_STATUS_PCENT1 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM TX_ACB_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Bronze' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
-- SELECT * FROM TX_ACB_AC_MANUAL_STATUS_PCENT1;

-- Combines the manuals to provide a percentage completed for the Advanced Communicator part of the ACB
DROP TEMPORARY TABLE IF EXISTS TX_ACB_AC_PROJECT_STATUS_PCENT1;
CREATE TEMPORARY TABLE TX_ACB_AC_PROJECT_STATUS_PCENT1 AS
	SELECT
		'Advanced Communicator' AS Requirement ,
		(SELECT (SUM(Countx) / '2') FROM TX_ACB_AC_MANUAL_STATUS_PCENT1) AS ProjectsCompleted;
-- SELECT * FROM TX_ACB_AC_PROJECT_STATUS_PCENT1;

DROP TEMPORARY TABLE IF EXISTS TX_ACB_SUMMARY0;
CREATE TEMPORARY TABLE TX_ACB_SUMMARY0 AS
	SELECT Qualification , ProjectComplete FROM TX_ACB_CC_STATUS0
	UNION
	SELECT * FROM TX_ACB_AC_PROJECT_STATUS_PCENT1;
SELECT * FROM TX_ACB_SUMMARY0;


-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


-- 3) ADVANCED COMMUNICATOR SILVER (ACS)
-- Requires Advanced Communicator Bronze (ACB), 2 completed AC manuals (10 speeches), and 2 completed manuals from BSS or SCS (2 speeches)


-- Creates a view of the completion of the Advanced Communicator Bronze Qualification from the Qualification Table.
DROP TEMPORARY TABLE IF EXISTS TX_ACS_ACB_STATUS0;
CREATE TEMPORARY TABLE TX_ACS_ACB_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '2'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '2'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '2' AND QualificationDate > '0' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM TX_ACS_ACB_STATUS0;

-- Creates a view of all Advanced Communicator Silver speeches
DROP TEMPORARY TABLE IF EXISTS TX_ACS_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_ACS_PROJECT_STATUS0 AS
	SELECT *
	FROM TX_MEMBER_MOSTRECENTPROJECT0
	WHERE
		NameFull = @NameFull
		AND QualificationsID = '3'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_ACS_PROJECT_STATUS0;

-- Counts the top 2 AC Manuals and the % complete
DROP TEMPORARY TABLE IF EXISTS TX_ACS_AC_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ACS_AC_PROJECT_STATUS_PCENT0 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM TX_ACS_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Silver' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ACS_AC_PROJECT_STATUS_PCENT0;

-- Counts top 2 BSS SCS Manuals and the % complete
DROP TEMPORARY TABLE IF EXISTS TX_ACS_BSSSCS_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ACS_BSSSCS_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM TX_ACS_PROJECT_STATUS0 WHERE (ManualGroup = 'Better Speaker Series' OR ManualGroup = 'Successful Club Series') GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ACS_BSSSCS_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM TX_ACS_ACB_STATUS0
UNION
SELECT
	'Advanced Communicator' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM TX_ACS_AC_PROJECT_STATUS_PCENT0) >= '1' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACS_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'BSS or SCS' AS Requirement ,
    IF((SELECT SUM(Countx) FROM TX_ACS_BSSSCS_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACS_BSSSCS_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted;



-- 4) ADVANCED COMMUNICATOR GOLD (ACG)
-- Requires Advanced Communicator Silver (ACS), 2 completed AC manuals (10 speeches), 1 completed manuals from SL or SC (1 speeches), and coach a member to CC#3


-- Creates a view of the completion of the Advanced Communicator Bronze Qualification from the Qualification Table.
DROP TEMPORARY TABLE IF EXISTS TX_ACG_ACS_STATUS0;
CREATE TEMPORARY TABLE TX_ACG_ACS_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '3'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '3'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '3' AND QualificationDate > '0' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM TX_ACG_ACS_STATUS0;

-- Creates a view of all Advanced Communicator Gold speeches
DROP TEMPORARY TABLE IF EXISTS TX_ACG_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_ACG_PROJECT_STATUS0 AS
	SELECT *
	FROM TX_MEMBER_MOSTRECENTPROJECT0
	WHERE
		NameFull = @NameFull
		AND QualificationsID = '4'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_ACG_PROJECT_STATUS0;

-- Counts the top 2 AC Manuals and the % complete
DROP TEMPORARY TABLE IF EXISTS TX_ACG_AC_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ACG_AC_PROJECT_STATUS_PCENT0 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM TX_ACG_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ACG_AC_PROJECT_STATUS_PCENT0;

-- Counts top 2 BSS SCS Manuals and the % complete
DROP TEMPORARY TABLE IF EXISTS TX_ACG_SCSL_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ACG_SCSL_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM TX_ACG_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND (ManualGroup = 'Success Communication' OR ManualGroup = 'Success Leadership') GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ACG_SCSL_PROJECT_STATUS_PCENT0;

-- Counts if member has completed the Mentor a newbie to CC3
DROP TEMPORARY TABLE IF EXISTS TX_ACG_OTHER_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ACG_OTHER_PROJECT_STATUS_PCENT0 AS
  SELECT Project , COUNT(*) AS Countx FROM TX_ACG_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND ProjectsID = '181' GROUP BY Project ORDER BY Countx DESC Limit 1;
SELECT * FROM TX_ACG_OTHER_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM TX_ACG_ACS_STATUS0
UNION
SELECT
	'Advanced Communicator' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM TX_ACG_AC_PROJECT_STATUS_PCENT0) >= '1' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACG_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'SC or SL' AS Requirement ,
  IF((SELECT SUM(Countx) FROM TX_ACG_SCSL_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACG_SCSL_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'Coach a member to CC3' AS Requirement ,
  IF((SELECT SUM(Countx) FROM TX_ACG_OTHER_PROJECT_STATUS_PCENT0) >= '1' , 1 , 0) AS ProjectsCompleted;



-- --------- LEADERSHIP TRACKS --------------

-- 1) COMPETENT LEADER
-- (a) Creates a structure, (b) addes project completion dates, (c) filters to specific member, (d) tests each project progress

-- Creates the Competent Leader Structure and adds Current Members  to form a Matrix
DROP TEMPORARY TABLE IF EXISTS TX_CL_STRUCTURE_MEMBERS0;
CREATE TEMPORARY TABLE TX_CL_STRUCTURE_MEMBERS0 AS
	SELECT
    TX_TMI_STRUCTURE0.QualificationsID AS QualificationsID ,
    TX_TMI_STRUCTURE0.QualificationsOrder AS QualificationsOrder ,
    TX_TMI_STRUCTURE0.Qualification AS Qualification,
    SUBSTRING(TX_TMI_STRUCTURE0.ProjectsOrder, 1, LOCATE ('.' , TX_TMI_STRUCTURE0.ProjectsOrder)-1) AS ProjectsGroup ,
    SUBSTRING(TX_TMI_STRUCTURE0.Project, 1, LOCATE (':' , TX_TMI_STRUCTURE0.Project)-1) AS ProjectGroup,
    TX_TMI_STRUCTURE0.ProjectsID AS ProjectsID ,
    TX_TMI_STRUCTURE0.ProjectsOrder AS ProjectsOrder ,
    TX_TMI_STRUCTURE0.Project AS Project ,
    TX_TMI_STRUCTURE0.RolesID AS RolesID ,
    TX_TMI_STRUCTURE0.RolesOrder AS RolesOrder ,
    TX_TMI_STRUCTURE0.Role AS Role,
    RECORDS_MEMBERS.id AS MembersID,
    CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
    CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TX_TMI_STRUCTURE0.ProjectsID) AS NameFull_ProjectsID
	FROM TX_TMI_STRUCTURE0
	CROSS JOIN RECORDS_MEMBERS
	WHERE
		(TX_TMI_STRUCTURE0.QualificationsID = '5')
    AND (RECORDS_MEMBERS.currentmember = 'Yes');
-- SELECT * FROM TX_CL_STRUCTURE_MEMBERS0;

-- Add's completed project dates to the above CL Strcuture to Members matrix
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS0;
CREATE TEMPORARY TABLE TX_CL_STATUS0 AS
	SELECT
		TX_CL_STRUCTURE_MEMBERS0.QualificationsID ,
		TX_CL_STRUCTURE_MEMBERS0.QualificationsOrder ,
		TX_CL_STRUCTURE_MEMBERS0.Qualification ,
		TX_CL_STRUCTURE_MEMBERS0.ProjectsGroup ,
		TX_CL_STRUCTURE_MEMBERS0.ProjectGroup ,
    TX_CL_STRUCTURE_MEMBERS0.ProjectsID ,
		TX_CL_STRUCTURE_MEMBERS0.ProjectsOrder ,
		TX_CL_STRUCTURE_MEMBERS0.Project ,
		TX_CL_STRUCTURE_MEMBERS0.RolesID ,
		TX_CL_STRUCTURE_MEMBERS0.RolesOrder ,
		TX_CL_STRUCTURE_MEMBERS0.Role ,
		TX_CL_STRUCTURE_MEMBERS0.MembersID ,
		TX_CL_STRUCTURE_MEMBERS0.NameFull ,
		TX_CL_STRUCTURE_MEMBERS0.NameFull_ProjectsID ,
		TX_MOSTRECENTPROJECT0.Date1
	FROM TX_CL_STRUCTURE_MEMBERS0
	LEFT JOIN TX_MOSTRECENTPROJECT0 ON TX_MOSTRECENTPROJECT0.NameFull_ProjectsID = TX_CL_STRUCTURE_MEMBERS0.NameFull_ProjectsID
	ORDER BY membersID , QualificationsOrder , ProjectsOrder , RolesOrder;
-- SELECT * FROM TX_CL_STATUS0;

-- Filters the above to a specific member.
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS1;
CREATE TEMPORARY TABLE TX_CL_STATUS1 AS
  SELECT * FROM TX_CL_STATUS0
  WHERE NameFull = @NameFull;
-- SELECT * FROM TX_CL_STATUS1;

-- CL Project 1 query: Complete 3 of 4 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT1;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT1 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '1' ) >= '3' , '1' , '0') AS ProjectComplete;

-- CL Project 2 query: Complete 2 of 3 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT2;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT2 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '2' ) >= '2', '1' , '0') AS ProjectComplete;

-- CL Project 3 query: Complete 3 of 3 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT3;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT3 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '3' ) >= '3', '1' , '0') AS ProjectComplete;

-- CL Project 4 query: Complete Timer +1
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT4;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT4 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF (
			(SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsID = '162' ) >= '1'
			AND
			(SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '4' AND ProjectsID <> '162' ) >= '1' , '1' , '0') AS ProjectComplete;

-- CL Project 5 query: Complete 3 of 4 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT5;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT5 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '5' ) >= '3', '1' , '0') AS ProjectComplete;

-- CL Project 6 query: Complete 1 of 6 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT6;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT6 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '6' ) >= '1', '1' , '0') AS ProjectComplete;

-- CL Project 7 query: Complete 2 of 4 projects
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT7;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT7 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '7' ) >= '2', '1' , '0') AS ProjectComplete;

-- CL Project 8 query: Complete 1 Chair plus 2 others
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT8;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT8 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF(
			(SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND (ProjectsID = '137' OR ProjectsID = '138' )) >= '1'
			AND
			(SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '8' AND ProjectsID <> '137' AND ProjectsID <> '138' ) >= '2' , '1' , '0') AS ProjectComplete;

-- CL Project 9 query: Complete 1 of 3
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT9;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT9 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '9' ) >= '1', '1' , '0') AS ProjectComplete;

-- CL Project 10 query: Complete Toastmaster or General Evaluator, or one of the other projects.
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS_PROJECT10;
CREATE TEMPORARY TABLE TX_CL_STATUS_PROJECT10 AS
	SELECT
		(SELECT ProjectsGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM TX_CL_STATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF(
			(SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND (ProjectsID = '158' OR ProjectsID = '156' )) >= '2'
			OR (SELECT COUNT(*) FROM TX_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '10' AND ProjectsID <> '158' AND ProjectsID <> '156' ) >= '2' , '1' , '0') AS ProjectComplete;

-- Combines all the above queries to a single table to show the Competent Leader progress.
DROP TEMPORARY TABLE IF EXISTS TX_CL_STATUS2;
CREATE TEMPORARY TABLE TX_CL_STATUS2 AS
	SELECT * FROM TX_CL_STATUS_PROJECT1
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT2
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT3
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT4
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT5
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT6
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT7
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT8
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT9
	UNION
	SELECT * FROM TX_CL_STATUS_PROJECT10;
SELECT * FROM TX_CL_STATUS2;

SELECT
	'Competent Leader' AS Requirement ,
	(SUM(ProjectComplete) / '10') AS Completed
FROM TX_CL_STATUS2;


-- 2) ADVANCED LEADER BRONZE
-- Completed CL, completed CC, at least 6 months as club officer and club success plan, particiapated in officer training, completed all projects from 2 SCS or LES manuals

DROP TEMPORARY TABLE IF EXISTS TX_ALB_CC_STATUS0;
CREATE TEMPORARY TABLE TX_ALB_CC_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '1' AND QualificationDate > '0' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM TX_ALB_CC_STATUS0;

DROP TEMPORARY TABLE IF EXISTS TX_ALB_CL_STATUS0;
CREATE TEMPORARY TABLE TX_ALB_CL_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '5'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '5'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '5' AND QualificationDate > '0' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM TX_ALB_CL_STATUS0;


-- Creates a view of all Advanced Leader Bronze projects
DROP TEMPORARY TABLE IF EXISTS TX_ALB_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_ALB_PROJECT_STATUS0 AS
	SELECT *
	FROM TX_MEMBER_MOSTRECENTPROJECT0
	WHERE
		NameFull = @NameFull
		AND QualificationsID = '6'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_ALB_PROJECT_STATUS0;

-- Counts if member has completed Club officer, club success, or training?
DROP TEMPORARY TABLE IF EXISTS TX_ALB_OTHER_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ALB_OTHER_PROJECT_STATUS_PCENT0 AS
  SELECT Project , COUNT(*) AS Countx FROM TX_ALB_PROJECT_STATUS0 WHERE Qualification = 'Advanced Leader Bronze' AND (ProjectsID = '182' OR ProjectsID = '183') GROUP BY Project ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ALB_OTHER_PROJECT_STATUS_PCENT0;

-- Counts if member has completed 2 projects from SCS or LES ?
DROP TEMPORARY TABLE IF EXISTS TX_ALB_SCSLES_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ALB_SCSLES_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM TX_ALB_PROJECT_STATUS0 WHERE Qualification = 'Advanced Leader Bronze' AND (ManualGroup = 'Successful Club Series' OR ManualGroup = 'Leadership Excellence Series') GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ALB_SCSLES_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM TX_ALB_CC_STATUS0
UNION
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM TX_ALB_CL_STATUS0
UNION
SELECT
	'Atleast 6 month as a Club Officer and participated in the Club Success Plan' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM TX_ACG_AC_PROJECT_STATUS_PCENT0) >= '1' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACG_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'SC or SL' AS Requirement ,
  IF((SELECT SUM(Countx) FROM TX_ACG_SCSL_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM TX_ACG_SCSL_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'Coach a member to CC3' AS Requirement ,
  IF((SELECT SUM(Countx) FROM TX_ACG_OTHER_PROJECT_STATUS_PCENT0) >= '1' , 1 , 0) AS ProjectsCompleted;


-- 2) ADVANCED LEADER SILVER
-- Completed ALB, served term as a district leader, served as a club sponsor, completed the HPLP

DROP TEMPORARY TABLE IF EXISTS TX_ALS_ALB_STATUS0;
CREATE TEMPORARY TABLE TX_ALS_ALB_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '6'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '6'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM TX_QUALIFICATIONS0 WHERE QualificationsID = '6' AND QualificationDate > '0' AND NameFull = @NameFull) >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM TX_ALS_ALB_STATUS0;


-- Creates a view of all Advanced Leader Bronze projects
DROP TEMPORARY TABLE IF EXISTS TX_ALS_PROJECT_STATUS0;
CREATE TEMPORARY TABLE TX_ALS_PROJECT_STATUS0 AS
	SELECT *
	FROM TX_MEMBER_MOSTRECENTPROJECT0
	WHERE
		NameFull = @NameFull
		AND QualificationsID = '7'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_ALS_PROJECT_STATUS0;

-- Counts if member has completed Club officer, club success, or training?
DROP TEMPORARY TABLE IF EXISTS TX_ALS_OTHER_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ALS_OTHER_PROJECT_STATUS_PCENT0 AS
  SELECT Project , COUNT(*) AS Countx FROM TX_ALS_PROJECT_STATUS0 WHERE Qualification = 'Advanced Leader Silver' AND (ProjectsID = '184' OR ProjectsID = '185') GROUP BY Project ORDER BY Countx DESC Limit 2;
SELECT * FROM TX_ALB_OTHER_PROJECT_STATUS_PCENT0;

-- Counts if member has completed 2 projects from SCS or LES ?
DROP TEMPORARY TABLE IF EXISTS TX_ALS_HPLP_PROJECT_STATUS_PCENT0;
CREATE TEMPORARY TABLE TX_ALS_HPLP_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM TX_ALS_PROJECT_STATUS0 WHERE Qualification = 'Advanced Leader Silver' AND (ManualGroup = 'High Performance Leadership Program') GROUP BY Manual ORDER BY Countx DESC;
SELECT * FROM TX_ALS_HPLP_PROJECT_STATUS_PCENT0;
