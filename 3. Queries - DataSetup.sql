

-- ========================  TMI STRUCTURE  ========================

-- Combination of the TMI Data Tables to show the TMI Structure
DROP TABLE IF EXISTS TX_TMI_STRUCTURE0;
CREATE TABLE TX_TMI_STRUCTURE0
	(
		id Serial ,

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

		QualificationProject VARCHAR(255)
	);

INSERT INTO TX_TMI_STRUCTURE0
		(
			TracksID ,
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

			QualificationProject
		)
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

-- ========================  QUALIFICATIONS ========================

-- Lists members qualifications: ALL

DROP TABLE IF EXISTS TX_QUALIFICATIONS0;
CREATE TABLE TX_QUALIFICATIONS0
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,

		TracksID bigint(40) unsigned ,
		TracksOrder INT ,
		Track VARCHAR(255) ,

		QualificationsID bigint(40) unsigned ,
		QualificationsOrder INT ,
		Qualification VARCHAR(255) ,
		QualificationShort VARCHAR(255) ,
		QualificationDate DATE ,
		QualificationStatus VARCHAR(255),

		Club VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,

		NameFull_QualificationsID VARCHAR(255) ,
		NameFull_Qualification VARCHAR(255)
	);

INSERT INTO TX_QUALIFICATIONS0
		(
			MembersID ,
			NameFull ,

			TracksID ,
			TracksOrder ,
			Track ,

			QualificationsID ,
			QualificationsOrder ,
			Qualification ,
			QualificationShort ,
			QualificationDate ,
			QualificationStatus ,

			Club ,
			CurrentMember ,

			NameFull_QualificationsID ,
			NameFull_Qualification
		)
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
SELECT * FROM TX_QUALIFICATIONS0;

-- ========================  RECORDS_PROJECTS ========================

DROP TABLE IF EXISTS TX_RECORDS_PROJECTS0;
CREATE TABLE TX_RECORDS_PROJECTS0
	(
		id SERIAL ,

		RP_ID bigint(40) unsigned ,
		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,

		TracksID bigint(40) unsigned ,
		TracksOrder INT ,
		Track VARCHAR(255) ,

		RP_QualificationsID bigint(40) unsigned ,
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

		RP_ProjectsID bigint(40) unsigned ,
		ProjectsID bigint(40) unsigned ,
		ProjectsOrder INT ,
		Project VARCHAR(255) ,

		RP_RolesID bigint(40) unsigned ,
		RolesID bigint(40) unsigned ,
		RolesOrder INT ,
		Role VARCHAR(255) ,

		QualificationStatus VARCHAR(255) ,
		Date1 DATE,
		Date1Num INT,
		Status1 VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,
		Club VARCHAR(255) ,

		NameFull_QualificationsID VARCHAR(255) ,
		NameFull_Qualification VARCHAR(255) ,
		NameFull_ProjectsID VARCHAR(255) ,
		NameFull_Project VARCHAR(255) ,
		NameFull_RolesID VARCHAR(255) ,
		NameFull_Role VARCHAR(255)
	);

