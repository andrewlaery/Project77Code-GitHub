

-- ========================  TTX_TMI_STRUCTURE 0 ========================

-- Combination of the TMI Data Tables to show the TMI Structure
DROP TABLE IF EXISTS TX_TMI_STRUCTURE0;
CREATE TABLE TX_TMI_STRUCTURE0
	(id Serial ,
    TracksID bigint(40) unsigned ,
    TracksOrder INT ,
    Track VARCHAR(255) ,
    QualificationsID bigint(40) unsigned ,
    QualificationsOrder INT ,
    Qualification VARCHAR(255) ,
    QualificationShort VARCHAR(255) ,
    ManualGroupsID bigint(40) unsigned ,
    ManualGroupsOrder INT ,
    ManualGroup VARCHAR(255) ,
    ManualsID bigint(40) unsigned ,
    ManualsOrder INT ,
    Manual VARCHAR(255) ,
    ProjectsID bigint(40) unsigned ,
    ProjectsOrder INT ,
    Project VARCHAR(255) ,
    RolesID bigint(40) unsigned ,
    RolesOrder INT ,
    Role VARCHAR(255) ,
    QualificationProject VARCHAR(255));

INSERT INTO TX_TMI_STRUCTURE0
		(TracksID ,
		TracksOrder ,
		Track ,
		QualificationsID , 
		QualificationsOrder ,
		Qualification ,
		QualificationShort ,
		ManualGroupsID ,
		ManualGroupsOrder ,
		ManualGroup ,
		ManualsID ,
		ManualsOrder ,
		Manual ,
		ProjectsID ,
		ProjectsOrder ,
		Project ,
		RolesID ,
		RolesOrder ,
		Role ,
		QualificationProject)
	SELECT
		TMI_TRACKS.id ,
		TMI_TRACKS.tmiorder ,
		TMI_TRACKS.track ,
		TMI_QUALIFICATIONS.id ,
		TMI_QUALIFICATIONS.tmiorder ,
		TMI_QUALIFICATIONS.qualification ,
		TMI_QUALIFICATIONS.qualificationshort ,
		TMI_MANUAL_GROUPS.id ,
		TMI_MANUAL_GROUPS.tmiorder ,
		TMI_MANUAL_GROUPS.manual_group ,
		TMI_MANUALS.id ,
		TMI_MANUALS.tmiorder ,
		TMI_MANUALS.manual ,
		TMI_PROJECTS.id ,
		TMI_PROJECTS.tmiorder ,
		TMI_PROJECTS.project ,
		TMI_ROLES.id ,
		TMI_ROLES.tmiorder ,
		TMI_ROLES.role ,
		CONCAT(TMI_QUALIFICATIONS.id , '-', TMI_PROJECTS.id)
	FROM TMI_PROJECTS
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = TMI_PROJECTS.rolesID
	LEFT JOIN TMI_MANUALS ON  TMI_MANUALS.id = TMI_PROJECTS.manualsID
	LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
	LEFT JOIN TMI_QUALS_MANUALGROUPS ON TMI_QUALS_MANUALGROUPS.manual_groupID = TMI_MANUAL_GROUPS.id
	LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = TMI_QUALS_MANUALGROUPS.qualificationID
	LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID;
SELECT * FROM TX_TMI_STRUCTURE0;

/*
SECTION 1 OF 2: CURRENT MEMBERS, THEIR QUALIFICATIONS AND PROJECTS
*/

-- ========================  TTX_QUALIFICATIONS ========================

-- Lists members qualifications: ALL
DROP TEMPORARY TABLE IF EXISTS TTX_QUALIFICATIONS0;
CREATE TEMPORARY TABLE TTX_QUALIFICATIONS0 AS
	SELECT
		RECORDS_QUALIFICATIONS.membersID AS MembersID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,
		TMI_TRACKS.id AS TracksID ,
		TMI_TRACKS.tmiorder AS TracksOrder ,
		TMI_TRACKS.track AS Track ,
		TMI_QUALIFICATIONS.id AS QualificationsID ,
		TMI_QUALIFICATIONS.tmiorder AS QualificationsOrder ,
		TMI_QUALIFICATIONS.qualification AS Qualification ,
		TMI_QUALIFICATIONS.qualificationshort AS QualificationShort ,
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
SELECT * FROM TTX_QUALIFICATIONS0;

-- ========================  TTX_RECORDS_PROJECTS 0 ========================


DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_PROJECTS0;
CREATE TEMPORARY TABLE TTX_RECORDS_PROJECTS0 AS
	SELECT
		RECORDS_PROJECTS.id AS RP_ID ,
		RECORDS_PROJECTS.membersID,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) AS NameFull ,

		TTX_TMI_STRUCTURE0.tracksID AS TracksID ,
		TTX_TMI_STRUCTURE0.tracksorder AS TracksOrder ,
		TTX_TMI_STRUCTURE0.track AS Track ,

		RECORDS_PROJECTS.qualificationsID AS RP_QualificationsID,
		TTX_TMI_STRUCTURE0.qualificationsID AS QualificationsID ,
		TTX_TMI_STRUCTURE0.qualificationsorder AS QualificationsOrder ,
		TTX_TMI_STRUCTURE0.qualification AS Qualification ,
		TTX_TMI_STRUCTURE0.QualificationShort AS QualificationShort ,

		TTX_TMI_STRUCTURE0.ManualGroupsID AS ManualGroupsID ,
		TTX_TMI_STRUCTURE0.ManualGroupsOrder AS ManualGroupsOrder ,
		TTX_TMI_STRUCTURE0.ManualGroup AS ManualGroup ,

		TTX_TMI_STRUCTURE0.ManualsID AS ManualsID ,
		TTX_TMI_STRUCTURE0.ManualsOrder AS ManualsOrder ,
		TTX_TMI_STRUCTURE0.Manual AS Manual ,

		RECORDS_PROJECTS.projectsID AS RP_ProjectsID ,
		TTX_TMI_STRUCTURE0.ProjectsID AS ProjectsID ,
		TTX_TMI_STRUCTURE0.ProjectsOrder AS ProjectsOrder ,
		TTX_TMI_STRUCTURE0.Project AS Project ,

		RECORDS_PROJECTS.rolesID AS RP_RolesID,
		TTX_TMI_STRUCTURE0.RolesID AS RolesID ,
		TTX_TMI_STRUCTURE0.RolesOrder AS RolesOrder ,
		TTX_TMI_STRUCTURE0.Role AS Role ,

		TTX_QUALIFICATIONS0.qualificationstatus AS QualificationStatus ,
		RECORDS_PROJECTS.projectdate AS Date1 ,
		CAST(RECORDS_PROJECTS.projectdate AS unsigned) AS Date1Num ,
		RECORDS_PROJECTS.itemstatus AS Status1 ,
		RECORDS_MEMBERS.currentmember AS CurrentMember ,
		RECORDS_CLUBS.name AS Club ,

		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.qualificationsID) AS NameFull_QualificationsID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.qualification) AS NameFull_Qualification ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.projectsID) AS NameFull_ProjectsID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.project) AS NameFull_Project ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.rolesID) AS NameFull_RolesID ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TTX_TMI_STRUCTURE0.role) AS NameFull_Role

	FROM RECORDS_PROJECTS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_PROJECTS.membersID
	LEFT JOIN TTX_TMI_STRUCTURE0 ON TTX_TMI_STRUCTURE0.QualficationProject = CONCAT(RECORDS_PROJECTS.qualificationsID , '-' , RECORDS_PROJECTS.projectsID)
	LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID
	LEFT JOIN TTX_QUALIFICATIONS0 ON TTX_QUALIFICATIONS0.NameFull_QualificationsID = CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TTX_TMI_STRUCTURE0.qualificationsID);
SELECT * FROM TTX_RECORDS_PROJECTS0;

/*
-- Lists projects including duplicates: ALL MEMBERS
DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_PROJECTS0;
CREATE TEMPORARY TABLE TTX_RECORDS_PROJECTS0 AS
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
-- SELECT * FROM TTX_RECORDS_PROJECTS0;

-- Lists projects including duplicates + Qualification Status: ALL MEMBERS
DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_PROJECTS0;
CREATE TEMPORARY TABLE TTX_RECORDS_PROJECTS0 AS
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
-- SELECT * FROM TTX_RECORDS_PROJECTS0
*/

-- ========================  TTX_MOSTRECENTPROJECT 0 ========================

-- Lists members most recent projects excluding duplicates: ALL MEMBERS

DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTPROJECT_SETUP1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTPROJECT_SETUP1 AS
  SELECT
    MembersID ,
    NameFull ,
    Club ,
    CurrentMember ,
    Track ,
    QualificationsID ,
    QualificationsOrder ,
    Qualification ,
		QualificationShort ,
    QualificationStatus ,
    ManualGroupsID ,
    ManualGroupsOrder ,
    ManualGroup ,
    ManualsID ,
    ManualsOrder ,
    Manual ,
    ProjectsID ,
    ProjectsOrder ,
    Project ,
    RolesID ,
    RolesOrder ,
    Role ,
    Status1 ,
    Date1 ,
    Date1Num ,
    NameFull_ProjectsID ,
    NameFull_RolesID
  FROM TTX_RECORDS_PROJECTS0;
-- SELECT * FROM TTX_MOSTRECENTPROJECT_SETUP1;

DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTPROJECT_SETUP2;
CREATE TEMPORARY TABLE TTX_MOSTRECENTPROJECT_SETUP2 AS
  SELECT
		NameFull_ProjectsID AS NameFull_ProjectsID,
		MAX(Date1Num) AS Date1Num
  FROM TTX_RECORDS_PROJECTS0
  GROUP BY NameFull_ProjectsID;
-- SELECT * FROM TTX_MOSTRECENTPROJECT_SETUP2;

DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTPROJECT0;
CREATE TEMPORARY TABLE TTX_MOSTRECENTPROJECT0 AS
SELECT
  MembersID ,
  NameFull ,
  Club ,
  CurrentMember ,
  Track ,
  QualificationsID ,
  QualificationsOrder ,
  Qualification ,
	QualificationShort ,
  QualificationStatus ,
  ManualGroupsID ,
  ManualGroupsOrder ,
  ManualGroup ,
  ManualsID ,
  ManualsOrder ,
  Manual ,
  ProjectsID ,
  ProjectsOrder ,
  Project ,
  RolesID ,
  RolesOrder ,
  Role ,
  Status1 ,
  Date1 ,
  TTX_MOSTRECENTPROJECT_SETUP1.Date1Num ,
  TTX_MOSTRECENTPROJECT_SETUP1.NameFull_ProjectsID ,
  NameFull_RolesID
FROM TTX_MOSTRECENTPROJECT_SETUP1
INNER JOIN TTX_MOSTRECENTPROJECT_SETUP2
  ON
    TTX_MOSTRECENTPROJECT_SETUP1.NameFull_ProjectsID = TTX_MOSTRECENTPROJECT_SETUP2.NameFull_ProjectsID
    AND TTX_MOSTRECENTPROJECT_SETUP1.Date1Num = TTX_MOSTRECENTPROJECT_SETUP2.Date1Num;
-- SELECT * FROM TTX_MOSTRECENTPROJECT0;


-- ========================  TTX_MOSTRECENTROLE 0 ========================


-- Lists most recent role: ALL MEMBERS


DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE_SETUP1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE_SETUP1 AS
    SELECT
			MembersID,
			NameFull ,
			Club ,
			CurrentMember ,
			TracksID,
			Track ,
			QualificationsID ,
			QualificationsOrder ,
			Qualification ,
			QualificationShort ,
			RolesID ,
			RolesOrder ,
			Role ,
			Status1 ,
			Date1 ,
			Date1Num ,
			NameFull_Role ,
			NameFull_ProjectsID ,
			NameFull_RolesID
    FROM TTX_RECORDS_PROJECTS0;
-- SELECT * FROM TTX_MOSTRECENTROLE_SETUP1;

DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE_SETUP2;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE_SETUP2 AS
    SELECT
			MembersID,
			NameFull ,
			Club ,
			CurrentMember ,
			TracksID,
			Track ,
			QualificationsID ,
			QualificationsOrder ,
			Qualification ,
			QualificationShort ,
			RolesID ,
			RolesOrder ,
			Role ,
			Status1 ,
			Date1 ,
			Date1Num ,
			NameFull_Role ,
			NameFull_ProjectsID ,
			NameFull_RolesID
    FROM TTX_RECORDS_PROJECTS0;
-- SELECT * FROM TTX_MOSTRECENTROLE_SETUP2;

SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE0;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE0 AS
    SELECT
        TTX_MOSTRECENTROLE_SETUP1.MembersID AS MembersID,
        TTX_MOSTRECENTROLE_SETUP1.NameFull AS NameFull ,
        TTX_MOSTRECENTROLE_SETUP1.Club AS Club ,
        TTX_MOSTRECENTROLE_SETUP1.CurrentMember AS CurrentMember ,
        TTX_MOSTRECENTROLE_SETUP1.TracksID AS TracksID,
        TTX_MOSTRECENTROLE_SETUP1.Track AS Track ,
        TTX_MOSTRECENTROLE_SETUP1.QualificationsID AS QualificationsID ,
        TTX_MOSTRECENTROLE_SETUP1.QualificationsOrder AS QualificationsOrder ,
        TTX_MOSTRECENTROLE_SETUP1.Qualification AS Qualification ,
				TTX_MOSTRECENTROLE_SETUP1.QualificationShort AS QualificationShort ,
        TTX_MOSTRECENTROLE_SETUP1.RolesID AS RolesID ,
        TTX_MOSTRECENTROLE_SETUP1.RolesOrder AS RolesOrder ,
        TTX_MOSTRECENTROLE_SETUP1.Role AS Role ,
        TTX_MOSTRECENTROLE_SETUP1.Status1 AS Status1 ,
        TTX_MOSTRECENTROLE_SETUP1.Date1 AS Date1 ,
        TTX_MOSTRECENTROLE_SETUP1.Date1Num AS Date1Num ,
        TTX_MOSTRECENTROLE_SETUP1.NameFull_Role as NameFull_Role ,
        TTX_MOSTRECENTROLE_SETUP1.NameFull_ProjectsID AS NameFull_ProjectsID ,
        TTX_MOSTRECENTROLE_SETUP1.NameFull_RolesID as NameFull_RolesID
    FROM TTX_MOSTRECENTROLE_SETUP1
    LEFT OUTER JOIN TTX_MOSTRECENTROLE_SETUP2
        ON TTX_MOSTRECENTROLE_SETUP1.NameFull_Role = TTX_MOSTRECENTROLE_SETUP2.NameFull_Role AND TTX_MOSTRECENTROLE_SETUP1.Date1Num < TTX_MOSTRECENTROLE_SETUP2.Date1Num
        WHERE (TTX_MOSTRECENTROLE_SETUP2.NameFull_Role IS NULL)
	GROUP BY TTX_MOSTRECENTROLE_SETUP1.NameFull , TTX_MOSTRECENTROLE_SETUP1.Role
	ORDER BY TTX_MOSTRECENTROLE_SETUP1.NameFull , TTX_MOSTRECENTROLE_SETUP1.RolesOrder , TTX_MOSTRECENTROLE_SETUP1.Date1Num , TTX_MOSTRECENTROLE_SETUP1.NameFull;
