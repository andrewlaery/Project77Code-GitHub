
-- SET PARAMETERS

SET @Club = 'Corporate Toastmasters';
SET @currentclubs = 'Corporate Toastmasters';
SET @QualificationStatus1 = 'In progress';
SET @QualificationStatus2 = 'Completed';
SET @CurrentMember = 'Yes';


-- ========================  CURRENT MEMBERS ========================

-- List of current memebers

DROP TABLE IF EXISTS TX_CURRENTMEMBERS1;
CREATE TABLE TX_CURRENTMEMBERS1
    (
      id SERIAL ,

      MembersID INT ,
      NameFull VARCHAR(255) ,
      ClubsID INT ,
      CurrentClub VARCHAR(255)
    );

INSERT INTO TX_CURRENTMEMBERS1
    (
      MembersID ,
      NameFull ,
      ClubsID ,
      CurrentClub
    )
    SELECT
      MembersID ,
      NameFull ,
      ClubsID ,
      currentclubs
    FROM TX_ALLMEMBERS0
    ORDER BY ClubsID , NameFull;

SELECT * FROM TX_CURRENTMEMBERS1;


-- ========================  TX_QUALIFICATIONS ========================

DROP TABLE IF EXISTS TX_QUALIFICATIONS1;
CREATE TABLE TX_QUALIFICATIONS1
    (
      id SERIAL ,

      MembersID INT ,
      NameFull VARCHAR(255) ,
      CurrentMember VARCHAR(255) ,

      QualificationsID INT ,
      Qualification VARCHAR(255) ,
      QualificationShort VARCHAR(255) ,
      QualificationStatus VARCHAR(255)
    );

INSERT INTO TX_QUALIFICATIONS1
    (
      MembersID ,
      NameFull ,
      CurrentMember ,

      QualificationsID ,
      Qualification ,
      QualificationShort ,
      QualificationStatus
    )
    SELECT
      MembersID ,
      NameFull ,
      CurrentMember ,

      QualificationsID ,
      Qualification ,
      QualificationShort ,
      QualificationStatus
    FROM TX_QUALIFICATIONS0
    ORDER BY NameFull , QualificationsOrder;

SELECT * FROM TX_QUALIFICATIONS1;



-- ========================  TX_RECORDS_PROJECTS ========================
-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member


DROP TABLE IF EXISTS TX_RECORDS_PROJECTS1;
CREATE TABLE TX_RECORDS_PROJECTS1
    (
      id SERIAL ,

      RP_ID INT ,
      MembersID INT ,
      NameFull VARCHAR(255) ,

      QualificationsID INT ,
      QualificationShort VARCHAR(255) ,

      ManualsID INT ,
      Manual VARCHAR(255) ,

      ProjectsID INT ,
      Project VARCHAR(255) ,

      RolesID INT ,
      Role VARCHAR(255) ,

      ClubsID INT ,
      Club VARCHAR(255) ,
      Date1 DATE
    );

INSERT INTO TX_RECORDS_PROJECTS1
    (
      RP_ID ,
      MembersID ,
      NameFull ,

      QualificationsID ,
      QualificationShort ,

      ManualsID ,
      Manual ,

      ProjectsID ,
      Project ,

      RolesID ,
      Role ,

      ClubsID ,
      Club ,
      Date1
    )
	SELECT
      RP_ID ,
      MembersID ,
      NameFull ,

      QualificationsID ,
      QualificationShort ,

      ManualsID ,
      Manual ,

      ProjectsID ,
      Project ,

      RolesID ,
      Role ,

      ClubsID ,
      Club ,
      Date1
    FROM TX_RECORDS_PROJECTS0
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TX_RECORDS_PROJECTS1;



-- ========================  TX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member

DROP TABLE IF EXISTS TX_MOSTRECENTPROJECT1;
CREATE TABLE TX_MOSTRECENTPROJECT1
    (
      id SERIAL ,

      MembersID INT ,
      NameFull VARCHAR(255) ,

      QualificationsID INT ,
      QualificationShort VARCHAR(255) ,

      ManualsID INT ,
      Manual VARCHAR(255) ,

      ProjectsID INT ,
      Project VARCHAR(255) ,

      RolesID INT ,
      Role VARCHAR(255) ,

      ClubsID INT ,
      Club VARCHAR(255) ,

      Date1 DATE
    );

INSERT INTO TX_MOSTRECENTPROJECT1
  (
    MembersID ,
    NameFull ,

    QualificationsID ,
    QualificationShort ,

    ManualsID ,
    Manual ,

    ProjectsID ,
    Project ,

    RolesID ,
    Role ,

    ClubsID ,
    Club ,

    Date1
  )
  SELECT
    MembersID ,
    NameFull ,

    QualificationsID ,
    QualificationShort ,

    ManualsID ,
    Manual ,

    ProjectsID ,
    Project ,

    RolesID ,
    Role ,

    ClubsID ,
    Club ,

    Date1
  FROM TX_MOSTRECENTPROJECT0
  ORDER BY NameFull , QualificationsOrder , ManualsOrder , ProjectsOrder , Date1Num;
SELECT * FROM TX_MOSTRECENTPROJECT1;

-- ========================  TX_MOSTRECENTROLE 0-1 ========================

DROP TABLE IF EXISTS TX_MOSTRECENTROLE1;
CREATE TABLE TX_MOSTRECENTROLE1
    (
      id SERIAL ,

      MembersID bigint(40) unsigned ,
      NameFull VARCHAR(255) ,

      RolesID INT ,
      Role VARCHAR(255) ,

      ClubsID INT ,
      Club VARCHAR(255) ,

      Date1 DATE
    );

INSERT INTO TX_MOSTRECENTROLE1
    (
      MembersID ,
      NameFull ,

      RolesID ,
      Role ,

      ClubsID ,
      Club ,

      Date1
    )
  SELECT
      MembersID ,
      NameFull ,

      RolesID ,
      Role ,

      ClubsID ,
      Club ,

      Date1
  FROM TX_MOSTRECENTROLE0
  ORDER BY RolesOrder , Date1Num , NameFull ;
SELECT * FROM TX_MOSTRECENTROLE1;
