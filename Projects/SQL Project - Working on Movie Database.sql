-- SQL Project - Working on Movie Database
-- Medium post: https://medium.com/@aadata/sql-project-working-on-movie-database-de290adacfde

-- Movie Database
-- https://miro.medium.com/max/1400/1*gHFEXlP9Y-FnWIwc3rbAAQ.png

-- Queries
-- 1. From the movie table, find the name and year of the movies. Return movie title, movie release year.
SELECT mov_title, mov_year
FROM movie

-- 2. From the movie table, find when the movie ‘American Beauty’ released. Return movie release year.
SELECT mov_year
FROM movie
WHERE mov_title = ‘American Beauty’

-- 3. From the movie table, find the movie, which was made in the year 1999. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_year = 1999

-- 4. From the movie table, find those movies, which was made before 1998. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_year < 1998

-- 5. From the movie and reviewer tables, find the name of all reviewers and movies together in a single list.
SELECT rev_name
FROM reviewer
UNION
SELECT mov_title
FROM movie

-- 6. From the rating and reviewer tables, find all reviewers who have rated 7 or more stars to their rating. Return reviewer name.
SELECT rev.rev_name
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
WHERE rat.rev_stars >= 7

-- 7. From the movie and rating tables, find the movies without any rating. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id NOT IN
(
SELECT mov_id FROM rating
)

-- 8. From the movie table, find the movies with ID 905 or 907 or 917. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id IN (905, 907, 917)

-- 9. From the movie table, find those movie titles, which include the words ‘Boogie Nights’. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
SELECT mov_id, mov_title, mov_year
FROM movie
WHERE mov_title LIKE ‘%Boogie%Nights%’
ORDER BY mov_year ASC

-- 10. From the actor table, find those actors whose first name is ‘Woody’ and the last name is ‘Allen’. Return actor ID
SELECT act_id
FROM actor
WHERE act_fname = ‘Woody’
AND act_lname = ‘Allen’

-- 11. From the movie, movie_cast, and actor tables, find the actors who played a role in the movie ‘Annie Hall’. Return all the fields of actor table.
SELECT *
FROM actor
WHERE act_id IN
(
SELECT act_id FROM movie_cast WHERE mov_id =
(
SELECT mov_id FROM movie WHERE mov_title = ‘Annie Hall’
)
)

-- 12. From the movie, movie_direction, and director tables, find the director who directed a movie that casted a role for ‘Eyes Wide Shut’. Return director first name, last name.
SELECT dir_fname, dir_lname
FROM director
WHERE dir_id =
(
SELECT dir_id FROM movie_direction WHERE mov_id =
(
SELECT mov_id FROM movie WHERE mov_title = ‘Eyes Wide Shut’
)
)

-- 13. From the movie table, find those movies, which released in the country besides UK. Return movie title, movie year, movie time, date of release, releasing country.
SELECT mov_title, mov_year, mov_time, mov_dt_rel, mov_rel_country
FROM movie
WHERE mov_rel_country = ‘UK’

-- 14. From the movie, movie_cast, actor, movie_direction, director, rating, and reviewer tables, find those movies where reviewer is unknown. Return movie title, year, release date, director first name, last name, actor first name, last name.
SELECT m.mov_title, m.mov_year, m.mov_dt_rel, d.dir_fname, d.dir_lname, a.act_fname, a.act_lname
FROM movie AS m
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
JOIN actor AS a
ON mc.act_id = a.act_id
WHERE m.mov_id IN
(
SELECT mov_id FROM rating WHERE rev_id IN
(
SELECT rev_id FROM reviewer WHERE rev_name IS NULL
)
)

-- 15. From the movie, movie_direction, and director tables, find those movies directed by the director whose first name is ‘Woddy’ and last name is ‘Allen’. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id IN
(
SELECT mov_id FROM movie_direction WHERE dir_id =
(
SELECT dir_id FROM director WHERE dir_fname = ‘Woody’ AND dir_lname = ‘Allen’
)
)

-- 16. From the movie and rating tables, find those years, which produced at least one movie and that, received a rating of more than three stars. Sort the result-set in ascending order by movie year. Return movie year.
SELECT DISTINCT mov_year
FROM movie
WHERE mov_id IN
(
SELECT mov_id FROM rating WHERE rev_stars > 3
)
ORDER BY mov_year ASC

