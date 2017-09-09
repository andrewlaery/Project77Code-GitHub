SET @Role = 'Speaker';
SET @NameFull = 'Daniel Bates';

SELECT
		ProjectsID ,
        ProjectsOrder ,
        Project
FROM TX_TMI_STRUCTURE0
WHERE Role = @Role
ORDER by ProjectsOrder;

SELECT
	NameFull ,
    QualificationShort ,
    ProjectsID ,
    ProjectsOrder ,
    Project
FROM TX_MOSTRECENTPROJECT0
WHERE
NameFull = @NameFull
AND Role = @Role
ORDER BY ProjectsOrder;
