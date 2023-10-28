-- Create new Database 
DROP DATABASE IF EXISTS "IPL Project";
CREATE DATABASE "IPL Project";

-- Create matches table
CREATE TABLE IF NOT EXISTS matches
(
	Id 				INT,
	season 			INT,
	city 			VARCHAR,
	date			DATE,
	team1			VARCHAR,
	team2			VARCHAR,
	toss_winner		VARCHAR,
	toss_decission	VARCHAR,
	result			VARCHAR,
	dl_applied		VARCHAR,
	winner			VARCHAR,
	win_by_runs		VARCHAR,
	win_by_wickets	VARCHAR,
	player_of_match	VARCHAR,
	venue			VARCHAR,
	umpire1			VARCHAR,
	umpire2			VARCHAR,
	umpire3			VARCHAR
	
);

-- Create deliveries table

CREATE TABLE deliveries(
    match_id        INT,
    inning          INT,
    batting_team    VARCHAR,
    bowling_team    VARCHAR,
    over            INT,
    ball            INT,
    batsman         VARCHAR,
    non_striker     VARCHAR,
    bowler          VARCHAR,
    is_super_over   INT,
    wide_runs       INT,
    bye_runs        INT,
    legbye_runs     INT,
    noball_runs     INT,
    penalty_runs    INT,
    batsman_runs    INT,
    extra_runs      INT,
    total_runs      INT,
    player_dismissed VARCHAR,
    dismissal_kind  VARCHAR,
    fielder         VARCHAR
    )

-- Number of matches played per year for all the years in IPL.
SELECT season, COUNT(season) FROM matches group by season order by season;

-- Number of matches won per team per year in IPL.
SELECT season, winner, count(winner) from matches 
where winner is not null 
group by winner,season
order by season;

-- Extra runs conceded per team in the year 2016
SELECT bowling_team, SUM(extra_runs) from deliveries 
join matches 
on deliveries.match_id = matches.Id
where matches.season = '2016'
group by bowling_team;

-- Top 10 economical bowlers in the year 2015
SELECT bowler, 
( SUM(cast(total_runs as float)) /(COUNT(ball)-COUNT(case when wide_runs > 0 then 1 END)-COUNT(case when noball_runs >0 then 1 END)) ) * 6 as EcoRate
FROM deliveries
JOIN matches
on deliveries.match_id = matches.Id
Where matches.season = 2015 
group by bowler
order by EcoRate
limit 10;

-- Find the number of times each team won the toss and also won the match

SELECT winner, COUNT(toss_winner) FROM matches 
WHERE toss_winner = winner 
GROUP BY winner;


--Find a player who has won the highest number of Player of the Match awards for each season
WITH temporaryTable as
(SELECT season,player_of_match, MAX(count) as maxcount
FROM 
(SELECT season, player_of_match, COUNT(player_of_match) as count
from matches
group by season, player_of_match )
group by season, player_of_match
order by season, maxcount desc)
SELECT DISTINCT ON (temporaryTable.season)
temporaryTable.season,
temporaryTable.player_of_match,
temporaryTable.maxcount
FROM temporaryTable

--Find the strike rate of a batsman for each season

SELECT season, ( SUM(cast(batsman_runs as float)) /(COUNT(ball)-COUNT(case when wide_runs > 0 then 1 END)-COUNT(case when noball_runs >0 then 1 END)) ) * 100 as StrikeRate
FROM matches
JOIN deliveries
on deliveries.match_id = matches.Id
Where batsman ='MS Dhoni'
group by season
order by season


--Find the highest number of times one player has been dismissed by another player
SELECT bowler, player_dismissed, MAX(count) as maximum
FROM
(SELECT bowler, player_dismissed, COUNT(player_dismissed) as count
FROM deliveries
WHERE player_dismissed IS NOT NULL
group by bowler, player_dismissed)
group by bowler, player_dismissed
order by maximum desc


--Find the bowler with the best economy in super overs
SELECT bowler, 
( SUM(cast(total_runs as float)) /(COUNT(ball)-COUNT(case when wide_runs > 0 then 1 END)-COUNT(case when noball_runs >0 then 1 END)) ) * 6 as EcoRate
FROM deliveries
JOIN matches
on deliveries.match_id = matches.Id
Where deliveries.is_super_over > 0
group by bowler
order by EcoRate
limit 1;