-- 17. From the movie and rating tables, find those movies, which have no ratings. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id NOT IN
(
SELECT mov_id FROM rating
)

-- 18. From the rating and reviewer tables, find those reviewers who have rated nothing for some movies. Return reviewer name.
SELECT rev_name
FROM reviewer
WHERE rev_id IN
(
SELECT rev_id FROM rating WHERE rev_stars IS NULL
)

-- 19. From the movie, rating, and reviewer tables, find those movies, which reviewed by a reviewer and got a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars.
SELECT rev.rev_name, m.mov_title, rat.rev_stars
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
JOIN movie AS m
ON rat.mov_id = m.mov_id
WHERE rev.rev_name IS NOT NULL
AND rat.rev_stars IS NOT NULL
ORDER BY rev.rev_name ASC, m.mov_title ASC, rat.rev_stars ASC

-- 20. From the movie, rating, and reviewer tables, find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.
SELECT rev.rev_name, m.mov_title
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
JOIN movie AS m
ON rat.mov_id = m.mov_id
WHERE rev.rev_id IN
(
SELECT rev_id FROM rating GROUP BY rev_id HAVING COUNT(rev_id) > 1
)

-- 21. From the movie and rating tables, find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order by movie title. Return movie title and maximum number of review stars.
SELECT m.mov_title, MAX(rat.rev_stars)
FROM movie AS m
JOIN rating AS rat
ON m.mov_id = rat.mov_id
GROUP BY m.mov_title
ORDER BY m.mov_title ASC

-- 22. From the movie, rating, and reviewer tables, find all reviewers who rated the movie ‘American Beauty’. Return reviewer name.
SELECT rev_name
FROM reviewer
WHERE rev_id IN
(
SELECT rev_id FROM rating WHERE mov_id =
(
SELECT mov_id FROM movie WHERE mov_title = ‘American Beauty’
)
)

-- 23. From the movie, rating, and reviewer tables, find the movies, which have reviewed by any reviewer body except by ‘Paul Monks’. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id IN
(
SELECT mov_id FROM rating WHERE rev_id <>
(
SELECT rev_id FROM reviewer WHERE rev_name = ‘Paul Monks’
)
)

-- 24. From the movie, rating, and reviewer tables, find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies.
SELECT rev.rev_name, m.mov_title, rat.rev_stars
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
JOIN movie AS m
ON rat.mov_id = m.mov_id
ORDER BY rat.rev_stars ASC
LIMIT 1

-- 25. From the movie, movie_direction, and director tables, find the movies directed by ‘James Cameron’. Return movie title.
SELECT mov_title
FROM movie
WHERE mov_id IN
(
SELECT mov_id FROM movie_direction WHERE dir_id =
(
SELECT dir_id FROM director WHERE dir_fname = ‘James’ AND dir_lname = ‘Cameron’
)
)

-- 26. Find the name of those movies where one or more actors acted in two or more movies.
SELECT mov_title
FROM movie
WHERE mov_id IN
(
SELECT mov_id FROM movie_cast WHERE act_id IN
(
SELECT act_id FROM movie_cast GROUP BY act_id HAVING COUNT(act_id) > 1
)
)

-- 27. From the rating and reviewer tables, find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name.
SELECT rev.rev_name
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
WHERE rat.rev_stars IS NULL

-- 28. From the movie, movie_cast, and actor tables, find the actors who were cast in the movie ‘Annie Hall’. Return actor first name, last name and role.
SELECT a.act_fname, a.act_lname, mc.role
FROM actor AS a
JOIN movie_cast AS mc
ON a.act_id = mc.act_id
JOIN movie AS m
ON mc.mov_id = m.mov_id
WHERE m.mov_title = ‘Annie Hall’

-- 29. From the movie, movie_direction, and director tables, find the director who directed a movie that casted a role for ‘Eyes Wide Shut’. Return director first name, last name and movie title.
SELECT d.dir_fname, d.dir_lname, m.mov_title
FROM director AS d
JOIN movie_direction AS md
ON d.dir_id = md.dir_id
JOIN movie AS m
ON md.mov_id = m.mov_id
WHERE m.mov_title = ‘Eyes Wide Shut’

