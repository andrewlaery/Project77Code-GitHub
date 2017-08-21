
-- SET PARAMETERS
SET @Club = 'Corporate Toastmasters';
SET @currentclubs = 'Corporate Toastmasters';
SET @QualificationStatus = 'In progress';
SET @CurrentMember = 'Yes';


/*
SECTION 1: TMI Data Setup
*/

-- ========================  TTX_TMI_STRUCTURE 0 ========================

-- Combination of the TMI Data Tables to show the TMI Structure
DROP TABLE IF EXISTS TTX_TMI_STRUCTURE0;
CREATE TABLE TTX_TMI_STRUCTURE0 AS
	SELECT
		TMI_TRACKS.id AS TracksID ,
		TMI_TRACKS.tmiorder AS TracksOrder ,
		TMI_TRACKS.track AS Track ,
		TMI_QUALIFICATIONS.id AS QualificationsID ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationsOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
		TMI_MANUAL_GROUPS.id AS ManualGroupsID ,
		TMI_MANUAL_GROUPS.tmiorder AS ManualGroupsOrder ,
		TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
		TMI_MANUALS.id AS ManualsID ,
		TMI_MANUALS.tmiorder AS ManualsOrder ,
		TMI_MANUALS.manual AS Manual ,
		TMI_PROJECTS.id AS ProjectsID ,
		TMI_PROJECTS.tmiorder AS ProjectsOrder ,
		TMI_PROJECTS.project AS Project ,
		TMI_ROLES.id AS RolesID ,
		TMI_ROLES.tmiorder AS RolesOrder ,
		TMI_ROLES.role AS Role
	FROM TMI_PROJECTS
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = TMI_PROJECTS.rolesID
	LEFT JOIN TMI_MANUALS ON  TMI_MANUALS.id = TMI_PROJECTS.manualsID
	LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
	LEFT JOIN TMI_QUALS_MANUALGROUPS ON TMI_QUALS_MANUALGROUPS.manual_groupID = TMI_MANUAL_GROUPS.id
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = TMI_QUALS_MANUALGROUPS.qualificationID
	LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID;
SELECT * FROM TTX_TMI_STRUCTURE0;

/*
SECTION 1 OF 2: CURRENT MEMBERS, THEIR QUALIFICATIONS AND PROJECTS
*/

-- ========================  TTX_QUALIFICATIONS 0-1 ========================

-- Lists members qualifications: ALL
DROP TABLE IF EXISTS TTX_QUALIFICATIONS0;
CREATE TABLE TTX_QUALIFICATIONS0 AS
	SELECT
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_TRACKS.id AS TracksID ,
		TMI_TRACKS.tmiorder AS TracksOrder ,
		TMI_TRACKS.track AS Track ,
		TMI_QUALIFICATIONS.id AS QualificationsID ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationsOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
		RECORDS_QUALIFICATIONS.qualificationdate AS QualificationDate,
		RECORDS_QUALIFICATIONS.qualificationstatus AS QualificationStatus ,
		RECORDS_CLUBS.name AS Club ,
		RECORDS_MEMBERS.currentmember AS CurrentMember ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TMI_QUALIFICATIONS.id) AS NameFull_QualificationsID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification
	FROM RECORDS_QUALIFICATIONS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_QUALIFICATIONS.membersID
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_QUALIFICATIONS.qualificationsID
	LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID
	LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID;
-- Lists members qualifications: from SET Club, Current Member and 'In Progress'
DROP TABLE IF EXISTS TTX_QUALIFICATIONS1;
CREATE TABLE TTX_QUALIFICATIONS1 AS
    SELECT *
    FROM TTX_QUALIFICATIONS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (QualificationStatus = @QualificationStatus);
SELECT * FROM TTX_QUALIFICATIONS0 ORDER BY NameFull , Qualification;
SELECT * FROM TTX_QUALIFICATIONS1 ORDER BY NameFull , Qualification;


-- ========================  TTX_RECORDS_PROJECTS 0-2 ========================

