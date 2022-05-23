-- SQL Project - Working on Soccer Database
-- Medium post: https://medium.com/@aadata/sql-project-working-on-soccer-database-7ba715b79f85

-- Soccer Database
-- https://miro.medium.com/max/1400/1*6plRPYIKWpGT3nP2cYTgvQ.png

-- Queries
-- 1. From the soccer_venue table, count the number of venues for EURO cup 2016. Return number of venues.
SELECT COUNT(venue_id)
FROM soccer_venue

-- 2. From the player_mast table, count the number of countries participated in the EURO cup 2016.
SELECT COUNT(DISTINCT(team_id))
FROM player_mast

-- 3. From the goal_details table, find the number of goals scored in EURO cup 2016 within normal time schedule.
SELECT COUNT(goal_id)
FROM goal_details
WHERE goal_schedule = ‘NT’

-- 4. From the match_mast table, find the number of matches ended with a result.
SELECT COUNT(match_no)
FROM match_mast
WHERE results IS NOT NULL

-- 5. From the match_mast table, find the number of matches ended with draws.
SELECT COUNT(match_no)
FROM match_mast
WHERE results = ‘DRAW’

-- 6. From the match_mast table, find the date when Football EURO cup 2016 begins.
SELECT MIN(play_date) AS “Beginning Date”
FROM match_mast

-- 7. From the goal_details table, find the number of self-goals scored in EURO cup 2016.
SELECT COUNT(goal_type)
FROM goal_details
WHERE goal_type = ‘O’

-- 8. From the match_mast table, count the number of matches ended with a win results in-group stage.
SELECT COUNT(match_no)
FROM match_mast
WHERE results = ‘WIN’
AND play_stage = ‘G’

-- 9. From the penalty_shootout table, find the number of matches got a result by penalty shootout.
SELECT COUNT(DISTINCT(match_no))
FROM penalty_shootout

-- 10. From the match_mast table, find the number of matches decided by penalties in the Round 16.
SELECT COUNT(match_no)
FROM match_mast
WHERE decided_by = ‘P’
AND play_stage = ‘R’

-- 11. From the goal_details table, find the number of goal scored in every match within normal play schedule. Sort the result-set on match number. Return match number, number of goal scored.
SELECT match_no, COUNT(goal_id)
FROM goal_details
GROUP BY match_no
ORDER BY match_no

-- 12. From the match_mast table, find those matches where no stoppage time added in the first half of play. Return match no, date of play, and goal scored.
SELECT match_no, play_date, goal_score
FROM match_mast
WHERE stop1_sec = 0

-- 13. From the match_details table, count the number of matches ending with a goalless draw in-group stage of play. Return number of matches.
SELECT COUNT(DISTINCT(match_no))
FROM match_details
WHERE win_lose = ‘D’
AND goal_score = 0
AND play_stage = ‘G’

-- 14. From the match_details table, count the number of matches ending with only one goal win, except those matches, which was decided by penalty shoot-out. Return number of matches.
SELECT COUNT(match_no)
FROM match_details
WHERE win_lose = ‘W’
AND goal_score = 1
AND decided_by <> ‘P’

-- 15. From the player_in_out table, count the number of players replaced in the tournament. Return number of players as “Player Replaced”.
SELECT COUNT(player_id) AS “Player Replaced”
FROM player_in_out
WHERE in_out = ‘I’

-- 16. From the player_in_out table, count the total number of players replaced within normal time of play. Return number of players as “Player Replaced”.
SELECT COUNT(player_id) AS “Player Replaced”
FROM player_in_out
WHERE in_out = ‘I’
AND play_schedule = ‘NT’

-- 17. From the player_in_out table, count the number of players replaced in the stoppage time. Return number of players as “Player Replaced”.
SELECT COUNT(player_id) AS “Player Replaced”
FROM player_in_out
WHERE in_out = ‘I’
AND play_schedule = ‘ST’

-- 18. From the player_in_out table, count the total number of players replaced in the first half of play. Return number of players as “Player Replaced”.
SELECT COUNT(player_id) AS “Player Replaced”
FROM player_in_out
WHERE in_out = ‘I’
AND play_half = 1

-- 19. From the match_details table, count the total number of goalless draws have there in the entire tournament. Return number of goalless draws.
SELECT COUNT(DISTINCT(match_no))
FROM match_details
WHERE win_lose = ‘D’
AND goal_score = 0

-- 20. From the player_in_out table, count the total number of players replaced in the extra time of play.
SELECT COUNT(player_id)
FROM player_in_out
WHERE in_out = ‘I’
AND play_schedule = ‘ET’

-- 21. From the player_in_out table, count the number of substitute happened in various stage of play for the entire Tournament. Sort the result-set in ascending order by play-half, play-schedule and number of substitute happened. Return play-half, play-schedule, number of substitute happened.
SELECT play_half, play_schedule, COUNT(*)
FROM player_in_out
WHERE in_out = ‘I’
GROUP BY play_half, play_schedule
ORDER BY play_half ASC, play_schedule ASC, COUNT(*) ASC

-- 22. From the penalty_shootout table, count the number of shots taken in penalty shootout matches. Number of shots as “Number of Penalty Kicks”.
SELECT COUNT(kick_id) AS “Number of Penalty Kicks”
FROM penalty_shootout

-- 23. From the penalty_shootout table, count the number of shots scored goal in penalty shootout matches. Return number of shots scored goal as “Goal Scored by Penalty Kicks”.
SELECT COUNT(kick_id) AS “Goal Scored by Penalty Kicks”
FROM penalty_shootout
WHERE score_goal = ‘Y’

-- 24. From the penalty_shootout table, count the number of shots missed or saved in penalty shootout matches. Return number of shots missed as “Goal missed or saved by Penalty Kicks”.
SELECT COUNT(kick_id) AS “Goal Missed or Saved by Penalty Kicks”
FROM penalty_shootout
WHERE score_goal = ‘N’

