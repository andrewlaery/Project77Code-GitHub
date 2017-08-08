
/*
SECTION 1 OF 2: CURRENT MEMBERS, THEIR QUALIFICATIONS AND PROJECTS
*/

-- Lists members qualifications.
DROP VIEW IF EXISTS V_QUALIFICATIONS0;
CREATE VIEW V_QUALIFICATIONS0 AS
	SELECT
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_TRACKS.track AS Track ,
		TMI_TRACKS.tmiorder AS TrackOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationOrder ,
		RECORDS_QUALIFICATIONS.qualificationdate AS QualificationDate,
		RECORDS_QUALIFICATIONS.qualificationstatus AS QualificationStatus ,
		RECORDS_CLUBS.name AS Club ,
		RECORDS_MEMBERS.currentmember AS CurrentMember ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification
	FROM RECORDS_QUALIFICATIONS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_QUALIFICATIONS.membersID
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_QUALIFICATIONS.qualificationsID
	LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID
	LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID;
DROP VIEW IF EXISTS V_QUALIFICATIONS1;
CREATE VIEW V_QUALIFICATIONS1 AS
    SELECT *
    FROM V_QUALIFICATIONS0
    WHERE
        (Club = 'Corporate Toastmasters')
        AND (CurrentMember = 'Yes')
        AND (QualificationStatus = 'In progress');
SELECT * FROM V_QUALIFICATIONS0 ORDER BY NameFull , Qualification;
SELECT * FROM V_QUALIFICATIONS1 ORDER BY NameFull , Qualification;



-- Lists members projects including duplicates
DROP VIEW IF EXISTS V_RECORDS_PROJECTS0;
CREATE VIEW V_RECORDS_PROJECTS0 AS
	SELECT
		RECORDS_PROJECTS.id  AS ID ,
		RECORDS_PROJECTS.membersID AS MembersID ,
    CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_TRACKS.track AS Track ,
		TMI_TRACKS.tmiorder AS TrackOrder ,
		RECORDS_PROJECTS.qualificationsID AS qualificationsID ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
		TMI_MANUAL_GROUPS.tmiorder AS ManualGroupOrder ,
		TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
		TMI_MANUALS.tmiorder AS ManualOrder ,
    TMI_MANUALS.manual AS Manual ,
		RECORDS_PROJECTS.projectsID AS ProjectsID ,
		TMI_PROJECTS.tmiorder AS ProjectOrder ,
		TMI_PROJECTS.project AS Project ,
		RECORDS_PROJECTS.rolesID AS RolesID,
		TMI_ROLES.tmiorder AS RoleOrder ,
		TMI_ROLES.role AS Role ,
    RECORDS_PROJECTS.projectdate AS Date1 ,
    RECORDS_PROJECTS.itemstatus AS Status1 ,
    RECORDS_MEMBERS.currentmember AS CurrentMember ,
    RECORDS_CLUBS.name AS Club ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification ,
    CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_PROJECTS.project) AS NameFull_Project ,
    CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_ROLES.role) AS NameFull_Role
	FROM RECORDS_PROJECTS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_PROJECTS.membersID
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_PROJECTS.qualificationsID
	LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID
	LEFT JOIN TMI_PROJECTS ON TMI_PROJECTS.id = RECORDS_PROJECTS.projectsID
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = RECORDS_PROJECTS.rolesID
  LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID
  LEFT JOIN TMI_MANUALS ON TMI_MANUALS.id = TMI_PROJECTS.manualsID
  LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID;
SELECT * FROM V_RECORDS_PROJECTS0;

