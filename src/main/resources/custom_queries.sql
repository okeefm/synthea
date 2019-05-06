-- CUSTOM REPORT QUERIES
-- This file contains the queries that will be run, one at a time, to generate custom CSV reports.
-- Each query will produce 1 report.
-- Blank lines and lines starting with -- (single line comments) will be ignored.
-- In this initial implementation, all queries must start with SELECT 
--   (ie, no creation of views or modification of data allowed)
-- and each query must be on its own line, entirely on a single line.
-- See the DataStore class for details on what tables are available.


-- Sample Query 1: select everything from the "person" table.
-- Note that column ordering is not guaranteed.

-- select * from person;



-- Sample Query 2: select the number of living people.

-- select count(*) from person where person.DATE_OF_DEATH is null;



-- Sample Query 3: select the people that have an active diagnosis of diabetes, along with the age of diagnosis

-- select p.name, p.gender, DATEADD('MILLISECOND', p.DATE_OF_BIRTH, DATE '1970-01-01') DOB, DATEADD('MILLISECOND', c.start , DATE '1970-01-01') onset_date, DATEDIFF('YEAR', DATEADD('MILLISECOND', p.DATE_OF_BIRTH, DATE '1970-01-01'), DATEADD('MILLISECOND', c.start, DATE '1970-01-01')) age_at_diagnosis   FROM PERSON p, CONDITION c WHERE p.ID = c.PERSON_ID AND c.code = '44054006';

select p.name, DATEADD('MILLISECOND', pr.start , DATE '1970-01-01') FROM PERSON p, PROCEDURE pr WHERE p.ID = pr.PERSON_ID AND pr.code in ('442023007', '469365001', '442023007');

SELECT p.name, DATEADD('MILLISECOND', m.start , DATE '1970-01-01') FROM PERSON p, MEDICATION m WHERE p.ID = m.PERSON_ID AND m.code in ('854255', '855324', '861360');

SELECT p.name, DATEADD('MILLISECOND', e.start , DATE '1970-01-01') FROM PERSON p, ENCOUNTER e WHERE p.ID = e.PERSON_ID AND e.code in ('183452005', '32485007', '8715000');

SELECT p.name, DATEADD('MILLISECOND', e.start , DATE '1970-01-01'), DATEADD('MILLISECOND', m.start , DATE '1970-01-01') FROM PERSON p, ENCOUNTER e, MEDICATION m WHERE p.ID = e.PERSON_ID AND p.ID = m.PERSON_ID AND e.code in ('183452005', '32485007', '8715000') AND m.code in ('854255', '855324', '861360') AND ABS(m.start - e.start) < (12 * 60 * 60 * 1000);

SELECT p.name, DATEADD('MILLISECOND', e.start , DATE '1970-01-01'), DATEADD('MILLISECOND', pr.start , DATE '1970-01-01') FROM PERSON p, ENCOUNTER e, PROCEDURE pr WHERE p.ID = e.PERSON_ID AND p.ID = pr.PERSON_ID AND e.code in ('183452005', '32485007', '8715000') AND pr.code in ('442023007', '469365001', '442023007') AND ABS(e.start - pr.start) < (12 * 60 * 60 * 1000);
