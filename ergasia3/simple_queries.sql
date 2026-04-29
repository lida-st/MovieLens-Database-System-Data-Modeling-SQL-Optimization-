-------------------------------------------------------------------------
/*Ερώτημα 1 : Χαρούμενα δράματα των άγγλων
Βρες μου τις ταινίες που είναι original language τα αγγλικά και με βαθμολογία  μεταξύ 4 και 5.
*/
SELECT m.title
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
JOIN ratings r ON m.id = r.movie_id
WHERE g.name = 'Drama' 
AND m.original_language = 'en'
GROUP BY m.id, m.title
HAVING AVG(r.rating) BETWEEN 4 AND 5;

-------------------------------------------------------------------------
/*Ερώτημα 2 : Τα χειρότερα δράματα Double kill
Βρες μου τα 5 δραματα με τη χειρότρη βαθμολογία
*/
SELECT TOP 5 m.title
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
JOIN (
    SELECT movie_id, MIN(rating) as min_rating
    FROM ratings
    GROUP BY movie_id
) r ON m.id = r.movie_id
WHERE g.name = 'Drama'
ORDER BY r.min_rating;

-------------------------------------------------------------------------
/*Ερώτημα 3 : Οι εταιρίες που ξεζουμίζουν καλές ταινίες
Βρες μου τις production companies που βγαζουν collection
*/

SELECT DISTINCT pc.name
FROM ((productioncompany pc
JOIN hasProductioncompany HPC ON pc.id=HPC.pc_id)
JOIN belongsTocollection BTC ON BTC.movie_id=HPC.movie_id)

-------------------------------------------------------------------------
/*Ερώτημα 4 : Η Madonna είναι θεα?
Βρες μου τις top 5 ταινίες που παίζει η madonna
*/

SELECT m.title
FROM movie_cast mc
JOIN ratings r ON mc.movie_id = r.movie_id
JOIN movie m ON mc.movie_id = m.id
WHERE mc.person_id IN (
    SELECT person_id
    FROM movie_cast
    WHERE name = 'Madonna'
)
GROUP BY m.title
ORDER BY AVG(r.rating) DESC

-------------------------------------------------------------------------
/*Ερώτημα 5 : Οικογενιαρχης σκηνοθέτης
Βρες μου τον σκηνοθέτη που έχει σκηνοθετήσει τισ περισσότερες ταινίες που το genre τους είναι family.
*/
SELECT mc.name AS director
FROM movie_crew mc
JOIN hasGenre hg ON mc.movie_id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE mc.department = 'Directing' AND g.name = 'Family'
GROUP BY mc.name
HAVING COUNT(mc.movie_id) = (
    SELECT MAX(movie_count)
    FROM (
        SELECT COUNT(mc.movie_id) AS movie_count
        FROM movie_crew mc
        JOIN hasGenre hg ON mc.movie_id = hg.movie_id
        JOIN genre g ON hg.genre_id = g.id
        WHERE mc.department = 'Directing' AND g.name = 'Family'
        GROUP BY mc.name
    ) AS director_movies
);

-------------------------------------------------------------------------
/*Ερώτημα 6 : BEST PARTIES EVER
Βρες μου τις 5 πιο popular ταινίες που έχουν να κάνουν με party
*/
SELECT TOP 5 title
FROM movie
WHERE overview LIKE '%party%'
ORDER BY popularity DESC;

-------------------------------------------------------------------------
/*Ερώτημα 7 : Wifes of hollywood
βρες μου όλες τις ηθοποιούς που έχουν παίξει τον ρόλο της wife κάποια στιγμή της καριέρας τους. 
*/
SELECT DISTINCT mc.name
FROM movie_cast mc
JOIN hasKeyword hk ON mc.movie_id = hk.movie_id
JOIN keyword k ON hk.keyword_id = k.id
WHERE k.name = 'wife';

-------------------------------------------------------------------------
/*Ερώτημα 8 : Adventure fanatic
Βρες μου και εμφάνισέ μου όλες τιs ταινίες adventure και όποιες έχουν και homepage να εμφανίζεις και το λινκ τους.  
*/
SELECT m.title, m.homepage
FROM movie m
LEFT JOIN hasGenre hg ON m.id = hg.movie_id
LEFT JOIN genre g ON hg.genre_id = g.id
WHERE g.name = 'Adventure' OR g.id IS NULL;

-------------------------------------------------------------------------
/*Ερώτημα 9 : Καλοπληρωμένοι
Βρες μου και δώσε μου το crew που δούλεψε στην ταινία που είχε το μεγαλύτερο buget και πες μου και το genre της ταινίας αυτής.

*/
SELECT mc.name AS crew_name, m.title AS movie_title, g.name AS genre_name
FROM movie m
JOIN movie_crew mc ON m.id = mc.movie_id
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE m.id = (
    SELECT TOP 1 id FROM movie ORDER BY budget DESC
);

-------------------------------------------------------------------------
/*Ερώτημα 10 :Είναι ο Bill Weston το κρυφό μας είδωλο
Σε ποιές ταινίες παίζει ο Bill Weston και ποιό είναι το tagline ,αν υπάρχει.
*/
SELECT m.title, m.tagline
FROM movie m
LEFT JOIN movie_crew mc ON m.id = mc.movie_id
WHERE mc.name = 'Bill Weston'
AND m.title IS NOT NULL;

-------------------------------------------------------------------------
/*Ερώτημα 11 : Θρυλική συλλογή των 2000s
Ποιά είναι συλλογή με την καλύτερη βαθμολολογία που παράχθηκε τη χρονιά 2000-2005.
*/
SELECT c.id, c.name
FROM collection c
WHERE c.id = (
    SELECT TOP 1 c2.id
    FROM collection c2
    JOIN belongsToCollection bc ON c2.id = bc.collection_id
    JOIN ratings r ON bc.movie_id = r.movie_id
    JOIN movie m ON bc.movie_id = m.id
    WHERE YEAR(m.release_date) BETWEEN 2000 AND 2005
    GROUP BY c2.id
    ORDER BY MAX(r.rating) DESC
);

-------------------------------------------------------------------------
/*Ερώτημα 12 : Αποτυχημένο production company
Βρες μου ποιό είναιι το production company που έχει κάνει τις περισσότερες ταινίες που η βαθμολογία είναιντους είναι <2.
*/
SELECT TOP 1 pc.name AS production_company
FROM productioncompany pc
JOIN movie m ON pc.id = m.id
JOIN (
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM ratings
    GROUP BY movie_id
    HAVING AVG(rating) > 2
) AS rated_movies ON m.id = rated_movies.movie_id
GROUP BY pc.name
ORDER BY COUNT(m.id) DESC;

-------------------------------------------------------------------------
--THE END!!!!!!!
