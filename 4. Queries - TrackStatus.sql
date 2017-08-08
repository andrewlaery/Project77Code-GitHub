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

DROP VIEW IF EXISTS V_LEADERSHIPTRACKSTATUS0;
CREATE VIEW V_LEADERSHIPTRACKSTATUS0 AS
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
    AND Track = 'Leadership'
    AND QualificationStatus = 'In progress'
    AND (Qualification <> 'No qualification')
    AND (Role <> 'No role')
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM V_LEADERSHIPTRACKSTATUS0;
