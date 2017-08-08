DROP VIEW IF EXISTS V_TMI_CL0;
CREATE VIEW V_TMI_CL0 AS
	SELECT TMI_QUALIFICATIONS.qualification AS Qualification , 
			TMI_MANUAL_GROUPS.manual_group AS ManualGroup ,
            TMI_MANUALS.manual AS Manual ,
            TMI_PROJECTS.project AS Project ,
            TMI_PROJECTS.tmiorder AS ProjectsOrder ,
            TMI_ROLES.role AS Role
		FROM TMI_PROJECTS
		LEFT JOIN TMI_ROLES ON TMI_ROLES.id = TMI_PROJECTS.rolesID 
		LEFT JOIN TMI_MANUALS ON  TMI_MANUALS.id = TMI_PROJECTS.manualsID
		LEFT JOIN TMI_MANUAL_GROUPS ON TMI_MANUAL_GROUPS.id = TMI_MANUALS.manual_groupsID
		LEFT JOIN TMI_QUALS_MANUALGROUPS ON TMI_QUALS_MANUALGROUPS.manual_groupID = TMI_MANUAL_GROUPS.id 
		LEFT JOIN TMI_QUALIFICATIONS ON TMI_QUALIFICATIONS.id = TMI_QUALS_MANUALGROUPS.qualificationID
		LEFT JOIN TMI_TRACKS ON TMI_TRACKS.id = TMI_QUALIFICATIONS.tracksID
	WHERE TMI_QUALIFICATIONS.qualification = 'Competent Leader';
SELECT * FROM V_TMI_CL0;

SELECT 
	SUBSTRING(project , 1, (LOCATE (':' , project))-1) AS SubProject,
    COUNT(*) AS SubProjectCount
    -- FLOOR(ProjectsOrder)	
FROM V_TMI_CL0
GROUP BY SubProject
ORDER BY FLOOR(ProjectsOrder);
-- WHERE Project LIKE '%Listening and Leadership%';


