#import data
MTData1 <- read.csv("~/Desktop/S&L/Coding/Midtown_Apartments/MTData1.csv")
summary(MTData1)
dim(MTData1)

#boxplot of overall rent distribution
png("OverallMTRentDist.png", width=800, height=300)
boxplot(MTData1$Rent, 
        col="lightgreen", 
        xlab="Rent ($/month)",
        cex.lab = 1.5,
        horizontal=TRUE,
        axes = FALSE, 
        staplewex=1)
text(x=fivenum(MTData1$Rent), labels =fivenum(MTData1$Rent), y=0.7, cex = 1.5)
dev.off()

#making a scatterplot plot of year built vs $/Sqft

OneBedMTData1 <- filter(MTData1, Bedrooms == 1)
plot(OneBedMTData1$Year.built, 
     OneBedMTData1$X..Sqft, 
     ylim = c(1,4.5), 
     main = "Year built vs $/SQFT for 1 bedroom apartments",
     xlab = "Year Built",
     ylab = "$ per SQFT",
     col = "black", 
     pch = 21,
     bg="blue")