SELECT * FROM TTX_MOSTRECENTROLE0;

/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES
*/

-- ========================  TTX_ALLMEMBERS 0 ========================

-- Lists current Members: ALL MEMBERS
DROP TEMPORARY TABLE IF EXISTS TTX_ALLMEMBERS0;
CREATE TEMPORARY TABLE TTX_ALLMEMBERS0 AS
    SELECT
				id AS MembersID ,
				CONCAT(RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull ,
        currentclubs ,
        currentmember
    FROM RECORDS_MEMBERS;
SELECT * FROM TTX_ALLMEMBERS0 ORDER BY currentclubs , currentmember , NameFull;
SELECT * FROM TTX_ALLMEMBERS0;

-- ========================  TTX_RECORDS_MEMBER_UNAVAILABILITY 0 ========================

DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_MEMBER_UNAVAILABILITY0;
CREATE TEMPORARY TABLE TTX_RECORDS_MEMBER_UNAVAILABILITY0 AS
	SELECT
			RECORDS_MEMBER_UNAVAILABILITY.membersID AS MembersID ,
			CONCAT(RECORDS_MEMBERS.namefirst , " " , RECORDS_MEMBERS.namelast) AS NameFull ,
			RECORDS_MEMBER_UNAVAILABILITY.rolesID AS RolesID ,
			TMI_ROLES.Role AS Role ,
			RECORDS_MEMBER_UNAVAILABILITY.startdate AS StartDate ,
			RECORDS_MEMBER_UNAVAILABILITY.enddate AS EndDate ,
			RECORDS_MEMBER_UNAVAILABILITY.notes AS Notes ,
			CONCAT(RECORDS_MEMBERS.namefirst , " " , RECORDS_MEMBERS.namelast , ' - ' , TMI_ROLES.Role) AS NameFull_Role ,
			CONCAT(RECORDS_MEMBERS.namefirst , " " , RECORDS_MEMBERS.namelast , ' - ' , RECORDS_MEMBER_UNAVAILABILITY.rolesID) AS NameFull_RoleID
	FROM RECORDS_MEMBER_UNAVAILABILITY
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_MEMBER_UNAVAILABILITY.MembersID
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = RECORDS_MEMBER_UNAVAILABILITY.RolesID;
SELECT * FROM TTX_RECORDS_MEMBER_UNAVAILABILITY0;


-- ========================  TTX_CONTESTABLE_TMIROLES 0 ========================

-- Lists All Contestable Roles
DROP TEMPORARY TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES0;
CREATE TEMPORARY TABLE TTX_CONTESTABLE_TMIROLES0 AS
    SELECT Role
    FROM TMI_ROLES
    WHERE contestable = 'Yes';
SELECT * FROM TTX_CONTESTABLE_TMIROLES0;

-- ========================  TTX_CONTESTABLE_TMIROLES_TO_MEMBERS 0-2 ========================

-- CROSS JOIN MEMBERS & CONTESTABLE ROLES: All Members
DROP TEMPORARY TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
CREATE TEMPORARY TABLE TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0 AS
    SELECT
			* ,
			CONCAT(TTX_ALLMEMBERS0.NameFull , ' - ' , TTX_CONTESTABLE_TMIROLES0.Role) AS NameFull_Role1
    FROM TTX_CONTESTABLE_TMIROLES0
    CROSS JOIN TTX_ALLMEMBERS0;
SELECT * FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
