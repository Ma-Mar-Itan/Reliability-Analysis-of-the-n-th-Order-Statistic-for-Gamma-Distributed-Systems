library(shiny)

# ============================================================
# Functions
# ============================================================
h_func <- function(x, lambda, k, n) {
  Gamma_k         <- gamma(k)
  lower_inc_gamma <- pgamma(lambda * x, shape = k, lower.tail = TRUE) * Gamma_k
  numerator       <- n * (lower_inc_gamma^(n - 1)) * (lambda^k) * (x^(k - 1)) * exp(-lambda * x)
  denominator     <- Gamma_k^n
  numerator / denominator
}

R_func <- function(t, lambda, k, n) {
  Gamma_k         <- gamma(k)
  lower_inc_gamma <- pgamma(lambda * t, shape = k, lower.tail = TRUE) * Gamma_k
  1 - (lower_inc_gamma^n) / (Gamma_k^n)
}

Z_func <- function(t, lambda, k, n) {
  Gamma_k         <- gamma(k)
  lower_inc_gamma <- pgamma(lambda * t, shape = k, lower.tail = TRUE) * Gamma_k
  numerator       <- n * (lower_inc_gamma^(n - 1)) * (lambda^k) * (t^(k - 1)) * exp(-lambda * t)
  denominator     <- Gamma_k^n - lower_inc_gamma^n
  if (abs(denominator) < 1e-15) return(NA)
  numerator / denominator
}

COLORS <- c("#0ea58a", "#F48024", "#E06C75", "#98C379", "#C678DD", "#61AFEF", "#E5C07B", "#FF6B9D")

