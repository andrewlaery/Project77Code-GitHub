
-- SET PARAMETERS

SET @Club = 'Daybreak Toastmasters';
SET @currentclubs = 'Daybreak Toastmasters';
SET @QualificationStatus1 = 'In progress';
SET @QualificationStatus2 = 'Completed';
SET @CurrentMember = 'Yes';
SET @NameFull = 'Donald Jessep';


-- ========================  CURRENT MEMBERS ========================

-- List of current memebers
DROP TEMPORARY TABLE IF EXISTS TTX_CURRENTMEMBERS1;
CREATE TEMPORARY TABLE TTX_CURRENTMEMBERS1 AS
    SELECT
			NameFull
    FROM TTX_ALLMEMBERS0
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember)
        AND (NameFull = @Namefull);
SELECT * FROM TTX_CURRENTMEMBERS1 ORDER BY NameFull;


-- ========================  TTX_QUALIFICATIONS ========================

-- List of current members TMI Qualifications:
DROP TEMPORARY TABLE IF EXISTS TTX_QUALIFICATIONS1;
CREATE TEMPORARY TABLE TTX_QUALIFICATIONS1 AS
    SELECT
			NameFull ,
			Track ,
			QualificationShort ,
			QualificationStatus
    FROM TTX_QUALIFICATIONS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND ((QualificationStatus = @QualificationStatus1) OR (QualificationStatus = @QualificationStatus2))
        AND (NameFull = @Namefull)
		ORDER BY NameFull , QualificationsOrder;
SELECT * FROM TTX_QUALIFICATIONS1;


-- ========================  TTX_RECORDS_PROJECTS ========================


-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_PROJECTS1;
CREATE TEMPORARY TABLE TTX_RECORDS_PROJECTS1 AS
	SELECT
			RP_ID ,
			NameFull ,
			Track ,
			QualificationShort ,
			ManualGroup ,
			Manual ,
			Project ,
			Role ,
			Date1
    FROM TTX_RECORDS_PROJECTS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (Qualification <> 'No qualification')
        AND (Role <> 'No role')
        AND (NameFull = @Namefull)
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TTX_RECORDS_PROJECTS1;


-- ========================  TTX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTPROJECT1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTPROJECT1 AS
    SELECT
				NameFull ,
				Track ,
				QualificationShort ,
				ManualGroup ,
				Manual ,
				Project ,
				Role ,
				Date1
      FROM TTX_MOSTRECENTPROJECT0
      WHERE
          (Club = @Club)
          AND (CurrentMember = @CurrentMember)
          AND (Qualification <> 'No qualification')
          AND (Role <> 'No role')
          AND (NameFull = @Namefull)
      ORDER BY NameFull , QualificationsOrder , ManualsOrder , ProjectsOrder , Date1Num;
SELECT * FROM TTX_MOSTRECENTPROJECT1;

-- ========================  TTX_MOSTRECENTROLE 0-1 ========================


DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE1 AS
    SELECT
					NameFull ,
					Role ,
					Date1
        FROM TTX_MOSTRECENTROLE0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
            AND (NameFull = @Namefull)
        ORDER BY NameFull , RolesOrder , Date1Num;
SELECT * FROM TTX_MOSTRECENTROLE1;
