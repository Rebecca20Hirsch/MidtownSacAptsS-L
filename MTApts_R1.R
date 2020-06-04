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

#boxplot of cost per square foot distribution
png("OverallMTSqftcostDist.png", width=800, height=300)
boxplot(MTData1$X..Sqft, 
        col="lightgreen",
        xlab="Rent per square foot ($)",
        cex.lab = 1.5,
        horizontal=TRUE,
        axes=TRUE,
        staplewex=1)
text(x=fivenum(MTData1$X..Sqft), 
     labels = round(fivenum(MTData1$X..Sqft), digits = 2),
     y=0.7, 
     cex = 1)
dev.off()

#boxplot of rent distribution by decade
Data18701900 <- filter(MTData1, Year.built < 1900)
Data19001930 <- filter(MTData1, Year.built >= 1900 & Year.built < 1930)
Data19301960 <- filter(MTData1, Year.built >= 1930 & Year.built < 1960)
Data19601990 <- filter(MTData1, Year.built >= 1960 & Year.built < 1990)
Data19902020 <- filter(MTData1, Year.built >= 1990 & Year.built < 2020)

png("yearvscostSQFTboxplot.png", width=470, height=600)
boxplot(Data19001930$X..Sqft, #note I eliminated 1970-1900 because of the lack of data
        Data19301960$X..Sqft,
        Data19601990$X..Sqft,
        Data19902020$X..Sqft, 
        col = c("lavender","lightblue","tan", "lightgreen"),
        xlab= "Year Built",
        ylab = "Cost per square foot ($)",
        horizontal=FALSE,
        boxwex = 0.65,
        names = c("1900-29", "1930-59", "1960-89","1990-2020"))
dev.off()



#making a scatterplot plot of year built vs $/Sqft

OneBedMTData1 <- filter(MTData1, Bedrooms == 1)
png("YearvscostSQFT.png",width = 600, height = 500)
plot(OneBedMTData1$Year.built, 
     OneBedMTData1$X..Sqft, 
     ylim = c(1,4.5), 
     main = "Year built vs $/SQFT for 1 bedroom apartments",
     xlab = "Year Built",
     ylab = "$ per SQFT",
     col = "black", 
     pch = 21,
     bg="blue")
abline(lm(formula = OneBedMTData1$X..Sqft ~ OneBedMTData1$Year.built), col = "green", lwd = 2)
text(x=1970, y = 3, labels = (".01x - 17.12 = y"), cex = 1, adj = 0, srt = 17.12)
dev.off()



