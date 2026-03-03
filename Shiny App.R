library(shiny)

# ============================================================
# h(x; λ, k, n) function
# ============================================================
h <- function(x, lambda, k, n) {
  Gamma_k         <- gamma(k)
  lower_inc_gamma <- pgamma(lambda * x, shape = k, lower.tail = TRUE) * Gamma_k
  numerator       <- n * (lower_inc_gamma^(n - 1)) * (lambda^k) * (x^(k - 1)) * exp(-lambda * x)
  denominator     <- Gamma_k^n
  numerator / denominator
}

COLORS <- c("steelblue", "firebrick", "darkgreen", "darkorchid", "darkorange", "black", "deeppink", "darkturquoise")

# ============================================================
# UI
# ============================================================
ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }

      /* ── Equation banner ── */
      .eq-box {
        background: linear-gradient(135deg, #2c3e50, #3498db);
        color: white;
        padding: 18px 30px;
        border-radius: 10px;
        margin-bottom: 20px;
        text-align: center;
      }
      .eq-box h2 { margin: 0 0 8px; font-size: 20px; letter-spacing: 0.03em; }
      .eq-img { font-size: 17px; font-style: italic; opacity: 0.95; }

      /* ── Cards ── */
      .well {
        background: white; border: none;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 16px;
        margin-bottom: 12px;
      }
      .line-card {
        background: white; border: none;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 14px 16px;
        margin-bottom: 10px;
        border-left: 5px solid #ccc;
      }
      .line-card .card-title {
        font-weight: 700; font-size: 14px;
        margin-bottom: 8px; color: #2c3e50;
      }

      /* ── Buttons ── */
      .btn-add    { background:#27ae60; color:white; border:none; border-radius:6px; width:100%; margin-bottom:6px; }
      .btn-remove { background:#e74c3c; color:white; border:none; border-radius:6px; padding:3px 10px; font-size:12px; float:right; }
      .btn-plot   { background:#3498db; color:white; border:none; border-radius:6px; width:100%; margin-top:6px; }
      .btn-save   { background:#8e44ad; color:white; border:none; border-radius:6px; width:100%; margin-top:6px; }

      /* ── Status bar ── */
      .integral-box {
        background: #eaf4fb; border-left: 4px solid #3498db;
        padding: 10px 15px; border-radius: 5px;
        margin-top: 14px; font-size: 13px; color: #2c3e50;
      }
      .error-box {
        background: #fdecea; border-left: 4px solid #e74c3c;
        padding: 10px 15px; border-radius: 5px;
        margin-top: 14px; font-size: 13px; color: #c0392b;
      }
      .section-label {
        font-size: 12px; font-weight: 700; text-transform: uppercase;
        letter-spacing: 0.05em; color: #7f8c8d;
        margin: 12px 0 4px;
      }
      hr { margin: 10px 0; }
    "))
  ),

  # ── Equation at top ──
  div(class = "eq-box",
    h2("h(x; \u03bb, k, n) — Distribution Explorer"),
    div(class = "eq-img",
      HTML(paste0(
        "h(x) = ",
        "[ n &middot; &gamma;<sup>n&minus;1</sup>(k, &lambda;x) &middot; ",
        "&lambda;<sup>k</sup> &middot; x<sup>k&minus;1</sup> &middot; e<sup>&minus;&lambda;x</sup> ]",
        " / &Gamma;<sup>n</sup>(k)",
        "&nbsp;&nbsp;&nbsp;&nbsp; x, &lambda;, k, n &gt; 0"
      ))
    )
  ),

  fluidRow(
    # ── Left sidebar ──
    column(3,
      div(class = "well",
        p(class = "section-label", "Lines"),
        uiOutput("line_cards"),
        actionButton("add_line", "+ Add Line", class = "btn btn-add", icon = icon("plus"))
      ),
      div(class = "well",
        p(class = "section-label", "X Axis Range"),
        fluidRow(
          column(6, numericInput("xmin", "x min", value = 0.01, min = 0.001, step = 0.01)),
          column(6, numericInput("xmax", "x max", value = 5,    min = 0.1,   step = 0.5))
        ),
        numericInput("xstep", "Step size", value = 0.01, min = 0.001, max = 1, step = 0.001),
        helpText("Smaller = smoother curve.", style = "font-size:11px;color:#95a5a6;")
      ),
      actionButton("plot_btn", "Plot", class = "btn btn-plot", icon = icon("chart-line")),
      br(),
      downloadButton("save_png", "Save as PNG", class = "btn btn-save")
    ),

    # ── Main plot ──
    column(9,
      div(class = "well",
        plotOutput("h_plot", height = "500px"),
        uiOutput("status_box")
      )
    )
  )
)

# ============================================================
# Server
# ============================================================
server <- function(input, output, session) {

  # Track list of line IDs
  line_ids <- reactiveVal(1L)
  next_id  <- reactiveVal(2L)

  # Add line
  observeEvent(input$add_line, {
    current <- line_ids()
    if (length(current) >= 8) return()   # max 8 lines
    new_id <- next_id()
    line_ids(c(current, new_id))
    next_id(new_id + 1L)
  })

  # Remove line
  observe({
    lapply(line_ids(), function(id) {
      btn_id <- paste0("remove_", id)
      observeEvent(input[[btn_id]], {
        current <- line_ids()
        if (length(current) > 1) line_ids(setdiff(current, id))
      }, ignoreInit = TRUE)
    })
  })

  # Render line cards dynamically
  output$line_cards <- renderUI({
    ids <- line_ids()
    lapply(ids, function(id) {
      color <- COLORS[((id - 1) %% length(COLORS)) + 1]
      div(class = "line-card",
          style = paste0("border-left-color:", color, ";"),
        div(class = "card-title",
          paste0("Line ", id),
          if (length(ids) > 1)
            actionButton(paste0("remove_", id), "Remove",
                         class = "btn btn-remove", style = paste0("background:", color, ";"))
        ),
        fluidRow(
          column(4, numericInput(paste0("lambda_", id), HTML("&lambda;"), value = 1,   min = 0.01, step = 0.1)),
          column(4, numericInput(paste0("k_",      id), "k",             value = 2,   min = 0.1,  step = 0.5)),
          column(4, numericInput(paste0("n_",      id), "n",             value = 3,   min = 1,    step = 1))
        )
      )
    })
  })

  # Collect all line params when Plot is pressed
  plot_data <- eventReactive(input$plot_btn, {
    ids <- line_ids()
    lines <- lapply(ids, function(id) {
      list(
        id     = id,
        lambda = input[[paste0("lambda_", id)]],
        k      = input[[paste0("k_",      id)]],
        n      = input[[paste0("n_",      id)]],
        color  = COLORS[((id - 1) %% length(COLORS)) + 1]
      )
    })
    list(
      lines = lines,
      xmin  = input$xmin,
      xmax  = input$xmax,
      xstep = input$xstep
    )
  }, ignoreNULL = FALSE)

  # Validate
  valid_inputs <- reactive({
    p <- plot_data()
    if (is.null(p$xmin) || is.null(p$xmax) || is.null(p$xstep)) return("Enter all x range values.")
    if (p$xmin <= 0)      return("x min must be > 0.")
    if (p$xmax <= p$xmin) return("x max must be greater than x min.")
    if (p$xstep <= 0)     return("Step size must be > 0.")
    if ((p$xmax - p$xmin) / p$xstep > 10000) return("Too many points — increase step size.")
    for (l in p$lines) {
      if (is.null(l$lambda) || is.null(l$k) || is.null(l$n)) return("Fill in all parameter values.")
      if (l$lambda <= 0 || l$k <= 0 || l$n <= 0) return("All parameters must be > 0.")
    }
    return(NULL)
  })

  make_plot <- function(p) {
    x_vals <- seq(p$xmin, p$xmax, by = p$xstep)

    # Compute y for all lines to get y range
    all_y <- lapply(p$lines, function(l) {
      sapply(x_vals, function(x) h(x, l$lambda, l$k, l$n))
    })
    ymax <- max(unlist(all_y), na.rm = TRUE) * 1.1

    par(mar = c(5, 5, 4, 2), bg = "white")
    plot(NULL,
         xlim = c(p$xmin, p$xmax), ylim = c(0, ymax),
         xlab = "x", ylab = "h(x; lambda, k, n)",
         main = "h(x; lambda, k, n)",
         cex.main = 1.4, cex.lab = 1.2,
         panel.first = grid(col = "#eeeeee", lty = 1))

    for (i in seq_along(p$lines)) {
      l <- p$lines[[i]]
      lines(x_vals, all_y[[i]], col = l$color, lwd = 2.5)
    }

    legend("topright",
           legend = sapply(p$lines, function(l) paste0("lambda=", l$lambda, " k=", l$k, " n=", l$n)),
           col    = sapply(p$lines, function(l) l$color),
           lwd    = 2.5, bty = "n", cex = 0.9)
  }

  output$h_plot <- renderPlot({
    err <- valid_inputs()
    if (!is.null(err)) {
      par(mar = c(0,0,0,0)); plot.new()
      text(0.5, 0.5, err, col = "#e74c3c", cex = 1.3)
      return()
    }
    make_plot(plot_data())
  })

  output$status_box <- renderUI({
    err <- valid_inputs()
    if (!is.null(err)) return(div(class = "error-box", err))

    p        <- plot_data()
    n_points <- length(seq(p$xmin, p$xmax, by = p$xstep))
    n_lines  <- length(p$lines)

    div(class = "integral-box",
      HTML(sprintf("<strong>%d line(s)</strong> plotted &nbsp;|&nbsp; <strong>%d points</strong> per line &nbsp;|&nbsp; x: %g to %g (step = %g)",
                   n_lines, n_points, p$xmin, p$xmax, p$xstep))
    )
  })

  output$save_png <- downloadHandler(
    filename = function() "h_function_plot.png",
    content  = function(file) {
      p <- plot_data()
      png(file, width = 3000, height = 2000, res = 300)
      make_plot(p)
      dev.off()
    }
  )
}

shinyApp(ui, server)