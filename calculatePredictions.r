TourneySeeds <- read.csv('TourneySeeds.csv')
teamsWinRate <- read.csv('teamsWinRate.csv')
matchesToPredict <- read.csv('sample_submission.csv')

predict <- function (match) {
  #
  id <- sapply(match, paste0, collapse = "")[1]
  idSplit <- strsplit(id, "_")[[1]]

  #
  season <- as.numeric(idSplit[1])
  teamA <- as.numeric(idSplit[2])
  teamB <- as.numeric(idSplit[3])

  #
  teamASeedRows <- TourneySeeds[which(TourneySeeds$Team == teamA), ]
  teamBSeedRows <- TourneySeeds[which(TourneySeeds$Team == teamB), ]

  #
  teamASeed <- teamASeedRows[which(teamASeedRows$Season == season), ][1, ]['Seed'][1, ]
  teamBSeed <- teamBSeedRows[which(teamBSeedRows$Season == season), ][1, ]['Seed'][1, ]

  #
  teamASeed <- substring(teamASeed, 2, 3)
  teamBSeed <- substring(teamBSeed, 2, 3)

  #
  seedDifference <- as.numeric(teamASeed) - as.numeric(teamBSeed)

  #
  teamAWinRateRow <- teamsWinRate[which(teamsWinRate$Team == teamA), ]
  teamBWinRateRow <- teamsWinRate[which(teamsWinRate$Team == teamB), ]

  #
  teamAWinRate <- as.character(unlist(teamAWinRateRow['Win.Rate']))
  teamBWinRate <- as.character(unlist(teamBWinRateRow['Win.Rate']))

  #
  teamAWinRate <- substring(teamAWinRate, 1, 2)
  teamBWinRate <- substring(teamBWinRate, 1, 2)

  #
  if (teamAWinRate == '0%') {
     teamAWinRate = 0
  }
  if (teamBWinRate == '0%') {
     teamBWinRate = 0
  }

  #
  teamsWinRateDifference <- as.numeric(teamAWinRate) - as.numeric(teamBWinRate)

  #
  prediction <- 0.5

  #
  prediction <- prediction + ((seedDifference * 0.016) * -1)
  prediction <- prediction + (teamsWinRateDifference * 0.0025)

  #
  id <-  paste(season, teamA, teamB, sep = '_')

  #
  outputRow <- paste(id, prediction, sep = ',')
  cat(outputRow, file = 'predictions.csv', append = T, fill = T)

}

#
by(matchesToPredict, 1:nrow(matchesToPredict), predict)

