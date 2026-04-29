--movie

ALTER TABLE movie
ADD CONSTRAINT movie_pk
PRIMARY KEY (id);

-- genre

ALTER TABLE genre
ADD CONSTRAINT genre_pk
PRIMARY KEY (id);

--productioncompany

ALTER TABLE productioncompany
ADD CONSTRAINT productioncompany_pk
PRIMARY KEY (id);

--collection

ALTER TABLE collection
ADD CONSTRAINT collection_pk
PRIMARY KEY (id);

--movie_cast

ALTER TABLE movie_cast
ADD CONSTRAINT movie_cast_pk
PRIMARY KEY (cid);

ALTER TABLE movie_cast
 ADD CONSTRAINT FK_MCAmovieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 --movie_crew

ALTER TABLE movie_crew
ADD CONSTRAINT movie_crew_pk
PRIMARY KEY (cid);

ALTER TABLE movie_cast
 ADD CONSTRAINT FK_MCRmovieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

--Keyword

ALTER TABLE Keyword
ADD CONSTRAINT Keyword_pk
PRIMARY KEY (id);

--ratings

ALTER TABLE ratings
ADD CONSTRAINT ratings_pk
PRIMARY KEY (user_id,movie_id);

ALTER TABLE ratings
 ADD CONSTRAINT FK_movieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 --belongsTocollection

ALTER TABLE belongsTocollection
 ADD CONSTRAINT FK_BTCmovie_id FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 ALTER TABLE belongsTocollection
 ADD CONSTRAINT FK_collectionid FOREIGN
KEY (collection_id)
 REFERENCES collection(id);

 --hasGenre

ALTER TABLE hasGenre
 ADD CONSTRAINT FK_HGmovie_id FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 ALTER TABLE hasGenre
 ADD CONSTRAINT FK_genreid FOREIGN
KEY (genre_id)
 REFERENCES genre(id);

 --hasProductioncompany

 ALTER TABLE hasProductioncompany
 ADD CONSTRAINT FK_HPCmovie_id FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 ALTER TABLE hasProductioncompany
 ADD CONSTRAINT FK_pcid FOREIGN
KEY (pc_id)
 REFERENCES productioncompany(id);

 --hasKeyword

 ALTER TABLE hasKeyword
 ADD CONSTRAINT FK_HKmovie_id FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 ALTER TABLE hasKeyword
 ADD CONSTRAINT FK_keywordid FOREIGN
KEY (Keyword_id)
 REFERENCES Keyword(id);

