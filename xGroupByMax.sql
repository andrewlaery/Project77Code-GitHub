

==========================================================================================

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
			RolesID ,
			RolesOrder ,
			Role ,
			Status1 ,
			Date1 ,
			Date1Num ,
			NameFull_Role ,
			NameFull_ProjectsID ,
			NameFull_RolesID
    FROM TTX_RECORDS_PROJECTS1;
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
			RolesID ,
			RolesOrder ,
			Role ,
			Status1 ,
			Date1 ,
			Date1Num ,
			NameFull_Role ,
			NameFull_ProjectsID ,
			NameFull_RolesID
    FROM TTX_RECORDS_PROJECTS1;
-- SELECT * FROM TTX_MOSTRECENTROLE_SETUP2;

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
        WHERE (TTX_MOSTRECENTROLE_SETUP2.NameFull_Role IS NULL);
-- SELECT * FROM TTX_MOSTRECENTROLE0;


SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE1 AS
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
