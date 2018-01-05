SET @Role = 'Toastmaster';
SET @NameFull = 'Mark Hornblow';

SELECT
	NameFull ,
    QualificationsID ,
    QualificationShort ,
    QualificationStatus
FROM TX_QUALIFICATIONS0
WHERE
	NameFull = @NameFull;


SELECT
	QualificationShort ,
	ManualsID ,
    Manual ,
    ProjectsID ,
	ProjectsOrder ,
	Project ,
    Role
FROM TX_TMI_STRUCTURE0
WHERE Role = @Role
ORDER BY QualificationsOrder , ManualsOrder , ProjectsOrder;

SELECT
	NameFull ,
	QualificationShort ,
	ManualsID ,
    Manual ,
    ProjectsID ,
	ProjectsOrder ,
	Project
FROM TX_MOSTRECENTPROJECT0
WHERE
	NameFull = @NameFull
	AND Role = @Role
ORDER BY QualificationsOrder , ManualsOrder , ProjectsOrder;