DROP VIEW IF EXISTS V_RECORDS_PROJECTS1;
CREATE VIEW V_RECORDS_PROJECTS1 AS
	SELECT
		V_RECORDS_PROJECTS0.ID AS ID ,
		V_RECORDS_PROJECTS0.MembersID AS MembersID ,
		V_RECORDS_PROJECTS0.NameFull AS NameFull ,
		V_RECORDS_PROJECTS0.Track AS Track ,
		V_RECORDS_PROJECTS0.TrackOrder AS TrackOrder ,
		V_RECORDS_PROJECTS0.QualificationsID AS QualificationsID ,
		V_RECORDS_PROJECTS0.QualificationOrder AS QualificationOrder ,
		V_RECORDS_PROJECTS0.Qualification AS Qualification ,
		V_RECORDS_PROJECTS0.ManualGroupOrder AS ManualGroupOrder ,
    V_RECORDS_PROJECTS0.ManualGroup AS ManualGroup ,
		V_RECORDS_PROJECTS0.ManualOrder AS ManualOrder ,
    V_RECORDS_PROJECTS0.Manual AS Manual ,
		V_RECORDS_PROJECTS0.ProjectsID AS ProjectsID ,
		V_RECORDS_PROJECTS0.ProjectOrder AS ProjectOrder ,
		V_RECORDS_PROJECTS0.Project AS Project ,
		V_RECORDS_PROJECTS0.RolesID AS RolesID ,
		V_RECORDS_PROJECTS0.RoleOrder AS RoleOrder ,
		V_RECORDS_PROJECTS0.Role AS Role ,
		V_QUALIFICATIONS0.qualificationstatus AS QualificationStatus ,
		V_RECORDS_PROJECTS0.Date1 AS Date1 ,
    CAST(V_RECORDS_PROJECTS0.Date1 AS unsigned) AS Date1Num ,
    V_RECORDS_PROJECTS0.Status1 AS Status1 ,
    V_RECORDS_PROJECTS0.CurrentMember AS CurrentMember ,
		V_RECORDS_PROJECTS0.Club AS Club ,
		V_RECORDS_PROJECTS0.NameFull_Qualification AS NameFull_Qualification ,
		V_RECORDS_PROJECTS0.NameFull_Project AS NameFull_Project ,
		V_RECORDS_PROJECTS0.NameFull_Role AS NameFull_Role
	FROM V_RECORDS_PROJECTS0
	LEFT JOIN V_QUALIFICATIONS0 ON V_QUALIFICATIONS0.NameFull_Qualification = V_RECORDS_PROJECTS0.NameFull_Qualification;

DROP VIEW IF EXISTS V_RECORDS_PROJECTS2;
CREATE VIEW V_RECORDS_PROJECTS2 AS
	SELECT *
    FROM V_RECORDS_PROJECTS1
    WHERE
        (Club = 'Corporate Toastmasters')
        AND (CurrentMember = 'Yes')
        AND (Qualification <> 'No qualification')
        AND (Role <> 'No role')
        AND (DATE1 = '2017-07-26')
        -- AND (RECORDS_PROJECTS.itemstatus = 'actual');
        -- AND (CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) = 'Donald Jessep');
    ORDER BY NameFull , Qualification , ManualGroup , Manual , Project;

SELECT * FROM V_RECORDS_PROJECTS1;
SELECT * FROM V_RECORDS_PROJECTS2;


-- Lists members most recent projects excluding duplicates.
DROP VIEW IF EXISTS V_MOSTRECENTPROJECT0;
CREATE VIEW V_MOSTRECENTPROJECT0 AS
    SELECT
					a.NameFull ,
					a.Club ,
					a.CurrentMember ,
					a.Track ,
					a.QualificationOrder ,
					a.Qualification ,
					a.QualificationStatus ,
					a.ManualGroupOrder ,
					a.ManualGroup ,
					a.ManualOrder ,
					a.Manual ,
					a.ProjectOrder ,
					a.Project ,
					a.RoleOrder ,
					a.Role ,
					a.Status1 ,
					a.Date1 ,
					a.Date1Num
        FROM V_RECORDS_PROJECTS1 a
        LEFT OUTER JOIN V_RECORDS_PROJECTS1 b
            ON a.NameFull_Project = b.NameFull_Project AND a.Date1Num < b.Date1Num
        WHERE
            (b.NameFull_Project IS NULL)
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;

