
-- SET PARAMETERS

SET @Club = 'Corporate Toastmasters';
SET @currentclubs = 'Corporate Toastmasters';
SET @QualificationStatus1 = 'In progress';
SET @QualificationStatus2 = 'Completed';
SET @CurrentMember = 'Yes';


-- ========================  CURRENT MEMBERS ========================

-- List of current memebers

DROP TABLE IF EXISTS TX_CURRENTMEMBERS1_CTM;
CREATE TABLE TX_CURRENTMEMBERS1_CTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      MembersID INT ,
      CurrentClub VARCHAR(255)
    );

INSERT INTO TX_CURRENTMEMBERS1_CTM
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

SELECT * FROM TX_CURRENTMEMBERS1_CTM;


-- ========================  TX_QUALIFICATIONS ========================

DROP TABLE IF EXISTS TX_QUALIFICATIONS1_CTM;
CREATE TABLE TX_QUALIFICATIONS1_CTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      MembersID INT ,
      Qualification VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      QualificationStatus VARCHAR(255)
    );

INSERT INTO TX_QUALIFICATIONS1_CTM
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

-- SELECT * FROM TX_QUALIFICATIONS1_CTM;



-- ========================  TX_RECORDS_PROJECTS ========================
-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member


DROP TABLE IF EXISTS TX_RECORDS_PROJECTS1_CTM;
CREATE TABLE TX_RECORDS_PROJECTS1_CTM
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

INSERT INTO TX_RECORDS_PROJECTS1_CTM
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
SELECT * FROM TX_RECORDS_PROJECTS1_CTM;



-- ========================  TX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member

DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT1_CTM;
CREATE TABLE TX_MOSTRECENTPROJECT1_CTM
    (
      id SERIAL ,

      NameFull VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      Manual VARCHAR(255) ,
      Project VARCHAR(255) ,
      Role VARCHAR(255) ,
      Date1 DATE
    );

INSERT INTO TX_MOSTRECENTPROJECT1_CTM
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
SELECT * FROM TX_MOSTRECENTPROJECT1_CTM;

-- ========================  TX_MOSTRECENTROLE 0-1 ========================

DROP TABLE IF EXISTS TX_MOSTRECENTROLE1_CTM;
CREATE TABLE TX_MOSTRECENTROLE1_CTM
      (
        id SERIAL ,

        NameFull VARCHAR(255) ,
        Role VARCHAR(255) ,
        Date1 DATE
      );

INSERT INTO TX_MOSTRECENTROLE1_CTM
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
SELECT * FROM TX_MOSTRECENTROLE1_CTM;
