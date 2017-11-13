

-- Change all 'forecast' projects to 'forecast_old' so the filters work.
SET @today = current_date();
SET SQL_SAFE_UPDATES = 0;
UPDATE RECORDS_PROJECTS
SET itemstatus = 'forecast_old'
WHERE
	MeetingDate < @today
	AND itemstatus = 'forecast';
SET SQL_SAFE_UPDATES = 1;


-- Change all 'forecast' projects to 'forecast_old' so the filters work.
SET @today = '2017-11-08';
SET SQL_SAFE_UPDATES = 0;
UPDATE RECORDS_PROJECTS
SET itemstatus = 'forecast_old'
WHERE
	MeetingDate = @today
	AND itemstatus = 'forecast';
SET SQL_SAFE_UPDATES = 1;
