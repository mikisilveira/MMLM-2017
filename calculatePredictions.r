# Load csv and tranform them into data frames.
TourneySeeds <- read.csv('TourneySeeds.csv')
teamsWinRate <- read.csv('teamsWinRate.csv')
matchesToPredict <- read.csv('sample_submission.csv')

predict <- function (match) {
  # Transform 'id' from list to string and split 'id' to get game season and team ids. 
  id <- sapply(match, paste0, collapse = "")[1]
  idSplit <- strsplit(id, "_")[[1]]
  
  # Transform season, teamA and teamB from string to numbers.
  season <- as.numeric(idSplit[1])
  teamA <- as.numeric(idSplit[2])
  teamB <- as.numeric(idSplit[3])

  # Getting all seeds of teamA and teamB from 'TourneySeeds' data frame.
  teamASeedRows <- TourneySeeds[which(TourneySeeds$Team == teamA), ]
  teamBSeedRows <- TourneySeeds[which(TourneySeeds$Team == teamB), ]

  # Filter 'teamA' and 'teamB' seeds by season.
  teamASeed <- teamASeedRows[which(teamASeedRows$Season == season), ][1, ]['Seed'][1, ]
  teamBSeed <- teamBSeedRows[which(teamBSeedRows$Season == season), ][1, ]['Seed'][1, ]

  # Remove the region of each Team seed. E.g. 01 <- X01 (the second and third characters only.)
  teamASeed <- substring(teamASeed, 2, 3)
  teamBSeed <- substring(teamBSeed, 2, 3)

  # Calculating difference between 'teamASeed' and 'teamBSeed'
  seedDifference <- as.numeric(teamASeed) - as.numeric(teamBSeed)

  # Filter 'teamA' and 'teamB' rows from 'teamsWinRate' dataframe.
  teamAWinRateRow <- teamsWinRate[which(teamsWinRate$Team == teamA), ]
  teamBWinRateRow <- teamsWinRate[which(teamsWinRate$Team == teamB), ]

  # Generate 'teamAWinRate' and 'teamBWinRate'from 'Win.Rate' row and transform list in character.
  teamAWinRate <- as.character(unlist(teamAWinRateRow['Win.Rate']))
  teamBWinRate <- as.character(unlist(teamBWinRateRow['Win.Rate']))

  # Removing '%' from 'teamAWinRate' and 'teamBWinRate', leaving only the numeric value.
  teamAWinRate <- substring(teamAWinRate, 1, 2)
  teamBWinRate <- substring(teamBWinRate, 1, 2)

  # Treat special case when has only one numeric value. 0% was the only case.
  if (teamAWinRate == '0%') {
     teamAWinRate = 0
  }
  if (teamBWinRate == '0%') {
     teamBWinRate = 0
  }

  # Calculating difference between win rates.
  teamsWinRateDifference <- as.numeric(teamAWinRate) - as.numeric(teamBWinRate)

  # This is the prediction inicial value (50% win chance for each team).
  prediction <- 0.5

  # Here is the definition of the main predictions calculation. 
  # The 'seedDifference' and 'teamsWinRateDifference' coefficients where defined by these calculations:
  # First, distribute equal weight for Seeds and Win Rate: 0.25
  # Then this value is spread between their possible variations.
  # E.g. 'seedDifference' varies from 1 to 15, meaning 0.25/15 = 0.016
  # and the 'teamsWinRateDifference' varies from 0 to 100, meaning 0.25/100 = 0.0025
  # The * -1 operation on the 'seedDifference' was necessary because for seeds the smaller value is better.
  # So, a negative 'seedDifference' in that case should increase the prediction calculation instead of decrease it.
  prediction <- prediction + ((seedDifference * 0.016) * -1)
  prediction <- prediction + (teamsWinRateDifference * 0.0025)

  # Mount id back to original format.
  id <-  paste(season, teamA, teamB, sep = '_')

  # Write the prediction row in final csv file to export it.
  outputRow <- paste(id, prediction, sep = ',')
  cat(outputRow, file = 'predictions.csv', append = T, fill = T)

}

# For each row of 'matchesToPredict' run 'predict' function.
by(matchesToPredict, 1:nrow(matchesToPredict), predict)

