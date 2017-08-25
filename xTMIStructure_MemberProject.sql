SET @Role = 'Speaker';
SET @NameFull = 'Michelle Bruhn';

SELECT
	Track ,
  Qualification ,
  ManualGroup ,
  Manual ,
  ProjectsID ,
  ProjectsOrder ,
  Project ,
  RolesID ,
  Role
FROM TTX_TMI_STRUCTURE0
WHERE Role = @Role
ORDER BY TracksOrder , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;

SELECT
	NameFull ,
	Track ,
  Qualification ,
  ManualGroup ,
  Manual ,
  ProjectsID ,
  ProjectsOrder ,
  Project ,
  RolesID ,
  Role
FROM TTX_RECORDS_PROJECTS1
WHERE
	Role = @Role
  AND NameFull = @NameFull;
