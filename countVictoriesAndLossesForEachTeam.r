TourneyCompactResults <- read.csv('TourneyCompactResults.csv')

victoriesByTeam <- table(TourneyCompactResults$Wteam)
lossesByTeam <- table(TourneyCompactResults$Lteam)

write.table(victoriesByTeam, file = "victoriesByTeam.csv", col.names = c("Team","Victories"), row.names = FALSE, sep = ",")
write.table(lossesByTeam, file = "lossesByTeam.csv", col.names = c("Team","Losses"), row.names = FALSE, sep = ",")
