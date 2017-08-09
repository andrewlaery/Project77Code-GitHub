
-- COMUNICATION TRACK

-- Creates a view of current status of a members Communication track progress

DROP VIEW IF EXISTS V_COMMUNICATIONTRACKSTATUS0;
CREATE VIEW V_COMMUNICATIONTRACKSTATUS0 AS
  SELECT
      NameFull ,
      Track ,
      Qualification ,
      ManualGroup
      Manual ,
      Project ,
      Role ,
      Date1 ,
      QualificationStatus
  FROM V_MOSTRECENTPROJECT0
  WHERE
    NameFull = 'Emma Armitage'
    AND Track = 'Communication'
    AND QualificationStatus = 'In progress'
    AND (Qualification <> 'No qualification')
    AND (Role <> 'No role')
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_COMMUNICATIONTRACKSTATUS0;


-- COMPETENT LEADERSHIP TRACK


-- Creates a CL Structure and Current Members Matrix
DROP VIEW IF EXISTS V_CLSTRUCTURE_MEMBERS0;
CREATE VIEW V_CLSTRUCTURE_MEMBERS0 AS
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
-- SELECT * FROM V_CLSTRUCTURE_MEMBERS0;

-- Add's completed project dates for all CL Members
DROP VIEW IF EXISTS V_CL_MEMBERSSTATUS0;
CREATE VIEW V_CL_MEMBERSSTATUS0 AS
	SELECT
		V_CLSTRUCTURE_MEMBERS0.QualificationsID ,
		V_CLSTRUCTURE_MEMBERS0.QualificationsOrder ,
		V_CLSTRUCTURE_MEMBERS0.Qualification ,
		V_CLSTRUCTURE_MEMBERS0.ProjectsGroup ,
		V_CLSTRUCTURE_MEMBERS0.ProjectGroup ,
        V_CLSTRUCTURE_MEMBERS0.ProjectsID ,
		V_CLSTRUCTURE_MEMBERS0.ProjectsOrder ,
		V_CLSTRUCTURE_MEMBERS0.Project ,
		V_CLSTRUCTURE_MEMBERS0.RolesID ,
		V_CLSTRUCTURE_MEMBERS0.RolesOrder ,
		V_CLSTRUCTURE_MEMBERS0.Role ,
		V_CLSTRUCTURE_MEMBERS0.MembersID ,
		V_CLSTRUCTURE_MEMBERS0.NameFull ,
		V_CLSTRUCTURE_MEMBERS0.NameFull_ProjectsID ,
		V_MOSTRECENTPROJECT0.Date1
	FROM V_CLSTRUCTURE_MEMBERS0
	LEFT JOIN V_MOSTRECENTPROJECT0 ON V_MOSTRECENTPROJECT0.NameFull_ProjectsID = V_CLSTRUCTURE_MEMBERS0.NameFull_ProjectsID
	ORDER BY membersID , QualificationsOrder , ProjectsOrder , RolesOrder;
-- SELECT * FROM V_CL_MEMBERSSTATUS0;

DROP VIEW IF EXISTS V_CL_MEMBERSSTATUS1;
CREATE VIEW V_CL_MEMBERSSTATUS1 AS
  SELECT * FROM V_CL_MEMBERSSTATUS0
  WHERE NameFull = 'Emma Armitage';
-- SELECT * FROM V_CL_MEMBERSSTATUS1;

-- CL Project 1: Complete 3 of 4 projects
DROP VIEW IF EXISTS V_CL_PROJECT1STATUS0;
CREATE VIEW V_CL_PROJECT1STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '1'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '1' ) >= '3' , 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 2: Complete 2 of 3 projects
DROP VIEW IF EXISTS V_CL_PROJECT2STATUS0;
CREATE VIEW V_CL_PROJECT2STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '2'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '2' ) >= '2', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 3: Complete 3 of 3 projects
DROP VIEW IF EXISTS V_CL_PROJECT3STATUS0;
CREATE VIEW V_CL_PROJECT3STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '3'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF ((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '3' ) >= '3', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 4: Complete Timer +1
DROP VIEW IF EXISTS V_CL_PROJECT4STATUS0;
CREATE VIEW V_CL_PROJECT4STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '4'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF (
			(SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsID = '162' ) >= '1'
			AND
			(SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '4' AND ProjectsID <> '162' ) >= '1' , 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 5: Complete 3 of 4 projects
DROP VIEW IF EXISTS V_CL_PROJECT5STATUS0;
CREATE VIEW V_CL_PROJECT5STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '5'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '5' ) >= '3', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 6: Complete 1 of 6 projects
DROP VIEW IF EXISTS V_CL_PROJECT6STATUS0;
CREATE VIEW V_CL_PROJECT6STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '6'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '6' ) >= '1', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 7: Complete 2 of 4 projects
DROP VIEW IF EXISTS V_CL_PROJECT7STATUS0;
CREATE VIEW V_CL_PROJECT7STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '7'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '7' ) >= '2', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 8: Complete 1 Chair plus 2 others
DROP VIEW IF EXISTS V_CL_PROJECT8STATUS0;
CREATE VIEW V_CL_PROJECT8STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '8'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF(
			(SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND (ProjectsID = '137' OR ProjectsID = '138' )) >= '1'
			AND
			(SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '8' AND ProjectsID <> '137' AND ProjectsID <> '138' ) >= '2' , 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 9: Complete 1 of 3
DROP VIEW IF EXISTS V_CL_PROJECT9STATUS0;
CREATE VIEW V_CL_PROJECT9STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '9'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF((SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '9' ) >= '1', 'Yes' , 'No') AS CLProjectComplete;

-- CL Project 10: Complete Toastmaster or General Evaluator, or one of the other projects.
DROP VIEW IF EXISTS V_CL_PROJECT10STATUS0;
CREATE VIEW V_CL_PROJECT10STATUS0 AS
	SELECT
		(SELECT ProjectsGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectsGroup) AS ProjectsGroup ,
		(SELECT ProjectGroup FROM V_CL_MEMBERSSTATUS1 WHERE ProjectsGroup = '10'  GROUP BY ProjectGroup) AS ProjectGroup ,
		IF(
			(SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND (ProjectsID = '158' OR ProjectsID = '156' )) >= '2'
			OR (SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS1 WHERE Date1 > '0' AND ProjectsGroup = '10' AND ProjectsID <> '158' AND ProjectsID <> '156' ) >= '2' , 'Yes' , 'No') AS CLProjectComplete;

DROP VIEW IF EXISTS V_CL_MEMBERSSTATUS2;
CREATE VIEW V_CL_MEMBERSSTATUS2 AS
	SELECT * FROM V_CL_PROJECT1STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT2STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT3STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT4STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT5STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT6STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT7STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT8STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT9STATUS0
	UNION
	SELECT * FROM V_CL_PROJECT10STATUS0;
SELECT * FROM V_CL_MEMBERSSTATUS2;

-- ADVANCED LEADERSHIP TRACK