-- Lists projects including duplicates: ALL MEMBERS
DROP TABLE IF EXISTS TTX_RECORDS_PROJECTS0;
CREATE TABLE TTX_RECORDS_PROJECTS0 AS
	SELECT
		RECORDS_PROJECTS.id AS RP_ID ,
		RECORDS_PROJECTS.membersID AS MembersID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,

		TMI_TRACKS.id AS TracksID ,
		TMI_TRACKS.tmiorder AS TracksOrder ,
		TMI_TRACKS.track AS Track ,

		RECORDS_PROJECTS.qualificationsID AS RP_QualificationsID ,
		TMI_QUALIFICATIONS.id AS QualificationsID ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationsOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,

		TMI_MANUAL_GROUPS.id AS ManualGroupsID ,
		TMI_MANUAL_GROUPS.tmiorder AS ManualGroupsOrder ,
		TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,

		TMI_MANUALS.id AS ManualsID ,
		TMI_MANUALS.tmiorder AS ManualsOrder ,
		TMI_MANUALS.manual AS Manual ,

		RECORDS_PROJECTS.projectsID AS RP_ProjectsID ,
		TMI_PROJECTS.id AS ProjectsID ,
		TMI_PROJECTS.tmiorder AS ProjectOrder ,
		TMI_PROJECTS.project AS Project ,

		RECORDS_PROJECTS.rolesID AS RP_RolesID,
		TMI_ROLES.id AS RolesID ,
		TMI_ROLES.tmiorder AS RolesOrder ,
		TMI_ROLES.role AS Role ,

		RECORDS_PROJECTS.projectdate AS Date1 ,
		RECORDS_PROJECTS.itemstatus AS Status1 ,
		RECORDS_MEMBERS.currentmember AS CurrentMember ,
		RECORDS_CLUBS.name AS Club ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_QUALIFICATIONS.id) AS NameFull_QualificationsID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_QUALIFICATIONS.qualification) AS NameFull_Qualification ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_PROJECTS.id) AS NameFull_ProjectsID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_PROJECTS.project) AS NameFull_Project ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TMI_ROLES.id) AS NameFull_RolesID ,
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
SELECT * FROM TTX_RECORDS_PROJECTS0;

-- Lists projects including duplicates + Qualification Status: ALL MEMBERS
DROP TABLE IF EXISTS TTX_RECORDS_PROJECTS1;
CREATE TABLE TTX_RECORDS_PROJECTS1 AS
	SELECT
		TTX_RECORDS_PROJECTS0.RP_ID AS RP_ID ,
		TTX_RECORDS_PROJECTS0.MembersID AS MembersID ,
		TTX_RECORDS_PROJECTS0.NameFull AS NameFull ,

		TTX_RECORDS_PROJECTS0.TracksID AS TracksID ,
		TTX_RECORDS_PROJECTS0.TracksOrder AS TracksOrder ,
		TTX_RECORDS_PROJECTS0.Track AS Track ,

		TTX_RECORDS_PROJECTS0.QualificationsID AS QualificationsID ,
		TTX_RECORDS_PROJECTS0.QualificationsOrder AS QualificationsOrder ,
		TTX_RECORDS_PROJECTS0.Qualification AS Qualification ,

		TTX_RECORDS_PROJECTS0.ManualGroupsID AS ManualGroupsID ,
		TTX_RECORDS_PROJECTS0.ManualGroupsOrder AS ManualGroupsOrder ,
		TTX_RECORDS_PROJECTS0.ManualGroup AS ManualGroup ,

		TTX_RECORDS_PROJECTS0.ManualsID AS ManualsID ,
		TTX_RECORDS_PROJECTS0.ManualsOrder AS ManualsOrder ,
		TTX_RECORDS_PROJECTS0.Manual AS Manual ,

		TTX_RECORDS_PROJECTS0.ProjectsID AS ProjectsID ,
		TTX_RECORDS_PROJECTS0.ProjectOrder AS ProjectsOrder ,
		TTX_RECORDS_PROJECTS0.Project AS Project ,

		TTX_RECORDS_PROJECTS0.RolesID AS RolesID ,
		TTX_RECORDS_PROJECTS0.RolesOrder AS RolesOrder ,
		TTX_RECORDS_PROJECTS0.Role AS Role ,

		TTX_QUALIFICATIONS0.qualificationstatus AS QualificationStatus ,
		TTX_RECORDS_PROJECTS0.Date1 AS Date1 ,
		CAST(TTX_RECORDS_PROJECTS0.Date1 AS unsigned) AS Date1Num ,
		TTX_RECORDS_PROJECTS0.Status1 AS Status1 ,
		TTX_RECORDS_PROJECTS0.CurrentMember AS CurrentMember ,
		TTX_RECORDS_PROJECTS0.Club AS Club ,
		TTX_RECORDS_PROJECTS0.NameFull_QualificationsID AS NameFull_QualificationsID ,
		TTX_RECORDS_PROJECTS0.NameFull_Qualification AS NameFull_Qualification ,
		TTX_RECORDS_PROJECTS0.NameFull_ProjectsID AS NameFull_ProjectsID ,
		TTX_RECORDS_PROJECTS0.NameFull_Project AS NameFull_Project ,
		TTX_RECORDS_PROJECTS0.NameFull_RolesID AS NameFull_RolesID ,
		TTX_RECORDS_PROJECTS0.NameFull_Role AS NameFull_Role
	FROM TTX_RECORDS_PROJECTS0
	LEFT JOIN TTX_QUALIFICATIONS0 ON TTX_QUALIFICATIONS0.NameFull_Qualification = TTX_RECORDS_PROJECTS0.NameFull_Qualification;

