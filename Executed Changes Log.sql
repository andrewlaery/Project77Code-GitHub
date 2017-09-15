

-- ========================================================================

-- Code below executed 15-Sep-17 to update the Clubs ID column in the Projects Table.
SET SQL_SAFE_UPDATES = 0;

UPDATE RECORDS_PROJECTS
  INNER JOIN RECORDS_MEMBERS ON RECORDS_PROJECTS.membersID = RECORDS_MEMBERS.id
  SET RECORDS_PROJECTS.ClubsID = RECORDS_MEMBERS.ClubsID;

SET SQL_SAFE_UPDATES = 1;


-- ========================================================================
