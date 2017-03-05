TourneyCompactResults <- read.csv('TourneyCompactResults.csv')
TourneySeeds <- read.csv('TourneySeeds.csv')

totalPositiveSeedDiff = 0
totalNegativeSeedDiff = 0

seedQuad1 = 0
seedQuad2 = 0
seedQuad3 = 0
seedQuad4 = 0

generateReportWithSeedDifference <- function (row) {
 winnerTeamSeedRows <- TourneySeeds[which(TourneySeeds$Team == as.numeric(row['Wteam'])), ]
 loserTeamSeedRows <- TourneySeeds[which(TourneySeeds$Team == as.numeric(row['Lteam'])), ]

 Wseed <- winnerTeamSeedRows[which(winnerTeamSeedRows$Season == as.numeric(row['Season'])), ][1, ]['Seed'][1, ]
 Lseed <- loserTeamSeedRows[which(loserTeamSeedRows$Season == as.numeric(row['Season'])), ][1, ]['Seed'][1, ]

 Wseed <- substring(Wseed, 2, 3)
 Lseed <- substring(Lseed, 2, 3)

 seedDifference = as.numeric(Wseed) - as.numeric(Lseed)


 if (seedDifference >= 0) {
  totalPositiveSeedDiff <<- totalPositiveSeedDiff + 1
 } else {
  totalNegativeSeedDiff <<- totalNegativeSeedDiff + 1

  if (seedDifference >= -4) {
    seedQuad1 <<- seedQuad1 + 1
  }

  if (seedDifference < -4 && seedDifference >= -8) {
    seedQuad2 <<- seedQuad2 + 1
  }

  if (seedDifference < -8 && seedDifference >= -12) {
    seedQuad3 <<- seedQuad3 + 1
  }

  if (seedDifference < -12 && seedDifference >= -16) {
    seedQuad4 <<- seedQuad4 + 1
  }
 }

 outputRow <- paste(row['Season'], row['Wteam'], row['Lteam'], Wseed, Lseed, seedDifference, sep=',')

 cat(outputRow, file= 'seedsDifference.csv', append = T, fill = T)

}

by(TourneyCompactResults, 1:nrow(TourneyCompactResults), generateReportWithSeedDifference)

print(paste('Positives', totalPositiveSeedDiff, sep=':'))

print(paste('Negatives', totalNegativeSeedDiff, sep=':'))

print(paste('Quad1', seedQuad1, sep=':'))
print(paste('Quad2', seedQuad2, sep=':'))
print(paste('Quad3', seedQuad3, sep=':'))
print(paste('Quad4', seedQuad4, sep=':'))
