

-- Change all 'forecast' projects to 'forecast_old' so the filters work.
SET SQL_SAFE_UPDATES = 0;
UPDATE RECORDS_PROJECTS
SET itemstatus = 'forecast_old'
WHERE
	MeetingDate < '2017-11-06'
	AND itemstatus = 'forecast';
SET SQL_SAFE_UPDATES = 1;
