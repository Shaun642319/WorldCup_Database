#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# 1. Total number of goals from winning teams
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

# 2. Total number of goals from both teams
echo -e "\nTotal number of goals in all games from both teams combined:" 
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

# 3. Average number of goals from winning teams
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 16) FROM games")"

# 4. Average number of goals from winning teams rounded to two decimal places
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

# 5. Average number of goals from both teams
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals + opponent_goals), 16) FROM games")"

# 6. Most goals scored in a single game by one team
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

# 7. Number of games where the winning team scored more than two goals
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

# 8. Winner of the 2018 tournament
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT teams.name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE games.year = 2018 AND games.round = 'Final'")"

# 9. List of teams who played in the 2014 'Eighth-Final' round
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT(teams.name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE games.year = 2014 AND games.round = 'Eighth-Final' ORDER BY teams.name")"

# 10. List of unique winning team names in the whole data set
echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(teams.name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY teams.name")"

# 11. Year and team name of all the champions
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT games.year || '|' || teams.name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE games.round = 'Final' ORDER BY games.year")"

# 12. List of teams that start with 'Co'
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