INSERT INTO TX_RECORDS_PROJECTS0
	(
			RP_ID ,
			MembersID ,
			NameFull ,

			TracksID ,
			TracksOrder ,
			Track ,

			RP_QualificationsID,
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

			RP_ProjectsID ,
			ProjectsID ,
			ProjectsOrder ,
			Project ,

			RP_RolesID,
			RolesID ,
			RolesOrder ,
			Role ,

			QualificationStatus ,
			Date1 ,
			Date1Num ,
			Status1 ,
			CurrentMember ,
			Club ,

			NameFull_QualificationsID ,
			NameFull_Qualification ,
			NameFull_ProjectsID ,
			NameFull_Project ,
			NameFull_RolesID ,
			NameFull_Role
	)
	SELECT
		RECORDS_PROJECTS.id ,
		RECORDS_PROJECTS.membersID,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) ,

		TX_TMI_STRUCTURE0.tracksID ,
		TX_TMI_STRUCTURE0.tracksorder ,
		TX_TMI_STRUCTURE0.track ,

		RECORDS_PROJECTS.qualificationsID,
		TX_TMI_STRUCTURE0.qualificationsID ,
		TX_TMI_STRUCTURE0.qualificationsorder ,
		TX_TMI_STRUCTURE0.qualification ,
		TX_TMI_STRUCTURE0.QualificationShort ,

		TX_TMI_STRUCTURE0.ManualGroupsID ,
		TX_TMI_STRUCTURE0.ManualGroupsOrder ,
		TX_TMI_STRUCTURE0.ManualGroup ,

		TX_TMI_STRUCTURE0.ManualsID ,
		TX_TMI_STRUCTURE0.ManualsOrder ,
		TX_TMI_STRUCTURE0.Manual ,

		RECORDS_PROJECTS.projectsID ,
		TX_TMI_STRUCTURE0.ProjectsID ,
		TX_TMI_STRUCTURE0.ProjectsOrder ,
		TX_TMI_STRUCTURE0.Project ,

		RECORDS_PROJECTS.rolesID ,
		TX_TMI_STRUCTURE0.RolesID ,
		TX_TMI_STRUCTURE0.RolesOrder ,
		TX_TMI_STRUCTURE0.Role ,

		TX_QUALIFICATIONS0.qualificationstatus ,
		RECORDS_PROJECTS.projectdate ,
		CAST(RECORDS_PROJECTS.projectdate AS unsigned) ,
		RECORDS_PROJECTS.itemstatus ,
		RECORDS_MEMBERS.currentmember ,
		RECORDS_CLUBS.name ,

		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.qualificationsID) ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.qualification) ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.projectsID) ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.project) ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.rolesID) ,
		CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , " - " , TX_TMI_STRUCTURE0.role)
	FROM RECORDS_PROJECTS
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_PROJECTS.membersID
	LEFT JOIN TX_TMI_STRUCTURE0 ON TX_TMI_STRUCTURE0.QualificationProject = CONCAT(RECORDS_PROJECTS.qualificationsID , '-' , RECORDS_PROJECTS.projectsID)
	LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID
	LEFT JOIN TX_QUALIFICATIONS0 ON TX_QUALIFICATIONS0.NameFull_QualificationsID = CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast , ' - ' , TX_TMI_STRUCTURE0.qualificationsID);
SELECT * FROM TX_RECORDS_PROJECTS0;

-- ========================  MOSTRECENTPROJECT ========================

-- Lists members most recent projects excluding duplicates: ALL MEMBERS


DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT_SETUP1;
CREATE TABLE TX_MOSTRECENTPROJECT_SETUP1
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,
		Club VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,
		Track VARCHAR(255) ,

		QualificationsID bigint(40) unsigned ,
		QualificationsOrder INT ,
		Qualification VARCHAR(255) ,
		QualificationShort VARCHAR(255) ,
		QualificationStatus VARCHAR(255) ,

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

		Status1 VARCHAR(255) ,
		Date1 DATE ,
		Date1Num INT,

		NameFull_ProjectsID VARCHAR(255) ,
		NameFull_RolesID VARCHAR(255)
	);

INSERT INTO TX_MOSTRECENTPROJECT_SETUP1
		(
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
		)
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
  FROM TX_RECORDS_PROJECTS0;
-- SELECT * FROM TX_MOSTRECENTPROJECT_SETUP1;


DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT_SETUP2;
CREATE TABLE TX_MOSTRECENTPROJECT_SETUP2
	(
		id SERIAL ,
		NameFull_ProjectsID VARCHAR(255) ,
		Date1Num INT
	);

INSERT INTO TX_MOSTRECENTPROJECT_SETUP2
	(
		NameFull_ProjectsID ,
		Date1Num
	)
  SELECT
			NameFull_ProjectsID,
			MAX(Date1Num)
  	FROM TX_RECORDS_PROJECTS0
  	GROUP BY NameFull_ProjectsID;
-- SELECT * FROM TX_MOSTRECENTPROJECT_SETUP2;


DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT0;
CREATE TABLE TX_MOSTRECENTPROJECT0
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,
		Club VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,
		Track VARCHAR(255) ,

		QualificationsID bigint(40) unsigned ,
		QualificationsOrder INT ,
		Qualification VARCHAR(255) ,
		QualificationShort VARCHAR(255) ,
		QualificationStatus VARCHAR(255) ,

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

		Status1 VARCHAR(255) ,
		Date1 DATE ,
		Date1Num INT ,

		NameFull_ProjectsID VARCHAR(255) ,
		NameFull_RolesID VARCHAR(255)
	);

INSERT INTO TX_MOSTRECENTPROJECT0
		(
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
		)
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
	TX_MOSTRECENTPROJECT_SETUP1.Date1Num ,

	TX_MOSTRECENTPROJECT_SETUP1.NameFull_ProjectsID ,
	NameFull_RolesID
FROM TX_MOSTRECENTPROJECT_SETUP1
INNER JOIN TX_MOSTRECENTPROJECT_SETUP2
  ON
		TX_MOSTRECENTPROJECT_SETUP1.NameFull_ProjectsID = TX_MOSTRECENTPROJECT_SETUP2.NameFull_ProjectsID
		AND TX_MOSTRECENTPROJECT_SETUP1.Date1Num = TX_MOSTRECENTPROJECT_SETUP2.Date1Num;