DROP VIEW IF EXISTS V_MOSTRECENTPROJECT1;
CREATE VIEW V_MOSTRECENTPROJECT1 AS
    SELECT *
        FROM V_MOSTRECENTPROJECT0
        WHERE
            (Club = 'Corporate Toastmasters')
            AND (CurrentMember = 'Yes')
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;

SELECT * FROM V_MOSTRECENTPROJECT0;
SELECT * FROM V_MOSTRECENTPROJECT1;

-- Lists members most recent role.
DROP VIEW IF EXISTS V_MOSTRECENTROLE0;
CREATE VIEW V_MOSTRECENTROLE0 AS
    SELECT
            a.NameFull AS NameFull ,
            a.Club AS Club ,
            a.CurrentMember AS CurrentMember ,
						a.Track AS Track ,
						a.QualificationOrder AS QualificationOrder
            a.Qualification AS Qualification ,
						a.RoleOrder AS RoleOrder ,
            a.Role AS Role ,
            a.Status1 AS Status1 ,
            a.Date1 AS Date1 ,
            a.Date1Num AS Date1Num ,
            CONCAT(a.NameFull , ' - ' , a.Role) as NameFull_Role
        FROM V_RECORDS_PROJECTS1 a
        LEFT OUTER JOIN V_RECORDS_PROJECTS1 b
            ON a.NameFull_Role = b.NameFull_Role AND a.Date1Num < b.Date1Num
        WHERE
            (b.NameFull_Role IS NULL)
        ORDER BY Role , Date1Num , NameFull;

DROP VIEW IF EXISTS V_MOSTRECENTROLE1;
CREATE VIEW V_MOSTRECENTROLE1 AS
    SELECT *
        FROM V_MOSTRECENTROLE0
        WHERE
            (Club = 'Corporate Toastmasters')
            AND (CurrentMember = 'Yes')
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        GROUP BY NameFull , Role
        ORDER BY Role , Date1Num , NameFull;

SELECT * FROM V_MOSTRECENTROLE0;
SELECT * FROM V_MOSTRECENTROLE1;


/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES
*/

DROP VIEW IF EXISTS V_CURRENTMEMBERS0;
CREATE VIEW V_CURRENTMEMBERS0 AS
    SELECT
        CONCAT(RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull ,
        currentclubs ,
        currentmember
    FROM RECORDS_MEMBERS;
-- SELECT * FROM V_CURRENTMEMBERS0 ORDER BY currentclubs , currentmember , NameFull;

DROP VIEW IF EXISTS V_CURRENTMEMBERS1;
CREATE VIEW V_CURRENTMEMBERS1 AS
    SELECT *
    FROM V_CURRENTMEMBERS0
    WHERE
        (currentclubs = 'Corporate Toastmasters')
        AND (currentmember = 'Yes');
-- SELECT * FROM V_CURRENTMEMBERS1 ORDER BY currentclubs , currentmember , NameFull;

DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES0;
CREATE VIEW V_CONTESTABLE_TMIROLES0 AS
    SELECT Role
    FROM TMI_ROLES
    WHERE contestable = 'Yes';
-- SELECT * FROM V_CONTESTABLE_TMIROLES;


-- CROSS JOIN MEMBERS & CONTESTABLE ROLES
DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS0;
CREATE VIEW V_CONTESTABLE_TMIROLES_TO_MEMBERS0 AS
    SELECT *
    FROM V_CONTESTABLE_TMIROLES0
    CROSS JOIN V_CURRENTMEMBERS0;
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS0;

DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
CREATE VIEW V_CONTESTABLE_TMIROLES_TO_MEMBERS1 AS
    SELECT
        * ,
        CONCAT(NameFull , ' - ' , Role) AS NameFull_Role
    FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS0;
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1;

DROP VIEW IF EXISTS V_CONTESTABLE_TMIROLES_TO_MEMBERS2;
CREATE VIEW V_CONTESTABLE_TMIROLES_TO_MEMBERS2 AS
    SELECT *
    FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1
    WHERE
        (currentclubs = 'Corporate Toastmasters')
        AND (currentmember = 'Yes');
SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1;
SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS2;


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
