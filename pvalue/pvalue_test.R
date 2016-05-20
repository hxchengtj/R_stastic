## Here are examples for p-values

library(UsingR)
data("galton")

plot(galton$parent, galton$child, col = "blue", pch = 19)
lm1 <- lm(galton$child ~ galton$parent)
abline(lm1, lwd = 3, col = "red")


