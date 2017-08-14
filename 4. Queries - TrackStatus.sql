
-- --------- COMMUNICATION TRACKS --------------

-- 1) COMPETENT COMMUNICATOR

-- Creates a view of current status of a members Competent Communicator track progress
DROP VIEW IF EXISTS V_QUALIFICATION_STATUS0;
CREATE VIEW V_QUALIFICATION_STATUS0 AS
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
  -- WHERE
    -- (QualificationStatus = 'In progress' OR QualificationStatus = 'Completed')
    -- AND Qualification <> 'No qualification'
    -- AND Role <> 'No role'
  ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
-- SELECT * FROM V_QUALIFICATION_STATUS0;

DROP VIEW IF EXISTS V_CC_PROJECT_STATUS0;
CREATE VIEW V_CC_PROJECT_STATUS0 AS
  SELECT *
  FROM V_QUALIFICATION_STATUS0
  WHERE
    NameFull = 'Emma Armitage'
    AND QualificationsID = '1'
    AND QualificationStatus = 'In progress'
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
-- SELECT * FROM V_CC_PROJECT_STATUS0;

-- CC Percentage complete
DROP VIEW IF EXISTS V_CC_PROJECT_STATUS_PCENT0;
CREATE VIEW V_CC_PROJECT_STATUS_PCENT0 AS
	SELECT
		(SELECT QualificationsID FROM V_QUALIFICATION_STATUS0 WHERE QualificationsID = '1' GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM V_QUALIFICATION_STATUS0 WHERE QualificationsID = '1' GROUP BY Qualification) AS Qualification ,
        (SELECT COUNT(*) FROM V_QUALIFICATION_STATUS0 WHERE NameFull = 'Emma Armitage' AND QualificationsID = '1' AND QualificationStatus = 'In progress') / '10' AS Percentage;
SELECT * FROM V_CC_PROJECT_STATUS_PCENT0;


-- 2) ADVANCED COMMUNICATOR BRONZE (ACB)
-- Requires CC Qualification and 2 AC Manuals to be completed.

-- Creates a view of the completion of the Competent Communicator Qualification from the Qualification Table.
DROP VIEW IF EXISTS V_ACB_CC_STATUS0;
CREATE VIEW V_ACB_CC_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM V_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM V_QUALIFICATIONS0 WHERE QualificationsID = '1'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM V_QUALIFICATIONS0 WHERE QualificationsID = '1' AND QualificationDate > '0' AND NameFull = 'Linda Robert') >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM V_ACB_CC_STATUS0;

-- Creates a view of the current ACB AC projects for each member.
DROP VIEW IF EXISTS V_ACB_PROJECT_STATUS0;
CREATE VIEW V_ACB_PROJECT_STATUS0 AS
	SELECT *
	FROM V_QUALIFICATION_STATUS0
	WHERE
		NameFull = 'Linda Robert'
		AND QualificationsID = '2'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_ACB_PROJECT_STATUS0;


DROP VIEW IF EXISTS V_ACB_AC_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACB_AC_PROJECT_STATUS_PCENT0 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM V_ACB_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Bronze' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM V_ACB_AC_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM V_ACB_CC_STATUS0
UNION
SELECT
	'Advanced Communicator' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM V_ACB_AC_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM V_ACB_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted


-- 3) ADVANCED COMMUNICATOR SILVER (ACS)
-- Requires Advanced Communicator Bronze (ACB), 2 completed AC manuals (10 speeches), and 2 completed manuals from BSS or SCS (2 speeches)


-- Creates a view of the completion of the Advanced Communicator Bronze Qualification from the Qualification Table.
DROP VIEW IF EXISTS V_ACS_ACB_STATUS0;
CREATE VIEW V_ACS_ACB_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM V_QUALIFICATIONS0 WHERE QualificationsID = '2'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM V_QUALIFICATIONS0 WHERE QualificationsID = '2'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM V_QUALIFICATIONS0 WHERE QualificationsID = '2' AND QualificationDate > '0' AND NameFull = 'Linda Robert') >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM V_ACS_ACB_STATUS0;

-- Creates a view of all Advanced Communicator speeches
DROP VIEW IF EXISTS V_ACS_PROJECT_STATUS0;
CREATE VIEW V_ACS_PROJECT_STATUS0 AS
	SELECT *
	FROM V_QUALIFICATION_STATUS0
	WHERE
		NameFull = 'Mark Hornblow'
		AND QualificationsID = '3'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_ACS_PROJECT_STATUS0;