-- 25. From the penalty_shootout and player_mast tables, find the players with shot number they taken in penalty shootout matches. Return match_no, Team, player_name, jersey_no, score_goal, kick_no.
SELECT ps.match_no, pm.playing_club, pm.player_name, pm.jersey_no, ps.score_goal, ps.kick_no
FROM penalty_shootout AS ps
JOIN player_mast AS pm
ON ps.player_id = pm.player_id

-- 26. From the soccer_country and penalty_shootout tables, count the number of penalty shots taken by the teams. Return country name, number of shots as “Number of Shots”.
SELECT sc.country_name, COUNT(kick_id) AS “Number of Shots”
FROM soccer_country AS sc
JOIN penalty_shootout AS ps
ON sc.country_id = ps.team_id
GROUP BY sc.country_name
ORDER BY COUNT(kick_id) DESC, sc.country_name

-- 27. From the player_booked table, count the number of booking happened in each half of play within normal play schedule. Return play_half, play_schedule, number of booking happened.
SELECT play_half, play_schedule, COUNT(*)
FROM player_booked
WHERE play_schedule = ‘NT’
GROUP BY play_half, play_schedule
ORDER BY play_half

-- 28. From the player_booked table, count the number of booking happened in stoppage time.
SELECT COUNT(*)
FROM player_booked
WHERE play_schedule = ‘ST’

-- 29. From the player_booked table, count the number of booking happened in extra time.
SELECT COUNT(*)
FROM player_booked
WHERE play_schedule = ‘ET’

-- 30. From the match_details and soccer_country tables, find the teams played the first match of EURO cup 2016. Return match number, country name.
SELECT match_no, country_name
FROM match_details AS md
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE match_no = 1

-- 31. From the soccer_country and match_details tables, find the winner of EURO cup 2016. Return country name.
SELECT country_name
FROM soccer_country
WHERE country_id =
(
SELECT team_id FROM match_details WHERE play_stage = ‘F’ AND win_lose = ‘W’
)

-- 32. From the match_mast table, find the most watched match in the world. Return match_no, play_stage, goal_score, audience.
SELECT match_no, play_stage, goal_score, audence
FROM match_mast
WHERE audence IN
(
SELECT MAX(audence) FROM match_mast
)

-- 33. From the match_details and soccer_country tables, find the match number in which Germany played against Poland. Group the result set on match number. Return match number.
SELECT match_no
FROM match_details
WHERE team_id IN
(
SELECT country_id FROM soccer_country WHERE country_name = ‘Germany’ OR country_name = ‘Poland’
)
GROUP BY match_no
HAVING COUNT(match_no) = 2

-- 34. From the match_mast, match_details, and soccer_country tables, find the result of the match where Portugal played against Hungary. Return match_no, play_stage, play_date, results, goal_score.
SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no IN
(
SELECT match_no FROM match_details WHERE team_id IN
(
SELECT country_id FROM soccer_country WHERE country_name = ‘Portugal’ OR country_name = ‘Hungary’
)
GROUP BY match_no HAVING COUNT(match_no) = 2
)

-- 35. From the goal_details, soccer_country, and player_mast tables, find those players who scored number of goals in every match. Group the result set on match number, country name and player name. Sort the result-set in ascending order by match number. Return match number, country name, player name and number of matches.
SELECT gd.match_no, sc.country_name, pm.player_name, COUNT(*)
FROM goal_details AS gd
JOIN soccer_country AS sc
ON gd.team_id = sc.country_id
JOIN player_mast AS pm
ON gd.player_id = pm.player_id
GROUP BY gd.match_no, sc.country_name, pm.player_name
ORDER BY gd.match_no ASC

-- 36. From the soccer_country, goal_details, and match_mast tables, find the highest audience match. Return country name of the teams.
SELECT country_name
FROM soccer_country
WHERE country_id IN
(
SELECT DISTINCT(team_id) FROM goal_details WHERE match_no IN
(
SELECT match_no FROM match_mast ORDER BY audence DESC LIMIT 1
)
)

-- 37. From the player_mast, goal_details, match_details, and soccer_country tables, find the player who scored the last goal for Portugal against Hungary. Return player name.
SELECT player_name
FROM player_mast
WHERE player_id =
(
SELECT player_id FROM goal_details WHERE match_no =
(
SELECT match_no FROM match_details WHERE team_id IN
(
SELECT country_id FROM soccer_country WHERE country_name IN (‘Portugal’, ‘Hungary’)
)
GROUP BY match_no HAVING COUNT(match_no) = 2
)
ORDER BY goal_id DESC LIMIT 1
)

-- 38. From the match_mast table, find the second-highest stoppage time, which had been added, in the second half of play.
SELECT MIN(t.stop2_sec) AS “Second-Highest Stoppage”
FROM
(
SELECT stop2_sec FROM match_mast ORDER BY stop2_sec DESC LIMIT 2
) AS t

-- 39. From the soccer_country, match_details, and match_mast tables, find the teams played the match where second highest stoppage time had been added in second half of play. Return country name of the teams.
SELECT country_name
FROM soccer_country
WHERE country_id IN
(
SELECT team_id FROM match_details WHERE match_no =
(
SELECT match_no FROM match_mast WHERE stop2_sec =
(
SELECT MIN(t.stop2_sec) AS “Second-Highest Stoppage”
FROM
(
SELECT stop2_sec FROM match_mast ORDER BY stop2_sec DESC LIMIT 2
) AS t
)
)
)

