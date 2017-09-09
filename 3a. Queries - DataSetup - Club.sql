
-- SET PARAMETERS

SET @Club = 'Corporate Toastmasters';
SET @currentclubs = 'Corporate Toastmasters';
SET @QualificationStatus1 = 'In progress';
SET @QualificationStatus2 = 'Completed';
SET @CurrentMember = 'Yes';


-- ========================  CURRENT MEMBERS ========================

-- List of current memebers
DROP TEMPORARY TABLE IF EXISTS TX_CURRENTMEMBERS1;
CREATE TEMPORARY TABLE TX_CURRENTMEMBERS1 AS
    SELECT
			currentclubs AS CurrentClub ,
            NameFull
    FROM TX_ALLMEMBERS0
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember);
SELECT * FROM TX_CURRENTMEMBERS1 ORDER BY NameFull;


-- ========================  TX_QUALIFICATIONS ========================

-- List of current members TMI Qualifications:
DROP TEMPORARY TABLE IF EXISTS TX_QUALIFICATIONS1;
CREATE TEMPORARY TABLE TX_QUALIFICATIONS1 AS
    SELECT
			Club ,
            NameFull ,
			Track ,
			QualificationShort ,
			QualificationStatus
    FROM TX_QUALIFICATIONS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND ((QualificationStatus = @QualificationStatus1) OR (QualificationStatus = @QualificationStatus2))
		ORDER BY NameFull , QualificationsOrder;
SELECT * FROM TX_QUALIFICATIONS1;


-- ========================  TX_RECORDS_PROJECTS ========================


-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TX_RECORDS_PROJECTS1;
CREATE TEMPORARY TABLE TX_RECORDS_PROJECTS1 AS
	SELECT
			RP_ID ,
			Club ,
            NameFull ,
			Track ,
			QualificationShort ,
			ManualGroup ,
			Manual ,
			Project ,
			Role ,
			Date1
    FROM TX_RECORDS_PROJECTS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (Qualification <> 'No qualification')
        AND (Role <> 'No role')
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_RECORDS_PROJECTS1;


-- ========================  TX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TX_MOSTRECENTPROJECT1;
CREATE TEMPORARY TABLE TX_MOSTRECENTPROJECT1 AS
    SELECT
				Club ,
                NameFull ,
				Track ,
				QualificationShort ,
				ManualGroup ,
				Manual ,
				Project ,
				Role ,
				Date1
      FROM TX_MOSTRECENTPROJECT0
      WHERE
          (Club = @Club)
          AND (CurrentMember = @CurrentMember)
          AND (Qualification <> 'No qualification')
          AND (Role <> 'No role')
      ORDER BY NameFull , QualificationsOrder , ManualsOrder , ProjectsOrder , Date1Num;
SELECT * FROM TX_MOSTRECENTPROJECT1;

-- ========================  TX_MOSTRECENTROLE 0-1 ========================


DROP TEMPORARY TABLE IF EXISTS TX_MOSTRECENTROLE1;
CREATE TEMPORARY TABLE TX_MOSTRECENTROLE1 AS
    SELECT
					Club ,
          NameFull ,
					Role ,
					Date1
        FROM TX_MOSTRECENTROLE0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY NameFull , RolesOrder , Date1Num;
SELECT * FROM TX_MOSTRECENTROLE1;