# ============================================================
# UI
# ============================================================
ui <- fluidPage(
  tags$head(
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"),
    tags$link(rel = "preconnect", href = "https://fonts.googleapis.com"),
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Source+Code+Pro:wght@400;600&family=Lato:wght@300;400;700&display=swap"),
    tags$style(HTML("

      :root {
        --bg:      #f5f7fa;
        --surface: #ffffff;
        --surface2:#f0f2f5;
        --border:  #dde1e7;
        --accent:  #0ea58a;
        --accent2: #e07010;
        --text:    #1a1f2e;
        --muted:   #6b7280;
        --radius:  12px;
      }

      * { box-sizing: border-box; margin: 0; padding: 0; }

      body {
        background-color: var(--bg);
        color: var(--text);
        font-family: 'Lato', sans-serif;
        font-weight: 300;
        min-height: 100vh;
      }

      /* ── Header ── */
      .app-header {
        background: linear-gradient(160deg, #f5f7fa 0%, #e8f0fe 50%, #f5f7fa 100%);
        border-bottom: 1px solid var(--border);
        box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        padding: 22px 40px 0;
        position: relative;
        overflow: hidden;
      }
      .app-header::before {
        content: '';
        position: absolute;
        top: -60px; right: -60px;
        width: 300px; height: 300px;
        background: radial-gradient(circle, rgba(14,165,138,0.08) 0%, transparent 70%);
        pointer-events: none;
      }
      .header-top { padding-bottom: 16px; }
      .app-title {
        font-family: 'Playfair Display', serif;
        font-size: 20px;
        font-weight: 700;
        color: var(--text);
        line-height: 1.3;
        margin-bottom: 0;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      /* ── Function tabs ── */
      .fn-tabs {
        display: flex;
        gap: 0;
        margin-top: 14px;
      }
      .fn-tab {
        padding: 10px 28px;
        font-family: 'Source Code Pro', monospace;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.06em;
        cursor: pointer;
        border: 1px solid var(--border);
        border-bottom: none;
        border-radius: 8px 8px 0 0;
        background: var(--surface2);
        color: var(--muted);
        transition: all 0.18s;
        user-select: none;
        margin-right: 4px;
      }
      .fn-tab:hover { background: var(--surface); color: var(--accent); }
      .fn-tab.active {
        background: var(--surface);
        color: var(--accent);
        border-color: var(--border);
        border-bottom: 2px solid var(--surface);
        margin-bottom: -1px;
        z-index: 1;
      }

      /* ── Equation card ── */
      .eq-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-left: 3px solid var(--accent);
        border-radius: var(--radius);
        padding: 18px 28px;
        margin: 20px 20px 0;
        display: flex;
        flex-direction: column;
        gap: 12px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.04);
      }
      .eq-card-top {
        display: flex;
        align-items: center;
        gap: 20px;
      }
      .eq-card-bottom {
        display: flex;
        align-items: center;
        gap: 24px;
        padding-top: 10px;
        border-top: 1px solid var(--border);
      }
      .eq-label {
        font-family: 'Source Code Pro', monospace;
        font-size: 11px;
        color: var(--accent);
        text-transform: uppercase;
        letter-spacing: 0.1em;
        white-space: nowrap;
        font-weight: 600;
      }
      .eq-formula {
        font-size: 16px;
        color: var(--text);
        flex: 1;
        overflow-x: auto;
      }
      .eq-fn-title {
        font-family: 'Lato', sans-serif;
        font-size: 14px;
        font-weight: 700;
        color: var(--text);
        white-space: nowrap;
      }
      .eq-fn-summary {
        font-family: 'Lato', sans-serif;
        font-size: 12px;
        font-weight: 400;
        color: var(--muted);
        line-height: 1.5;
        flex: 1;
      }
      .eq-condition {
        font-family: 'Source Code Pro', monospace;
        font-size: 11px;
        color: var(--muted);
        white-space: nowrap;
        background: var(--surface2);
        border: 1px solid var(--border);
        border-radius: 6px;
        padding: 4px 10px;
      }

      /* ── Body ── */
      .app-body {
        display: flex;
        padding: 20px;
        gap: 0;
        min-height: calc(100vh - 200px);
      }

      /* ── Sidebar ── */
      .sidebar {
        width: 290px;
        min-width: 290px;
        margin-right: 20px;
        overflow-y: auto;
        max-height: calc(100vh - 160px);
        padding-right: 4px;
      }
      /* Subtle scrollbar */
      .sidebar::-webkit-scrollbar { width: 4px; }
      .sidebar::-webkit-scrollbar-track { background: transparent; }
      .sidebar::-webkit-scrollbar-thumb { background: var(--border); border-radius: 4px; }
      .sidebar::-webkit-scrollbar-thumb:hover { background: var(--muted); }

      .sidebar-section {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 16px;
        margin-bottom: 12px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.04);
      }
      .section-title {
        font-family: 'Source Code Pro', monospace;
        font-size: 10px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.12em;
        color: var(--accent);
        margin-bottom: 12px;
        padding-bottom: 8px;
        border-bottom: 1px solid var(--border);
      }

      /* ── Auto-update toggle ── */
      .auto-update-row {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
        padding: 8px 10px;
        background: var(--surface2);
        border: 1px solid var(--border);
        border-radius: 8px;
      }
      .auto-update-row label {
        font-size: 11px !important;
        font-weight: 600 !important;
        text-transform: uppercase !important;
        letter-spacing: 0.08em !important;
        color: var(--muted) !important;
        margin: 0 !important;
        cursor: pointer;
      }
      .auto-update-row input[type=checkbox] {
        accent-color: var(--accent);
        width: 14px; height: 14px;
        cursor: pointer;
      }

      /* ── Line cards ── */
      .line-card {
        background: var(--surface2);
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 12px 14px;
        margin-bottom: 10px;
      }
      .line-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
      }
      .line-tag {
        font-family: 'Source Code Pro', monospace;
        font-size: 11px;
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 4px;
        color: #ffffff;
      }

      /* ── Remove spinners ── */
      input[type=number]::-webkit-inner-spin-button,
      input[type=number]::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
      input[type=number] { -moz-appearance: textfield; }

      .form-group { margin-bottom: 10px !important; }
      label {
        font-size: 11px !important; font-weight: 600 !important;
        text-transform: uppercase; letter-spacing: 0.08em;
        color: var(--muted) !important; margin-bottom: 4px !important;
      }
      .form-control {
        background: var(--bg) !important;
        border: 1px solid var(--border) !important;
        border-radius: 6px !important;
        color: var(--text) !important;
        font-family: 'Source Code Pro', monospace !important;
        font-size: 13px !important;
        padding: 6px 10px !important;
        transition: border-color 0.2s;
      }
      .form-control:focus {
        border-color: var(--accent) !important;
        box-shadow: 0 0 0 2px rgba(14,165,138,0.15) !important;
        outline: none !important;
      }
      /* Validation warning inline */
      .field-warning {
        font-family: 'Source Code Pro', monospace;
        font-size: 10px;
        color: #E06C75;
        margin-top: 3px;
        display: flex;
        align-items: center;
        gap: 4px;
      }

      /* ── Buttons ── */
      .btn {
        font-family: 'Lato', sans-serif !important;
        font-weight: 700 !important; font-size: 12px !important;
        letter-spacing: 0.06em !important; text-transform: uppercase !important;
        border: none !important; border-radius: 6px !important;
        padding: 8px 14px !important; transition: all 0.2s !important;
        cursor: pointer !important;
      }
      .btn-add {
        background: rgba(14,165,138,0.15) !important;
        color: var(--accent) !important;
        border: 1px solid rgba(14,165,138,0.3) !important;
        width: 100%; margin-top: 4px;
      }
      .btn-add:hover { background: rgba(14,165,138,0.25) !important; }
      .btn-remove {
        background: rgba(224,108,117,0.15) !important;
        color: #E06C75 !important;
        border: 1px solid rgba(224,108,117,0.3) !important;
        font-size: 10px !important; padding: 3px 8px !important;
      }
      .btn-remove:hover { background: rgba(224,108,117,0.3) !important; }
      .btn-plot {
        background: var(--accent) !important;
        color: #ffffff !important;
        width: 100%; margin-bottom: 8px;
      }
      .btn-plot:hover { background: #0c9478 !important; }
      .btn-plot:disabled { background: #9ca3af !important; cursor: not-allowed !important; }
      .btn-save {
        background: rgba(224,112,16,0.12) !important;
        color: var(--accent2) !important;
        border: 1px solid rgba(224,112,16,0.3) !important;
        width: 100%;
      }
      .btn-save:hover { background: rgba(224,112,16,0.22) !important; }

      /* ── Plot panel ── */
      .plot-panel { flex: 1; display: flex; flex-direction: column; gap: 14px; min-width: 0; }
      .plot-box {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 24px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        position: relative;
      }

      /* ── Spinner overlay ── */
      .plot-spinner {
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(255,255,255,0.85);
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: var(--radius);
        z-index: 10;
        font-family: 'Source Code Pro', monospace;
        font-size: 12px;
        color: var(--accent);
        gap: 10px;
      }
      .spinner-dot {
        width: 8px; height: 8px;
        background: var(--accent);
        border-radius: 50%;
        animation: bounce 1.2s infinite ease-in-out;
      }
      .spinner-dot:nth-child(2) { animation-delay: 0.2s; }
      .spinner-dot:nth-child(3) { animation-delay: 0.4s; }
      @keyframes bounce {
        0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
        40%            { transform: scale(1.0); opacity: 1.0; }
      }

      /* ── Info panels ── */
      .info-panel {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 20px 24px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.04);
      }
      .info-title {
        font-family: 'Source Code Pro', monospace;
        font-size: 10px; font-weight: 600;
        text-transform: uppercase; letter-spacing: 0.12em;
        color: var(--accent);
        margin-bottom: 14px; padding-bottom: 8px;
        border-bottom: 1px solid var(--border);
      }
      .info-grid { display: flex; flex-wrap: wrap; gap: 10px; }
      .info-item {
        background: var(--surface2);
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 12px 16px;
        min-width: 180px;
        max-width: 320px;
        flex: 1;
      }
      .info-item-label {
        font-family: 'Source Code Pro', monospace;
        font-size: 10px; color: var(--muted);
        margin-bottom: 6px; letter-spacing: 0.06em;
      }
      .info-item-value {
        font-family: 'Source Code Pro', monospace;
        font-size: 20px; font-weight: 600; color: var(--text);
      }
      .info-item-value.valid   { color: #0ea58a; }
      .info-item-value.invalid { color: #E06C75; }
      .info-item-params {
        font-family: 'Source Code Pro', monospace;
        font-size: 10px; color: var(--muted); margin-top: 4px;
      }
      .info-dot {
        display: inline-block; width: 8px; height: 8px;
        border-radius: 50%; margin-right: 6px; vertical-align: middle;
      }

      /* ── Status bar ── */
      .status-bar {
        padding: 10px 16px; border-radius: 8px;
        font-family: 'Source Code Pro', monospace;
        font-size: 12px; margin-top: 10px;
      }
      .status-ok    { background: rgba(14,165,138,0.08); border: 1px solid rgba(14,165,138,0.2); color: var(--accent); }
      .status-error { background: rgba(224,108,117,0.08); border: 1px solid rgba(224,108,117,0.2); color: #E06C75; }
      .status-warn  { background: rgba(244,128,36,0.08);  border: 1px solid rgba(244,128,36,0.2);  color: #F48024; }

      .help-block { color: var(--muted) !important; font-size: 10px !important; }
      #save_png { display: block; text-align: center; }

      /* ── Legend below plot ── */
      .plot-legend {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 14px;
        padding-top: 12px;
        border-top: 1px solid var(--border);
      }
      .legend-item {
        display: flex;
        align-items: center;
        gap: 7px;
        font-family: 'Source Code Pro', monospace;
        font-size: 11px;
        color: var(--text);
        background: var(--surface2);
        border: 1px solid var(--border);
        border-radius: 6px;
        padding: 4px 10px;
      }
      .legend-swatch {
        width: 22px; height: 3px;
        border-radius: 2px;
        flex-shrink: 0;
      }
    "))
  ),

  # ── Header with tabs ──
  div(class = "app-header",
    div(class = "header-top",
      div(class = "app-title",
          "Reliability Analysis of the n", tags$sup("th"),
          " Order Statistic for Gamma-Distributed Systems")
    ),
    div(class = "fn-tabs",
      div(class = "fn-tab active", id = "tab-hx", onclick = "switchTab('hx')", "h(t) — PDF"),
      div(class = "fn-tab",        id = "tab-rt", onclick = "switchTab('rt')", "R(t) — Reliability"),
      div(class = "fn-tab",        id = "tab-zt", onclick = "switchTab('zt')", "Z(t) — Hazard")
    ),
    tags$script(HTML("
      function switchTab(fn) {
        ['hx','rt','zt'].forEach(function(t) {
          document.getElementById('tab-' + t).classList.remove('active');
        });
        document.getElementById('tab-' + fn).classList.add('active');
        Shiny.setInputValue('active_fn', fn, {priority: 'event'});
      }
    "))
  ),

  uiOutput("eq_card"),

  div(class = "app-body",
    div(class = "sidebar",
      div(class = "sidebar-section",
        div(class = "section-title", "Curve Parameters"),
        div(id = "line_cards_container"),
        actionButton("add_line", "+ Add Curve", class = "btn btn-add", icon = icon("plus"))
      ),
      div(class = "sidebar-section",
        div(class = "section-title", "T Axis Range"),
        fluidRow(
          column(6, numericInput("xmin", "min", value = 0.01, min = 0.001, step = 0.01)),
          column(6, numericInput("xmax", "max", value = 5,    min = 0.1,   step = 0.5))
        ),
        numericInput("xstep", "Step size", value = 0.01, min = 0.001, max = 1, step = 0.001),
        helpText("Smaller = smoother curve"),
        uiOutput("range_warning")
      ),
      div(class = "sidebar-section",
        div(class = "section-title", uiOutput("eval_label")),
        numericInput("eval_pt", "t =", value = 1, min = 0.001, step = 0.1),
        helpText(uiOutput("eval_help"))
      ),
      # Auto-update + plot button
      div(class = "sidebar-section",
        div(class = "section-title", "Plot Controls"),
        div(class = "auto-update-row",
          tags$input(type = "checkbox", id = "auto_update_cb",
                     onchange = "Shiny.setInputValue('auto_update', this.checked, {priority:'event'})"),
          tags$label(`for` = "auto_update_cb", "Auto-update plot")
        ),
        actionButton("plot_btn", "Generate Plot", class = "btn btn-plot", icon = icon("chart-line")),
        uiOutput("png_download_ui")
      )
    ),

    div(class = "plot-panel",
      div(class = "plot-box",
        plotOutput("main_plot", height = "440px"),
        uiOutput("plot_legend"),
        uiOutput("status_bar")
      ),
      uiOutput("info_panel")
    )
  )
)

# ============================================================
# Server
# ============================================================
server <- function(input, output, session) {

  # ── Active tab ──
  active_fn <- reactive({
    if (is.null(input$active_fn)) "hx" else input$active_fn
  })

  auto_update <- reactive({
    isTRUE(input$auto_update)
  })

  # ── Equation card ──
  output$eq_card <- renderUI({
    fn <- active_fn()
    eq <- switch(fn,
      hx = list(label   = "h(t)",
                math    = "$$h(t;\\, \\lambda, k, n) = \\frac{n \\cdot \\gamma^{\\,n-1}(k,\\, \\lambda t) \\cdot \\lambda^{k} \\cdot t^{k-1} \\cdot e^{-\\lambda t}}{\\Gamma^{n}(k)}$$",
                cond    = "t, \u03bb, k, n > 0",
                title   = "Probability Density Function (PDF)",
                summary = "Represents the relative likelihood that the entire n-component system fails exactly at time t."),
      rt = list(label   = "R(t)",
                math    = "$$R(t) = 1 - \\frac{\\gamma^{n}(k,\\, \\lambda t)}{\\Gamma^{n}(k)}$$",
                cond    = "t, \u03bb, k, n > 0",
                title   = "Reliability Function (or Survival Function)",
                summary = "Calculates the probability that a parallel system of n independent components is still functioning at time t."),
      zt = list(label   = "Z(t)",
                math    = "$$Z(t) = \\frac{n \\cdot \\gamma^{\\,n-1}(k,\\, \\lambda t) \\cdot \\lambda^{k} \\cdot t^{k-1} \\cdot e^{-\\lambda t}}{\\Gamma^{n}(k) - \\gamma^{n}(k,\\, \\lambda t)}$$",
                cond    = "t, \u03bb, k, n > 0",
                title   = "Hazard Function (or Failure Rate)",
                summary = "Measures the instantaneous rate of system failure at time t, given that the system has survived up until that moment.")
    )
    div(class = "eq-card",
      div(class = "eq-card-top",
        div(class = "eq-label", eq$label),
        div(class = "eq-formula", withMathJax(helpText(eq$math)))
      ),
      div(class = "eq-card-bottom",
        div(class = "eq-fn-title", eq$title),
        div(class = "eq-fn-summary", eq$summary),
        div(class = "eq-condition", eq$cond)
      )
    )
  })

  # ── Eval label / help (single persistent input) ──
  output$eval_label <- renderUI({
    switch(active_fn(), hx = "Evaluate h(t) at point",
                        rt = "Evaluate R(t) at point",
                        zt = "Evaluate Z(t) at point")
  })
  output$eval_help <- renderUI({
    switch(active_fn(), hx = "Shows h(t) value for each curve",
                        rt = "Shows R(t) value for each curve",
                        zt = "Shows Z(t) value for each curve")
  })

  # ── Range warning ──
  output$range_warning <- renderUI({
    xmin  <- input$xmin;  xmax <- input$xmax;  xstep <- input$xstep
    if (is.null(xmin) || is.null(xmax) || is.null(xstep)) return(NULL)
    msgs <- c()
    if (!is.null(xmin)  && xmin  <= 0)      msgs <- c(msgs, "\u26a0 Min must be > 0")
    if (!is.null(xmax)  && !is.null(xmin) && xmax <= xmin) msgs <- c(msgs, "\u26a0 Max must be > Min")
    if (!is.null(xstep) && xstep <= 0)      msgs <- c(msgs, "\u26a0 Step must be > 0")
    if (!is.null(xstep) && !is.null(xmin) && !is.null(xmax) &&
        xstep > 0 && xmax > xmin &&
        (xmax - xmin) / xstep > 10000)      msgs <- c(msgs, "\u26a0 Too many points — increase step size")
    if (length(msgs) == 0) return(NULL)
    div(lapply(msgs, function(m) div(class = "field-warning", m)))
  })

  # ── Line cards (insertUI/removeUI — preserves input values) ──
  line_ids <- reactiveVal(1L)
  next_id  <- reactiveVal(2L)

  make_card_ui <- function(id, show_remove = TRUE) {
    color <- COLORS[((id - 1) %% length(COLORS)) + 1]
    div(id = paste0("card_", id), class = "line-card",
      div(class = "line-card-header",
        div(class = "line-tag", style = paste0("background:", color, ";"), paste0("Curve ", id)),
        if (show_remove)
          actionButton(paste0("remove_", id), "Remove", class = "btn btn-remove")
      ),
      fluidRow(
        column(4, numericInput(paste0("lambda_", id), "\u03bb", value = 1,   min = 0.01, step = 0.1)),
        column(4, numericInput(paste0("k_",      id), "k",      value = 2,   min = 0.1,  step = 0.5)),
        column(4, numericInput(paste0("n_",      id), "n",      value = 3,   min = 1,    step = 1))
      )
    )
  }

  # Enforce integer n on change
  observe({
    lapply(line_ids(), function(id) {
      nval <- input[[paste0("n_", id)]]
      if (!is.null(nval) && nval != round(nval)) {
        updateNumericInput(session, paste0("n_", id), value = round(nval))
      }
    })
  })

  # Insert first card on startup
  observe({
    insertUI(selector = "#line_cards_container", where = "beforeEnd",
             ui = make_card_ui(1, show_remove = FALSE), immediate = TRUE)
  }) |> bindEvent(TRUE, once = TRUE)

  # Generic remove handler factory
  wire_remove <- function(id) {
    observeEvent(input[[paste0("remove_", id)]], {
      current <- line_ids()
      if (length(current) <= 1) return()
      line_ids(setdiff(current, id))
      removeUI(selector = paste0("#card_", id), immediate = TRUE)
      # If only one left, remove its Remove button
      if (length(current) - 1 == 1) {
        remaining <- setdiff(current, id)
        removeUI(selector = paste0("#card_", remaining[1], " .btn-remove"), immediate = TRUE)
      }
    }, ignoreInit = TRUE)
  }

  # Wire remove for card 1 at startup
  wire_remove(1)

  observeEvent(input$add_line, {
    current <- line_ids()
    if (length(current) >= 8) return()
    new_id <- next_id()
    line_ids(c(current, new_id))
    next_id(new_id + 1L)

    # Add Remove button to the previously-sole card
    if (length(current) == 1) {
      insertUI(
        selector  = paste0("#card_", current[1], " .line-card-header"),
        where     = "beforeEnd",
        ui        = actionButton(paste0("remove_", current[1]), "Remove", class = "btn btn-remove"),
        immediate = TRUE
      )
    }

    insertUI(selector = "#line_cards_container", where = "beforeEnd",
             ui = make_card_ui(new_id, show_remove = TRUE), immediate = TRUE)
    wire_remove(new_id)
  })

  # ── Collect current params reactively (for auto-update) ──
  current_params <- reactive({
    ids <- line_ids()
    lines <- lapply(ids, function(id) {
      list(
        id     = id,
        lambda = input[[paste0("lambda_", id)]],
        k      = input[[paste0("k_",      id)]],
        n      = round(input[[paste0("n_", id)]]),
        color  = COLORS[((id - 1) %% length(COLORS)) + 1]
      )
    })
    list(fn = active_fn(), lines = lines,
         xmin = input$xmin, xmax = input$xmax, xstep = input$xstep,
         eval_pt = input$eval_pt)
  })

  # ── plot_data: triggered by button OR auto-update ──
  plot_data <- reactiveVal(NULL)

  # Button trigger
  observeEvent(input$plot_btn, {
    plot_data(isolate(current_params()))
  })

  # Auto-update trigger
  observe({
    p <- current_params()  # take dependency
    if (isTRUE(isolate(auto_update()))) {
      plot_data(p)
    }
  })

  # Also re-trigger when auto_update is turned ON
  observeEvent(input$auto_update, {
    if (isTRUE(input$auto_update)) {
      plot_data(isolate(current_params()))
    }
  })

  # ── Validation ──
  valid_inputs <- reactive({
    p <- plot_data()
    if (is.null(p)) return("Click 'Generate Plot' to render.")
    if (is.null(p$xmin) || is.null(p$xmax) || is.null(p$xstep)) return("Enter all range values.")
    if (p$xmin <= 0)      return("Min must be > 0.")
    if (p$xmax <= p$xmin) return("Max must be greater than min.")
    if (p$xstep <= 0)     return("Step size must be > 0.")
    if ((p$xmax - p$xmin) / p$xstep > 10000) return("Too many points — increase step size.")
    for (l in p$lines) {
      if (is.null(l$lambda) || is.null(l$k) || is.null(l$n)) return("Fill in all parameter values.")
      if (l$lambda <= 0 || l$k <= 0 || l$n < 1) return("All parameters must be > 0; n \u2265 1.")
    }
    return(NULL)
  })

  # ── Make plot (no legend inside) ──
  make_plot <- function(p) {
    v_vals <- seq(p$xmin, p$xmax, by = p$xstep)

    all_y <- lapply(p$lines, function(l) {
      sapply(v_vals, function(v) {
        tryCatch(switch(p$fn,
          hx = h_func(v, l$lambda, l$k, l$n),
          rt = R_func(v, l$lambda, l$k, l$n),
          zt = Z_func(v, l$lambda, l$k, l$n)
        ), error = function(e) NA)
      })
    })

    all_finite <- unlist(lapply(all_y, function(y) y[is.finite(y) & !is.na(y)]))

    ylim <- if (p$fn == "rt") {
      c(0, 1.05)
    } else if (length(all_finite) > 0) {
      c(0, min(quantile(all_finite, 0.99, na.rm = TRUE) * 1.15, max(all_finite) * 1.12))
    } else {
      c(0, 1)
    }

    ylab_text <- switch(p$fn, hx = "h(t)", rt = "R(t)", zt = "Z(t)")
    main_text <- switch(p$fn,
      hx = "h(t; \u03bb, k, n)  \u2014  Probability Density Function",
      rt = "R(t; \u03bb, k, n)  \u2014  Reliability Function",
      zt = "Z(t; \u03bb, k, n)  \u2014  Hazard Function"
    )

    par(mar = c(4.5, 5, 3, 2), bg = "#ffffff",
        col.axis = "#6b7280", col.lab = "#6b7280", col.main = "#1a1f2e", family = "sans")

    plot(NULL, xlim = c(p$xmin, p$xmax), ylim = ylim,
         xlab = "t", ylab = ylab_text, main = main_text,
         cex.main = 1.3, cex.lab = 1.1, cex.axis = 0.9, bty = "n",
         panel.first = {
           rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = "#ffffff", border = NA)
           abline(h = pretty(ylim),              col = "#dde1e7", lty = 1, lwd = 0.8)
           abline(v = pretty(c(p$xmin, p$xmax)), col = "#dde1e7", lty = 1, lwd = 0.8)
           if (p$fn == "rt")
             abline(h = 0.5, col = "#9ca3af", lty = 2, lwd = 1)
         })

    for (i in seq_along(p$lines)) {
      y <- all_y[[i]]; y[!is.finite(y)] <- NA
      lines(v_vals, y, col = p$lines[[i]]$color, lwd = 2.5)
    }

    eval_pt <- p$eval_pt
    if (!is.null(eval_pt) && eval_pt >= p$xmin && eval_pt <= p$xmax) {
      abline(v = eval_pt, col = "#9ca3af", lty = 3, lwd = 1.2)
    }
  }

  # ── Render plot ──
  output$main_plot <- renderPlot({
    err <- valid_inputs()
    if (!is.null(err)) {
      par(bg = "#ffffff", mar = c(0,0,0,0)); plot.new()
      text(0.5, 0.5, err, col = "#E06C75", cex = 1.2); return()
    }
    make_plot(plot_data())
  }, bg = "#ffffff")

  # ── HTML legend below plot ──
  output$plot_legend <- renderUI({
    err <- valid_inputs()
    if (!is.null(err)) return(NULL)
    p <- plot_data()
    items <- lapply(p$lines, function(l) {
      div(class = "legend-item",
        div(class = "legend-swatch", style = paste0("background:", l$color, ";")),
        paste0("\u03bb=", l$lambda, "  k=", l$k, "  n=", l$n)
      )
    })
    div(class = "plot-legend", items)
  })

  # ── Status bar ──
  output$status_bar <- renderUI({
    err <- valid_inputs()
    if (!is.null(err)) {
      cls <- if (grepl("Click", err)) "status-bar status-warn" else "status-bar status-error"
      return(div(class = cls, paste0("\u26a0  ", err)))
    }
    p <- plot_data()
    n_pts <- length(seq(p$xmin, p$xmax, by = p$xstep))
    div(class = "status-bar status-ok",
      HTML(sprintf("\u2713 &nbsp; %d curve(s) &nbsp;|&nbsp; %d pts/curve &nbsp;|&nbsp; range [%g, %g] &nbsp;|&nbsp; step = %g",
                   length(p$lines), n_pts, p$xmin, p$xmax, p$xstep))
    )
  })

  # ── PNG download — base64 trick for Shinylive compatibility ──
  output$png_download_ui <- renderUI({
    err <- valid_inputs()
    if (!is.null(err)) return(NULL)
    p <- plot_data()

    # Render to temp PNG, encode as base64
    tmp <- tempfile(fileext = ".png")
    tryCatch({
      png(tmp, width = 3000, height = 2000, res = 300, bg = "#ffffff")
      make_plot(p)
      dev.off()
      b64 <- base64enc::base64encode(tmp)
      href <- paste0("data:image/png;base64,", b64)
      fname <- paste0(p$fn, "_plot.png")
      tags$a(
        href     = href,
        download = fname,
        class    = "btn btn-save",
        style    = "display:block;text-align:center;text-decoration:none;margin-top:0;",
        "\u2193  Export PNG"
      )
    }, error = function(e) {
      # Fallback: standard downloadButton if base64enc not available
      downloadButton("save_png_fallback", "Export PNG", class = "btn btn-save")
    })
  })

  output$save_png_fallback <- downloadHandler(
    filename = function() paste0(plot_data()$fn, "_plot.png"),
    content  = function(file) {
      png(file, width = 3000, height = 2000, res = 300, bg = "#ffffff")
      make_plot(plot_data())
      dev.off()
    }
  )

  # ── Info panel ──
  output$info_panel <- renderUI({
    err <- valid_inputs()
    if (!is.null(err)) return(NULL)
    p  <- plot_data()
    fn <- p$fn
    t0 <- p$eval_pt

    if (fn == "hx") {
      integral_cards <- lapply(p$lines, function(l) {
        val <- tryCatch(
          integrate(function(x) h_func(x, l$lambda, l$k, l$n), lower = 0, upper = Inf)$value,
          error = function(e) NA)
        is_valid  <- !is.na(val) && abs(val - 1) < 0.01
        val_class <- if (!is.na(val) && is_valid) "info-item-value valid" else "info-item-value invalid"
        val_text  <- if (is.na(val)) "Error" else sprintf("%.6f", val)
        div(class = "info-item",
          div(class = "info-item-label",
              tags$span(class = "info-dot", style = paste0("background:", l$color, ";")),
              paste0("Curve ", l$id, "  \u2014  \u222b\u2080\u207e h(t) dt")),
          div(class = val_class, val_text),
          div(class = "info-item-params", paste0("\u03bb=", l$lambda, "  k=", l$k, "  n=", l$n)),
          if (!is.na(val))
            div(style = paste0("font-size:10px;margin-top:4px;font-family:'Source Code Pro',monospace;color:",
                               if (is_valid) "#0ea58a" else "#E06C75", ";"),
                if (is_valid) "\u2713 Valid density" else "\u26a0 Not integrating to 1")
        )
      })

      eval_cards <- if (!is.null(t0) && t0 > 0) {
        lapply(p$lines, function(l) {
          val <- tryCatch(h_func(t0, l$lambda, l$k, l$n), error = function(e) NA)
          val_color <- if (is.na(val) || !is.finite(val)) "#E06C75" else "#1a1f2e"
          val_text  <- if (is.na(val) || !is.finite(val)) "Undefined" else sprintf("%.6f", val)
          div(class = "info-item",
            div(class = "info-item-label",
                tags$span(class = "info-dot", style = paste0("background:", l$color, ";")),
                paste0("Curve ", l$id, "  \u2014  h(t = ", t0, ")")),
            div(class = "info-item-value", style = paste0("color:", val_color, ";"), val_text),
            div(class = "info-item-params", paste0("\u03bb=", l$lambda, "  k=", l$k, "  n=", l$n))
          )
        })
      } else NULL

      tagList(
        div(class = "info-panel",
          div(class = "info-title", HTML("\u222b Integral Check &nbsp;\u2014&nbsp; should equal 1.0 for a valid density")),
          div(class = "info-grid", integral_cards)
        ),
        if (!is.null(eval_cards))
          div(class = "info-panel",
            div(class = "info-title", HTML(paste0("h(t) at t = ", t0, " &nbsp;\u2014&nbsp; probability density at this point"))),
            div(class = "info-grid", eval_cards)
          )
      )

    } else {
      if (is.null(t0) || t0 <= 0) return(NULL)
      cards <- lapply(p$lines, function(l) {
        val <- tryCatch(
          switch(fn, rt = R_func(t0, l$lambda, l$k, l$n),
                     zt = Z_func(t0, l$lambda, l$k, l$n)),
          error = function(e) NA)

        if (fn == "rt") {
          val_color <- if (!is.na(val)) { if (val >= 0.5) "#0ea58a" else "#F48024" } else "#E06C75"
          val_text  <- if (is.na(val)) "Error" else sprintf("%.6f", val)
          pct_text  <- if (!is.na(val)) sprintf("(%.2f%%)", val * 100) else ""
          div(class = "info-item",
            div(class = "info-item-label",
                tags$span(class = "info-dot", style = paste0("background:", l$color, ";")),
                paste0("Curve ", l$id, "  \u2014  R(t = ", t0, ")")),
            div(class = "info-item-value", style = paste0("color:", val_color, ";"),
                val_text,
                tags$span(style = "font-size:13px;margin-left:8px;color:var(--muted);", pct_text)),
            div(class = "info-item-params", paste0("\u03bb=", l$lambda, "  k=", l$k, "  n=", l$n))
          )
        } else {
          val_color <- if (is.na(val) || !is.finite(val)) "#E06C75" else "#1a1f2e"
          val_text  <- if (is.na(val) || !is.finite(val)) "Undefined" else sprintf("%.6f", val)
          div(class = "info-item",
            div(class = "info-item-label",
                tags$span(class = "info-dot", style = paste0("background:", l$color, ";")),
                paste0("Curve ", l$id, "  \u2014  Z(t = ", t0, ")")),
            div(class = "info-item-value", style = paste0("color:", val_color, ";"), val_text),
            div(class = "info-item-params", paste0("\u03bb=", l$lambda, "  k=", l$k, "  n=", l$n))
          )
        }
      })

      title_text <- if (fn == "rt")
        paste0("R(t) at t = ", t0, " &nbsp;\u2014&nbsp; probability of surviving beyond t")
      else
        paste0("Z(t) at t = ", t0, " &nbsp;\u2014&nbsp; instantaneous failure rate at time t")

      div(class = "info-panel",
        div(class = "info-title", HTML(title_text)),
        div(class = "info-grid", cards)
      )
    }
  })
}

shinyApp(ui, server)