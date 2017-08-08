-- Creates a view of current status of a members communication track progress


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
    NameFull = 'Peter Webster'
    AND Track = 'Communication'
    AND QualificationStatus = 'In progress'
    AND (Qualification <> 'No qualification')
    AND (Role <> 'No role')
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_COMMUNICATIONTRACKSTATUS0;


-- LEADERSHIP


-- Creates a CL Structure and Current Members Matrix
DROP VIEW IF EXISTS V_CLSTRUCTURE_MEMBERS0;
CREATE VIEW V_CLSTRUCTURE_MEMBERS0 AS
	SELECT
		V_TMI_STRUCTURE0.QualificationsID AS QualificationsID ,
        V_TMI_STRUCTURE0.QualificationsOrder AS QualificationsOrder ,
        V_TMI_STRUCTURE0.Qualification AS Qualification,
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
SELECT * FROM V_CLSTRUCTURE_MEMBERS0;

-- Add's completed project dates for all CL Members
DROP VIEW IF EXISTS V_CL_MEMBERSSTATUS0;
CREATE VIEW V_CL_MEMBERSSTATUS0 AS
	SELECT
		V_CLSTRUCTURE_MEMBERS0.QualificationsID ,
		V_CLSTRUCTURE_MEMBERS0.QualificationsOrder ,
		V_CLSTRUCTURE_MEMBERS0.Qualification ,
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

SELECT * FROM V_CL_MEMBERSSTATUS0
WHERE NameFull = 'Peter Webster';

-- Counts the number of clompleted projects.
SELECT COUNT(*) FROM V_CL_MEMBERSSTATUS0
WHERE
	NameFull = 'Peter Webster'
    AND ProjectsOrder < '2'
    AND Date1 > '0';
