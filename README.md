# 📊 h(x; λ, k, n) — Distribution Explorer

An interactive R Shiny web application for visualizing the PDF of the **nth Order Statistic of a Gamma Distribution**.

🔗 **Live App:** [https://malekitani.shinyapps.io/gamma_fun_app/](https://malekitani.shinyapps.io/gamma_fun_app/)

---

## 📐 The Equation

The app models the following probability density function:

$$h(x;\, \lambda, k, n) = \frac{n \cdot \gamma^{n-1}(k,\, \lambda x) \cdot \lambda^k \cdot x^{k-1} \cdot e^{-\lambda x}}{\Gamma^n(k)}, \quad x, \lambda, k, n > 0$$

Where:
- $\gamma(k, \lambda x)$ — lower incomplete gamma function
- $\Gamma(k)$ — complete gamma function
- $\lambda$ — rate parameter
- $k$ — shape parameter
- $n$ — order statistic index

---

## ✨ Features

- **Multiple curves** — add and remove lines dynamically, each with its own λ, k, n values
- **Color-coded lines** — each curve gets a distinct color with a matching legend
- **Customizable x-axis** — set x min, x max, and step size (resolution)
- **Save as PNG** — export the plot as a high-quality 300 DPI image
- **Integral check** — displays ∫h(x)dx to verify the function is a valid density
- **Fully online** — no installation required, accessible via browser

---

## 🚀 Running Locally

**Requirements:** R (≥ 4.0) and the `shiny` package.

```r
install.packages("shiny")
shiny::runApp("Gamma_Fun_app.R")
```

---

## 🌐 Deploying to shinyapps.io

```r
install.packages("rsconnect")
library(rsconnect)

rsconnect::setAccountInfo(name = "YOUR_NAME", token = "YOUR_TOKEN", secret = "YOUR_SECRET")
rsconnect::deployApp(appPrimaryDoc = "Gamma_Fun_app.R")
```

Credentials are available under **Account → Tokens** on [shinyapps.io](https://www.shinyapps.io).

---

## 📁 File Structure

```
.
└── Gamma_Fun_app.R   # Full Shiny app (UI + Server)
```

---

## 👩‍🔬 Acknowledgements

Developed in collaboration with **Dr. Noura**.