-- Counts the top 2 AC Manuals and the % complete
DROP VIEW IF EXISTS V_ACS_AC_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACS_AC_PROJECT_STATUS_PCENT0 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM V_ACS_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Silver' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM V_ACS_AC_PROJECT_STATUS_PCENT0;

-- Counts top 2 BSS SCS Manuals and the % complete
DROP VIEW IF EXISTS V_ACS_BSSSCS_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACS_BSSSCS_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM V_ACS_PROJECT_STATUS0 WHERE (ManualGroup = 'Better Speaker Series' OR ManualGroup = 'Successful Club Series') GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM V_ACS_BSSSCS_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM V_ACS_ACB_STATUS0
UNION
SELECT
	'Advanced Communicator' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM V_ACS_AC_PROJECT_STATUS_PCENT0) >= '1' , 1 , (SELECT (SUM(Countx) / '2') FROM V_ACS_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'BSS or SCS' AS Requirement ,
    IF((SELECT SUM(Countx) FROM V_ACS_BSSSCS_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM V_ACS_BSSSCS_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted;



-- 4) ADVANCED COMMUNICATOR GOLD (ACG)
-- Requires Advanced Communicator Silver (ACS), 2 completed AC manuals (10 speeches), 1 completed manuals from SL or SC (1 speeches), and coach a member to CC#3


-- Creates a view of the completion of the Advanced Communicator Bronze Qualification from the Qualification Table.
DROP VIEW IF EXISTS V_ACG_ACS_STATUS0;
CREATE VIEW V_ACG_ACS_STATUS0 AS
	SELECT
		(SELECT QualificationsID FROM V_QUALIFICATIONS0 WHERE QualificationsID = '3'  GROUP BY QualificationsID) AS QualificationsID ,
		(SELECT Qualification FROM V_QUALIFICATIONS0 WHERE QualificationsID = '3'  GROUP BY QualificationsID) AS Qualification ,
		IF((SELECT COUNT(*) FROM V_QUALIFICATIONS0 WHERE QualificationsID = '3' AND QualificationDate > '0' AND NameFull = 'Donald Jessep') >= '1', '1', '0' ) AS  ProjectComplete;
SELECT * FROM V_ACG_ACS_STATUS0;

-- Creates a view of all Advanced Communicator speeches
DROP VIEW IF EXISTS V_ACG_PROJECT_STATUS0;
CREATE VIEW V_ACG_PROJECT_STATUS0 AS
	SELECT *
	FROM V_QUALIFICATION_STATUS0
	WHERE
		NameFull = 'Donald Jessep'
		AND QualificationsID = '4'
		AND QualificationStatus = 'In progress'
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_ACG_PROJECT_STATUS0;

-- Counts the top 2 AC Manuals and the % complete
DROP VIEW IF EXISTS V_ACG_AC_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACG_AC_PROJECT_STATUS_PCENT0 AS
	SELECT Manual , (COUNT(*) / '5') AS Countx FROM V_ACG_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND ManualGroup = 'Advanced Communicator' GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM V_ACG_AC_PROJECT_STATUS_PCENT0;

-- Counts top 2 BSS SCS Manuals and the % complete
DROP VIEW IF EXISTS V_ACG_SCSL_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACG_SCSL_PROJECT_STATUS_PCENT0 AS
  SELECT Manual , COUNT(*) AS Countx FROM V_ACS_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND (ManualGroup = 'Success Communication' OR ManualGroup = 'Success Leadership') GROUP BY Manual ORDER BY Countx DESC Limit 2;
SELECT * FROM V_ACG_SCSL_PROJECT_STATUS_PCENT0;

-- Counts if member has completed the Mentor a newbie to CC3
DROP VIEW IF EXISTS V_ACG_OTHER_PROJECT_STATUS_PCENT0;
CREATE VIEW V_ACG_OTHER_PROJECT_STATUS_PCENT0 AS
  SELECT Project , COUNT(*) AS Countx FROM V_ACG_PROJECT_STATUS0 WHERE Qualification = 'Advanced Communicator Gold' AND ProjectsID = '181' GROUP BY Project ORDER BY Countx DESC Limit 1;
SELECT * FROM V_ACG_OTHER_PROJECT_STATUS_PCENT0;

-- Creates a summary UNION table of all the above queries.
SELECT
	Qualification AS Requirement ,
  ProjectComplete AS ProjectsCompleted
  FROM V_ACG_ACS_STATUS0
UNION
SELECT
	'Advanced Communicator' AS Requirement ,
	IF((SELECT (SUM(Countx) / '2') FROM V_ACG_AC_PROJECT_STATUS_PCENT0) >= '1' , 1 , (SELECT (SUM(Countx) / '2') FROM V_ACG_AC_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'SC or SL' AS Requirement ,
  IF((SELECT SUM(Countx) FROM V_ACG_SCSL_PROJECT_STATUS_PCENT0) >= '2' , 1 , (SELECT (SUM(Countx) / '2') FROM V_ACG_SCSL_PROJECT_STATUS_PCENT0)) AS ProjectsCompleted
UNION
SELECT
	'Coach a member to CC3' AS Requirement ,
  IF((SELECT SUM(Countx) FROM V_ACG_OTHER_PROJECT_STATUS_PCENT0) >= '1' , 1 , 0) AS ProjectsCompleted;



  -- --------- LEADERSHIP TRACKS --------------

  -- 1) COMPETENT LEADER
  -- (a) Creates a structure, (b) addes project completion dates, (c) filters to specific member, (d) tests each project progress

  -- Creates the Competent Leader Structure and adds Current Members  to form a Matrix
  DROP VIEW IF EXISTS V_CL_STRUCTURE_MEMBERS0;
  CREATE VIEW V_CL_STRUCTURE_MEMBERS0 AS
  	SELECT
      V_TMI_STRUCTURE0.QualificationsID AS QualificationsID ,
      V_TMI_STRUCTURE0.QualificationsOrder AS QualificationsOrder ,
      V_TMI_STRUCTURE0.Qualification AS Qualification,
      SUBSTRING(V_TMI_STRUCTURE0.ProjectsOrder, 1, LOCATE ('.' , V_TMI_STRUCTURE0.ProjectsOrder)-1) AS ProjectsGroup ,
      SUBSTRING(V_TMI_STRUCTURE0.Project, 1, LOCATE (':' , V_TMI_STRUCTURE0.Project)-1) AS ProjectGroup,
      V_TMI_STRUCTURE0.ProjectsID AS ProjectsID ,
      V_TMI_STRUCTURE0.ProjectsOrder AS ProjectsOrder ,
      V_TMI_STRUCTURE0.Project AS Project ,
      V_TMI_STRUCTURE0.RolesID AS RolesID ,
      V_TMI_STRUCTURE0.RolesOrder AS RolesOrder ,
      V_TMI_STRUCTURE0.Role AS Role,
      RECORDS_MEMBERS.id AS MembersID,
      CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
      CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , V_TMI_STRUCTURE0.ProjectsID) AS NameFull_ProjectsID
  	FROM V_TMI_STRUCTURE0
  	CROSS JOIN RECORDS_MEMBERS
  	WHERE
  		(V_TMI_STRUCTURE0.QualificationsID = '5')
      AND (RECORDS_MEMBERS.currentmember = 'Yes');
  -- SELECT * FROM V_CL_STRUCTURE_MEMBERS0;

  -- Add's completed project dates to the above CL Strcuture to Members matrix
  DROP VIEW IF EXISTS V_CL_STATUS0;
  CREATE VIEW V_CL_STATUS0 AS
  	SELECT
  		V_CL_STRUCTURE_MEMBERS0.QualificationsID ,
  		V_CL_STRUCTURE_MEMBERS0.QualificationsOrder ,
  		V_CL_STRUCTURE_MEMBERS0.Qualification ,
  		V_CL_STRUCTURE_MEMBERS0.ProjectsGroup ,
  		V_CL_STRUCTURE_MEMBERS0.ProjectGroup ,
      V_CL_STRUCTURE_MEMBERS0.ProjectsID ,
  		V_CL_STRUCTURE_MEMBERS0.ProjectsOrder ,
  		V_CL_STRUCTURE_MEMBERS0.Project ,
  		V_CL_STRUCTURE_MEMBERS0.RolesID ,
  		V_CL_STRUCTURE_MEMBERS0.RolesOrder ,
  		V_CL_STRUCTURE_MEMBERS0.Role ,
  		V_CL_STRUCTURE_MEMBERS0.MembersID ,
  		V_CL_STRUCTURE_MEMBERS0.NameFull ,
  		V_CL_STRUCTURE_MEMBERS0.NameFull_ProjectsID ,
  		V_MOSTRECENTPROJECT0.Date1
  	FROM V_CL_STRUCTURE_MEMBERS0
  	LEFT JOIN V_MOSTRECENTPROJECT0 ON V_MOSTRECENTPROJECT0.NameFull_ProjectsID = V_CL_STRUCTURE_MEMBERS0.NameFull_ProjectsID
  	ORDER BY membersID , QualificationsOrder , ProjectsOrder , RolesOrder;
  -- SELECT * FROM V_CL_STATUS0;

  -- Filters the above to a specific member.
  DROP VIEW IF EXISTS V_CL_STATUS1;
  CREATE VIEW V_CL_STATUS1 AS
    SELECT * FROM V_CL_STATUS0
    WHERE NameFull = 'Emma Armitage';
  -- SELECT * FROM V_CL_STATUS1;

  -- CL Project 1 query: Complete 3 of 4 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT1;
  CREATE VIEW V_CL_STATUS_PROJECT1 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF ((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '1' ) >= '3' , '1' , '0') AS ProjectComplete;

  -- CL Project 2 query: Complete 2 of 3 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT2;
  CREATE VIEW V_CL_STATUS_PROJECT2 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF ((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '2' ) >= '2', '1' , '0') AS ProjectComplete;

  -- CL Project 3 query: Complete 3 of 3 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT3;
  CREATE VIEW V_CL_STATUS_PROJECT3 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF ((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '3' ) >= '3', '1' , '0') AS ProjectComplete;

  -- CL Project 4 query: Complete Timer +1
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT4;
  CREATE VIEW V_CL_STATUS_PROJECT4 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF (
  			(SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsID = '162' ) >= '1'
  			AND
  			(SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '4' AND ProjectsID <> '162' ) >= '1' , '1' , '0') AS ProjectComplete;

  -- CL Project 5 query: Complete 3 of 4 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT5;
  CREATE VIEW V_CL_STATUS_PROJECT5 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '5' ) >= '3', '1' , '0') AS ProjectComplete;

  -- CL Project 6 query: Complete 1 of 6 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT6;
  CREATE VIEW V_CL_STATUS_PROJECT6 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '6' ) >= '1', '1' , '0') AS ProjectComplete;

  -- CL Project 7 query: Complete 2 of 4 projects
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT7;
  CREATE VIEW V_CL_STATUS_PROJECT7 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '7' ) >= '2', '1' , '0') AS ProjectComplete;

  -- CL Project 8 query: Complete 1 Chair plus 2 others
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT8;
  CREATE VIEW V_CL_STATUS_PROJECT8 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF(
  			(SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND (ProjectsID = '137' OR ProjectsID = '138' )) >= '1'
  			AND
  			(SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '8' AND ProjectsID <> '137' AND ProjectsID <> '138' ) >= '2' , '1' , '0') AS ProjectComplete;

  -- CL Project 9 query: Complete 1 of 3
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT9;
  CREATE VIEW V_CL_STATUS_PROJECT9 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF((SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '9' ) >= '1', '1' , '0') AS ProjectComplete;

  -- CL Project 10 query: Complete Toastmaster or General Evaluator, or one of the other projects.
  DROP VIEW IF EXISTS V_CL_STATUS_PROJECT10;
  CREATE VIEW V_CL_STATUS_PROJECT10 AS
  	SELECT
  		(SELECT ProjectsGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
  		(SELECT ProjectGroup FROM V_CL_STATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectGroup) AS ProjectGroup ,
  		IF(
  			(SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND (ProjectsID = '158' OR ProjectsID = '156' )) >= '2'
  			OR (SELECT COUNT(*) FROM V_CL_STATUS1 WHERE Date1 > '0' AND ProjectsGroup = '10' AND ProjectsID <> '158' AND ProjectsID <> '156' ) >= '2' , '1' , '0') AS ProjectComplete;

  -- Combines all the above queries to a single table to show the Competent Leader progress.
  DROP VIEW IF EXISTS V_CL_STATUS2;
  CREATE VIEW V_CL_STATUS2 AS
  	SELECT * FROM V_CL_STATUS_PROJECT1
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT2
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT3
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT4
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT5
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT6
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT7
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT8
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT9
  	UNION
  	SELECT * FROM V_CL_STATUS_PROJECT10;
  SELECT * FROM V_CL_STATUS2;

  SELECT
  	'Competent Leader' AS Requirement ,
  	(SUM(ProjectComplete) / '10') AS Completed
  FROM V_CL_STATUS2;

-- ADVANCED LEADERSHIP TRACK
