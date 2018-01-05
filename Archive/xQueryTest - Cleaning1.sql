SELECT * FROM RECORDS_PROJECTS
	WHERE MembersID = 17
    ORDER BY projectdate;

DROP VIEW IF EXISTS V_PROJECT_RECORDS;
CREATE VIEW V_PROJECT_RECORDS AS
	SELECT
			RECORDS_PROJECTS.membersID AS MembersID ,
            RECORDS_PROJECTS.qualificationsID AS QualificationsID ,
            RECORDS_PROJECTS.projectsID AS ProjectsID ,
            RECORDS_PROJECTS.rolesID AS RolesID ,
            RECORDS_PROJECTS.itemstatus AS ItemStatus ,
            RECORDS_PROJECTS.projectdate AS Date1 ,
			CONCAT( RECORDS_MEMBERS.namefirst , ' ' , RECORDS_MEMBERS.namelast) AS NameFull ,
			TMI_QUALIFICATIONS.qualification AS Qualification ,
            TMI_QUALIFICATIONS.tmiorder AS QualificationOrder ,
            -- TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
            TMI_MANUALS.manual AS Manual ,
            TMI_MANUALS.tmiorder AS ManualOrder ,
			TMI_PROJECTS.project AS Project ,
            TMI_PROJECTS.tmiorder AS ProjectOrder ,
			TMI_ROLES.role AS Role ,
            RECORDS_CLUBS.name AS Club ,
            RECORDS_MEMBERS.currentmember AS CurrentMember
		FROM RECORDS_PROJECTS
		LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_PROJECTS.membersID
		LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = RECORDS_PROJECTS.qualificationsID
		LEFT JOIN TMI_PROJECTS ON TMI_PROJECTS.id = RECORDS_PROJECTS.projectsID
		LEFT JOIN TMI_ROLES ON TMI_ROLES.id = RECORDS_PROJECTS.rolesID
		LEFT JOIN TMI_MANUALS ON TMI_MANUALS.id = TMI_PROJECTS.manualsID
		-- LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
       --  LEFT JOIN tmi_quals_manualgroups ON tmi_quals_manualgroups.manual_groupID = TMI_MANUAL_GROUPS.id
        LEFT JOIN RECORDS_CLUBS ON RECORDS_CLUBS.id = RECORDS_MEMBERS.clubsID;
SELECT * FROM V_PROJECT_RECORDS
	WHERE
		CurrentMember = 'Yes'
        AND Club = 'Daybreak Toastmasters'
        AND Qualification <> 'No qualification'
        AND MembersID = 17
        ORDER BY Date1;

SELECT * FROM DATA_AGENDAS
	WHERE MembersID = 17
    ORDER BY meetingdate;

DROP VIEW IF EXISTS V_TMI_PROJECTS;
CREATE VIEW V_TMI_PROJECTS AS
	SELECT
			TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
			TMI_MANUAL_GROUPS.tmiorder AS ManualGroupsOrder ,
			TMI_MANUALS.manual AS Manual ,
			TMI_MANUALS.tmiorder AS ManualOrder ,
			TMI_PROJECTS.project AS Project,
            TMI_PROJECTS.id AS ProjectID ,
			TMI_PROJECTS.tmiorder AS ProjectOrder ,
			TMI_ROLES.role AS Role ,
            TMI_ROLES.id AS RoleID
	FROM TMI_PROJECTS
	LEFT JOIN TMI_MANUALS ON TMI_MANUALS.id = TMI_PROJECTS.manualsID
	LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
	LEFT JOIN TMI_ROLES ON TMI_ROLES.id = TMI_PROJECTS.rolesID
	ORDER BY ManualGroupsOrder , ManualOrder , ProjectOrder;
SELECT * FROM V_TMI_PROJECTS
	ORDER BY ManualGroupsOrder , Role , ProjectOrder ;

DROP VIEW IF EXISTS V_MEMBER_QUALIFICATIONS;
CREATE VIEW V_MEMBER_QUALIFICATIONS AS
	SELECT
		records_members.namefirst AS NameFirst,
		records_members.namelast AS NameLast,
		tmi_qualifications.qualification AS Qualification,
		records_qualifications.qualificationdate AS QualificationDate,
		records_qualifications.qualificationstatus AS QualificationStatus
	FROM records_qualifications
	LEFT JOIN records_members ON records_members.id = records_qualifications.membersID
	LEFT JOIN tmi_qualifications ON tmi_qualifications.id = records_qualifications.qualificationsID;
SELECT * FROM V_MEMBER_QUALIFICATIONS
	WHERE
		QualificationStatus <> 'Not started'
		AND (namefirst = 'David'
		OR namefirst = 'Donald'
		OR namefirst = 'Ian'
		OR namefirst = 'Mark'
		OR namefirst = 'Peter'
		OR namefirst = 'Richard'
		OR namefirst = 'Robyn');

SELECT * FROM RECORDS_MEMBERS;
