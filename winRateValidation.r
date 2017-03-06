TourneyCompactResults <- read.csv('TourneyCompactResults.csv')
winRateMacroResults <- read.csv('winRateMacroResults.csv')

# Start counting of win rate diff. I'm expecting positive results.
totalPositiveWinRateDiff = 0
totalNegativeWinRateDiff = 0

generateReportWithWinRateDifference <- function (row) {
 winnerTeamWinRateRows <- winRateMacroResults[which(winRateMacroResults$Team == as.numeric(row['Wteam'])), ]
 loserTeamWinRateRows <- winRateMacroResults[which(winRateMacroResults$Team == as.numeric(row['Lteam'])), ]

 WwinRate <- winnerTeamWinRateRows[which(winnerTeamWinRateRows$Team == as.numeric(row['Wteam'])), ][1, ]['WinRate'][1, ]
 LwinRate <- loserTeamWinRateRows[which(loserTeamWinRateRows$Team == as.numeric(row['Lteam'])), ][1, ]['WinRate'][1, ]


 winRateDifference <- as.numeric(WwinRate) - as.numeric(LwinRate)

 print(paste(as.numeric(WwinRate), as.numeric(LwinRate), winRateDifference, sep=', '))
 if (winRateDifference >= 0) {
  totalPositiveWinRateDiff <<- totalPositiveWinRateDiff + 1
 } else {
  totalNegativeWinRateDiff <<- totalNegativeWinRateDiff + 1
 }

}

by(TourneyCompactResults, 1:nrow(TourneyCompactResults), generateReportWithWinRateDifference)


print(paste('Positives', totalPositiveWinRateDiff, sep=':'))
print(paste('Negatives', totalNegativeWinRateDiff, sep=':'))