-- 40. From the match_mast table, find the teams played the match where second highest stoppage time had been added in second half of play. Return match_no, play_date, stop2_sec.
SELECT match_no, play_date, stop2_sec
FROM match_mast
WHERE stop2_sec =
(
SELECT MIN(t.stop2_sec) AS “Second-Highest Stoppage”
FROM
(
SELECT stop2_sec FROM match_mast ORDER BY stop2_sec DESC LIMIT 2
) AS t
)

-- 41. From the soccer_country and match_details tables, find the team, which was defeated by Portugal in EURO cup 2016 final. Return the country name of the team.
SELECT country_name
FROM soccer_country
WHERE country_id =
(
SELECT team_id FROM match_details WHERE win_lose = ‘L’ ORDER BY match_no DESC LIMIT 1
)

-- 42. From the player_mast table, find the club, which supplied the most number of players to the 2016-EURO cup. Return club name, number of players.
SELECT playing_club, COUNT(player_id)
FROM player_mast
GROUP BY playing_club
HAVING COUNT(player_id) =
(
SELECT MAX(t.count) FROM 
(
SELECT COUNT(player_id) AS count FROM player_mast GROUP BY playing_club
) AS t
)

-- 43. From the player_mast and goal_details tables, find the player who scored the first penalty of the tournament. Return player name and Jersey number.
SELECT player_name, jersey_no
FROM player_mast
WHERE player_id =
(
SELECT player_id FROM goal_details WHERE goal_type = ‘P’ ORDER BY goal_id ASC LIMIT 1
)

-- 44. From the player_mast, soccer_country, and goal_details tables, find the player who scored the first penalty in the tournament. Return player name, Jersey number and country name.
SELECT pm.player_name, pm.jersey_no, sc.country_name
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE player_id =
(
SELECT player_id FROM goal_details WHERE goal_type = ‘P’ ORDER BY goal_id ASC LIMIT 1
)

-- 45. From the player_mast, penalty_gk, and soccer_country tables, find the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016. Return goalkeeper name.
SELECT player_name
FROM player_mast
WHERE player_id =
(
SELECT player_gk FROM penalty_gk WHERE match_no =
(
SELECT match_no FROM penalty_gk WHERE team_id IN
(
SELECT country_id FROM soccer_country WHERE country_name IN (‘Italy’, ‘Germany’)
)
GROUP BY match_no HAVING COUNT(match_no) = 2
)
AND team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘Italy’
)
)

-- 46. From the goal_details and soccer_country tables, find the number of goals Germany scored at the tournament.
SELECT COUNT(goal_id)
FROM goal_details
WHERE team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘Germany’
)

-- 47. From the player_mast and soccer_country tables, find the players who were the goalkeepers of England squad in 2016-EURO cup. Return player name, jersey number, club name.
SELECT player_name, jersey_no, playing_club
FROM player_mast
WHERE team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘England’
)
AND posi_to_play = ‘GK’

-- 48. From the player_mast and soccer_country tables, find the players under contract to Liverpool were in the Squad of England in 2016-EURO cup. Return player name, jersey number, position to play, age.
SELECT player_name, jersey_no, posi_to_play, age
FROM player_mast
WHERE team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘England’
)
AND playing_club = ‘Liverpool’

-- 49. From the player_mast, goal_details, and soccer_country tables, find the players who scored the last goal in the 2nd semi-final, i.e., 50th match in EURO cup 2016. Return player name, goal time, goal half, country name.
SELECT pm.player_name, gd.goal_time, gd.goal_half, sc.country_name
FROM player_mast AS pm
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.player_id =
(
SELECT player_id FROM goal_details WHERE match_no = 50 ORDER BY goal_id DESC LIMIT 1
)
ORDER BY goal_id DESC
LIMIT 1

-- 50. From the player_mast, match_captain, and match_details tables, find the captain of the EURO cup 2016 winning team from Portugal. Return the captain name.
SELECT player_name
FROM player_mast
WHERE player_id =
(
SELECT DISTINCT(player_captain) FROM match_captain WHERE team_id =
(
SELECT team_id FROM match_details WHERE play_stage = ‘F’ AND win_lose = ‘W’
)
)

-- 51. From the player_in_out, soccer_country, and match_mast tables, count the number of players played for ‘France’ in the final. Return ‘Number of players shared fields’.
SELECT 11 + COUNT(*) AS “Number of players shared fields”
FROM player_in_out
WHERE team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘France’
)
AND match_no =
(
SELECT match_no FROM match_mast WHERE play_stage = ‘F’
)
AND in_out = ‘I’

-- 52. From the player_mast, match_details, and soccer_country tables, find the Germany goalkeeper who didn’t concede any goal in their group stage matches. Return goalkeeper name, jersey number.
SELECT player_name, jersey_no
FROM player_mast
WHERE player_id IN
(
SELECT player_gk FROM match_details WHERE team_id =
(
SELECT country_id FROM soccer_country WHERE country_name = ‘Germany’
)
AND play_stage = ‘G’
AND goal_score = 0
)

-- 53. From the soccer_country and match_details tables, find the runners-up in Football EURO cup 2016. Return country name.
SELECT country_name
FROM soccer_country
WHERE country_id =
(
SELECT team_id FROM match_details WHERE play_stage = ‘F’ AND win_lose = ‘L’
)

-- 54. From the soccer_country and penalty_shootout tables, find the maximum penalty shots taken by the teams. Return country name, maximum penalty shots.
SELECT sc.country_name, MAX(t.count)
FROM soccer_country AS sc
JOIN
(
SELECT team_id, match_no, COUNT(kick_id) AS count
FROM penalty_shootout
GROUP BY team_id, match_no
) AS t
ON sc.country_id = t.team_id
GROUP BY sc.country_name
ORDER BY MAX(t.count) DESC

