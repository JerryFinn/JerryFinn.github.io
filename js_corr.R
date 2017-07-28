
setwd("D:/JerryUIUC/CS498Viz/project/DataSets")
js_county <- read.csv("js_county.csv")
js_county$DisabledRate <- js_county$DisabledWorkers / js_county$TotalLabor
#cor(js_county$UnemploymentRate, js_county$DisabledRate)
#fit <- lm(DisabledRate ~ UnemploymentRate, data = js_county)
#summary(fit)
#
#unique(js_county$StateCode)
#unique(js_county$Year)

d <- data.frame()
for(i in unique(js_county$StateCode)) {
  #print( i )
  x = js_county$UnemploymentRate[js_county$StateCode == i] 
  y = js_county$DisabledRate[js_county$StateCode == i]
  fit = lm(y ~ x)
  slope = coef(fit)[2]
  correlation = cor(x, y)
  pvalue = summary(fit)$coefficients[2,4]
  d <- rbind(d,c(9999, i, round(pvalue, digits = 3), round(slope, digits = 3), round(correlation, digits = 3)))
  for(j in unique(js_county$Year)) {
    x = js_county$UnemploymentRate[js_county$StateCode == i & js_county$Year == j]
    y = js_county$DisabledRate[js_county$StateCode == i & js_county$Year == j]
    fit = lm(y ~ x)
    slope = coef(fit)[2]
    correlation = cor(x, y)
    pvalue = summary(fit)$coefficients[2,4]
    d <- rbind(d,c(j, i, round(pvalue, digits = 3), round(slope, digits = 3), round(correlation, digits = 3)))
    #print( j )
  }
}
colnames(d) <- c("Year", "id", "Pvalue", "slope", "correlation")
write.csv(d, file = "js_correlation.csv",row.names=FALSE)
