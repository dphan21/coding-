# ==============================================================================
# FDI and GDP per Capita -- Research Report
# Section 2: Data preparation, variable selection, and correlation matrix
#
# Data source: WDI2017.RData (World Bank World Development Indicators, 2017)
# ==============================================================================

# ---- 1. Load the data -------------------------------------------------------
# load() restores the exact R object(s) that were saved into the .RData file.
# Unlike read.csv(), it does not return a value you assign yourself -- it
# creates the object(s) directly in your environment under their original
# name(s). Here that object is a data frame called `LabourData`.
load("WDI2017.RData")

# Confirm what was loaded and its size.
ls()                 # lists object names now in the environment -> "LabourData"
dim(LabourData)       # 265 rows (countries/territories) x 35 columns (indicators)

# ---- 2. Choose the dependent and explanatory variables -----------------------
# Dependent variable (Y): GDP per capita, PPP (current international $)
#   - PPP (purchasing power parity) adjusted figures are the standard choice
#     for *cross-country* comparisons of living standards/output per person,
#     because they correct for differences in price levels between countries.
#
# Explanatory variables (X): FDI net inflows is required by the assignment;
# four more variables were chosen because each is a commonly cited driver of
# economic growth and is available for a reasonably large number of countries
# in this dataset:
#   1. Foreign direct investment, net inflows (BoP, current US$)
#        -> the variable of central interest (capital inflows from abroad)
#   2. Individuals using the Internet (% of population)
#        -> proxy for technology adoption / digital infrastructure, linked
#           to productivity and the capacity to absorb FDI spillovers
#   3. Urban population (% of total population)
#        -> proxy for agglomeration effects, infrastructure and market access
#   4. Industry (including construction), value added (% of GDP)
#        -> captures the structure of the economy (industrialisation)
#   5. Commercial bank branches (per 100,000 adults)
#        -> proxy for financial sector development / access to credit, which
#           affects how effectively capital (including FDI) is channelled
#           into productive investment

dep_var <- "GDP per capita, PPP (current international $)"

exp_vars <- c(
  "Foreign direct investment, net inflows (BoP, current US$)",
  "Individuals using the Internet (% of population)",
  "Urban population (% of total population)",
  "Industry (including construction), value added (% of GDP)",
  "Commercial bank branches (per 100,000 adults)"
)

# ---- 3. Subset to the variables we need --------------------------------------
# Back-ticks are required because the column names contain spaces/commas,
# which are not valid in a bare R name.
analysis_df <- LabourData[, c("Country Name", dep_var, exp_vars)]

# Give the columns short, workable names for the rest of the script.
names(analysis_df) <- c("country", "gdp_pc_ppp", "fdi_net_inflows",
                         "internet_pct", "urban_pct", "industry_pct_gdp",
                         "bank_branches")

# ---- 4. Inspect missingness ---------------------------------------------------
# colSums(is.na(df)) counts, column by column, how many rows are NA.
# World Bank panel data is never complete for every country/year, so some
# missingness is expected and must be reported transparently.
na_counts <- colSums(is.na(analysis_df))
print(na_counts)

cat("\nRows with at least one missing value:",
    sum(!complete.cases(analysis_df)), "out of", nrow(analysis_df), "\n")

# ---- 5. Handle missing values: complete-case (listwise) deletion -------------
# complete.cases() returns a logical vector that is TRUE only for rows that
# have NO missing value in ANY of the selected columns. We keep only those
# rows. This is the simplest and most transparent approach for a
# cross-sectional correlation/regression exercise, and is appropriate here
# because (a) the correlation matrix and later regression require fully
# observed rows for every variable anyway, and (b) the missingness pattern
# is driven by data availability by country rather than by the variables of
# interest themselves (no obvious reason to think GDP is more likely to be
# missing *because* FDI is high or low).
analysis_complete <- analysis_df[complete.cases(analysis_df), ]

cat("\nCountries retained after complete-case filtering:",
    nrow(analysis_complete), "\n")

# ---- 6. Correlation matrix of the five explanatory variables ------------------
# cor() on a data frame of numeric columns returns the pairwise Pearson
# correlation coefficients. use = "complete.obs" is a safety net (not
# strictly needed here since we already removed NAs, but it is good
# practice): it tells cor() to drop any row with a missing value before
# computing each pairwise correlation.
explanatory_matrix <- analysis_complete[, c("fdi_net_inflows", "internet_pct",
                                             "urban_pct", "industry_pct_gdp",
                                             "bank_branches")]

cor_matrix <- cor(explanatory_matrix, use = "complete.obs", method = "pearson")

cat("\nCorrelation matrix of the five explanatory variables:\n")
print(round(cor_matrix, 3))

# Save the cleaned dataset and the correlation matrix for use in later
# sections of the report (e.g. the regression section).
write.csv(analysis_complete, "fdi_gdp_analysis_data.csv", row.names = FALSE)
write.csv(round(cor_matrix, 3), "fdi_gdp_correlation_matrix.csv")

cat("\nDone. Cleaned data written to fdi_gdp_analysis_data.csv\n")
cat("Correlation matrix written to fdi_gdp_correlation_matrix.csv\n")
