
/*
SECTION 1 OF 2: CURRENT MEMBERS, THEIR QUALIFICATIONS AND PROJECTS
*/

-- Lists members qualifications.
DROP VIEW IF EXISTS V_QUALIFICATIONS;
CREATE VIEW V_QUALIFICATIONS AS
	SELECT
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
        RECORDS_QUALIFICATIONS.qualificationdate AS QualificationDate,
        RECORDS_QUALIFICATIONS.qualificationstatus AS QualificationStatus ,
        RECORDS_CLUBS.name AS Club ,
        RECORDS_MEMBERS.currentmember AS CurrentMember ,
        CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification
    FROM RECORDS_QUALIFICATIONS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_QUALIFICATIONS.membersID
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_QUALIFICATIONS.qualificationsID
    LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID 
    WHERE (RECORDS_CLUBS.name = 'Corporate Toastmasters') AND (RECORDS_MEMBERS.currentmember = 'Yes');
SELECT * FROM V_QUALIFICATIONS WHERE QualificationStatus = 'In progress' ORDER BY NameFull , Qualification;


-- Lists members projects including duplicates
DROP VIEW IF EXISTS V_RECORDS_PROJECTS1;
CREATE VIEW V_RECORDS_PROJECTS1 AS
	SELECT 
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
        TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
        TMI_MANUALS.manual AS Manual ,
		TMI_PROJECTS.project AS Project ,
		TMI_ROLES.role AS Role ,
        RECORDS_PROJECTS.projectdate AS Date1 ,
        RECORDS_PROJECTS.itemstatus AS Status1 ,
        RECORDS_CLUBS.name AS Club ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification ,
        CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_PROJECTS.project) AS NameFull_Project ,
        CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_ROLES.role) AS NameFull_Role
	FROM RECORDS_PROJECTS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_PROJECTS.membersID
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_PROJECTS.qualificationsID
	LEFT JOIN TMI_PROJECTS ON TMI_PROJECTS.id = RECORDS_PROJECTS.projectsID
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = RECORDS_PROJECTS.rolesID
    LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID
    LEFT JOIN TMI_MANUALS ON TMI_MANUALS.id = TMI_PROJECTS.manualsID
    LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
    WHERE 
        (RECORDS_CLUBS.name = 'Corporate Toastmasters') 
        AND (RECORDS_MEMBERS.currentmember = 'Yes')
        AND (TMI_QUALIFICATIONS.qualification <> 'No qualification');
        -- AND (RECORDS_PROJECTS.itemstatus = 'actual');
        -- AND (CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) = 'Donald Jessep');
-- SELECT * FROM V_RECORDS_PROJECTS1;
DROP VIEW IF EXISTS V_RECORDS_PROJECTS2;
CREATE VIEW V_RECORDS_PROJECTS2 AS
	SELECT 
		V_RECORDS_PROJECTS1.NameFull AS NameFull ,
		V_RECORDS_PROJECTS1.Qualification AS Qualification ,
        V_RECORDS_PROJECTS1.ManualGroup AS ManualGroup ,
        V_RECORDS_PROJECTS1.Manual AS Manual ,
		V_RECORDS_PROJECTS1.Project AS Project ,
		V_RECORDS_PROJECTS1.Role AS Role ,
		V_QUALIFICATIONS.qualificationstatus AS QualificationStatus ,
		V_RECORDS_PROJECTS1.Date1 AS Date1 ,
        CAST(V_RECORDS_PROJECTS1.Date1 AS unsigned) AS Date1Num ,
        V_RECORDS_PROJECTS1.Status1 AS Status1 ,
		V_RECORDS_PROJECTS1.Club AS Club ,
		V_RECORDS_PROJECTS1.NameFull_Qualification AS NameFull_Qualification ,
		V_RECORDS_PROJECTS1.NameFull_Project AS NameFull_Project ,
		V_RECORDS_PROJECTS1.NameFull_Role AS NameFull_Role
	FROM V_RECORDS_PROJECTS1
	LEFT JOIN V_QUALIFICATIONS ON V_QUALIFICATIONS.NameFull_Qualification = V_RECORDS_PROJECTS1.NameFull_Qualification;
SELECT * FROM V_RECORDS_PROJECTS2;


