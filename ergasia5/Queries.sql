----------------------------Μέρος Α----------------------------

----------------Ερώτημα Β----------------

-------- α --------
CREATE INDEX idx_movie_title ON movie (title);
CREATE INDEX idx_movie_cast_movie_id ON movie_cast (movie_id);

----------------Ερώτημα C----------------

-------- α --------

SELECT movie_id
FROM Ratings
GROUP BY movie_id
HAVING AVG(rating) > 40;

-------- c --------

CREATE INDEX indec_rat ON Ratings (rating,movie_id);



----------------------------Μέρος B----------------------------

----------------Ερώτημα D----------------

-------- α --------

--DEFAULT NULL(=The default value is NULL to indicate that the average rating hasn't been calculated yet.)
ALTER TABLE movie
ADD AVG_Rating FLOAT(4) DEFAULT NULL;


-------- b --------
UPDATE movie
SET AVG_Rating = (
  SELECT AVG(rating)
  FROM ratings AS r
  WHERE r.movie_id = movie.id
)
--WHERE AVG_Rating IS NULL;
WHERE movie.id NOT IN (
  SELECT DISTINCT movie_id
  FROM ratings
);

-------- c --------
go 

CREATE TRIGGER up_trigger
ON ratings
AFTER INSERT
AS
BEGIN
UPDATE movie
SET movie.AVG_Rating = list.Average_Rating
FROM movie AS M
INNER JOIN(
  SELECT AVG(R.rating) AS Average_Rating, i.movie_id AS Movie_Id
  FROM inserted i
  INNER JOIN ratings R
  ON i.movie_id=R.movie_id
  GROUP BY i.movie_id)
AS list ON list.Movie_Id=M.id;
END;

