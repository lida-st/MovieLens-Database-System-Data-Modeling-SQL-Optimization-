--ratings

ALTER TABLE ratings
ADD CONSTRAINT ratings_pk
PRIMARY KEY (user_id,movie_id);

--hasKeyword

ALTER TABLE hasKeyword
ADD CONSTRAINT PK_hasKeyword
PRIMARY KEY (keyword_id,movie_id);


--belongsTocollection

ALTER TABLE belongsTocollection
ADD CONSTRAINT PK_belongsTocollection
PRIMARY KEY (collection_id,movie_id);


--hasProductioncompany

ALTER TABLE hasProductioncompany
ADD CONSTRAINT PK_hasProductioncompany
PRIMARY KEY (pc_id,movie_id);

--hasGenre

ALTER TABLE hasGenre
ADD CONSTRAINT hasGenre_PK
PRIMARY KEY (movie_id,genre_id);
