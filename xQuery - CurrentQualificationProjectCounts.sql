SELECT * FROM V_MOSTRECENTPROJECT1;

DROP VIEW IF EXISTS V_STATUS_CC0;
CREATE VIEW V_STATUS_CC0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Competent Communicator'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_CC0;

DROP VIEW IF EXISTS V_STATUS_ACB0;
CREATE VIEW V_STATUS_ACB0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Advanced Communicator Bronze'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_ACB0;

DROP VIEW IF EXISTS V_STATUS_ACS0;
CREATE VIEW V_STATUS_ACS0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Advanced Communicator Silver'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_ACS0;

DROP VIEW IF EXISTS V_STATUS_ACG0;
CREATE VIEW V_STATUS_ACG0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Advanced Communicator Gold'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_ACG0;

DROP VIEW IF EXISTS V_STATUS_CL0;
CREATE VIEW V_STATUS_CL0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Competent Leader'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_CL0;

DROP VIEW IF EXISTS V_STATUS_ALB0;
CREATE VIEW V_STATUS_ALB0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Advanced Leader Bronze'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_ALB0;

DROP VIEW IF EXISTS V_STATUS_ALS0;
CREATE VIEW V_STATUS_ALS0 AS
	SELECT 
			Qualification ,
            NameFull ,
			COUNT(*) AS NumOfCompletedProjects
		FROM V_MOSTRECENTPROJECT1
		WHERE Qualification = 'Advanced Leader Silver'
		GROUP BY namefull
        ORDER BY NumOfCompletedProjects , NameFull;
SELECT * FROM V_STATUS_ALS0;


SELECT * FROM V_STATUS_CC0
UNION
SELECT * FROM V_STATUS_ACB0
UNION
SELECT * FROM V_STATUS_ACS0
UNION
SELECT * FROM V_STATUS_ACG0
UNION
SELECT * FROM V_STATUS_CL0
UNION
SELECT * FROM V_STATUS_ALB0
UNION
SELECT * FROM V_STATUS_ALS0;