SELECT * FROM TX_MOSTRECENTPROJECT0;


-- ========================  MOSTRECENTROLE  ========================


-- Lists most recent role: ALL MEMBERS
DROP TABLE IF EXISTS TX_MOSTRECENTROLE_SETUP1;
CREATE TABLE TX_MOSTRECENTROLE_SETUP1
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,
		Club VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,

		TracksID bigint(40) unsigned ,
		Track VARCHAR(255) ,

		QualificationsID bigint(40) unsigned ,
		QualificationsOrder INT ,
		Qualification VARCHAR(255) ,
		QualificationShort VARCHAR(255) ,

		RolesID bigint(40) unsigned ,
		RolesOrder INT ,
		Role VARCHAR(255) ,

		Status1 VARCHAR(255) ,
		Date1 DATE ,
		Date1Num INT ,

		NameFull_Role VARCHAR(255) ,
		NameFull_ProjectsID VARCHAR(255) ,
		NameFull_RolesID VARCHAR(255)
	);

INSERT INTO TX_MOSTRECENTROLE_SETUP1
		(
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
		)
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
	FROM TX_RECORDS_PROJECTS0;
-- SELECT * FROM TX_MOSTRECENTROLE_SETUP1;


-- Lists most recent role: ALL MEMBERS
DROP TABLE IF EXISTS TX_MOSTRECENTROLE_SETUP2;
CREATE TABLE TX_MOSTRECENTROLE_SETUP2
		(
			id SERIAL ,

			MembersID bigint(40) unsigned ,
			NameFull VARCHAR(255) ,
			Club VARCHAR(255) ,
			CurrentMember VARCHAR(255) ,

			TracksID bigint(40) unsigned ,
			Track VARCHAR(255) ,

			QualificationsID bigint(40) unsigned ,
			QualificationsOrder INT ,
			Qualification VARCHAR(255) ,
			QualificationShort VARCHAR(255) ,

			RolesID bigint(40) unsigned ,
			RolesOrder INT ,
			Role VARCHAR(255) ,

			Status1 VARCHAR(255) ,
			Date1 DATE ,
			Date1Num INT ,

			NameFull_Role VARCHAR(255) ,
			NameFull_ProjectsID VARCHAR(255) ,
			NameFull_RolesID VARCHAR(255)
		);

INSERT INTO TX_MOSTRECENTROLE_SETUP2
		(
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
		)
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
  FROM TX_RECORDS_PROJECTS0;
-- SELECT * FROM TX_MOSTRECENTROLE_SETUP2;

SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS TX_MOSTRECENTROLE0;
CREATE TABLE TX_MOSTRECENTROLE0
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,
		Club VARCHAR(255) ,
		CurrentMember VARCHAR(255) ,

		TracksID bigint(40) unsigned ,
		Track VARCHAR(255) ,

		QualificationsID bigint(40) unsigned ,
		QualificationsOrder INT ,
		Qualification VARCHAR(255) ,
		QualificationShort VARCHAR(255) ,

		RolesID bigint(40) unsigned ,
		RolesOrder INT ,
		Role VARCHAR(255) ,

		Status1 VARCHAR(255) ,
		Date1 DATE ,
		Date1Num INT ,

		NameFull_Role VARCHAR(255) ,
		NameFull_ProjectsID VARCHAR(255) ,
		NameFull_RolesID VARCHAR(255)
	);

INSERT INTO TX_MOSTRECENTROLE0
			(
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
			)
    SELECT
			TX_MOSTRECENTROLE_SETUP1.MembersID ,
			TX_MOSTRECENTROLE_SETUP1.NameFull ,
			TX_MOSTRECENTROLE_SETUP1.Club ,
			TX_MOSTRECENTROLE_SETUP1.CurrentMember ,

			TX_MOSTRECENTROLE_SETUP1.TracksID ,
			TX_MOSTRECENTROLE_SETUP1.Track ,

			TX_MOSTRECENTROLE_SETUP1.QualificationsID ,
			TX_MOSTRECENTROLE_SETUP1.QualificationsOrder ,
			TX_MOSTRECENTROLE_SETUP1.Qualification ,
			TX_MOSTRECENTROLE_SETUP1.QualificationShort ,

			TX_MOSTRECENTROLE_SETUP1.RolesID ,
			TX_MOSTRECENTROLE_SETUP1.RolesOrder ,
			TX_MOSTRECENTROLE_SETUP1.Role ,

			TX_MOSTRECENTROLE_SETUP1.Status1 ,
			TX_MOSTRECENTROLE_SETUP1.Date1 ,
			TX_MOSTRECENTROLE_SETUP1.Date1Num ,

			TX_MOSTRECENTROLE_SETUP1.NameFull_Role ,
			TX_MOSTRECENTROLE_SETUP1.NameFull_ProjectsID ,
			TX_MOSTRECENTROLE_SETUP1.NameFull_RolesID
    FROM TX_MOSTRECENTROLE_SETUP1
    LEFT OUTER JOIN TX_MOSTRECENTROLE_SETUP2
        ON TX_MOSTRECENTROLE_SETUP1.NameFull_Role = TX_MOSTRECENTROLE_SETUP2.NameFull_Role AND TX_MOSTRECENTROLE_SETUP1.Date1Num < TX_MOSTRECENTROLE_SETUP2.Date1Num
    WHERE (TX_MOSTRECENTROLE_SETUP2.NameFull_Role IS NULL)
		GROUP BY NameFull , Role
		ORDER BY NameFull , RolesOrder , Date1Num , NameFull;