-- 55. From the player_mast, soccer_country, and penalty_shootout tables, find the maximum number of penalty shots taken by the players. Return country name, player name, jersey number and number of penalty shots.
SELECT sc.country_name, pm.player_name, pm.jersey_no, MAX(t.count)
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN
(
SELECT player_id, match_no, COUNT(kick_id) AS count
FROM penalty_shootout
GROUP BY player_id, match_no
) AS t
ON pm.player_id = t.player_id
GROUP BY sc.country_name, pm.player_name, pm.jersey_no
ORDER BY MAX(t.count) DESC, sc.country_name, pm.jersey_no

-- 56. From the penalty_shootout table, find those match where the highest number of penalty shots taken.
SELECT match_no
FROM penalty_shootout
GROUP BY match_no
HAVING COUNT(kick_id) =
(
SELECT MAX(t.count) FROM
(
SELECT match_no, COUNT(kick_id) AS count
FROM penalty_shootout
GROUP BY match_no
ORDER BY COUNT(kick_id) DESC
) AS t
)

-- 57. From the penalty_shootout and soccer_country tables, find the match number where highest number of penalty shots had been taken. Return match number, country name.
SELECT DISTINCT ps.match_no, sc.country_name
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
WHERE ps.match_no IN
(
SELECT match_no FROM penalty_shootout GROUP BY match_no HAVING COUNT(kick_id) =
(
SELECT MAX(t.count) FROM
(
SELECT match_no, COUNT(kick_id) AS count
FROM penalty_shootout
GROUP BY match_no
ORDER BY COUNT(kick_id) DESC
) AS t
)
)

-- 58. From the penalty_shootout, soccer_country, and player_mast tables, find the player of ‘Portugal’ who taken the seventh kick against ‘Poland’. Return match number, player name and kick number.
SELECT ps.match_no, pm.player_name, ps.kick_no
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
JOIN player_mast AS pm
ON ps.player_id = pm.player_id
WHERE ps.match_no =
(
SELECT DISTINCT t1.match_no FROM
(
SELECT *
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
WHERE sc.country_name = ‘Portugal’
) AS t1
JOIN
(
SELECT *
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
WHERE sc.country_name = ‘Poland’
) AS t2
ON t1.match_no = t2.match_no
)
AND sc.country_name = ‘Portugal’
AND kick_no = 7

-- 59. From the match_mast and penalty_shootout tables, find the stage of match where penalty kick number 23 had been taken. Return match number, play_stage.
SELECT match_no, play_stage
FROM match_mast
WHERE match_no =
(
SELECT match_no FROM penalty_shootout WHERE kick_id = 23
)

-- 60. From the soccer_venue, match_mast, and penalty_shootout tables, find the venues where penalty shoot-out matches played. Return venue name.
SELECT venue_name
FROM soccer_venue
WHERE venue_id IN
(
SELECT venue_id FROM match_mast WHERE match_no IN
(
SELECT DISTINCT match_no FROM penalty_shootout
)
)

-- 61. From the match_mast and penalty_shootout tables, find the date when penalty shootout matches played. Return playing date.
SELECT play_date
FROM match_mast
WHERE match_no IN
(
SELECT DISTINCT match_no FROM penalty_shootout
)

-- 62. From the goal_details table, find the quickest goal at the EURO cup 2016, after 5 minutes. Return ‘Quickest goal after 5 minutes’.
SELECT goal_time AS “Quickest goal after 5 minutes”
FROM goal_details
WHERE goal_time > 5
ORDER BY goal_time ASC
LIMIT 1

-- 63. From the soccer_venue, soccer_city, and match_mast tables, find the venue where EURO cup 2016 final match held. Return venue name, city.
SELECT sv.venue_name, sc.city
FROM soccer_venue AS sv
JOIN soccer_city AS sc
ON sv.city_id = sc.city_id
WHERE sv.venue_id =
(
SELECT venue_id FROM match_mast WHERE play_stage = ‘F’
)

-- 64. From the match_details and soccer_country tables, find the number of goal scored by each team in every match within normal play schedule. Return match number, country name and goal score.
SELECT md.match_no, sc.country_name, md.goal_score
FROM match_details AS md
JOIN soccer_country AS sc
ON md.team_id = sc.country_id

-- 65. From the player_mast, goal_details, and soccer_country tables, count the number of goals scored by each player within normal play schedule. Group the result set on player name and country name and sorts the result-set according to the highest to the lowest scorer. Return player name, number of goals and country name.
SELECT pm.player_name, COUNT(gd.goal_id), sc.country_name
FROM player_mast AS pm
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE gd.goal_schedule = ‘NT’
GROUP BY pm.player_name, sc.country_name

-- 66. From the player_mast, goal_details, and soccer_country tables, find the highest individual scorer in EURO cup 2016. Return player name, country name and highest individual scorer.
SELECT pm.player_name, sc.country_name, COUNT(gd.goal_id)
FROM player_mast AS pm
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
GROUP BY pm.player_name, sc.country_name
HAVING COUNT(gd.goal_id) =
(
SELECT COUNT(gd.goal_id) AS count FROM player_mast AS pm JOIN goal_details AS gd ON pm.player_id = gd.player_id JOIN soccer_country AS sc ON pm.team_id = sc.country_id GROUP BY pm.player_name, sc.country_name ORDER BY COUNT(gd.goal_id) DESC LIMIT 1
)

-- 67. From the player_mast, soccer_country, and goal_details tables, find the scorer in the final of EURO cup 2016. Return player name, jersey number and country name.
SELECT pm.player_name, pm.jersey_no, sc.country_name
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
WHERE gd.play_stage = ‘F’

-- 68. From the soccer_venue, soccer_city, and soccer_country tables, find the country where Football EURO cup 2016 held. Return country name.
SELECT DISTINCT sco.country_name
FROM soccer_venue AS sv
JOIN soccer_city AS sci
ON sv.city_id = sci.city_id
JOIN soccer_country AS sco
ON sci.country_id = sco.country_id

