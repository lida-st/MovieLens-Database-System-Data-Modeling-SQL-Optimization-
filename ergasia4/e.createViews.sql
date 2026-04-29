-- Δημιουργία όψης Actor
CREATE VIEW Actor AS
SELECT DISTINCT person_id, gender, name
FROM Movie_Cast;
GO 

-- Δημιουργία όψης CrewMember
CREATE VIEW CrewMember AS
SELECT DISTINCT person_id, gender, name
FROM Movie_Crew;
GO 

-- Δημιουργία της όψης Person με Union
CREATE VIEW Person AS
SELECT person_id, gender, name
FROM Actor
UNION
SELECT person_id, gender, name
FROM CrewMember;
GO 


-- Εμφάνιση των δεδομένων της όψης Actor
SELECT *
FROM Actor;

-- Εμφάνιση των δεδομένων της όψης CrewMember
SELECT *
FROM CrewMember;

-- Εμφάνιση των δεδομένων της όψης Person
SELECT *
FROM Person;