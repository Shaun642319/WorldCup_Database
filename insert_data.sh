#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
 
# Do not change code above this line. Use the PSQL variable above to query your database.
TRUNCATE=$($PSQL "TRUNCATE teams, games")
cat games.csv| while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Don't add column title
  if [[ $WINNER != 'winner' && $OPPONENT != 'opponent' ]]
  then
    # Check if the winner team name is there
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_INTO=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      echo "Inserted into teams," $WINNER
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
    # Check if opponent teams name is there
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_INTO=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      echo "Inserted into teams," $OPPONENT
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi
    # Insert data into games table
    INSERT_INTO_GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    echo "Inserted game: $YEAR $ROUND - $WINNER vs $OPPONENT"
  fi
done