-- 69. From the player_mast, soccer_country, and goal_details tables, find the player who scored first goal of EURO cup 2016. Return player_name, jersey_no, country_name, goal_time, goal_schedule, play_stage, goal_half.
SELECT pm.player_name, pm.jersey_no, sc.country_name, gd.goal_time, gd.goal_schedule, gd.play_stage, gd.goal_half
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
WHERE gd.goal_id = 1

-- 70. From the referee_mast, soccer_country, and match_mast tables, find the referee who managed the opening match. Return referee name, country name.
SELECT rm.referee_name, sc.country_name
FROM referee_mast AS rm
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
JOIN match_mast AS mm
ON rm.referee_id = mm.referee_id
WHERE mm.match_no = 1

-- 71. From the referee_mast, soccer_country, and match_mast tables, find the referee who managed the final match. Return referee name, country name.
SELECT rm.referee_name, sc.country_name
FROM referee_mast AS rm
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
JOIN match_mast AS mm
ON rm.referee_id = mm.referee_id
WHERE mm.play_stage = ‘F’

-- 72. From the asst_referee_mast, soccer_country, and match_details tables, find the referee who assisted the referee in the opening match. Return associated referee name, country name.
SELECT arm.ass_ref_name, sc.country_name
FROM asst_referee_mast AS arm
JOIN soccer_country AS sc
ON arm.country_id = sc.country_id
JOIN match_details AS md
ON arm.ass_ref_id = md.ass_ref
WHERE md.match_no = 1

-- 73. From the asst_referee_mast, soccer_country, and match_details tables, find the referee who assisted the referee in the final match. Return associated referee name, country name.
SELECT arm.ass_ref_name, sc.country_name
FROM asst_referee_mast AS arm
JOIN soccer_country AS sc
ON arm.country_id = sc.country_id
JOIN match_details AS md
ON arm.ass_ref_id = md.ass_ref
WHERE md.play_stage = ‘F’

-- 74. From the soccer_venue, soccer_city, and match_mast tables, find the city where the opening match of EURO cup 2016 played. Return venue name, city.
SELECT sv.venue_name, sc.city
FROM soccer_venue AS sv
JOIN soccer_city AS sc
ON sv.city_id = sc.city_id
JOIN match_mast AS mm
ON sv.venue_id = mm.venue_id
WHERE mm.match_no = 1

-- 75. From the soccer_venue, soccer_city, and match_mast tables, find the stadium hosted the final match of EURO cup 2016. Return venue_name, city, aud_capacity, audience.
SELECT sv.venue_name, sc.city, sv.aud_capacity, mm.audence
FROM soccer_venue AS sv
JOIN soccer_city AS sc
ON sv.city_id = sc.city_id
JOIN match_mast AS mm
ON sv.venue_id = mm.venue_id
WHERE mm.play_stage = ‘F’

-- 76. From the soccer_venue, soccer_city, and match_mast tables, count the number of matches played in each venue. Sort the result-set on venue name. Return Venue name, city, and number of matches.
SELECT sv.venue_name, sc.city, COUNT(mm.venue_id)
FROM soccer_venue AS sv
JOIN soccer_city AS sc
ON sv.city_id = sc.city_id
JOIN match_mast AS mm
ON sv.venue_id = mm.venue_id
GROUP BY sv.venue_name, sc.city
ORDER BY sv.venue_name

-- 77. From the player_booked, player_mast, and soccer_country tables, find the player who was the first player to be sent off at the tournament EURO cup 2016. Return match Number, country name and player name.
SELECT pb.match_no, sc.country_name, pm.player_name
FROM player_booked AS pb
JOIN player_mast AS pm
ON pb.player_id = pm.player_id
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pb.sent_off = ‘Y’
ORDER BY pb.match_no ASC, pb.booking_time ASC
LIMIT 1

-- 78. From the soccer_team and soccer_country tables, find those teams that scored only one goal to the tournament. Return country_name as “Team”, team in the group, goal_for.
SELECT sc.country_name AS “Team”, st.team_group, st.goal_for
FROM soccer_team AS st
JOIN soccer_country AS sc
ON st.team_id = sc.country_id
WHERE st.goal_for = 1

-- 79. From the soccer_venue, match_mast, and goal_details tables, count number of goals that has been scored at each venue. Return venue name and number of goals.
SELECT sv.venue_name, COUNT(gd.goal_id)
FROM soccer_venue AS sv
JOIN match_mast AS mm
ON sv.venue_id = mm.venue_id
JOIN goal_details AS gd
ON mm.match_no = gd.match_no
GROUP BY sv.venue_name
ORDER BY COUNT(gd.goal_id) DESC

-- 80. From the match_details, match_mast, and soccer_country tables, find the match where no stoppage time added in first half of play. Return match number, country name.
SELECT md.match_no, sc.country_name
FROM match_details AS md
JOIN match_mast AS mm
ON md.match_no = mm.match_no
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE mm.stop1_sec = 0

-- 81. From the soccer_country and soccer_team tables, find the team(s) who conceded the most goals in EURO cup 2016. Return country name, team group and match played.
SELECT sc.country_name, st.team_group, st.match_played, st.goal_agnst
FROM soccer_country AS sc
JOIN soccer_team AS st
ON sc.country_id = st.team_id
WHERE st.goal_agnst =
(
SELECT goal_agnst FROM soccer_team ORDER BY goal_agnst DESC LIMIT 1
)
ORDER BY st.goal_agnst DESC

