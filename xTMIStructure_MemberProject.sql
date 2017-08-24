SET @Role = 'Ah-Counter';
SET @NameFull = 'Natalie Hayter';

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
WHERE Role = @Role;

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
