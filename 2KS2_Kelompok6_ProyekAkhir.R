library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(readxl)
library(lmtest)
library(car)
library(DT)
library(haven)  # For SPSS files
library(readr)  # For CSV files
library(foreign) # For additional formats

# Modern CSS styling with enhanced icons
modern_css <- "
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css');

/* Global Styling */
body, .content-wrapper, .right-side {
  font-family: 'Inter', sans-serif !important;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
}

/* Header Styling */
.main-header .navbar {
  background: linear-gradient(90deg, #2C3E50, #3498DB) !important;
  border: none !important;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1) !important;
}

.main-header .navbar-custom-menu > .navbar-nav > li > .dropdown-menu {
  background: white !important;
}

.main-header .logo {
  background: linear-gradient(90deg, #2C3E50, #3498DB) !important;
  color: white !important;
  border: none !important;
  font-weight: 600 !important;
  font-size: 18px !important;
}

/* Sidebar Styling */
.main-sidebar, .left-side {
  background: linear-gradient(180deg, #2C3E50 0%, #34495E 100%) !important;
}

.sidebar-menu > li > a {
  color: #ECF0F1 !important;
  border-left: 3px solid transparent !important;
  transition: all 0.3s ease !important;
  font-weight: 500 !important;
}

.sidebar-menu > li:hover > a, .sidebar-menu > li.active > a {
  background: rgba(52, 152, 219, 0.2) !important;
  border-left: 3px solid #3498DB !important;
  color: white !important;
}

.sidebar-menu > li > a > .fa {
  color: #3498DB !important;
}

/* Content Area */
.content-wrapper {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%) !important;
  min-height: 100vh !important;
}

.content {
  padding: 20px !important;
}

/* Box Styling */
.box {
  border-radius: 15px !important;
  box-shadow: 0 8px 25px rgba(0,0,0,0.1) !important;
  border: none !important;
  margin-bottom: 25px !important;
  transition: transform 0.3s ease, box-shadow 0.3s ease !important;
  background: white !important;
}

.box:hover {
  transform: translateY(-5px) !important;
  box-shadow: 0 15px 35px rgba(0,0,0,0.15) !important;
}

.box-header {
  border-radius: 15px 15px 0 0 !important;
  padding: 20px !important;
}

.box-header.with-border {
  border-bottom: 2px solid #ecf0f1 !important;
}

.box-primary > .box-header {
  background: linear-gradient(135deg, #3498DB, #2980B9) !important;
  color: white !important;
}

.box-info > .box-header {
  background: linear-gradient(135deg, #1ABC9C, #16A085) !important;
  color: white !important;
}

.box-success > .box-header {
  background: linear-gradient(135deg, #2ECC71, #27AE60) !important;
  color: white !important;
}

.box-warning > .box-header {
  background: linear-gradient(135deg, #F39C12, #E67E22) !important;
  color: white !important;
}

.box-title {
  font-weight: 600 !important;
  font-size: 18px !important;
  margin: 0 !important;
}

.box-body {
  padding: 25px !important;
}

/* Icon Enhancement */
.fa, .fas, .far, .fab {
  margin-right: 8px !important;
}

.feature-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
  color: white !important;
  border-radius: 15px !important;
  padding: 20px !important;
  margin-bottom: 15px !important;
  transition: transform 0.3s ease !important;
}

.feature-card:hover {
  transform: translateY(-3px) !important;
}

.feature-icon {
  font-size: 2.5em !important;
  margin-bottom: 15px !important;
  display: block !important;
  text-align: center !important;
}

/* Button Styling */
.btn {
  border-radius: 25px !important;
  font-weight: 500 !important;
  padding: 12px 30px !important;
  transition: all 0.3s ease !important;
  border: none !important;
  text-transform: uppercase !important;
  letter-spacing: 0.5px !important;
}

.btn-primary {
  background: linear-gradient(135deg, #3498DB, #2980B9) !important;
  box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3) !important;
}

.btn-primary:hover {
  background: linear-gradient(135deg, #2980B9, #1F618D) !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4) !important;
}

.btn-success {
  background: linear-gradient(135deg, #2ECC71, #27AE60) !important;
  box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3) !important;
}

.btn-success:hover {
  background: linear-gradient(135deg, #27AE60, #1E8449) !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 6px 20px rgba(46, 204, 113, 0.4) !important;
}

.btn-lg {
  padding: 15px 40px !important;
  font-size: 16px !important;
}

/* Form Elements */
.form-control {
  border-radius: 10px !important;
  border: 2px solid #ecf0f1 !important;
  padding: 12px 15px !important;
  transition: all 0.3s ease !important;
  font-size: 14px !important;
}

.form-control:focus {
  border-color: #3498DB !important;
  box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25) !important;
}

.form-group label {
  font-weight: 600 !important;
  color: #2C3E50 !important;
  margin-bottom: 8px !important;
}

/* Table Styling */
.table {
  border-radius: 10px !important;
  overflow: hidden !important;
  box-shadow: 0 0 20px rgba(0,0,0,0.1) !important;
}

.table thead th {
  background: linear-gradient(135deg, #34495E, #2C3E50) !important;
  color: white !important;
  font-weight: 600 !important;
  border: none !important;
  padding: 15px !important;
}

.table tbody tr {
  transition: background-color 0.3s ease !important;
}

.table tbody tr:hover {
  background-color: rgba(52, 152, 219, 0.1) !important;
}

.table tbody td {
  padding: 12px 15px !important;
  border-color: #ecf0f1 !important;
}

/* Radio Button Styling */
.radio {
  margin-bottom: 15px !important;
}

.radio label {
  padding-left: 30px !important;
  font-weight: 500 !important;
  color: #2C3E50 !important;
}

.radio input[type='radio'] {
  margin-left: -30px !important;
  transform: scale(1.2) !important;
}

/* Alert/Info Styling */
p {
  color: #2C3E50 !important;
  line-height: 1.6 !important;
}

em {
  color: #7F8C8D !important;
  font-style: italic !important;
}

/* Numeric Input Styling */
.shiny-input-container {
  margin-bottom: 20px !important;
}

/* File Input Styling */
.btn-file {
  background: linear-gradient(135deg, #9B59B6, #8E44AD) !important;
  border-radius: 20px !important;
  color: white !important;
  font-weight: 500 !important;
}

/* Progress and Loading */
.progress {
  border-radius: 10px !important;
  height: 8px !important;
}

.progress-bar {
  background: linear-gradient(90deg, #3498DB, #2980B9) !important;
}

/* Text Output Styling */
pre {
  background: #f8f9fa !important;
  border: none !important;
  border-radius: 10px !important;
  padding: 20px !important;
  font-family: 'Monaco', 'Consolas', monospace !important;
  font-size: 13px !important;
  line-height: 1.5 !important;
  color: #2C3E50 !important;
  box-shadow: inset 0 2px 5px rgba(0,0,0,0.1) !important;
}

/* Video Styling */
iframe {
  border-radius: 15px !important;
  box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
}

/* Responsive Design */
@media (max-width: 768px) {
  .content {
    padding: 15px !important;
  }
  
  .box {
    margin-bottom: 20px !important;
  }
  
  .btn {
    padding: 10px 20px !important;
    font-size: 14px !important;
  }
}

/* Custom animations */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.box {
  animation: fadeInUp 0.6s ease-out !important;
}

/* Metadata specific styling */
.metadata-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
  color: white !important;
  border-radius: 15px !important;
  padding: 25px !important;
  margin-bottom: 20px !important;
  box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
}

.metadata-item {
  background: rgba(255,255,255,0.1) !important;
  border-radius: 10px !important;
  padding: 15px !important;
  margin-bottom: 15px !important;
  border-left: 4px solid #3498DB !important;
}

.stats-highlight {
  background: linear-gradient(135deg, #FF6B6B, #FF8E53) !important;
  color: white !important;
  padding: 15px !important;
  border-radius: 10px !important;
  margin: 10px 0 !important;
  text-align: center !important;
  font-weight: 600 !important;
}

/* Icon-specific styling */
.section-icon {
  font-size: 1.2em !important;
  margin-right: 10px !important;
  color: #3498DB !important;
}

.result-section {
  background: #f8f9fa !important;
  border-left: 4px solid #3498DB !important;
  padding: 20px !important;
  margin: 15px 0 !important;
  border-radius: 0 10px 10px 0 !important;
}

.interpretation-header {
  background: linear-gradient(135deg, #3498DB, #2980B9) !important;
  color: white !important;
  padding: 15px 20px !important;
  margin: -20px -20px 15px -20px !important;
  border-radius: 10px 10px 0 0 !important;
  font-weight: 600 !important;
}
</style>
"

# Fungsi untuk menghapus pencilan menggunakan IQR
remove_outliers <- function(data, variable) {
  cat("🔧 Mengolah variabel:", variable, "\n")
  cat("📊 Jenis data:", class(data[[variable]]), "\n")
  Q1 <- quantile(data[[variable]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[variable]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  cat("📉 Batas bawah IQR:", lower_bound, "\n")
  cat("📈 Batas atas IQR:", upper_bound, "\n")
  data <- data %>% filter(data[[variable]] >= lower_bound & data[[variable]] <= upper_bound)
  cat("✅ Pencilan pada variabel", variable, "telah dihapus menggunakan metode IQR.\n")
  return(data)
}

# Enhanced function to read multiple file formats
read_data_file <- function(file_path, file_ext) {
  switch(file_ext,
    ".xlsx" = read_excel(file_path),
    ".xls" = read_excel(file_path),
    ".csv" = read_csv(file_path),
    ".sav" = read_sav(file_path),
    ".dta" = read_dta(file_path),
    ".txt" = read_delim(file_path, delim = "\t"),
    ".tsv" = read_tsv(file_path),
    stop("Format file tidak didukung")
  )
}

# Fungsi untuk memproses data contoh dengan multiple Y variables
process_data <- function(data) {
  # Asumsi kolom: Tanggal_Y, Beras_Y, Beras_Y1, Beras_Y2, Beras_Y3, Beras_Y4, Beras_Y5, Beras_Y6, Tanggal_X, Tavg_X1, RR_X2
  expected_cols <- c("Tanggal_Y", "Beras_Y", "Beras_Y1", "Beras_Y2", "Beras_Y3", "Beras_Y4", "Beras_Y5", "Beras_Y6", "Tanggal_X", "Tavg_X1", "RR_X2")
  
  if (ncol(data) >= length(expected_cols)) {
    colnames(data)[1:length(expected_cols)] <- expected_cols
  } else {
    # Fallback untuk data dengan struktur berbeda
    colnames(data) <- c("Tanggal_Y", "Beras_Y", "Tanggal_X", "Tavg_X1", "RR_X2")[1:ncol(data)]
  }
  
  data$Tanggal_Y <- as.Date(data$Tanggal_Y, format = "%d-%m-%Y")
  data$Tanggal_X <- as.Date(data$Tanggal_X, format = "%d-%m-%Y")
  
  # Pilih kolom yang tersedia
  available_cols <- intersect(expected_cols, colnames(data))
  data_clean <- data %>% select(all_of(available_cols))
  
  data_clean <- data_clean %>% filter(!is.na(Tanggal_Y) & !is.na(Tanggal_X))
  merged_data <- merge(data_clean, data_clean, by.x = "Tanggal_X", by.y = "Tanggal_Y", suffixes = c("", "_X"))
  
  final_data_cleaned <- merged_data %>% filter(Tavg_X1 != 888 & Tavg_X1 != 999 & RR_X2 != 888 & RR_X2 != 999)
  
  # Convert Y variables to numeric
  y_vars <- c("Beras_Y", "Beras_Y1", "Beras_Y2", "Beras_Y3", "Beras_Y4", "Beras_Y5", "Beras_Y6")
  available_y_vars <- intersect(y_vars, colnames(final_data_cleaned))
  
  for (var in available_y_vars) {
    final_data_cleaned[[var]] <- as.numeric(gsub(",", "", final_data_cleaned[[var]]))
  }
  
  final_data_cleaned$Tavg_X1 <- as.numeric(final_data_cleaned$Tavg_X1)
  final_data_cleaned$RR_X2 <- as.numeric(final_data_cleaned$RR_X2)
  
  # Remove outliers for all Y variables and X variables
  for (var in available_y_vars) {
    if (var %in% colnames(final_data_cleaned)) {
      final_data_cleaned <- remove_outliers(final_data_cleaned, var)
    }
  }
  
  final_data_cleaned <- final_data_cleaned %>%
    remove_outliers(., "Tavg_X1") %>%
    remove_outliers(., "RR_X2")
  
  # Select relevant columns
  final_cols <- c(available_y_vars, "Tavg_X1", "RR_X2")
  final_data_no_outliers <- final_data_cleaned %>% select(all_of(intersect(final_cols, colnames(final_data_cleaned))))
  
  return(final_data_no_outliers)
}

# Fungsi untuk memproses data pengguna dengan variabel yang dapat disesuaikan
process_user_custom_data <- function(data, num_vars, var_labels) {
  expected_cols <- num_vars + 1
  if (ncol(data) < expected_cols) {
    stop(paste("Data harus memiliki minimal", expected_cols, "kolom (Y dan", num_vars, "variabel X)"))
  }
  
  selected_data <- data[, 1:expected_cols]
  col_names <- c("Y", paste0("X", 1:num_vars))
  colnames(selected_data) <- col_names
  
  for (col in col_names) {
    selected_data[[col]] <- as.numeric(selected_data[[col]])
  }
  
  selected_data <- selected_data %>% filter(complete.cases(.))
  
  for (col in col_names) {
    selected_data <- remove_outliers(selected_data, col)
  }
  
  return(selected_data)
}

# UI: Bagian Antarmuka Pengguna
ui <- dashboardPage(
  dashboardHeader(title = HTML("<i class='fas fa-chart-line'></i> Dashboard Analisis Modern")),
  dashboardSidebar(
    sidebarMenu(
      menuItem(HTML("<i class='fas fa-home'></i> Beranda"), tabName = "home", icon = NULL),
      menuItem(HTML("<i class='fas fa-info-circle'></i> Metadata Statistik"), tabName = "metadata", icon = NULL),
      menuItem(HTML("<i class='fas fa-database'></i> Data Contoh"), tabName = "example_data", icon = NULL),
      menuItem(HTML("<i class='fas fa-upload'></i> Import Data Custom"), tabName = "import_custom", icon = NULL),
      menuItem(HTML("<i class='fas fa-chart-bar'></i> Statistik Deskriptif"), tabName = "desc_stats", icon = NULL),
      menuItem(HTML("<i class='fas fa-chart-area'></i> Visualisasi Data"), tabName = "visualization", icon = NULL),
      menuItem(HTML("<i class='fas fa-cogs'></i> Model Regresi & Hasil"), tabName = "regression", icon = NULL)
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(HTML(modern_css))
    ),
    tabItems(
      # Halaman Beranda
      tabItem(tabName = "home",
              fluidRow(
                box(title = HTML("<i class='fas fa-rocket'></i> Selamat Datang di Dashboard Analisis Modern"), 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 20px;",
                        h1(HTML("<i class='fas fa-chart-line'></i> Platform Analisis Statistik Terpadu"), style = "color: #2C3E50; margin-bottom: 20px;"),
                        p("Dashboard modern ini memungkinkan Anda menganalisis hubungan kompleks antara berbagai faktor dengan menggunakan teknologi statistik terdepan.", 
                          style = "font-size: 16px; color: #34495E; margin-bottom: 30px;")
                    )
                )
              ),
              
              fluidRow(
                box(title = HTML("<i class='fas fa-star'></i> Fitur Unggulan Platform"), status = "info", solidHeader = TRUE, width = 6,
                    div(class = "feature-card",
                        HTML("<i class='fas fa-seedling feature-icon'></i>"),
                        h4(HTML("<i class='fas fa-check-circle'></i> Analisis Data Contoh Terintegrasi"), style = "margin: 0;"),
                        p("Eksplorasi berbagai jenis beras dengan faktor cuaca", style = "margin: 5px 0 0 0;")
                    ),
                    div(class = "feature-card",
                        HTML("<i class='fas fa-file-upload feature-icon'></i>"),
                        h4(HTML("<i class='fas fa-upload'></i> Import Multi-Format Fleksibel"), style = "margin: 0;"),
                        p("Upload Excel, CSV, SPSS, Stata dan format lainnya", style = "margin: 5px 0 0 0;")
                    ),
                    div(class = "feature-card",
                        HTML("<i class='fas fa-chart-pie feature-icon'></i>"),
                        h4(HTML("<i class='fas fa-chart-bar'></i> Visualisasi Data Interaktif"), style = "margin: 0;"),
                        p("Grafik modern dan interpretasi mendalam", style = "margin: 5px 0 0 0;")
                    ),
                    div(class = "feature-card",
                        HTML("<i class='fas fa-calculator feature-icon'></i>"),
                        h4(HTML("<i class='fas fa-calculator'></i> Model Regresi Linier Berganda"), style = "margin: 0;"),
                        p("Analisis inferensia dengan validasi model", style = "margin: 5px 0 0 0;")
                    )
                ),
                
                box(title = HTML("<i class='fas fa-question-circle'></i> Panduan Cepat"), status = "warning", solidHeader = TRUE, width = 6,
                    h4(HTML("<i class='fas fa-rocket'></i> Langkah-langkah Penggunaan:")),
                    tags$ol(
                      tags$li(HTML("<i class='fas fa-info-circle'></i> Kunjungi tab 'Metadata Statistik' untuk memahami konsep analisis")),
                      tags$li(HTML("<i class='fas fa-database'></i> Pilih 'Data Contoh' untuk eksplorasi analisis beras dan cuaca")),
                      tags$li(HTML("<i class='fas fa-file-upload'></i> Atau gunakan 'Import Data Custom' untuk data Anda sendiri")),
                      tags$li(HTML("<i class='fas fa-chart-bar'></i> Lihat 'Statistik Deskriptif' untuk ringkasan data")),
                      tags$li(HTML("<i class='fas fa-chart-line'></i> Eksplorasi 'Visualisasi Data' untuk pola dan tren")),
                      tags$li(HTML("<i class='fas fa-cogs'></i> Analisis lengkap di 'Model Regresi & Hasil'"))
                    ),
                    br(),
                    downloadButton("downloadGuidebook", HTML("<i class='fas fa-download'></i> Unduh Panduan Lengkap"), class = "btn-primary btn-lg")
                )
              ),
              
              fluidRow(
                box(title = HTML("<i class='fas fa-play-circle'></i> Tutorial Video Interaktif"), status = "success", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center;",
                        tags$iframe(width = "100%", height = "400", 
                                   src = "https://www.youtube.com/embed/S5Tk0lxBLfA?si=DTkoaFLNXQ-3fAb2", 
                                   frameborder = "0", 
                                   allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture", 
                                   allowfullscreen = TRUE,
                                   style = "max-width: 800px; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.15);")
                    )
                )
              )
      ),
      
      # Halaman Metadata Statistik (BARU)
      tabItem(tabName = "metadata",
              fluidRow(
                box(title = HTML("<i class='fas fa-chart-pie'></i> Metadata Kegiatan dan Variabel Statistik"), 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 20px;",
                        h2(HTML("<i class='fas fa-microscope'></i> Pusat Informasi Metodologi Statistik"), style = "color: #2C3E50;"),
                        p("Memahami konsep, metode, dan variabel yang digunakan dalam analisis", style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = HTML("<i class='fas fa-tasks'></i> Kegiatan Statistik Yang Dilakukan"), 
                    status = "info", solidHeader = TRUE, width = 6,
                    div(class = "metadata-item",
                        h4(HTML("<i class='fas fa-calculator'></i> 1. Analisis Deskriptif"), style = "color: #2C3E50; margin-bottom: 10px;"),
                        p(HTML("<i class='fas fa-bullseye'></i> Perhitungan ukuran pemusatan (mean, median, modus)")),
                        p(HTML("<i class='fas fa-expand-arrows-alt'></i> Perhitungan ukuran penyebaran (standar deviasi, varians)")),
                        p(HTML("<i class='fas fa-list'></i> Identifikasi nilai minimum dan maksimum")),
                        p(HTML("<i class='fas fa-search'></i> Analisis distribusi data dan identifikasi outlier"))
                    ),
                    
                    div(class = "metadata-item",
                        h4(HTML("<i class='fas fa-chart-line'></i> 2. Analisis Inferensia"), style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("📈 Regresi Linier Berganda (Multiple Linear Regression)"),
                        p("🧪 Uji Signifikansi Parameter (t-test)"),
                        p("📊 Uji Kelayakan Model (F-test)"),
                        p("🎯 Analisis Koefisien Determinasi (R²)")
                    ),
                    
                    div(class = "metadata-item",
                        h4("✅ 3. Validasi Model", style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("🔬 Uji Normalitas Residual (Shapiro-Wilk Test)"),
                        p("📊 Uji Homoskedastisitas (Breusch-Pagan Test)"),
                        p("🔢 Uji Multikolinearitas (Variance Inflation Factor)"),
                        p("📈 Analisis Residual dan Leverage")
                    )
                ),
                
                box(title = "📋 Variabel Statistik dalam Analisis", 
                    status = "warning", solidHeader = TRUE, width = 6,
                    div(class = "metadata-item",
                        h4("🎯 Variabel Dependen (Y)", style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("💰 Harga Beras (Rupiah per kilogram)"),
                        p("📊 Jenis: Variabel kuantitatif kontinu"),
                        p("🎯 Peran: Variabel yang diprediksi/dijelaskan"),
                        p("📈 Skala: Rasio dengan nilai nol absolut")
                    ),
                    
                    div(class = "metadata-item",
                        h4("📈 Variabel Independen (X)", style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("🌡️ X₁: Suhu Rata-rata (°Celsius)"),
                        p("🌧️ X₂: Curah Hujan (milimeter)"),
                        p("📊 Jenis: Variabel kuantitatif kontinu"),
                        p("🎯 Peran: Variabel prediktor/penjelas"),
                        p("📏 Skala: Interval dan Rasio")
                    )
                )
              )
      ),
      
      # Halaman Data Contoh
      tabItem(tabName = "example_data",
              fluidRow(
                box(title = "📈 Eksplorasi Data Contoh Beras & Cuaca", 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 15px;",
                        h3("🌾 Analisis Hubungan Harga Beras dengan Faktor Cuaca", style = "color: #2C3E50; margin-bottom: 15px;"),
                        p("Jelajahi bagaimana suhu rata-rata dan curah hujan mempengaruhi harga berbagai jenis beras", 
                          style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = "🎯 Pilih Jenis Beras untuk Analisis", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("🌾 Pilih Varietas Beras:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             p("Setiap jenis beras memiliki karakteristik harga yang unik dan merespons faktor cuaca dengan cara yang berbeda.", style = "margin-bottom: 15px;"),
                             uiOutput("y_variable_selector")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("💡 Tips Analisis", style = "margin: 0;"),
                                 br(),
                                 p("🔍 Bandingkan berbagai jenis beras"),
                                 p("📊 Perhatikan pola harga vs cuaca"),
                                 p("📈 Gunakan untuk prediksi harga"),
                                 p("🎯 Validasi dengan data historis")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "Data Contoh yang Telah Dibersihkan", status = "success", solidHeader = TRUE, width = 12,
                    div(style = "margin-bottom: 20px;",
                        h4(HTML("<i class='fas fa-table'></i> Data Analisis Lengkap:"), style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("Semua data yang telah dibersihkan dan siap untuk analisis dengan fitur pencarian dan sorting:", style = "color: #34495E;")
                    ),
                    DT::dataTableOutput("exampleCleanedData")
                )
              )
      ),
      
      # Halaman Import Data Custom
      tabItem(tabName = "import_custom",
              fluidRow(
                box(title = "📁 Platform Import Data Kustom", 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 15px;",
                        h3("🚀 Analisis Data Anda Sendiri", style = "color: #2C3E50; margin-bottom: 15px;"),
                        p("Ikuti wizard 3 langkah mudah untuk menganalisis data Anda dengan teknologi regresi linier berganda", 
                          style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = "🔢 Langkah 1: Konfigurasi Analisis", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("📊 Tentukan Struktur Data Anda:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             p("Berapa banyak faktor (variabel independen) yang ingin Anda analisis pengaruhnya terhadap variabel target?", style = "margin-bottom: 15px;"),
                             numericInput("num_vars", "Jumlah Faktor Prediktor:", 
                                          value = 2, min = 1, max = 10, step = 1),
                             p(em("Contoh: Untuk menganalisis pengaruh suhu dan curah hujan terhadap harga beras, pilih 2"), style = "color: #7F8C8D;")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("📋 Panduan Cepat", style = "margin: 0;"),
                                 br(),
                                 p("🎯 1 Variabel Target (Y)"),
                                 p("📈 1-10 Faktor Prediktor (X)"),
                                 p("🧮 Minimum 20 observasi"),
                                 p("💾 Format file: Multiple")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "🏷️ Langkah 2: Penamaan Variabel", status = "warning", solidHeader = TRUE, width = 12,
                    h4("✏️ Berikan Nama Deskriptif untuk Setiap Variabel:", style = "color: #2C3E50; margin-bottom: 15px;"),
                    p("Nama yang jelas akan memudahkan interpretasi hasil analisis.", style = "margin-bottom: 20px;"),
                    uiOutput("variable_labels_ui")
                )
              ),
              
              fluidRow(
                box(title = "📤 Langkah 3: Upload & Pemrosesan Data", status = "success", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("📂 Format File yang Dibutuhkan:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             fileInput("file_custom", HTML("<i class='fas fa-file-upload'></i> Pilih File Data Anda:"), 
                                      accept = c(".xlsx", ".xls", ".csv", ".sav", ".dta", ".txt", ".tsv"),
                                      buttonLabel = HTML("<i class='fas fa-folder-open'></i> Browse..."),
                                      placeholder = "Belum ada file yang dipilih"),
                             div(style = "background: #e3f2fd; padding: 10px; border-radius: 8px; margin-top: 10px;",
                                 h6(HTML("<i class='fas fa-info-circle'></i> Format File yang Didukung:"), style = "color: #1976D2; margin-bottom: 8px;"),
                                 p(HTML("<i class='fas fa-file-excel'></i> Excel (.xlsx, .xls) | <i class='fas fa-file-csv'></i> CSV (.csv) | <i class='fas fa-chart-bar'></i> SPSS (.sav) | <i class='fas fa-database'></i> Stata (.dta) | <i class='fas fa-file-alt'></i> Text (.txt, .tsv)"), 
                                   style = "margin: 0; color: #1976D2; font-size: 12px;")
                             ),
                             br(),
                             actionButton("process_custom_data", "🚀 Proses & Analisis Data", 
                                         class = "btn-success btn-lg",
                                         style = "width: 100%; padding: 15px; font-size: 16px;")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("📋 Checklist", style = "margin: 0;"),
                                 br(),
                                 p("✅ Data dalam format angka"),
                                 p("✅ Tidak ada sel kosong"),
                                 p("✅ Minimal 20 observasi"),
                                 p("✅ File multi-format"),
                                 p("✅ Kolom terstruktur rapi")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "📋 Informasi Variabel Anda", status = "primary", solidHeader = TRUE, width = 6,
                    div(style = "min-height: 200px;",
                        verbatimTextOutput("variable_info")
                    )
                ),
                box(title = "📊 Status Pemrosesan", status = "info", solidHeader = TRUE, width = 6,
                    div(style = "min-height: 200px; padding: 20px; text-align: center;",
                        div(id = "processing-status",
                            h4("⏳ Menunggu Data", style = "color: #7F8C8D; margin-bottom: 15px;"),
                            p("Upload file data Anda untuk memulai pemrosesan", style = "color: #95A5A6;"),
                            hr(),
                            p("🔄 Sistem akan otomatis:", style = "color: #34495E; font-weight: 600; margin-bottom: 10px;"),
                            tags$ul(style = "text-align: left; color: #7F8C8D;",
                              tags$li("Membersihkan data missing values"),
                              tags$li("Mendeteksi dan menghapus outlier"),
                              tags$li("Memvalidasi format data"),
                              tags$li("Menyiapkan untuk analisis regresi")
                            )
                        )
                    )
                )
              ),
              
              fluidRow(
                box(title = "Data yang Telah Dibersihkan", status = "success", solidHeader = TRUE, width = 12,
                    div(style = "margin-bottom: 20px;",
                        h4(HTML("<i class='fas fa-table'></i> Data Siap Analisis:"), style = "color: #2C3E50; margin-bottom: 10px;"),
                        p("Semua data Anda yang telah dibersihkan dan siap untuk dianalisis dengan fitur pencarian dan sorting:", style = "color: #34495E;")
                    ),
                    DT::dataTableOutput("customCleanedData")
                )
              )
      ),
      
      # Halaman Statistik Deskriptif
      tabItem(tabName = "desc_stats",
              fluidRow(
                box(title = "📋 Analisis Statistik Deskriptif", 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 15px;",
                        h3("📊 Eksplorasi Karakteristik Data", style = "color: #2C3E50; margin-bottom: 15px;"),
                        p("Memahami distribusi, pemusatan, dan penyebaran data melalui statistik deskriptif komprehensif", 
                          style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = "🎯 Pilihan Sumber Data", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("📊 Pilih Dataset untuk Analisis:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             radioButtons("data_choice_stats", "Sumber Data:", 
                                          choices = c("📈 Data Contoh (Beras & Cuaca)" = "example", 
                                                      "📁 Data Kustom Saya" = "custom"),
                                          selected = "example"),
                             p("Pilih sumber data yang ingin Anda analisis karakteristik statistiknya.", style = "color: #7F8C8D;")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("📈 Yang Akan Dianalisis", style = "margin: 0;"),
                                 br(),
                                 p("📊 Ukuran Pemusatan"),
                                 p("📏 Ukuran Penyebaran"),
                                 p("🎯 Nilai Ekstrem"),
                                 p("📋 Ringkasan Komprehensif")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "📊 Hasil Analisis Statistik Deskriptif", status = "success", solidHeader = TRUE, width = 12,
                    verbatimTextOutput("descStats")
                )
              )
      ),
      
      # Halaman Visualisasi Data
      tabItem(tabName = "visualization",
              fluidRow(
                box(title = "📉 Pusat Visualisasi Data Interaktif", 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 15px;",
                        h3("📊 Eksplorasi Visual Model Regresi", style = "color: #2C3E50; margin-bottom: 15px;"),
                        p("Analisis mendalam kualitas model melalui grafik diagnostik dan visualisasi prediksi", 
                          style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = "🎯 Pilihan Sumber Data", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("📊 Pilih Dataset untuk Visualisasi:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             radioButtons("data_choice_viz", "Sumber Data:", 
                                          choices = c("📈 Data Contoh (Beras & Cuaca)" = "example", 
                                                      "📁 Data Kustom Saya" = "custom"),
                                          selected = "example"),
                             p("Grafik akan menampilkan analisis diagnostik model regresi dari dataset yang dipilih.", style = "color: #7F8C8D;")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("📊 Jenis Visualisasi", style = "margin: 0;"),
                                 br(),
                                 p("📈 Residual vs Fitted"),
                                 p("📊 Distribusi Residual"),
                                 p("🎯 Actual vs Predicted"),
                                 p("✅ Validasi Model")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "📈 Grafik Residual vs Prediksi", status = "primary", solidHeader = TRUE, width = 12,
                    plotOutput("residualsPlot", height = 400)
                )
              ),
              
              fluidRow(
                box(title = "📊 Distribusi Kesalahan Prediksi", status = "warning", solidHeader = TRUE, width = 12,
                    plotOutput("histResiduals", height = 400)
                )
              ),
              
              fluidRow(
                box(title = "🎯 Perbandingan Nilai Asli vs Prediksi", status = "success", solidHeader = TRUE, width = 12,
                    plotOutput("predictedVsActual", height = 400)
                )
              )
      ),
      
      # Halaman Model Regresi & Hasil
      tabItem(tabName = "regression",
              fluidRow(
                box(title = "🔬 Laboratorium Analisis Regresi", 
                    status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 15px;",
                        h3("🧮 Hasil Analisis dan Kesimpulan Statistik", style = "color: #2C3E50; margin-bottom: 15px;"),
                        p("Interpretasi komprehensif model regresi linier berganda dengan validasi statistik mendalam", 
                          style = "font-size: 16px; color: #34495E;")
                    )
                )
              ),
              
              fluidRow(
                box(title = "🎯 Pilihan Sumber Data", status = "info", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(8,
                             h4("📊 Pilih Dataset untuk Analisis Regresi:", style = "color: #2C3E50; margin-bottom: 15px;"),
                             radioButtons("data_choice_reg", "Sumber Data:", 
                                          choices = c("📈 Data Contoh (Beras & Cuaca)" = "example", 
                                                      "📁 Data Kustom Saya" = "custom"),
                                          selected = "example"),
                             p("Sistem akan melakukan analisis regresi linier berganda lengkap dengan interpretasi yang mudah dipahami.", style = "color: #7F8C8D;")
                      ),
                      column(4,
                             div(class = "stats-highlight",
                                 h4("🔬 Analisis Meliputi", style = "margin: 0;"),
                                 br(),
                                 p("📊 Koefisien Regresi"),
                                 p("🧪 Uji Signifikansi"),
                                 p("📈 R² dan Model Fit"),
                                 p("✅ Validasi Asumsi")
                             )
                      )
                    )
                )
              ),
              
              fluidRow(
                box(title = "📊 Detail Teknis Model Regresi", status = "primary", solidHeader = TRUE, width = 12,
                    verbatimTextOutput("regressionSummary")
                )
              ),
              
              fluidRow(
                box(title = HTML("<i class='fas fa-brain'></i> Interpretasi dan Kesimpulan Praktis"), status = "success", solidHeader = TRUE, width = 12,
                    htmlOutput("regressionInterpretation")
                )
              )
      )
    )
  )
)

# Server: Bagian Fungsi untuk Menangani Logika Aplikasi
server <- function(input, output, session) {
  
  # Reactive values untuk menyimpan data
  example_data <- reactiveVal(NULL)
  custom_data <- reactiveVal(NULL)
  custom_labels <- reactiveVal(NULL)
  custom_num_vars <- reactiveVal(2)
  selected_y_var <- reactiveVal("Beras_Y")
  
  # Memuat dan memproses data contoh
  observe({
    tryCatch({
      df <- read_excel("Data.xlsx")
      example_data(process_data(df))
    }, error = function(e) {
      # Buat data contoh dummy jika file tidak tersedia
      dummy_data <- data.frame(
        Beras_Y = c(12000, 13000, 11500, 14000, 12500, 13500, 11000, 15000, 12800, 13200,
                    11800, 12200, 13800, 14500, 11200, 12900, 13100, 14200, 11900, 13400),
        Beras_Y1 = c(10000, 11000, 9500, 12000, 10500, 11500, 9000, 13000, 10800, 11200,
                     9800, 10200, 11800, 12500, 9200, 10900, 11100, 12200, 9900, 11400),
        Beras_Y2 = c(10500, 11500, 10000, 12500, 11000, 12000, 9500, 13500, 11300, 11700,
                     10300, 10700, 12300, 13000, 9700, 11400, 11600, 12700, 10400, 11900),
        Beras_Y3 = c(13000, 14000, 12500, 15000, 13500, 14500, 12000, 16000, 13800, 14200,
                     12800, 13200, 14800, 15500, 12200, 13900, 14100, 15200, 12900, 14400),
        Beras_Y4 = c(13500, 14500, 13000, 15500, 14000, 15000, 12500, 16500, 14300, 14700,
                     13300, 13700, 15300, 16000, 12700, 14400, 14600, 15700, 13400, 14900),
        Beras_Y5 = c(15000, 16000, 14500, 17000, 15500, 16500, 14000, 18000, 15800, 16200,
                     14800, 15200, 16800, 17500, 14200, 15900, 16100, 17200, 14900, 16400),
        Beras_Y6 = c(16000, 17000, 15500, 18000, 16500, 17500, 15000, 19000, 16800, 17200,
                     15800, 16200, 17800, 18500, 15200, 16900, 17100, 18200, 15900, 17400),
        Tavg_X1 = c(28, 29, 27, 30, 28.5, 29.5, 26, 31, 28.8, 29.2,
                    27.5, 28.2, 30.1, 31.2, 26.8, 29.8, 28.9, 30.5, 27.8, 29.9),
        RR_X2 = c(150, 120, 180, 100, 160, 110, 200, 90, 140, 130,
                  170, 125, 95, 85, 190, 105, 135, 115, 175, 145)
      )
      example_data(dummy_data)
    })
  })
  
  # UI untuk memilih variabel Y
  output$y_variable_selector <- renderUI({
    data <- example_data()
    if (is.null(data)) return(NULL)
    
    # Identifikasi variabel Y yang tersedia
    y_vars <- colnames(data)[grepl("^Beras_Y", colnames(data))]
    
    # Buat pilihan dengan label yang lebih deskriptif
    choices <- list()
    for (var in y_vars) {
      if (var == "Beras_Y") {
        choices[["Beras Umum (Y)"]] <- var
      } else if (var == "Beras_Y1") {
        choices[["Beras Kualitas Bawah I (Y1)"]] <- var
      } else if (var == "Beras_Y2") {
        choices[["Beras Kualitas Bawah II (Y2)"]] <- var
      } else if (var == "Beras_Y3") {
        choices[["Beras Kualitas Medium I (Y3)"]] <- var
      } else if (var == "Beras_Y4") {
        choices[["Beras Kualitas Medium II (Y4)"]] <- var
      } else if (var == "Beras_Y5") {
        choices[["Beras Kualitas Super I (Y5)"]] <- var
      } else if (var == "Beras_Y6") {
        choices[["Beras Kualitas Super II (Y6)"]] <- var
      } else {
        choices[[var]] <- var
      }
    }
    
    selectInput("selected_y_variable", 
                "Pilih Jenis Beras:", 
                choices = choices,
                selected = selected_y_var())
  })
  
  # Update selected Y variable
  observeEvent(input$selected_y_variable, {
    if (!is.null(input$selected_y_variable)) {
      selected_y_var(input$selected_y_variable)
    }
  })
  
  # Handler untuk mengunduh guidebook
  output$downloadGuidebook <- downloadHandler(
    filename = function() {
      paste("Guidebook_Dashboard_Analisis_", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      guidebook_path <- "guidebook.pdf"
      
      if (file.exists(guidebook_path)) {
        file.copy(guidebook_path, file)
      } else {
        tryCatch({
          pdf(file, width = 8.5, height = 11)
          plot.new()
          text(0.5, 0.9, "GUIDEBOOK DASHBOARD ANALISIS", cex = 2, font = 2)
          text(0.5, 0.8, "Panduan Penggunaan Dashboard", cex = 1.5)
          text(0.1, 0.7, "1. Pilih jenis beras untuk data contoh", adj = 0)
          text(0.1, 0.65, "2. Atau pilih jumlah faktor untuk data custom", adj = 0)
          text(0.1, 0.6, "3. Beri nama untuk setiap variabel", adj = 0)
          text(0.1, 0.55, "4. Upload file Excel dengan format yang benar", adj = 0)
          text(0.1, 0.5, "5. Lihat hasil analisis di tab yang tersedia", adj = 0)
          text(0.1, 0.4, "Format Data Excel:", font = 2, adj = 0)
          text(0.1, 0.35, "- Kolom 1: Variabel target (Y)", adj = 0)
          text(0.1, 0.3, "- Kolom 2-n: Faktor-faktor (X1, X2, ...)", adj = 0)
          text(0.1, 0.25, "- Semua data harus berupa angka", adj = 0)
          text(0.1, 0.2, "- Tidak boleh ada sel kosong", adj = 0)
          dev.off()
        }, error = function(e) {
          writeLines(c(
            "GUIDEBOOK DASHBOARD ANALISIS",
            "",
            "Panduan Penggunaan:",
            "1. Pilih jenis beras untuk data contoh",
            "2. Atau pilih jumlah faktor untuk data custom",
            "3. Beri nama untuk setiap variabel", 
            "4. Upload file Excel dengan format yang benar",
            "5. Lihat hasil analisis di tab yang tersedia",
            "",
            "Format Data Excel:",
            "- Kolom 1: Variabel target (Y)",
            "- Kolom 2-n: Faktor-faktor (X1, X2, ...)",
            "- Semua data harus berupa angka",
            "- Tidak boleh ada sel kosong"
          ), file)
        })
      }
    },
    contentType = "application/pdf"
  )
  
  # UI dinamis untuk label variabel
  output$variable_labels_ui <- renderUI({
    num_vars <- input$num_vars
    if (is.null(num_vars) || num_vars < 1) return(NULL)
    
    label_inputs <- list()
    
    label_inputs[[1]] <- textInput("label_Y", "Nama untuk Variabel yang Ingin Diprediksi (Y):", 
                                   value = "Variabel Target", placeholder = "Contoh: Harga Beras, Penjualan, dll.")
    
    for (i in 1:num_vars) {
      label_inputs[[i+1]] <- textInput(paste0("label_X", i), 
                                       paste("Nama untuk Faktor", i, ":"), 
                                       value = paste("Faktor", i), 
                                       placeholder = "Contoh: Suhu, Curah Hujan, dll.")
    }
    
    do.call(tagList, label_inputs)
  })
  
  # Menangani unggahan file custom dengan multiple format support
  observeEvent(input$process_custom_data, {
    req(input$file_custom, input$num_vars)
    file_path <- input$file_custom$datapath
    file_name <- input$file_custom$name
    file_ext <- tools::file_ext(file_name)
    file_ext_with_dot <- paste0(".", file_ext)
    num_vars <- input$num_vars
    
    labels <- list()
    labels[["Y"]] <- ifelse(is.null(input$label_Y) || input$label_Y == "", "Variabel Target", input$label_Y)
    
    for (i in 1:num_vars) {
      label_input <- paste0("label_X", i)
      labels[[paste0("X", i)]] <- ifelse(is.null(input[[label_input]]) || input[[label_input]] == "", 
                                         paste0("Faktor", i), input[[label_input]])
    }
    
    tryCatch({
      # Read data using the enhanced function that supports multiple formats
      data <- read_data_file(file_path, file_ext_with_dot)
      processed_data <- process_user_custom_data(data, num_vars, labels)
      custom_data(processed_data)
      custom_labels(labels)
      custom_num_vars(num_vars)
      
      showModal(modalDialog(
        title = HTML("<i class='fas fa-check-circle'></i> Berhasil!"),
        HTML(paste("<i class='fas fa-thumbs-up'></i> Data Anda dengan", num_vars, "faktor telah berhasil diproses dan siap dianalisis!<br>",
                   "<i class='fas fa-file'></i> Format file:", toupper(file_ext), "<br>",
                   "<i class='fas fa-database'></i> Jumlah observasi:", nrow(processed_data))),
        easyClose = TRUE,
        footer = NULL
      ))
    }, error = function(e) {
      showModal(modalDialog(
        title = HTML("<i class='fas fa-exclamation-triangle'></i> Ada Masalah"),
        HTML(paste("<i class='fas fa-times-circle'></i> Gagal memproses data. Pastikan:", 
              "<br>• <i class='fas fa-file-check'></i> File memiliki format yang benar", 
              "<br>• <i class='fas fa-calculator'></i> Semua data berupa angka", 
              "<br>• <i class='fas fa-ban'></i> Tidak ada sel yang kosong", 
              "<br>• <i class='fas fa-list'></i> Urutan kolom: Y, X1, X2, ...",
              "<br><br><i class='fas fa-bug'></i> Detail error:", e$message)),
        easyClose = TRUE,
        footer = NULL
      ))
    })
  })
  
  output$variable_info <- renderText({
    if (!is.null(custom_labels())) {
      labels <- custom_labels()
      info_text <- "Variabel yang Akan Dianalisis:\n\n"
      info_text <- paste0(info_text, "Target Prediksi: ", labels[["Y"]], "\n")
      info_text <- paste0(info_text, "\nFaktor-faktor yang Mempengaruhi:\n")
      
      x_vars <- names(labels)[names(labels) != "Y"]
      for (i in 1:length(x_vars)) {
        var_name <- x_vars[i]
        info_text <- paste0(info_text, "   ", i, ". ", labels[[var_name]], "\n")
      }
      return(info_text)
    } else {
      return("Belum ada data yang diproses. Silakan unggah file data Anda terlebih dahulu.")
    }
  })
  
  # Function to get example data with selected Y variable
  get_example_data_with_selected_y <- reactive({
    data <- example_data()
    y_var <- selected_y_var()
    
    if (is.null(data) || is.null(y_var)) return(NULL)
    
    if (y_var %in% colnames(data)) {
      # Create new dataset with selected Y variable renamed to a standard name
      selected_data <- data %>%
        select(all_of(c(y_var, "Tavg_X1", "RR_X2"))) %>%
        rename(Selected_Y = !!y_var)
      
      return(selected_data)
    }
    
    return(NULL)
  })
  
  output$exampleCleanedData <- DT::renderDataTable({
    data <- get_example_data_with_selected_y()
    if (is.null(data)) return(NULL)
    
    # Rename columns for display
    display_data <- data
    y_var_name <- selected_y_var()
    
    # Get descriptive name for Y variable
    y_display_name <- switch(y_var_name,
                             "Beras_Y" = "Beras Umum",
                             "Beras_Y1" = "Beras Kualitas Bawah I",
                             "Beras_Y2" = "Beras Kualitas Bawah II", 
                             "Beras_Y3" = "Beras Kualitas Medium I",
                             "Beras_Y4" = "Beras Kualitas Medium II",
                             "Beras_Y5" = "Beras Kualitas Super I",
                             "Beras_Y6" = "Beras Kualitas Super II",
                             y_var_name)
    
    colnames(display_data) <- c(y_display_name, "Suhu Rata-rata (°C)", "Curah Hujan (mm)")
    
    DT::datatable(display_data, 
                  options = list(
                    pageLength = -1,  # Show all rows
                    lengthMenu = list(c(10, 25, 50, 100, -1), c('10', '25', '50', '100', 'Semua')),
                    searchHighlight = TRUE,
                    dom = 'Blfrtip',
                    buttons = c('copy', 'csv', 'excel'),
                    language = list(
                      search = "🔍 Cari:",
                      lengthMenu = "Tampilkan _MENU_ data per halaman",
                      info = "📊 Menampilkan _START_ sampai _END_ dari _TOTAL_ data",
                      paginate = list(previous = "⬅️ Sebelumnya", "next" = "Selanjutnya ➡️")
                    )
                  ),
                  rownames = FALSE,
                  class = 'cell-border stripe')
  })
  
  output$customCleanedData <- DT::renderDataTable({
    req(custom_data())
    
    DT::datatable(custom_data(), 
                  options = list(
                    pageLength = -1,  # Show all rows
                    lengthMenu = list(c(10, 25, 50, 100, -1), c('10', '25', '50', '100', 'Semua')),
                    searchHighlight = TRUE,
                    dom = 'Blfrtip',
                    buttons = c('copy', 'csv', 'excel'),
                    language = list(
                      search = "🔍 Cari:",
                      lengthMenu = "Tampilkan _MENU_ data per halaman",
                      info = "📊 Menampilkan _START_ sampai _END_ dari _TOTAL_ data",
                      paginate = list(previous = "⬅️ Sebelumnya", "next" = "Selanjutnya ➡️")
                    )
                  ),
                  rownames = FALSE,
                  class = 'cell-border stripe')
  })
  
  selected_data_stats <- reactive({
    if (input$data_choice_stats == "example") {
      return(get_example_data_with_selected_y())
    } else if (input$data_choice_stats == "custom") {
      req(custom_data())
      return(custom_data())
    }
    return(NULL)
  })
  
  selected_data_viz <- reactive({
    if (input$data_choice_viz == "example") {
      return(get_example_data_with_selected_y())
    } else if (input$data_choice_viz == "custom") {
      req(custom_data())
      return(custom_data())
    }
    return(NULL)
  })
  
  selected_data_reg <- reactive({
    if (input$data_choice_reg == "example") {
      return(get_example_data_with_selected_y())
    } else if (input$data_choice_reg == "custom") {
      req(custom_data())
      return(custom_data())
    }
    return(NULL)
  })
  
  output$descStats <- renderPrint({
    data <- selected_data_stats()
    if (is.null(data)) {
      cat("Silakan pilih data yang tersedia atau unggah data custom Anda terlebih dahulu.")
      return()
    }
    
    cat("RINGKASAN STATISTIK DATA\n")
    cat(paste(rep("=", 40), collapse = ""), "\n\n")
    
    if (input$data_choice_stats == "example") {
      y_var_name <- selected_y_var()
      y_display_name <- switch(y_var_name,
                               "Beras_Y" = "Beras Umum",
                               "Beras_Y1" = "Beras Kualitas Bawah I",
                               "Beras_Y2" = "Beras Kualitas Bawah II", 
                               "Beras_Y3" = "Beras Kualitas Medium I",
                               "Beras_Y4" = "Beras Kualitas Medium II",
                               "Beras_Y5" = "Beras Kualitas Super I",
                               "Beras_Y6" = "Beras Kualitas Super II",
                               y_var_name)
      
      cat("Variabel Target:", y_display_name, "\n")
      cat("   Min: Rp", format(min(data$Selected_Y, na.rm = TRUE), big.mark = ","), "\n")
      cat("   Max: Rp", format(max(data$Selected_Y, na.rm = TRUE), big.mark = ","), "\n")
      cat("   Rata-rata: Rp", format(round(mean(data$Selected_Y, na.rm = TRUE), 0), big.mark = ","), "\n")
      cat("   Median: Rp", format(round(median(data$Selected_Y, na.rm = TRUE), 0), big.mark = ","), "\n\n")
      
      cat("Suhu Rata-rata:\n")
      cat("   Min:", min(data$Tavg_X1, na.rm = TRUE), "°C\n")
      cat("   Max:", max(data$Tavg_X1, na.rm = TRUE), "°C\n")
      cat("   Rata-rata:", round(mean(data$Tavg_X1, na.rm = TRUE), 2), "°C\n")
      cat("   Median:", round(median(data$Tavg_X1, na.rm = TRUE), 2), "°C\n\n")
      
      cat("Curah Hujan:\n")
      cat("   Min:", min(data$RR_X2, na.rm = TRUE), "mm\n")
      cat("   Max:", max(data$RR_X2, na.rm = TRUE), "mm\n")
      cat("   Rata-rata:", round(mean(data$RR_X2, na.rm = TRUE), 2), "mm\n")
      cat("   Median:", round(median(data$RR_X2, na.rm = TRUE), 2), "mm\n\n")
      
    } else if ("Y" %in% colnames(data) && !is.null(custom_labels())) {
      labels <- custom_labels()
      cat("Variabel Target:", labels[["Y"]], "\n")
      cat("   Min:", min(data$Y, na.rm = TRUE), "\n")
      cat("   Max:", max(data$Y, na.rm = TRUE), "\n")
      cat("   Rata-rata:", round(mean(data$Y, na.rm = TRUE), 2), "\n")
      cat("   Median:", round(median(data$Y, na.rm = TRUE), 2), "\n\n")
      
      x_vars <- colnames(data)[colnames(data) != "Y"]
      for (var in x_vars) {
        var_label <- labels[[var]]
        cat(var_label, ":\n")
        cat("   Min:", min(data[[var]], na.rm = TRUE), "\n")
        cat("   Max:", max(data[[var]], na.rm = TRUE), "\n")
        cat("   Rata-rata:", round(mean(data[[var]], na.rm = TRUE), 2), "\n")
        cat("   Median:", round(median(data[[var]], na.rm = TRUE), 2), "\n\n")
      }
    } else {
      summary(data)
    }
  })
  
  model_viz <- reactive({
    data <- selected_data_viz()
    if (is.null(data)) return(NULL)
    
    tryCatch({
      if ("Selected_Y" %in% colnames(data)) {
        return(lm(Selected_Y ~ Tavg_X1 + RR_X2, data = data))
      } else if ("Y" %in% colnames(data)) {
        x_vars <- colnames(data)[colnames(data) != "Y"]
        formula_str <- paste("Y ~", paste(x_vars, collapse = " + "))
        return(lm(as.formula(formula_str), data = data))
      }
      return(NULL)
    }, error = function(e) {
      return(NULL)
    })
  })
  
  model_reg <- reactive({
    data <- selected_data_reg()
    if (is.null(data)) return(NULL)
    
    tryCatch({
      if ("Selected_Y" %in% colnames(data)) {
        return(lm(Selected_Y ~ Tavg_X1 + RR_X2, data = data))
      } else if ("Y" %in% colnames(data)) {
        x_vars <- colnames(data)[colnames(data) != "Y"]
        formula_str <- paste("Y ~", paste(x_vars, collapse = " + "))
        return(lm(as.formula(formula_str), data = data))
      }
      return(NULL)
    }, error = function(e) {
      return(NULL)
    })
  })
  
  output$residualsPlot <- renderPlot({
    model <- model_viz()
    if (is.null(model)) {
      plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
      text(5, 5, "Silakan pilih data yang tersedia\natau unggah data custom terlebih dahulu", cex=1.2)
      return()
    }
    
    residuals <- model$residuals
    fitted_values <- model$fitted.values
    ggplot(data.frame(fitted = fitted_values, residuals = residuals), aes(x = fitted, y = residuals)) +
      geom_point(alpha = 0.6, color = "steelblue") +
      geom_hline(yintercept = 0, linetype = "dashed", color = "red", size = 1) +
      labs(title = "Grafik Residual vs Prediksi", 
           x = "Nilai Prediksi", 
           y = "Residual (Selisih)",
           subtitle = "Titik yang tersebar acak menunjukkan model yang baik") +
      theme_minimal()
  })
  
  output$histResiduals <- renderPlot({
    model <- model_viz()
    if (is.null(model)) {
      plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
      text(5, 5, "Silakan pilih data yang tersedia\natau unggah data custom terlebih dahulu", cex=1.2)
      return()
    }
    
    residuals <- model$residuals
    ggplot(data.frame(residuals = residuals), aes(x = residuals)) +
      geom_histogram(fill = "lightblue", color = "darkblue", alpha = 0.7, bins = 30) +
      geom_vline(xintercept = 0, linetype = "dashed", color = "red", size = 1) +
      labs(title = "Distribusi Kesalahan Prediksi", 
           x = "Kesalahan Prediksi", 
           y = "Frekuensi",
           subtitle = "Bentuk seperti lonceng menunjukkan model yang baik") +
      theme_minimal()
  })
  
  output$predictedVsActual <- renderPlot({
    model <- model_viz()
    data <- selected_data_viz()
    if (is.null(model) || is.null(data)) {
      plot(1, type="n", xlab="", ylab="", xlim=c(0, 10), ylim=c(0, 10))
      text(5, 5, "Silakan pilih data yang tersedia\natau unggah data custom terlebih dahulu", cex=1.2)
      return()
    }
    
    fitted_values <- model$fitted.values
    
    if ("Selected_Y" %in% colnames(data)) {
      y_var_name <- selected_y_var()
      y_display_name <- switch(y_var_name,
                               "Beras_Y" = "Beras Umum",
                               "Beras_Y1" = "Beras Kualitas Bawah I",
                               "Beras_Y2" = "Beras Kualitas Bawah II", 
                               "Beras_Y3" = "Beras Kualitas Medium I",
                               "Beras_Y4" = "Beras Kualitas Medium II",
                               "Beras_Y5" = "Beras Kualitas Super I",
                               "Beras_Y6" = "Beras Kualitas Super II",
                               y_var_name)
      
      ggplot(data, aes(x = Selected_Y, y = fitted_values)) +
        geom_point(alpha = 0.6, color = "darkgreen") +
        geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
        labs(title = "Perbandingan Nilai Asli vs Prediksi", 
             x = paste("Harga Asli", y_display_name, "(Rp)"), 
             y = paste("Prediksi Harga", y_display_name, "(Rp)"),
             subtitle = "Semakin dekat ke garis merah, semakin akurat") +
        theme_minimal()
    } else if ("Y" %in% colnames(data)) {
      y_label <- ifelse(!is.null(custom_labels()), custom_labels()[["Y"]], "Nilai Y")
      ggplot(data, aes(x = Y, y = fitted_values)) +
        geom_point(alpha = 0.6, color = "darkgreen") +
        geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
        labs(title = "Perbandingan Nilai Asli vs Prediksi", 
             x = paste("Nilai Asli", y_label), 
             y = paste("Prediksi", y_label),
             subtitle = "Semakin dekat ke garis merah, semakin akurat") +
        theme_minimal()
    }
  })
  
  output$regressionSummary <- renderPrint({
    model <- model_reg()
    if (is.null(model)) {
      cat("Silakan pilih data yang tersedia atau unggah data custom Anda terlebih dahulu.")
      return()
    }
    summary(model)
  })
  
  output$regressionInterpretation <- renderText({
    model <- model_reg()
    data <- selected_data_reg()
    
    if (is.null(model) || is.null(data)) {
      return("Silakan pilih data yang tersedia atau unggah data custom Anda terlebih dahulu.")
    }
    
    tryCatch({
      summary_model <- summary(model)
      coefs <- coefficients(model)
      residuals <- model$residuals
      
      # Determine variable names based on data type
      dep_var_name <- "variabel yang ingin diprediksi"
      if (input$data_choice_reg == "example") {
        y_var_name <- selected_y_var()
        dep_var_name <- switch(y_var_name,
                               "Beras_Y" = "harga Beras Umum",
                               "Beras_Y1" = "harga Beras Kualitas Bawah I",
                               "Beras_Y2" = "harga Beras Kualitas Bawah II", 
                               "Beras_Y3" = "harga Beras Kualitas Medium I",
                               "Beras_Y4" = "harga Beras Kualitas Medium II",
                               "Beras_Y5" = "harga Beras Kualitas Super I",
                               "Beras_Y6" = "harga Beras Kualitas Super II",
                               "harga beras")
      } else if (!is.null(custom_labels())) {
        dep_var_name <- custom_labels()[["Y"]]
      }
      
      r_squared <- summary_model$r.squared
      
      # Build structured HTML output
      html_output <- paste0(
        '<div class="result-section">',
        '<div class="interpretation-header"><i class="fas fa-info-circle section-icon"></i>INFORMASI DASAR MODEL</div>',
        '<p><i class="fas fa-database"></i> <strong>Jumlah observasi:</strong> ', nrow(data), ' data</p>',
        '<p><i class="fas fa-layer-group"></i> <strong>Jumlah faktor prediksi:</strong> ', length(coefs) - 1, ' faktor</p>',
        '<p><i class="fas fa-bullseye"></i> <strong>Variabel target:</strong> ', dep_var_name, '</p>',
        '</div>'
      )
      
      # Model Quality Assessment
      quality_status <- ""
      quality_color <- ""
      quality_icon <- ""
      
      if (r_squared >= 0.9) {
        quality_status <- "LUAR BIASA"
        quality_color <- "#27AE60"
        quality_icon <- "fas fa-trophy"
      } else if (r_squared >= 0.8) {
        quality_status <- "SANGAT BAIK"
        quality_color <- "#2ECC71"
        quality_icon <- "fas fa-star"
      } else if (r_squared >= 0.6) {
        quality_status <- "CUKUP BAIK"
        quality_color <- "#F39C12"
        quality_icon <- "fas fa-thumbs-up"
      } else if (r_squared >= 0.4) {
        quality_status <- "SEDANG"
        quality_color <- "#E67E22"
        quality_icon <- "fas fa-exclamation-triangle"
      } else {
        quality_status <- "KURANG BAIK"
        quality_color <- "#E74C3C"
        quality_icon <- "fas fa-times-circle"
      }
      
      html_output <- paste0(html_output,
        '<div class="result-section">',
        '<div class="interpretation-header"><i class="fas fa-chart-line section-icon"></i>KUALITAS PREDIKSI MODEL</div>',
        '<div style="background: ', quality_color, '; color: white; padding: 15px; border-radius: 10px; margin: 10px 0;">',
        '<h4 style="margin: 0;"><i class="', quality_icon, '"></i> ', quality_status, ' (R² = ', round(r_squared, 3), ')</h4>',
        '</div>',
        '<p><i class="fas fa-percentage"></i> <strong>Akurasi prediksi:</strong> ', round(r_squared * 100, 1), '% dari perubahan ', dep_var_name, ' dapat dijelaskan oleh model</p>',
        '<p><i class="fas fa-question-circle"></i> <strong>Faktor lain:</strong> ', round((1-r_squared) * 100, 1), '% dipengaruhi faktor di luar model</p>',
        '</div>'
      )
      
      # Final Recommendations
      rec_html <- '<div class="result-section"><div class="interpretation-header"><i class="fas fa-lightbulb section-icon"></i>KESIMPULAN DAN REKOMENDASI</div>'
      
      significant_vars <- 0
      if (input$data_choice_reg == "example") {
        if (length(coefs) >= 2 && summary_model$coefficients[2, 4] < 0.05) significant_vars <- significant_vars + 1
        if (length(coefs) >= 3 && summary_model$coefficients[3, 4] < 0.05) significant_vars <- significant_vars + 1
      } else if (!is.null(custom_labels())) {
        x_vars <- names(coefs)[-1]
        for (i in 1:length(x_vars)) {
          p_value <- summary_model$coefficients[i+1, 4]
          if (p_value < 0.05) significant_vars <- significant_vars + 1
        }
      }
      
      if (significant_vars > 0 && r_squared >= 0.7) {
        rec_html <- paste0(rec_html,
          '<div style="background: #27AE60; color: white; padding: 15px; border-radius: 10px; margin: 10px 0;">',
          '<h4 style="margin: 0;"><i class="fas fa-trophy"></i> MODEL SANGAT BAIK & DAPAT DIANDALKAN</h4>',
          '</div>',
          '<p><i class="fas fa-check"></i> ', significant_vars, ' faktor berpengaruh signifikan</p>',
          '<p><i class="fas fa-chart-line"></i> Akurasi prediksi tinggi (', round(r_squared * 100, 1), '%)</p>',
          '<p><i class="fas fa-lightbulb"></i> <strong>Rekomendasi:</strong> Gunakan model untuk prediksi dan pengambilan keputusan</p>'
        )
      } else if (significant_vars > 0 && r_squared >= 0.5) {
        rec_html <- paste0(rec_html,
          '<div style="background: #F39C12; color: white; padding: 15px; border-radius: 10px; margin: 10px 0;">',
          '<h4 style="margin: 0;"><i class="fas fa-thumbs-up"></i> MODEL CUKUP BAIK</h4>',
          '</div>',
          '<p><i class="fas fa-check"></i> ', significant_vars, ' faktor berpengaruh signifikan</p>',
          '<p><i class="fas fa-chart-line"></i> Akurasi prediksi sedang (', round(r_squared * 100, 1), '%)</p>',
          '<p><i class="fas fa-lightbulb"></i> <strong>Rekomendasi:</strong> Tambahkan faktor lain untuk meningkatkan akurasi</p>'
        )
      } else {
        rec_html <- paste0(rec_html,
          '<div style="background: #E74C3C; color: white; padding: 15px; border-radius: 10px; margin: 10px 0;">',
          '<h4 style="margin: 0;"><i class="fas fa-exclamation-triangle"></i> MODEL PERLU DIPERBAIKI</h4>',
          '</div>',
          '<p><i class="fas fa-times"></i> Akurasi prediksi rendah (', round(r_squared * 100, 1), '%)</p>',
          '<p><i class="fas fa-lightbulb"></i> <strong>Rekomendasi:</strong> Cari faktor yang lebih berpengaruh atau gunakan metode lain</p>'
        )
      }
      
      rec_html <- paste0(rec_html, '</div>')
      html_output <- paste0(html_output, rec_html)
      
      return(html_output)
      
    }, error = function(e) {
      return(paste('<div style="color: red;"><i class="fas fa-exclamation-triangle"></i> Terjadi kesalahan dalam analisis:', e$message, '</div>'))
    })
  })
}

# Menjalankan Aplikasi Shiny
shinyApp(ui = ui, server = server)