-- 82. From the match_mast, match_details, and soccer_country tables, find those matches where highest stoppage time added in 2nd half of play. Return match number, country name, stoppage time(sec.)
SELECT mm.match_no, sc.country_name, mm.stop2_sec
FROM match_mast AS mm
JOIN match_details AS md
ON mm.match_no = md.match_no
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE mm.stop2_sec =
(
SELECT stop2_sec FROM match_mast ORDER BY stop2_sec DESC LIMIT 1
)

-- 83. From the match_details and soccer_country tables, find those matches ending with a goalless draw in-group stage of play. Return match number, country name.
SELECT md.match_no, sc.country_name
FROM match_details AS md
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE md.win_lose = ‘D’
AND md.goal_score = 0
AND md.play_stage = ‘G’

-- 84. From the match_mast, match_details, and soccer_country tables, find those match(s) where the 2nd highest stoppage time had been added in the second half of play. Return match number, country name and stoppage time.
SELECT mm.match_no, sc.country_name, mm.stop2_sec
FROM match_mast AS mm
JOIN match_details AS md
ON mm.match_no = md.match_no
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE mm.stop2_sec =
(
SELECT MIN(t.stop2_sec) FROM
(
SELECT stop2_sec
FROM match_mast
ORDER BY stop2_sec DESC
LIMIT 2
) AS t
)

-- 85. From the player_mast, soccer_country, and match_details tables, find the number of matches played a player as a goalkeeper for his team. Return country name, player name, number of matches played as a goalkeeper.
SELECT sc.country_name, pm.player_name, COUNT(pm.player_id)
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN match_details AS md
ON pm.player_id = md.player_gk
GROUP BY sc.country_name, pm.player_name
ORDER BY COUNT(pm.player_id) DESC, sc.country_name, pm.player_name

-- 86. From the soccer_venue, match_mast, and goal_details tables, find the venue that has seen the most number of goals. Return venue name, number of goals.
SELECT sv.venue_name, COUNT(gd.goal_id)
FROM soccer_venue AS sv
JOIN match_mast AS mm
ON sv.venue_id = mm.venue_id
JOIN goal_details AS gd
ON mm.match_no = gd.match_no
GROUP BY sv.venue_name
ORDER BY COUNT(gd.goal_id) DESC, sv.venue_name
LIMIT 1

-- 87. From the player_mast and soccer_country tables, find the oldest player appeared in a EURO cup 2016 match. Return country name, player name, jersey number and age.
SELECT sc.country_name, pm.player_name, pm.jersey_no, pm.age
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.age =
(
SELECT MAX(age) FROM player_mast
)

-- 88. From the match_details and soccer_country tables, find those two teams, scored three goals in a single game in this tournament. Return match number and country name.
SELECT md.match_no, sc.country_name
FROM match_details AS md
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE md.goal_score = 3
AND match_no IN
(
SELECT match_no FROM match_details AS md WHERE goal_score = 3 GROUP BY match_no HAVING COUNT(match_no) = 2
)

-- 89. From the soccer_team and soccer_country tables, find those teams that finished bottom of their respective groups after conceding four times in three games. Return country name, team group and match played.
SELECT sc.country_name, st.team_group, st.match_played
FROM soccer_team AS st
JOIN soccer_country AS sc
ON st.team_id = sc.country_id
WHERE group_position =
(
SELECT MAX(group_position) FROM soccer_team
)
AND goal_agnst = 4
AND match_played = 3
ORDER BY st.team_group, sc.country_name

-- 90. From the player_mast, soccer_country, and match_details tables, find those players, who contracted to ‘Lyon’ club and participated in the EURO cup 2016 Finals. Return player name, jersey_no, position to play, age, country name.
SELECT pm.player_name, pm.jersey_no, pm.posi_to_play, pm.age, sc.country_name
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.playing_club = ‘Lyon’
AND pm.team_id IN
(
SELECT team_id FROM match_details WHERE play_stage = ‘F’
)
ORDER BY pm.player_name

-- 91. From the soccer_country and match_details tables, find the final four teams in the tournament. Return country name.
SELECT country_name
FROM soccer_country
WHERE country_id IN
(
SELECT team_id FROM match_details WHERE play_stage IN (‘S’, ‘F’) ORDER BY match_no DESC LIMIT 6
)

-- 92. From the player_mast, soccer_country, and match_captain tables, find the captains of the top four teams that participated in the semi-finals (match 48 and 49) in the tournament. Return country name, player name, jersey number and position to play.
SELECT sc.country_name, pm.player_name, pm.jersey_no, pm.posi_to_play
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN match_captain AS mc
ON pm.team_id = mc.team_id
WHERE mc.match_no IN (48, 49)
AND pm.player_id = mc.player_captain

-- 93. From the player_mast, soccer_country, and match_captain tables, find the captains of all the matches in the tournament. Return match number, country name, player name, jersey number and position to play.
SELECT mc.match_no, sc.country_name, pm.player_name, pm.jersey_no, pm.posi_to_play
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN match_captain AS mc
ON pm.team_id = mc.team_id
WHERE pm.player_id = mc.player_captain
ORDER BY mc.match_no, sc.country_name

-- 94. From the player_mast, match_captain, soccer_country, and match_details tables, find the captain and goalkeeper of all the matches. Return match number, Captain, Goal Keeper and country name.
SELECT t1.match_no, t1.player_name AS “Captain”, pm.player_name AS “Goal Keeper”, t1.country_name
FROM player_mast AS pm
JOIN
(
SELECT mc.match_no, pm.player_id, pm.team_id, pm.player_name, sc.country_name
FROM player_mast AS pm
JOIN match_captain AS mc
ON pm.player_id = mc.player_captain
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
) AS t1
ON pm.team_id = t1.team_id
JOIN match_details AS md
ON md.match_no = t1.match_no
AND md.team_id = pm.team_id
WHERE posi_to_play = ‘GK’
AND md.player_gk = pm.player_id
ORDER BY t1.match_no, t1.country_name

