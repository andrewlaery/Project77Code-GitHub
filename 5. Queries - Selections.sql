    /*
1>> Create a new TABLE to hold forecast schedules including Date, Club, Role, Name.
2>> Progressively create a VIEW query of the forecast TABLE for each role selector loop to see who has already been selected for a role at that meeting 
and change their rank.
3>> Create unavailability table
3>> Create an availability table for each role (0 = unavailable, 0.5 = role priority, 1 = available, 1000 = role depriority). 



Account for requests (i.e. can I please do a role in 2 meetings time)

Remove people who can not complete a role

*/


-- Create forecast table which needs to be updated...
DROP TABLE IF EXISTS TTX_FORECAST0;
CREATE TABLE TTX_FORECAST0 (id SERIAL , NameFull VARCHAR(255) , Role VARCHAR(255) , clubsID bigint(40) unsigned , meetingdate DATE);
-- SELECT * FROM TTX_FORECAST0;

-- =========== ROLE SELECTION CREATE LOOPS FOR EACH MEETING


-- Create a member/role counter from the Forecast Table
DROP VIEW IF EXISTS V_TTX_FORECAST_COUNT0;
CREATE VIEW V_TTX_FORECAST_COUNT0 AS
	SELECT 
        NameFull ,
        COUNT(*)*100000000 AS RankAdder
    FROM TTX_FORECAST0
    WHERE 
        (ClubsID = '2')
        AND (meetingdate = '2017-07-12')
    GROUP BY NameFull;
-- SELECT * FROM V_TTX_FORECAST_COUNT0;

-- Create a list of members who are unavailable
DROP VIEW IF EXISTS V_RECORDS_MEMBER_UNAVAILABILITY0;
CREATE VIEW V_RECORDS_MEMBER_UNAVAILABILITY0 AS
	SELECT 
			CONCAT(RECORDS_MEMBERS.namefirst, ' ' , RECORDS_MEMBERS.namelast) AS NameFull
        FROM RECORDS_MEMBER_UNAVAILABILITY
	LEFT JOIN RECORDS_MEMBERS ON RECORDS_MEMBERS.id = RECORDS_MEMBER_UNAVAILABILITY.membersID
    WHERE
		 (startdate <= '2017-07-12') 
		 AND (enddate >= '2017-07-12');
SELECT * FROM V_RECORDS_MEMBER_UNAVAILABILITY0;

-- Create full ranking view linked to forecast table and removing unavailable members
DROP TABLE IF EXISTS TTX_TMI_ROLES_MEMBER_RANKED0;
CREATE TABLE TTX_TMI_ROLES_MEMBER_RANKED0 (id SERIAL , NameFull VARCHAR(255) , Role VARCHAR(255) , Date1Num INT DEFAULT 1, RankAdder INT DEFAULT 1, Rank INT , MeetingDate DATE DEFAULT '2017-07.12' , ClubsID VARCHAR(255) DEFAULT '2');
INSERT INTO TTX_TMI_ROLES_MEMBER_RANKED0 (NameFull , Role , Date1Num , RankAdder , Rank)
    SELECT 
        V_CONTESTABLE_TMIROLES_TO_MEMBERS2.NameFull,
        V_CONTESTABLE_TMIROLES_TO_MEMBERS2.Role ,
        IFNULL(CAST(V_MOSTRECENTROLE1.Date1 AS unsigned),1) ,
        IFNULL(V_TTX_FORECAST_COUNT0.RankAdder,1) ,
       (IFNULL(CAST(V_MOSTRECENTROLE1.Date1 AS unsigned),1) + IFNULL(V_TTX_FORECAST_COUNT0.RankAdder,1))
    FROM V_CONTESTABLE_TMIROLES_TO_MEMBERS2
    LEFT JOIN V_MOSTRECENTROLE1 ON V_MOSTRECENTROLE1.NameFull_Role = V_CONTESTABLE_TMIROLES_TO_MEMBERS2.NameFull_Role
    LEFT JOIN V_TTX_FORECAST_COUNT0 ON V_TTX_FORECAST_COUNT0.NameFull = V_CONTESTABLE_TMIROLES_TO_MEMBERS2.NameFull
    WHERE V_CONTESTABLE_TMIROLES_TO_MEMBERS2.NameFull NOT IN (SELECT * FROM V_RECORDS_MEMBER_UNAVAILABILITY0);
SELECT * FROM TTX_TMI_ROLES_MEMBER_RANKED0 ORDER BY Role, Rank, NameFull;

INSERT INTO TTX_FORECAST0 (NameFull , Role , clubsID , meetingdate)
	SELECT NameFull , Role , clubsID , meetingdate
 		FROM TTX_TMI_ROLES_MEMBER_RANKED0
        WHERE Role = 'Speaker'
        ORDER BY Rank , NameFull
        LIMIT 3;

        
SELECT * FROM TTX_FORECAST0;