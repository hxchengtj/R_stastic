## Here are examples for p-values

library(UsingR)
data("galton")

plot(galton$parent, galton$child, col = "blue", pch = 19)
lm1 <- lm(galton$child ~ galton$parent)
abline(lm1, lwd = 3, col = "red")

summary(lm1)

# Call:
#   lm(formula = galton$child ~ galton$parent)
#
# Residuals:
#   Min      1Q  Median      3Q     Max
# -7.8050 -1.3661  0.0487  1.6339  5.9264
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept)   23.94153    2.81088   8.517   <2e-16 ***
#   galton$parent  0.64629    0.04114  15.711   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 2.239 on 926 degrees of freedom
# Multiple R-squared:  0.2105,	Adjusted R-squared:  0.2096
# F-statistic: 246.8 on 1 and 926 DF,  p-value: < 2.2e-16

x <- seq(-20, 20, length.out = 100)
plot(x, dt(x, df = (100 - 2)), col = "blue", type = "l", lwd = 3)
arrows(summary(lm1)$coeff[2,3], 0.25, summary(lm1)$coeff[2, 3], 0, col ="red", lwd = 3)