-- 95. From the player_mast and soccer_country tables, find the player who was selected for the ‘Man of the Match’ award in the finals of EURO cup 2016.Return player name, country name.
SELECT pm.player_name, sc.country_name
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.player_id =
(
SELECT plr_of_match FROM match_mast WHERE play_stage = ‘F’
)

-- 96. From the player_in_out, soccer_country, and player_mast tables, find the substitute players who came into the field in the first half of play within normal play schedule. Return match_no, country_name, player_name, jersey_no and time_in_out.
SELECT pio.match_no, sc.country_name, pm.player_name, pm.jersey_no, pio.time_in_out
FROM player_in_out AS pio
JOIN soccer_country AS sc
ON pio.team_id = sc.country_id
JOIN player_mast AS pm
ON pio.player_id = pm.player_id
WHERE pio.in_out = ‘I’
AND pio.play_half = 1
AND pio.play_schedule = ‘NT’

-- 97. From the match_mast, player_mast, and soccer_country tables, prepare a list for the player of the match against each match. Return match number, play date, country name, player of the Match, jersey number.
SELECT mm.match_no, mm.play_date, sc.country_name, pm.player_name, pm.jersey_no
FROM match_mast AS mm
JOIN player_mast AS pm
ON mm.plr_of_match = pm.player_id
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
ORDER BY mm.match_no

-- 98. From the penalty_shootout, soccer_country, and player_mast tables, find the player who taken the penalty shot number 26. Return match number, country name, player name.
SELECT ps.match_no, sc.country_name, pm.player_name
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
JOIN player_mast AS pm
ON ps.player_id = pm.player_id
WHERE ps.kick_id = 26

-- 99. From the penalty_shootout and soccer_country tables, find the team against which the penalty shot number 26 had been taken. Return match number, country name.
SELECT ps.match_no, sc.country_name
FROM penalty_shootout AS ps
JOIN soccer_country AS sc
ON ps.team_id = sc.country_id
WHERE ps.match_no =
(
SELECT match_no FROM penalty_shootout WHERE kick_id = 26
)
AND ps.team_id <>
(
SELECT team_id FROM penalty_shootout WHERE kick_id = 26
)
GROUP BY ps.match_no, sc.country_name

-- 100. From the match_captain, soccer_country, and player_mast tables, find the captain who was also the goalkeeper. Return match number, country name, player name and jersey number.
SELECT mc.match_no, sc.country_name, pm.player_name
FROM match_captain AS mc
JOIN soccer_country AS sc
ON mc.team_id = sc.country_id
JOIN player_mast AS pm
ON mc.player_captain = pm.player_id
WHERE pm.posi_to_play = ‘GK’
ORDER BY mc.match_no

-- 101. From the match_captain, soccer_country, and player_mast tables, find the number of captains who was also the goalkeeper. Return number of captains.
SELECT COUNT(DISTINCT(pm.player_id))
FROM match_captain AS mc
JOIN soccer_country AS sc
ON mc.team_id = sc.country_id
JOIN player_mast AS pm
ON mc.player_captain = pm.player_id
WHERE pm.posi_to_play = ‘GK’

-- 102. From the player_mast, soccer_country, and player_booked tables, find the players along with their team booked number of times in the tournament. Show the result according to the team and number of times booked in descending order. Return country name, player name, and team booked number of times.
SELECT sc.country_name, pm.player_name, COUNT(pb.player_id)
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN player_booked AS pb
ON pm.player_id = pb.player_id
GROUP BY sc.country_name, pm.player_name
ORDER BY sc.country_name, pm.player_name

-- 103. From the player_mast and player_booked tables, count the players who booked the most number of times. Return player name, number of players who booked most number of times.
SELECT pm.player_name, COUNT(pb.player_id)
FROM player_mast AS pm
JOIN player_booked AS pb
ON pm.player_id = pb.player_id
GROUP BY pm.player_name
HAVING COUNT(pb.player_id) =
(
SELECT COUNT(player_id) FROM player_booked GROUP BY player_id ORDER BY COUNT(player_id) DESC LIMIT 1
)

-- 104. From the soccer_country and player_booked tables, find the number of players booked for each team. Return country name, number of players booked.
SELECT sc.country_name, COUNT(pb.team_id)
FROM soccer_country AS sc
JOIN player_booked AS pb
ON sc.country_id = pb.team_id
GROUP BY sc.country_name
ORDER BY COUNT(pb.team_id) DESC

-- 105. From the player_booked table, find those matches where most number of cards shown. Return match number, number of cards shown.
SELECT match_no, COUNT(match_no)
FROM player_booked
GROUP BY match_no
HAVING COUNT(match_no) =
(
SELECT COUNT(match_no) FROM player_booked GROUP BY match_no ORDER BY COUNT(match_no) DESC LIMIT 1
)

-- 106. From the match_details, asst_referee_mast, and soccer_country tables, find the assistant referees. Return match number, country name, assistant referee name.
SELECT md.match_no, sc.country_name, arm.ass_ref_name
FROM match_details AS md
JOIN asst_referee_mast AS arm
ON md.ass_ref = arm.ass_ref_id
JOIN soccer_country AS sc
ON arm.country_id = sc.country_id

-- 107. From the match_details, asst_referee_mast, and soccer_country tables, find the assistant referees of each country assists the number of matches. Sort the result-set in descending order on number of matches. Return country name, number of matches.
SELECT sc.country_name, COUNT(DISTINCT(md.match_no))
FROM match_details AS md
JOIN asst_referee_mast AS arm
ON md.ass_ref = arm.ass_ref_id
JOIN soccer_country AS sc
ON arm.country_id = sc.country_id
GROUP BY sc.country_name
ORDER BY COUNT(md.match_no) DESC