-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member
DROP TABLE IF EXISTS TTX_RECORDS_PROJECTS2;
CREATE TABLE TTX_RECORDS_PROJECTS2 AS
	SELECT *
    FROM TTX_RECORDS_PROJECTS1
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (Qualification <> 'No qualification')
        AND (Role <> 'No role')
        AND (DATE1 = '2017-07-26')
        -- AND (RECORDS_PROJECTS.itemstatus = 'actual');
        -- AND (CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) = 'Donald Jessep');
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;

SELECT * FROM TTX_RECORDS_PROJECTS1;
SELECT * FROM TTX_RECORDS_PROJECTS2;

-- ========================  TTX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: ALL MEMBERS
DROP TABLE IF EXISTS TTX_MOSTRECENTPROJECT0;
CREATE TABLE TTX_MOSTRECENTPROJECT0 AS
    SELECT
					a.MembersID ,
					a.NameFull ,
					a.Club ,
					a.CurrentMember ,
					a.Track ,
					a.QualificationsID ,
					a.QualificationsOrder ,
					a.Qualification ,
					a.QualificationStatus ,
					a.ManualGroupsID ,
					a.ManualGroupsOrder ,
					a.ManualGroup ,
					a.ManualsID ,
					a.ManualsOrder ,
					a.Manual ,
					a.ProjectsID ,
					a.ProjectsOrder ,
					a.Project ,
					a.RolesID ,
					a.RolesOrder ,
					a.Role ,
					a.Status1 ,
					a.Date1 ,
					a.Date1Num ,
					a.NameFull_ProjectsID ,
					a.NameFull_RolesID
        FROM TTX_RECORDS_PROJECTS1 a
        LEFT OUTER JOIN TTX_RECORDS_PROJECTS1 b
            ON a.NameFull_Project = b.NameFull_Project AND a.Date1Num < b.Date1Num
        WHERE
            (b.NameFull_Project IS NULL)
        ORDER BY NameFull , QualificationsOrder , ManualsOrder , ProjectsOrder , Date1Num;

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member
DROP TABLE IF EXISTS TTX_MOSTRECENTPROJECT1;
CREATE TABLE TTX_MOSTRECENTPROJECT1 AS
    SELECT *
        FROM TTX_MOSTRECENTPROJECT0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;

SELECT * FROM TTX_MOSTRECENTPROJECT0;
SELECT * FROM TTX_MOSTRECENTPROJECT1;

-- ========================  TTX_MOSTRECENTROLE 0-1 ========================