-- Lists members most recent projects excluding duplicates.
DROP VIEW IF EXISTS V_MOSTRECENTPROJECT1;
CREATE VIEW V_MOSTRECENTPROJECT1 AS
    SELECT
            a.NameFull ,
            a.Qualification ,
            a.ManualGroup ,
            a.Manual ,
            a.Project ,
            a.Role ,
            a.Status1 ,
            a.Date1 ,
            a.Date1Num
        FROM V_RECORDS_PROJECTS2 a
        LEFT OUTER JOIN V_RECORDS_PROJECTS2 b
            ON a.NameFull_Project = b.NameFull_Project AND a.Date1Num < b.Date1Num
        WHERE 
            (b.NameFull_Project IS NULL)
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;
DROP VIEW IF EXISTS V_MOSTRECENTPROJECT2;
CREATE VIEW V_MOSTRECENTPROJECT2 AS
    SELECT * 
        FROM V_MOSTRECENTPROJECT1
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;
SELECT * FROM V_MOSTRECENTPROJECT2;


-- Lists members most recent role.
DROP VIEW IF EXISTS V_MOSTRECENTROLE1;
CREATE VIEW V_MOSTRECENTROLE1 AS
    SELECT
            a.NameFull AS NameFull ,
            a.Role AS Role ,
            a.Status1 AS Status1 ,
            a.Date1 AS Date1 ,
            a.Date1Num AS Date1Num ,
            CONCAT(a.NameFull , ' - ' , a.Role) as NameFull_Role
        FROM V_RECORDS_PROJECTS2 a
        LEFT OUTER JOIN V_RECORDS_PROJECTS2 b
            ON a.NameFull_Role = b.NameFull_Role AND a.Date1Num < b.Date1Num
        WHERE 
            (b.NameFull_Role IS NULL)
        ORDER BY Role , Date1Num , NameFull;
DROP VIEW IF EXISTS V_MOSTRECENTROLE2;
CREATE VIEW V_MOSTRECENTROLE2 AS
    SELECT
            NameFull ,
            Role ,
            Status1 ,
            Date1 ,
            Date1Num ,
            NameFull_Role
        FROM V_MOSTRECENTROLE1
        WHERE Role <> 'No role'
        GROUP BY NameFull , Role
        ORDER BY Role , Date1Num , NameFull;
SELECT * FROM V_MOSTRECENTROLE2;

/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES MATRIX
*/

DROP VIEW IF EXISTS V_CURRENTMEMBERS;
CREATE VIEW V_CURRENTMEMBERS AS
    SELECT
        CONCAT(RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull
    FROM RECORDS_MEMBERS
    WHERE (currentclubs = 'Corporate Toastmasters') AND (currentmember = 'Yes');
-- SELECT * FROM V_CURRENTMEMBERS ORDER BY NameFull;

DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES;
CREATE VIEW V_CONTESTABLE_TMIROLES AS
    SELECT Role
    FROM TMI_ROLES
    WHERE contestable = 'Yes';
-- SELECT * FROM V_CONTESTABLE_TMIROLES;

DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
CREATE VIEW V_CONTESTABLE_TMIROLES_TO_MEMBERS1 AS
    SELECT * 
    FROM V_CONTESTABLE_TMIROLES 
    CROSS JOIN V_CURRENTMEMBERS;
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS2;
CREATE VIEW V_CONTESTABLE_TMIROLES_TO_MEMBERS2 AS
    SELECT
        * ,
        CONCAT(NameFull , ' - ' , Role) AS NameFull_Role
    FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
    -- WHERE NameFull <> 'Emma Armitage';
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS2;




/*
DROP VIEW IF EXISTS V_QUALIFICATIONS;
DROP VIEW IF EXISTS V_RECORDS_PROJECTS1;
DROP VIEW IF EXISTS V_RECORDS_PROJECTS2;
DROP VIEW IF EXISTS V_MOSTRECENTPROJECT1;
DROP VIEW IF EXISTS V_MOSTRECENTPROJECT2;
DROP VIEW IF EXISTS V_MOSTRECENTROLE1;
DROP VIEW IF EXISTS V_MOSTRECENTROLE2;
DROP VIEW IF EXISTS V_CURRENTMEMBERS;
DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES;
DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS2;
*/

