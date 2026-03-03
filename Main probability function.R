# h(x; λ, k, n) = [n * γ^(n-1)(k, λx) * λ^k * x^(k-1) * e^(-λx)] / Γ^n(k)
# where x, λ, k, n > 0
# γ(k, λx) is the lower incomplete gamma function
# Γ(k)     is the complete gamma function

h <- function(x, lambda, k, n) {
  # Input validation
  if (any(c(x, lambda, k, n) <= 0)) stop("All parameters and x must be > 0")

  # Complete gamma function: Γ(k)
  Gamma_k <- gamma(k)

  # Lower incomplete gamma function: γ(k, λx)
  # pgamma gives the regularized version P(k, λx) = γ(k, λx) / Γ(k)
  # So: γ(k, λx) = pgamma(lambda * x, shape = k, lower = TRUE) * Γ(k)
  lower_inc_gamma <- pgamma(lambda * x, shape = k, lower.tail = TRUE) * Gamma_k

  # Compute h(x; λ, k, n)
  numerator   <- n * (lower_inc_gamma^(n - 1)) * (lambda^k) * (x^(k - 1)) * exp(-lambda * x)
  denominator <- Gamma_k^n

  return(numerator / denominator)
}



# Plot h(x) for a range of x values

#Range and Steps for X
x_vals <- seq(0.01, 5, length.out = 500)

# Parameter sets
params <- list(
  list(lambda = 1, k = 2, n = 1, label = "λ=1, k=2, n=1"),
  list(lambda = 1, k = 2, n = 3, label = "λ=1, k=2, n=3"),
  list(lambda = 2, k = 3, n = 2, label = "λ=2, k=3, n=2"),
  list(lambda = 0.5, k = 1, n = 4, label = "λ=0.5, k=1, n=4")
)

colors <- c("steelblue", "firebrick", "darkgreen", "darkorchid")


# Save plot as PNG

png("h_function_plot.png", width = 3000, height = 2000, res = 300)

plot(NULL, xlim = c(0, 5), ylim = c(0, 1.2),
     xlab = "x", ylab = "h(x; λ, k, n)",
     main = expression(h(x*";"~lambda*","~k*","~n) ==
       frac(n~gamma^{n-1}*(k*","~lambda*x)~lambda^k~x^{k-1}~e^{-lambda*x},
            Gamma^n*(k))))

for (i in seq_along(params)) {
  p <- params[[i]]
  y_vals <- sapply(x_vals, function(x) h(x, p$lambda, p$k, p$n))
  lines(x_vals, y_vals, col = colors[i], lwd = 2)
}

legend("topright", legend = sapply(params, `[[`, "label"),
       col = colors, lwd = 2, bty = "n")

dev.off()



# Verify it integrates to 1 for one case
integral <- integrate(function(x) h(x, lambda = 1, k = 2, n = 3),
                      lower = 0, upper = Inf)
cat("Integral check (should be ~1):", integral$value, "\n")
