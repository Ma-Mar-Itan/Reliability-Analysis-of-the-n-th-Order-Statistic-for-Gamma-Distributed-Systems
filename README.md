# Reliability Analysis of the n<sup>th</sup> Order Statistic for Gamma-Distributed Systems

<div align="center">

![R](https://img.shields.io/badge/R-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-blue?style=for-the-badge&logo=rstudio&logoColor=white)
![Shinylive](https://img.shields.io/badge/Shinylive-WebAssembly-purple?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**An interactive browser-based tool for visualizing and evaluating the PDF, Reliability, and Hazard functions of the n<sup>th</sup> order statistic derived from a Gamma distribution.**

[**🚀 Launch App**](https://shinylive.io/r/app/#h=0&code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IIgMQACALwzZc+QsVLlK+eIkAxAK4QCpWiU7rVJ02ZUjuAfQBmOghIA8AWgl3d+kuwAeuCdVh6ABMoPwBrPwgBCRARCQkAcVgYKCsw+IzMlwkAc2SodjDhCHjqIgB3OEYrPgIrPJgUp1dUBpT2AJhgqAkAKglfCR40OGkJCP8KqoxSKFpqMYAVLABVAFFo-qTG1LC4iQgteGZSIkZMjOyS-o6p6tr6-IA9dhLXAEYBTYkOwJCnop9H7eF7pD5fIFwbyodjOTrdIHeYrxIIUIgwPhQU7nLKubYpNJPUQlA5HKpYs4SAD0ElREHRmOxIgAviIRFhbPZmm57J4IOxSH54SFwpForESfjdhdcbl8oVkZNKvddI8dtzWvLhT1+oKhtwRmMJmVlTM5gspBJlutvlK0vt3hJXLdlTVVW0oETojT2Hawl6WWyIAAtTm6bnuPQGfl67Wig7i-Z+mWXVwehX7E1VN11D0a9PaoF64aoUaW413M3zJarDZAv37Q7HCk4i5XIEu7MPD0vN4ST7fX5df6Am6kUFO-sQ-pQmFwv46iSkRV0hnQbFtvH5Ql9rMq3PPYnxWg2H5QeicdirjHrs7RRz9uDOd4AVmijDgpC0jH5ADkAIKKk25IbjS16MmcgbEgAwgA8gAMrBWAAMrcgQ7BCGAYgAAxwFAL4ABxQJhfiYWIGgACwEdhABMFEkRIZFrNhABs0EAOwvgxZEAJwEdBADM7E8dxWHQSx7EEQAIlJoliCx7z-hoawaHJawvtB2HsQAQnJGgaCx2k8bJYDFMY5gWZZqjqCsACS5lWY5TlSCIWi0BG1BuUEAAKUA5HAGEkrMOScAAJNweFBIFmTBWFnAEIwtCoKQXCMA4lqYdwpCkKgnCIFSVIEEEEAAFacBgBBlFoQQ2AEH4VeiVJQCVUDeFSdAXlSKSkNwLVtTRGDsYNVIALJYtwABSrUYGVAD8xAQDYtA5FIixwAAGs4I0jfBzj-iNVjQQAEosO2YQIuD7PEsWhXQEBhOwH4WoxYCoB+C0QHAegMdwH6nhlYBZTleUFTYJCkOVOREEQOTUHhqC0OVxAwOdl0ktdflhXdD1PWMmGcKQrBwzwcCfj9f144D2W5flVJg2QkPQ7D8OIw1MCFZwnA0bNNiwPMrBSN5ASsLztCMAA1FJiOoMLiDlDkWUAAIUdh2EANwsaravsarABkvMYtQAvIUQ34EHA4vQUQqLi95jBEHLCukMrWua9h+t80bUjwRSjtKwJWsq+rOvu0E0vC1InDlGgqNXUumOhQTRMBSdO0YWAQYyog9tEKQMRx5kzjOPQOSIDKYg2C+NjsbzasFxkRecN+vPm2XFc2B3Hd1+jFyN83UDmzRiAV9hNg0ZX3cpk6xdnKijBlxIYhBKi7xwOxk8pkXA-m2QC84XhhFQBvMpbwQO+kEPi9wFp2HvOr9fxEX5DeKQC-xGI7xQO8Y9wMfvfODALQ5Aghv3kvQdiNFqJ-0Ls4ZgYctB5XiO8GiqBvDQIkKyI8Fx+ggAkPQIg3hnCcFoAALz4KXPBs8qgzzQRIFIjAch8DLurCQqAoDL3IcwtWGDM4XHwUEVg+ce6ZHoAPMIOR7Y6CCM4YgZR54SAAG4sFhMXHIAh0HxFkWcMuSjGAqOfsuDRbhwbOANvzMuAByH2pwLF+E4FACAnAiFVBPEY+mpBnCVGWllMuAd77CIyDeZwEVvGv37KrBR3B0GYPrlSfogAAUniRII6kUqgSESX0Kk9cMBoFQME1J5wJRT1EQQcRkiIAgP8HwPCjBnASPYbQCgKV3ia1RDkPwFcq41x6NhAApB0uABEbCj1GC+PpHTK7V15uEvp6iH6UMYHPGe2V0Rl3eKgoYRA6BBEUcoou+DFlVDmQE+I+DCHDCCBUZhEgUHeH7LciQDDRHsGwrgV57yMCsWOVPNhHCIAUJog8lWGz-E-KIMQvkZcnpYloAo3+8yiBwsYLVK5EheDLwoNE7JuT8nsKqIgRA9A4Bgw-EIqeC1yC7wkBYixRjUDgtoJCiQ55OBbKAfCk5S4iCoDLs4TWqDuGJSdry-laD5nlFoEEHqvjVYCrRXAUJMrsICvmSUsppsKlQoaVAagdS4GNLIOwAgYtKpwD8E8go7wKK4BaS+G1AkCJvM+QRaI4ylzMEcWwj8ZAJA616d8lM9K+DkFqXAOFDMy70k+ligJGAIp4tqacVAMRWHsLDv85ZpwYBrJYnKzBMocnoGcPoUgcMyUpncaYz2rBLFCygCLOY5wpacBlvW2xQwXE2DcSY4hJC4BlxosqsVnLK1eOFb6rW8ytHyN0foqEhj5l3SfCE8d7wMACSMfQxhEBM2rIkKClM5ReDkCIWw1uBwKjMFQEYxFVQUXlDLuiukRiDHOFvcik0Zc4DUDoLlRGMbYkJKSdoDw0Z44XnSUk3oWTY02B3bMCDRSUxhxbbLNwcNh1TzyDy-dm6WDbuLdytZFEVUBPzRcDAcHi3nnLTKX56aKF3w2ZA0jU9K1mKNpYk2ZtRhW1RBIO2RB20wBIOCs9HK2M9tIf2+5rGK0mLHT4iQbsjFw2ytQltA9OH7s+SxOAMAjEEG-Ky+RQayBVCMQcueayNmsu2bsvR+yqGMADTKKz1D8ErOzRe6NqrnOwIaQgsuBENkhbudhXDqqxESI1ZU2dfdkUDzgDRVzFxp06L2QA9lQRUsxQ9RC6MZcdULGwhgd4BFOBGIQRp79X0wlRokymLdfBYGKokCRzDFxyOZEo-B88iBuDvpTWqmLUiMuOaIf3c26iJDpYcyo7eTSZvdYyL16j9AclRjhbRvh0Xylxcy03RL03DNbO0fN0+59csZHc7Uub8WZ6HJc5Z-znms0Dts1syVF3JvHbgNd+IzWd1vb3c+OTMoSHOD4KibwayAMBLiZBiQawACOWgYUkFmywHZGToPZLgCjmR2OdsiL27F8bKijst3+y9p7Nm7l2e+w927AOFlLLhjYMJAlPv2Ye4tsgrPbsBfgYgh7+qEGs-o9p8rzGwt4YYUwm5Q6lcgqMSh1tNb0NQjcRh5wYd3pMtkUcCARjsNrNuS984BpLkPv3f2DZHXHk5Gee8t5TrsIUWuyt+IGACdE8WYR5NSGZTq7Q7VbX8ydXLR3Yy-TiDz4WfmWblXnXMje4kL7wnBBse7pgCTjIof61l3D6ni4Uecgx-IDAePTTE+cuT3RcHFwpcZqTWsodtOllt-twzr7OzmfOa9-jwnAQiULGDxcdj1auOmzSrx62oxBPCdE5p823ayBEOk2s9ZpfMj3cy-zhdnLX2kHyyS7zWh0BVGz5wRrMo1MhtPVp-5zCyv6aMUe2PT-z30nKFe9fHiimYSKm9c6emepiZwgCAQ+e8QlavaMmLSTee+Z2M6mWBirOJecOCKSK96zgsOzKQCRAMaBafuVGJaZaE+mQU+hsmuViFI7a9ijiziiUXa8ycBW+-YHWABniCq46Icp2ciFOT886rOn+J6q+Mmv--+oBw+piO6TcOwbAMBxiG+HGtB1iQmdiDiTit+LB3B8B5uSBGQo6vBSmQcAh52D2gCwCrOS6+SbWa6L4OuUIWBZGshC0YcfIyh1B5i1K3Gc+EgfGi+9sy+9IEh+hHB7wO+FhqBE21hcAOWH+x6T4Ehkal6aAlmZOY2P2VOSWKWne+KPemyvOmWLOBRtS4uiCuau+GQLeFCjuTGNRMSCOQGEg2k1sgiuOMGBaOK-CgilBBe4cReWuNR8QdRA6HeSeaAXC8yQSK6Sm2e1A6Ed82EkSk4g6Q6Q+WCmQiOGSyEkqcAoi5wXR2SxCqIRxyhEqUq3AA6PEkxnKQSVx0qNydxRhgO+GLWQqSmg6bxEg76uBmuUAhBeGhC8xYSixyxES3Ak4LSmxdKaa5CrW46XBMhLREgyEWg9Apaow8U9sP6FxeOsaZxhxLABKPB9AYQjKRCCUWy1AFxuCTxNx7WeapxBxRxZJlQFJVJuJtJRxxazApSw2WRmq7q2hXqTS3CYBxJ7JiA5JlJHiPJ+JLAxa3ARw9AQppSo2IpA+T2M2QulRZcXBPCRJbJpJspnJ8p1JeJdJypPUapA2Q2uCI2+2QhWWNhkpvCPW0pypt+UYmOAxpywpB2E2uRJ2fmdORRjO-epRg+5RwutAQWP2lRkuCJL--49W0rjLlSYgPE2eAkUAp45zJT869VWefWNMABucoOGk1yzLWPLLCYB9bZyDLWpwZlOnVRFYbIL0Zg9-VobSyVFYuQ1KZJ9NyazbmBCBZ7CYDJZju5ZruVZnudKDKTK0K+gcKj5FweNyEJNZNfxSKws2jBa9bLabNBL8y9K2TEARWF4bK5AL6IjLCHOYSLCXx0H3C6FB6bmObJLL4dqpzaHqHTqBEb44jqGwxUF0jl1se1e8FCjm121J4e1FKTSpHt1cZG7mWyZRikO0OLh4S3BrZLDq9nZ7DvZYmXDoNEdXF41vDaVgbR+WGyFL1Kbq2P7pN1ClyecYdPLcu8qbWQrKYbV2RfO4nC767cTEgYyybnKDi-FGOQHlC9gowa6T9ZDi0fAseEgeEt+UOO60t1TGecn7NiniAZA3AMivAND7r4ozK9D3U0Yeu36wxJzlWFzsnL7CnucvnPUAX8wUUVLuCpn4XJAkXaGpWFEsX6eisYQcAIszA8AdV+CVnyhbq1E-SvLKaWTmd8UOqAUpWLEM23KWmhMr+FETtU8KsvSU8mQuCTXATLXcM7Aa62EnXhdPX-Wyn3RKjRtki0RAqa1bdVtbBafAYMDbDiodzrur+F873VkZvVOpc8enlFBnm7Iu27DGExzGe7fCB7oDtuxZDuGyZ7lZ7ul7MnPu+3AV5Bow+jS9vhFi-hf1bD3ZHD-Ha+gnm+wnHecdYlymsNU8J--jjAF+QTud3C+delhdBlZWNEJd3zM9zLS2QjZ5w7x5DGgrSNT29PS7fVD5QPGeIPeq32uCEFkj2uIxniV6Zcf+GRg7PDcXwPG3sjeedzLrTLIZnV+Rfdl3A9Ki5Fa7d3IuqTmFKTsmE1GZsxo7mVTJ5W9xU8KQhCPLAkPxR5mB-YHnGAPPxH84Y+n1HinH0Pv18+AN8PfH4RyPDjaP-rRctle5Ar6FGZ-gLjJPbjr+rElPy3e3svbvSink4PyP3vMPfvwRG9gfINI6SLL3tCI546Kms2vTE26BzvrvVezgGfWgcAGAGf328QuC6NuE+ERES3PW9f+mjfOqzfLvEAbf2rVf1lvzrE-zffq2A-MAh35XP92fhjuf-1+foRiPd+iLYNkRof1fKiEf-LXtgehpRhYBPPinq1eHmu5D1SxcZQpS3CKnOV1j1Fo9VFRnJ-BGsH8T3CSKfQIsTqYXULOGIZeHDAfY7FWiyEWYF+Eq4sBP2FGAmFiAQTFxEBYdMasrkQK0JYmuvD-sX0h7MMferDHjgHy3pI9CBQnBAhbk9oEZu80nbGrWTgFoCiA6QDIDqxnZQo3WrTWBu03dwup4OwLXvPZgOYTNjmGAfIpP0sI08Bcc-H3CgPgHOAqg9sQpNm0V6VJI2ZLF5tC2dR6lhBt5HZFoLvjktXmhbGbOjT+aeD) &nbsp;|&nbsp; [📂 View Source](#)

</div>

---

## 📖 Overview

This application provides an **interactive environment** for analyzing the reliability properties of a system whose lifetime follows the **n<sup>th</sup> order statistic** of a Gamma distribution. It is designed for students, researchers, and engineers working in reliability theory, survival analysis, or mathematical statistics.

Given $n$ independent, identically distributed components, each with a Gamma-distributed lifetime $X_i \sim \text{Gamma}(\lambda, k)$, this app explores the statistical behavior of the **maximum order statistic** $X_{(n)}$ — the time at which the *last* component in a parallel system fails.

The app runs **entirely in the browser** via [Shinylive](https://shinylive.io) (WebAssembly) — no R installation or server required.

---

## 🧮 Mathematical Background

### Parameters

| Symbol | Name | Constraint |
|--------|------|-----------|
| $\lambda$ | Rate parameter of the Gamma distribution | $\lambda > 0$ |
| $k$ | Shape parameter of the Gamma distribution | $k > 0$ |
| $n$ | Number of components (order statistic index) | $n \in \mathbb{Z}^+$ |

Where $\gamma(k, \lambda t)$ denotes the **lower incomplete gamma function** and $\Gamma(k)$ the complete gamma function.

---

### Three Functions

#### `h(t)` — Probability Density Function

$$h(t;\, \lambda, k, n) = \frac{n \cdot \gamma^{\,n-1}(k,\, \lambda t) \cdot \lambda^{k} \cdot t^{k-1} \cdot e^{-\lambda t}}{\Gamma^{n}(k)}$$

Represents the **relative likelihood** that the entire $n$-component parallel system fails exactly at time $t$. This is the density of the maximum order statistic.

---

#### `R(t)` — Reliability Function (Survival Function)

$$R(t) = 1 - \frac{\gamma^{n}(k,\, \lambda t)}{\Gamma^{n}(k)}$$

Gives the **probability that the system is still functioning** at time $t$ — i.e., the probability that at least one component survives beyond $t$ in a parallel redundancy configuration.

---

#### `Z(t)` — Hazard Function (Failure Rate)

$$Z(t) = \frac{h(t)}{R(t)} = \frac{n \cdot \gamma^{\,n-1}(k,\, \lambda t) \cdot \lambda^{k} \cdot t^{k-1} \cdot e^{-\lambda t}}{\Gamma^{n}(k) - \gamma^{n}(k,\, \lambda t)}$$

Measures the **instantaneous rate of failure** at time $t$, given the system has survived up to that moment. A fundamental quantity in reliability engineering and survival analysis.

---

## ✨ Features

- **Three function tabs** — switch between h(t), R(t), and Z(t) instantly
- **Multi-curve overlay** — add up to 8 curves with independent parameter sets for direct comparison
- **Auto-update mode** — toggle live re-rendering as you adjust parameters
- **Point evaluation** — evaluate any function at a specific time $t$ for each curve
- **Integral validation** — automatically checks that h(t) integrates to 1 (valid density check)
- **Export PNG** — download high-resolution (300 DPI) plots, fully compatible with Shinylive
- **Inline warnings** — real-time validation feedback on axis range inputs
- **HTML legend** — curve legend rendered outside the plot area, eliminating overlap
- **Scrollable sidebar** — clean layout even with many curves added

---

## 🚀 Running the App

### Option 1 — Browser (No Installation)

Click the **Launch App** badge at the top of this page. The app runs entirely client-side via WebAssembly.

### Option 2 — Local R

```r
# Install dependencies if needed
install.packages(c("shiny", "base64enc"))

# Run the app
shiny::runApp("app.R")
```

### Option 3 — Export with Shinylive

```r
install.packages("shinylive")
shinylive::export(appdir = ".", destdir = "site")
# Then serve the site/ folder on any static host (GitHub Pages, Netlify, etc.)
```

---

## 🗂 Repository Structure

```
├── app.R          # Full Shiny application (single-file)
└── README.md      # This file
```

---

## 📐 Technical Notes

- The **lower incomplete gamma function** is computed via R's `pgamma()` with the relation $\gamma(k, x) = P(k, x) \cdot \Gamma(k)$, ensuring numerical stability across a wide parameter range.
- **Integer enforcement** on $n$: the app automatically rounds any decimal input for $n$ to the nearest integer, since the order statistic index must be a positive integer.
- The **hazard function** $Z(t)$ returns `NA` when the denominator $\Gamma^n(k) - \gamma^n(k, \lambda t)$ is numerically zero (i.e., $R(t) \approx 0$), avoiding division-by-zero errors.
- PNG export uses **base64 encoding** for full Shinylive compatibility, bypassing the `downloadHandler` server dependency.

---

## 📚 Background Reading

- Casella, G. & Berger, R.L. (2002). *Statistical Inference*, 2nd ed. Duxbury.
- Lawless, J.F. (2003). *Statistical Models and Methods for Lifetime Data*, 2nd ed. Wiley.
- Kalbfleisch, J.D. & Prentice, R.L. (2002). *The Statistical Analysis of Failure Time Data*, 2nd ed. Wiley.

---

## 🛠 Built With

- [**R**](https://www.r-project.org/) — statistical computing
- [**Shiny**](https://shiny.posit.co/) — reactive web framework
- [**Shinylive**](https://posit-dev.github.io/r-shinylive/) — WebAssembly deployment
- [**MathJax**](https://www.mathjax.org/) — LaTeX equation rendering
- [**Google Fonts**](https://fonts.google.com/) — Playfair Display, Source Code Pro, Lato

---

<div align="center">
  <sub>Built with R & Shiny · Deployed via Shinylive WebAssembly</sub>
</div>