SELECT * FROM TX_MOSTRECENTROLE0;

/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES
*/

-- ========================  ALLMEMBERS ========================

-- Lists current Members: ALL MEMBERS
DROP TABLE IF EXISTS TX_ALLMEMBERS0;
CREATE TABLE TX_ALLMEMBERS0
	(
		id SERIAL ,

		MembersID bigint(40) unsigned ,
		NameFull VARCHAR(255) ,
		currentclubs VARCHAR(255) ,
		currentmember VARCHAR(255)
	);

INSERT INTO TX_ALLMEMBERS0
		(
			MembersID ,
			NameFull ,
			currentclubs ,
			currentmember
		)
		SELECT
			id ,
			CONCAT(RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull,
			currentclubs ,
			currentmember
    FROM RECORDS_MEMBERS
	ORDER BY currentclubs , currentmember , NameFull ;
SELECT * FROM TX_ALLMEMBERS0;

-- ========================  RECORDS_MEMBER_UNAVAILABILITY ========================

DROP TABLE IF EXISTS TX_RECORDS_MEMBER_UNAVAILABILITY0;
CREATE TABLE TX_RECORDS_MEMBER_UNAVAILABILITY0
		(
			id SERIAL ,

			MembersID bigint(40) unsigned ,
			NameFull VARCHAR(255) ,

			RolesID bigint(40) unsigned ,
			Role VARCHAR(255) ,

			StartDate DATE ,
			EndDate DATE ,
			Notes VARCHAR(255) ,

			NameFull_Role VARCHAR(255) ,
			NameFull_RoleID VARCHAR(255)
		);

INSERT INTO TX_RECORDS_MEMBER_UNAVAILABILITY0
	(
		MembersID ,
		NameFull ,

		RolesID ,
		Role ,

		StartDate ,
		EndDate ,
		Notes ,

		NameFull_Role ,
		NameFull_RoleID
	)
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
SELECT * FROM TX_RECORDS_MEMBER_UNAVAILABILITY0;


-- ========================  CONTESTABLE_TMIROLES ========================

-- Lists All Contestable Roles
DROP TABLE IF EXISTS TX_CONTESTABLE_TMIROLES0;
CREATE TABLE TX_CONTESTABLE_TMIROLES0
		(
			id SERIAL ,
			Role VARCHAR(255)
		);

INSERT INTO TX_CONTESTABLE_TMIROLES0
		(
			Role
		)
  SELECT Role
  FROM TMI_ROLES
  WHERE contestable = 'Yes';
SELECT * FROM TX_CONTESTABLE_TMIROLES0;

-- ========================  CONTESTABLE_TMIROLES_TO_MEMBERS ========================

-- CROSS JOIN MEMBERS & CONTESTABLE ROLES: All Members
DROP TABLE IF EXISTS TX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
CREATE TABLE TX_CONTESTABLE_TMIROLES_TO_MEMBERS0
		(
			id SERIAL ,
			Role VARCHAR(255) ,
			NameFull_Role1 VARCHAR(255)
		);

INSERT INTO TX_CONTESTABLE_TMIROLES_TO_MEMBERS0
	(
		Role ,
		NameFull_Role1
	)
    SELECT
			TX_CONTESTABLE_TMIROLES0.Role ,
			CONCAT(TX_ALLMEMBERS0.NameFull , ' - ' , TX_CONTESTABLE_TMIROLES0.Role) AS NameFull_Role1
    FROM TX_CONTESTABLE_TMIROLES0
    CROSS JOIN TX_ALLMEMBERS0;
SELECT * FROM TX_CONTESTABLE_TMIROLES_TO_MEMBERS0;