-- Lists most recent role: ALL MEMBERS
DROP TABLE IF EXISTS TTX_MOSTRECENTROLE0;
CREATE TABLE TTX_MOSTRECENTROLE0 AS
    SELECT
			a.MembersID AS MembersID,
			a.NameFull AS NameFull ,
			a.Club AS Club ,
			a.CurrentMember AS CurrentMember ,
			a.TracksID AS TracksID,
			a.Track AS Track ,
			a.QualificationsID AS QualificationsID ,
			a.QualificationsOrder AS QualificationsOrder ,
			a.Qualification AS Qualification ,
			a.RolesID AS RolesID ,
			a.RolesOrder AS RolesOrder ,
			a.Role AS Role ,
			a.Status1 AS Status1 ,
			a.Date1 AS Date1 ,
			a.Date1Num AS Date1Num ,
			a.NameFull_Role as NameFull_Role ,
			a.NameFull_ProjectsID AS NameFull_ProjectsID ,
			a.NameFull_RolesID as NameFull_RolesID
    FROM TTX_RECORDS_PROJECTS1 a
    LEFT OUTER JOIN TTX_RECORDS_PROJECTS1 b
        ON a.NameFull_Role = b.NameFull_Role AND a.Date1Num < b.Date1Num
    WHERE
        (b.NameFull_Role IS NULL)
    ORDER BY RolesOrder , Date1Num , NameFull;

-- Lists most recent role: from SET Club and Current Member
DROP TABLE IF EXISTS TTX_MOSTRECENTROLE1;
CREATE TABLE TTX_MOSTRECENTROLE1 AS
    SELECT *
        FROM TTX_MOSTRECENTROLE0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        GROUP BY NameFull , Role
        ORDER BY RolesOrder , Date1Num , NameFull;

SELECT * FROM TTX_MOSTRECENTROLE0;
SELECT * FROM TTX_MOSTRECENTROLE1;


/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES
*/

-- ========================  TTX_CURRENTMEMBERS 0-1 ========================

-- Lists current Members: ALL MEMBERS
DROP TABLE IF EXISTS TTX_CURRENTMEMBERS0;
CREATE TABLE TTX_CURRENTMEMBERS0 AS
    SELECT
        CONCAT(RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull ,
        currentclubs ,
        currentmember
    FROM RECORDS_MEMBERS;
-- SELECT * FROM V_CURRENTMEMBERS0 ORDER BY currentclubs , currentmember , NameFull;

-- Lists current Members: SET by Club
DROP TABLE IF EXISTS TTX_CURRENTMEMBERS1;
CREATE TABLE TTX_CURRENTMEMBERS1 AS
    SELECT *
    FROM TTX_CURRENTMEMBERS0
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember);
-- SELECT * FROM V_CURRENTMEMBERS1 ORDER BY currentclubs , currentmember , NameFull;

-- ========================  TTX_CONTESTABLE_TMIROLES 0 ========================

-- Lists All Contestable Roles
DROP TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES0;
CREATE TABLE TTX_CONTESTABLE_TMIROLES0 AS
    SELECT Role
    FROM TMI_ROLES
    WHERE contestable = 'Yes';
-- SELECT * FROM V_CONTESTABLE_TMIROLES;

-- ========================  TTX_CONTESTABLE_TMIROLES_TO_MEMBERS 0-2 ========================

-- CROSS JOIN MEMBERS & CONTESTABLE ROLES: All Members
DROP TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
CREATE TABLE TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0 AS
    SELECT *
    FROM TTX_CONTESTABLE_TMIROLES0
    CROSS JOIN TTX_CURRENTMEMBERS0;
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS0;

DROP TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1;
CREATE TABLE TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1 AS
    SELECT
        * ,
        CONCAT(NameFull , ' - ' , Role) AS NameFull_Role
    FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
-- SELECT * FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS1;

-- CROSS JOIN MEMBERS & CONTESTABLE ROLES: from SET Club and Current Member
DROP TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES_TO_MEMBERS2;
CREATE TABLE TTX_CONTESTABLE_TMIROLES_TO_MEMBERS2 AS
    SELECT *
    FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember);
SELECT * FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1;
SELECT * FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS2;


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