-- 30. From the movie, movie_cast, and director tables, find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.
SELECT d.dir_fname, d.dir_lname, m.mov_title
FROM director AS d
JOIN movie_direction AS md
ON d.dir_id = md.dir_id
JOIN movie AS m
ON md.mov_id = m.mov_id
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
WHERE role = ‘Sean Maguire’

-- 31. From the movie, movie_cast, and actor tables, find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year.
SELECT a.act_fname, a.act_lname, m.mov_title, m.mov_year
FROM actor AS a
JOIN movie_cast AS mc
ON a.act_id = mc.act_id
JOIN movie AS m
ON mc.mov_id = m.mov_id
WHERE m.mov_year NOT BETWEEN 1990 AND 2000

-- 32. From the movie_direction, director, movie_genres, and genres tables, find the directors with number of genres movies. Group the result set on director first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.
SELECT d.dir_fname, d.dir_lname, g.gen_title, COUNT(g.gen_title)
FROM director AS d
JOIN movie_direction AS md
ON d.dir_id = md.dir_id
JOIN movie_genres AS mg
ON md.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
GROUP BY d.dir_fname, d.dir_lname, g.gen_title
ORDER BY d.dir_fname ASC, d.dir_lname ASC

-- 33. From the movie, movie_genres, and genres tables, find the movies with year and genres. Return movie title, movie year and generic title.
SELECT m.mov_title, m.mov_year, g.gen_title
FROM movie AS m
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id

-- 34. From the movie, movie_direction, director, movie_genres, and genres tables, find all the movies with year, genres, and name of the director.
SELECT m.mov_title, m.mov_year, g.gen_title, CONCAT(d.dir_fname, ‘ ‘, d.dir_lname) AS director
FROM movie AS m
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id

-- 35. From the movie, movie_direction, and director tables, find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director.
SELECT m.mov_title, m.mov_year, m.mov_dt_rel, m.mov_time, d.dir_fname, d.dir_lname
FROM movie AS m
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
WHERE m.mov_dt_rel < ‘1989–01–01’
ORDER BY m.mov_dt_rel DESC

-- 36. From the movie, movie_genres, and genres tables, compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre.
SELECT g.gen_title, AVG(m.mov_time), COUNT(m.mov_id)
FROM movie AS m
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
GROUP BY g.gen_title

-- 37. From the movie, movie_cast, actor, movie_direction, and director tables, find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role.
SELECT m.mov_title, m.mov_year, d.dir_fname, d.dir_lname, a.act_fname, a.act_lname, mc.role
FROM movie AS m
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
JOIN actor AS a
ON mc.act_id = a.act_id
ORDER BY m.mov_time ASC
LIMIT 1

-- 38. From the movie and rating tables, find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year.
SELECT DISTINCT m.mov_year
FROM movie AS m
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE rat.rev_stars IN (3, 4)
ORDER BY m.mov_year ASC

-- 39. From the movie, rating, and reviewer tables, get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
SELECT rev.rev_name, m.mov_title, rat.rev_stars
FROM reviewer AS rev
JOIN rating AS rat
ON rev.rev_id = rat.rev_id
JOIN movie AS m
ON rat.mov_id = m.mov_id
ORDER BY rev.rev_name, m.mov_title, rat.rev_stars

-- 40. From the movie and rating tables, find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. Return movie title and maximum review stars.
SELECT m.mov_title, MAX(rat.rev_stars)
FROM movie AS m
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE rat.rev_stars >= 1
GROUP BY m.mov_title
ORDER BY m.mov_title

-- 41. From the movie, movie_direction, director, and rating tables, find those movies, which have received ratings. Return movie title, director first name, director last name and review stars.
SELECT m.mov_title, d.dir_fname, d.dir_lname, rat.rev_stars
FROM movie AS m
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
JOIN rating AS rat
ON m.mov_id = rat.mov_id

-- 42. Find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
SELECT m.mov_title, a.act_fname, a.act_lname, mc.role
FROM movie AS m
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
JOIN actor AS a
ON mc.act_id = a.act_id
WHERE a.act_id IN
(
SELECT act_id FROM movie_cast GROUP BY act_id HAVING COUNT(act_id) >= 2
)

