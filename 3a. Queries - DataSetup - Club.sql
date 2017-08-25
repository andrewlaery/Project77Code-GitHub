
-- SET PARAMETERS

SET @Club = 'Corporate Toastmasters';
SET @currentclubs = 'Corporate Toastmasters';
SET @QualificationStatus = 'In progress';
SET @CurrentMember = 'Yes';



-- ========================  TTX_QUALIFICATIONS ========================

-- Lists members qualifications: from SET Club, Current Member and 'In Progress'
DROP TEMPORARY TABLE IF EXISTS TTX_QUALIFICATIONS1;
CREATE TEMPORARY TABLE TTX_QUALIFICATIONS1 AS
    SELECT *
    FROM TTX_QUALIFICATIONS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (QualificationStatus = @QualificationStatus);
SELECT * FROM TTX_QUALIFICATIONS1 ORDER BY NameFull , Qualification;


-- ========================  TTX_RECORDS_PROJECTS ========================

-- Lists projects including duplicates + Qualification Status: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TTX_RECORDS_PROJECTS1;
CREATE TEMPORARY TABLE TTX_RECORDS_PROJECTS1 AS
	SELECT *
    FROM TTX_RECORDS_PROJECTS0
    WHERE
        (Club = @Club)
        AND (CurrentMember = @CurrentMember)
        AND (Qualification <> 'No qualification')
        AND (Role <> 'No role')
        -- AND (DATE1 = '2017-07-26')
        -- AND (RECORDS_PROJECTS.itemstatus = 'actual');
        -- AND (CONCAT(RECORDS_MEMBERS.NameFirst , ' ' , RECORDS_MEMBERS.NameLast) = 'Donald Jessep');
    ORDER BY NameFull , QualificationsOrder , ManualGroupsOrder , ManualsOrder , ProjectsOrder;
SELECT * FROM TTX_RECORDS_PROJECTS1;

-- ========================  TTX_MOSTRECENTPROJECT 0-1 ========================

-- Lists members most recent projects excluding duplicates: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTPROJECT1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTPROJECT1 AS
    SELECT *
        FROM TTX_MOSTRECENTPROJECT0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY NameFull , Qualification , Manual , Project , Date1Num;
SELECT * FROM TTX_MOSTRECENTPROJECT1;

-- ========================  TTX_MOSTRECENTROLE 0-1 ========================


DROP TEMPORARY TABLE IF EXISTS TTX_MOSTRECENTROLE1;
CREATE TEMPORARY TABLE TTX_MOSTRECENTROLE1 AS
    SELECT *
        FROM TTX_MOSTRECENTROLE0
        WHERE
            (Club = @Club)
            AND (CurrentMember = @CurrentMember)
            AND (Qualification <> 'No qualification')
            AND (Role <> 'No role')
        ORDER BY NameFull , RolesOrder , Date1Num , NameFull;
SELECT * FROM TTX_MOSTRECENTROLE1;


/*
SECTION 2 OF 2: CREATE A CURRENT MEMBERS AND CONTESTABLE ROLES
*/

-- ========================  TTX_CURRENTMEMBERS 0-1 ========================

-- Lists current Members: SET by Club
DROP TEMPORARY TABLE IF EXISTS TTX_CURRENTMEMBERS1;
CREATE TEMPORARY TABLE TTX_CURRENTMEMBERS1 AS
    SELECT *
    FROM TTX_CURRENTMEMBERS0
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember);
-- SELECT * FROM V_CURRENTMEMBERS1 ORDER BY currentclubs , currentmember , NameFull;

-- ========================  TTX_CONTESTABLE_TMIROLES 0 ========================

-- Lists All Contestable Roles
DROP TEMPORARY TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES0;
CREATE TEMPORARY TABLE TTX_CONTESTABLE_TMIROLES0 AS
    SELECT Role
    FROM TMI_ROLES
    WHERE contestable = 'Yes';
-- SELECT * FROM V_CONTESTABLE_TMIROLES;

-- ========================  TTX_CONTESTABLE_TMIROLES_TO_MEMBERS 0-2 ========================

-- CROSS JOIN MEMBERS & CONTESTABLE ROLES: from SET Club and Current Member
DROP TEMPORARY TABLE IF EXISTS TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1;
CREATE TEMPORARY TABLE TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1 AS
    SELECT *
    FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS0
    WHERE
        (currentclubs = @currentclubs)
        AND (currentmember = @currentmember);
SELECT * FROM TTX_CONTESTABLE_TMIROLES_TO_MEMBERS1;
