-- Επιλέγουμε τα person_id που εμφανίζονται πάνω από μία φορά για διαφορετικό name ή gender 
SELECT person_id 
FROM ( 
    SELECT person_id, COUNT(DISTINCT name) AS distinct_names, COUNT(DISTINCT gender) AS distinct_genders 
    FROM Person 
    GROUP BY person_id ) 
AS subquery 
WHERE distinct_names > 1 OR distinct_genders > 1;

UPDATE movie_cast
SET person_id = (SELECT MIN(person_id) FROM Person WHERE name = 'Δημητρης' AND person_id IS NOT NULL)
WHERE person_id IN (
    SELECT person_id 
    FROM ( 
        SELECT person_id, COUNT(DISTINCT name) AS distinct_names, COUNT(DISTINCT gender) AS distinct_genders 
        FROM Person 
        GROUP BY person_id 
    ) AS subquery 
    WHERE distinct_names > 1 OR distinct_genders > 1
);

UPDATE movie_crew
SET person_id = (SELECT MIN(person_id) FROM Person WHERE name = 'Δημητρης' AND person_id IS NOT NULL)
WHERE person_id IN (
    SELECT person_id 
    FROM ( 
        SELECT person_id, COUNT(DISTINCT name) AS distinct_names, COUNT(DISTINCT gender) AS distinct_genders 
        FROM Person 
        GROUP BY person_id 
    ) AS subquery 
    WHERE distinct_names > 1 OR distinct_genders > 1
);