-- 43. From the movie, movie_cast, actor, movie_direction, and director tables, find the actor whose first name is ‘Claire’ and last name is ‘Danes’. Return director first name, last name, movie title, actor first name and last name, role.
SELECT d.dir_fname, d.dir_lname, m.mov_title, a.act_fname, a.act_lname, mc.role
FROM director AS d
JOIN movie_direction AS md
ON d.dir_id = md.dir_id
JOIN movie AS m
ON md.mov_id = m.mov_id
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
JOIN actor AS a
ON mc.act_id = a.act_id
WHERE a.act_fname = ‘Claire’
AND a.act_lname = ‘Danes’

-- 44. From the movie, movie_cast, actor, movie_direction, and director tables, find those actors who have directed their movies. Return actor first name, last name, movie title and role.
SELECT a.act_fname, a.act_lname, m.mov_title, mc.role
FROM actor AS a
JOIN movie_cast AS mc
ON a.act_id = mc.act_id
JOIN movie AS m
ON mc.mov_id = m.mov_id
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
WHERE a.act_fname = d.dir_fname
AND a.act_lname = d.dir_lname

-- 45. From the movie, movie_cast, and actor tables, find the cast list of the movie ‘Chinatown’. Return first name, last name.
SELECT a.act_fname, a.act_lname
FROM actor AS a
JOIN movie_cast AS mc
ON a.act_id = mc.act_id
JOIN movie AS m
ON mc.mov_id = m.mov_id
WHERE m.mov_title = ‘Chinatown’

-- 46. From the movie, movie_cast, and actor tables, find those movies where actor’s first name is ‘Harrison’ and last name is ‘Ford’. Return movie title.
SELECT m.mov_title
FROM actor AS a
JOIN movie_cast AS mc
ON a.act_id = mc.act_id
JOIN movie AS m
ON mc.mov_id = m.mov_id
WHERE a.act_fname = ‘Harrison’
AND a.act_lname = ‘Ford’

-- 47. From the movie and rating tables, find the highest-rated movies. Return movie title, movie year, review stars and releasing country.
SELECT m.mov_title, m.mov_year, rat.rev_stars, m.mov_rel_country
FROM movie AS m
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE rat.rev_stars IS NOT NULL
ORDER BY rat.rev_stars DESC
LIMIT 1

-- 48. From the movie, movie_genres, genres, and rating tables, find the highest-rated ‘Mystery Movies’. Return the title, year, and rating.
SELECT m.mov_title, m.mov_year, rat.rev_stars
FROM movie AS m
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE g.gen_title = ‘Mystery’
AND rat.rev_stars IS NOT NULL
ORDER BY rat.rev_stars DESC
LIMIT 1

-- 49. From the movie, movie_genres, genres, and rating tables, find the years when most of the ‘Mystery Movies’ produced. Count the number of generic title and compute their average rating. Group the result set on movie release year, generic title. Return movie year, generic title, number of generic title and average rating.
SELECT m.mov_year, g.gen_title, COUNT(g.gen_title), AVG(rat.rev_stars) AS avg_rating
FROM movie AS m
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE g.gen_title = ‘Mystery’
GROUP BY m.mov_year, g.gen_title
ORDER BY COUNT(g.gen_title) DESC
LIMIT 1

-- 50. From the movie, movie_cast, actor, movie_direction, director, movie_genres, genres, and rating tables, generate a report, which contain the fields movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.
SELECT m.mov_title, a.act_fname, a.act_lname, m.mov_year, mc.role, g.gen_title, CONCAT(d.dir_fname, ‘ ‘, d.dir_lname) AS director, m.mov_dt_rel, rat.rev_stars
FROM movie AS m
JOIN movie_cast AS mc
ON m.mov_id = mc.mov_id
JOIN actor AS a
ON mc.act_id = a.act_id
JOIN movie_genres AS mg
ON m.mov_id = mg.mov_id
JOIN genres AS g
ON mg.gen_id = g.gen_id
JOIN movie_direction AS md
ON m.mov_id = md.mov_id
JOIN director AS d
ON md.dir_id = d.dir_id
JOIN rating AS rat
ON m.mov_id = rat.mov_id
WHERE a.act_gender = ‘F’