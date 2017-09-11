
-- SET PARAMETERS

SET @Club = 'Daybreak Toastmasters';
SET @currentclubs = 'Daybreak Toastmasters';
SET @QualificationStatus1 = 'In progress';
SET @QualificationStatus2 = 'Completed';
SET @CurrentMember = 'Yes';


-- ========================  CURRENT MEMBERS ========================

-- List of current memebers

DROP TABLE IF EXISTS TX_CURRENTMEMBERS1_DTM;
CREATE TABLE TX_CURRENTMEMBERS1_DTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      MembersID INT ,
      CurrentClub VARCHAR(255)
    );

INSERT INTO TX_CURRENTMEMBERS1_DTM
    (
      NameFull ,
      MembersID ,
      CurrentClub
    )
  SELECT
    NameFull ,
    MembersID ,
    currentclubs
  FROM TX_ALLMEMBERS0
  WHERE
    (currentmember = @currentmember)
    AND (currentclubs = @currentclubs)
	ORDER BY NameFull;

SELECT * FROM TX_CURRENTMEMBERS1_DTM;


-- ========================  TX_QUALIFICATIONS ========================

DROP TABLE IF EXISTS TX_QUALIFICATIONS1_DTM;
CREATE TABLE TX_QUALIFICATIONS1_DTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      MembersID INT ,
      Qualification VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      QualificationStatus VARCHAR(255)
    );

INSERT INTO TX_QUALIFICATIONS1_DTM
    (
      NameFull ,
      MembersID ,
      Qualification ,
      QualificationShort ,
      QualificationStatus
    )
  SELECT
    NameFull ,
    MembersID ,
    Qualification ,
    QualificationShort ,
    QualificationStatus
  FROM TX_QUALIFICATIONS0
  WHERE
    (currentmember = @currentmember)
    AND (Club = @Club)
	ORDER BY NameFull , QualificationsOrder;

-- SELECT * FROM TX_QUALIFICATIONS1_DTM;



-- ========================  TX_RECORDS_PROJECTS ========================
-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member


DROP TABLE IF EXISTS TX_RECORDS_PROJECTS1_DTM;
CREATE TABLE TX_RECORDS_PROJECTS1_DTM
    (
      id SERIAL ,

      RP_ID bigint(40) unsigned ,
      NameFull VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      Manual VARCHAR(255) ,
      Project VARCHAR(255) ,
      Role VARCHAR(255) ,
      Date1 DATE
    );

INSERT INTO TX_RECORDS_PROJECTS1_DTM
    (
      RP_ID ,
      NameFull ,
      QualificationShort ,
      Manual ,
      Project ,
      Role ,
      Date1
    )
	SELECT
      RP_ID ,
      NameFull ,
      QualificationShort ,
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
SELECT * FROM TX_RECORDS_PROJECTS1_DTM;



-- ========================  TX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member

DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT1_DTM;
CREATE TABLE TX_MOSTRECENTPROJECT1_DTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      Manual VARCHAR(255) ,
      Project VARCHAR(255) ,
      Role VARCHAR(255) ,
      Date1 DATE
    );

INSERT INTO TX_MOSTRECENTPROJECT1_DTM
      (
        NameFull ,
        QualificationShort ,
        Manual ,
        Project ,
        Role ,
        Date1
      )
    SELECT
        NameFull ,
        QualificationShort ,
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
SELECT * FROM TX_MOSTRECENTPROJECT1_DTM;

-- ========================  TX_MOSTRECENTROLE 0-1 ========================

DROP TABLE IF EXISTS TX_MOSTRECENTROLE1_DTM;
CREATE TABLE TX_MOSTRECENTROLE1_DTM
      (
        id SERIAL ,

        NameFull VARCHAR(255) ,
        Role VARCHAR(255) ,
        Date1 DATE
      );

INSERT INTO TX_MOSTRECENTROLE1_DTM
      (
        NameFull ,
        Role ,
        Date1
      )
    SELECT
          NameFull ,
					Role ,
					Date1
        FROM TX_MOSTRECENTROLE0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY RolesOrder , Date1Num , NameFull ;
SELECT * FROM TX_MOSTRECENTROLE1_DTM;
