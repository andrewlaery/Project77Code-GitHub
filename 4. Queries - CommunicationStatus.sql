-- Creates a view of current status of a members communication track progress
DROP VIEW IF EXISTS V_COMMUNICATIONTRACKSTATUS0;
CREATE VIEW V_COMMUNICATIONTRACKSTATUS0 AS
    SELECT
      NameFull ,
      Track ,
      QualificationsOrder ,
      Qualification ,
      QualificationStatus ,
      ManualGroupsOrder ,
      ManualGroup ,
      ManualsOrder ,
      Manual ,
      ProjectsOrder ,
      Project ,
      RolesOrder ,
      Role ,
      Date1
	FROM V_MOSTRECENTPROJECT0
	ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_COMMUNICATIONTRACKSTATUS0;

DROP VIEW IF EXISTS V_COMMUNICATIONTRACKSTATUS1;
CREATE VIEW V_COMMUNICATIONTRACKSTATUS1 AS
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
  FROM V_COMMUNICATIONTRACKSTATUS0
  WHERE
    NameFull = 'Peter Webster'
    AND Track = 'Communication'
    AND QualificationStatus = 'In progress'
    AND (Qualification <> 'No qualification')
    AND (Role <> 'No role')
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;

SELECT * FROM V_COMMUNICATIONTRACKSTATUS1;