-- 108. From the match_mast, referee_mast, and soccer_country tables, find the name of referees for each match. Sort the result-set on match number. Return match number, country name, referee name.
SELECT mm.match_no, sc.country_name, rm.referee_name
FROM match_mast AS mm
JOIN referee_mast AS rm
ON mm.referee_id = rm.referee_id
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id

-- 109. From the match_mast, referee_mast, and soccer_country tables, count the number of matches managed by referees of each country. Return country name, number of matches.
SELECT sc.country_name, COUNT(mm.match_no)
FROM match_mast AS mm
JOIN referee_mast AS rm
ON mm.referee_id = rm.referee_id
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
GROUP BY sc.country_name
ORDER BY COUNT(mm.match_no) DESC

-- 110. From the match_mast, referee_mast, and soccer_country tables, find the number of matches managed by each referee. Return referee name, country name, number of matches.
SELECT rm.referee_name, sc.country_name, COUNT(mm.match_no)
FROM match_mast AS mm
JOIN referee_mast AS rm
ON mm.referee_id = rm.referee_id
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
GROUP BY rm.referee_name, sc.country_name
ORDER BY COUNT(mm.match_no) DESC

-- 111. From the match_mast, referee_mast, and soccer_country tables, find those referees who managed most of the matches. Return referee name, country name and number of matches.
SELECT rm.referee_name, sc.country_name, COUNT(mm.match_no)
FROM match_mast AS mm
JOIN referee_mast AS rm
ON mm.referee_id = rm.referee_id
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
GROUP BY rm.referee_name, sc.country_name
HAVING COUNT(mm.match_no) =
(
SELECT COUNT(mm.match_no) FROM match_mast AS mm JOIN referee_mast AS rm ON mm.referee_id = rm.referee_id GROUP BY rm.referee_name ORDER BY COUNT(mm.match_no) DESC LIMIT 1
)

-- 112. From the match_mast, referee_mast, soccer_country, and soccer_venue tables, find those referees who managed the number of matches in each venue. Return referee name, country name, venue name, number of matches.
SELECT rm.referee_name, sc.country_name, sv.venue_name, COUNT(mm.match_no)
FROM match_mast AS mm
JOIN referee_mast AS rm
ON mm.referee_id = rm.referee_id
JOIN soccer_country AS sc
ON rm.country_id = sc.country_id
JOIN soccer_venue AS sv
ON mm.venue_id = sv.venue_id
GROUP BY rm.referee_name, sc.country_name, sv.venue_name
ORDER BY COUNT(mm.match_no) DESC

-- 113. From the referee_mast, match_mast, and player_booked tables, find the referees and number of booked they made. Return referee name, number of matches.
SELECT rm.referee_name, COUNT(pb.match_no)
FROM referee_mast AS rm
JOIN match_mast AS mm
ON rm.referee_id = mm.referee_id
JOIN player_booked AS pb
ON mm.match_no = pb.match_no
GROUP BY rm.referee_name
ORDER BY COUNT(pb.match_no) DESC

-- 114. From the player_mast and soccer_country tables, find those players of each team who wore jersey number 10. Return country name, player name, position to play, age and playing club.
SELECT sc.country_name, pm.player_name, pm.posi_to_play, pm.age, pm.playing_club
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.jersey_no = 10

-- 115. From the player_mast, soccer_country, and goal_details tables, find those defenders who scored goal for their team. Return player name, jersey number, country name, age and playing club.
SELECT pm.player_name, pm.jersey_no, sc.country_name, pm.age, pm.playing_club
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
WHERE pm.posi_to_play = ‘DF’
AND pm.player_id IN
(
SELECT player_id FROM goal_details
)
ORDER BY pm.player_name

-- 116. From the player_mast, soccer_country, and goal_details tables, find those players who accidentally scores against his own team. Return player name, jersey number, country name, age, position to play, and playing club.
SELECT pm.player_name, pm.jersey_no, sc.country_name, pm.age, pm.posi_to_play, pm.playing_club
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
AND pm.player_id IN
(
SELECT player_id FROM goal_details WHERE goal_type = ‘O’
)
ORDER BY pm.player_name

-- 117. From the match_details and soccer_country tables, find the results of penalty shootout matches. Return match number, play stage, country name and penalty score.
SELECT md.match_no, md.play_stage, sc.country_name, md.penalty_score
FROM match_details AS md
JOIN soccer_country AS sc
ON md.team_id = sc.country_id
WHERE md.penalty_score IS NOT NULL
ORDER BY md.match_no, sc.country_name

-- 118. From the player_mast, soccer_country, and goal_details tables, find the goal scored by the players according to their playing position. Return country name, position to play, number of goals.
SELECT sc.country_name, pm.posi_to_play, COUNT(goal_id)
FROM player_mast AS pm
JOIN soccer_country AS sc
ON pm.team_id = sc.country_id
JOIN goal_details AS gd
ON pm.player_id = gd.player_id
GROUP BY sc.country_name, pm.posi_to_play
ORDER BY pm.posi_to_play, sc.country_name

-- 119. From the player_in_out, soccer_country, and player_mast tables, find those players who came into the field at the last time of play. Return match number, country name, player name, jersey number and time in out.
SELECT pio.match_no, sc.country_name, pm.player_name, pm.jersey_no, pio.time_in_out
FROM player_in_out AS pio
JOIN soccer_country AS sc
ON pio.team_id = sc.country_id
JOIN player_mast AS pm
ON pio.player_id = pm.player_id
WHERE (pio.in_out = ‘I’ AND pio.play_schedule = ‘NT’ AND pio.time_in_out = 90)
OR (pio.in_out = ‘I’ AND pio.play_schedule = ‘ET’ AND pio.time_in_out = 120)
ORDER BY pio.match_no, pio.time_in_out