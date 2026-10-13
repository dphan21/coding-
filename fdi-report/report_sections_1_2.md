# Research Report: FDI and GDP per Capita

## 1. Introduction

Foreign direct investment (FDI) is widely promoted as a growth lever for
developing economies, yet whether it actually translates into higher living
standards remains debated. This report investigates whether larger FDI net
inflows (BoP, current US$) are associated with higher GDP per capita across
host economies, using 2017 World Bank World Development Indicators data. The
question matters directly to the international organisation's mandate: if
FDI is systematically linked to income levels, encouraging FDI-friendly
policies (e.g. easing restrictions on foreign ownership, tax incentives,
streamlined approvals) is a credible growth strategy for member countries;
if the association is weak or explained by other factors, the organisation
should be cautious about recommending FDI promotion as a primary growth
policy and should examine complementary conditions (infrastructure, human
capital, financial development) that may matter more.

(99 words)

## 2. Data

**Dependent variable:** GDP per capita, PPP (current international $) —
used because PPP-adjusted figures are the standard measure for comparing
living standards/output per person across countries, as they correct for
differences in domestic price levels.

**Explanatory variables (five):**

1. **Foreign direct investment, net inflows (BoP, current US$)** — the
   variable of central interest.
2. **Individuals using the Internet (% of population)** — proxy for
   technology adoption and digital infrastructure, both linked to
   productivity and the economy's capacity to absorb FDI-driven spillovers.
3. **Urban population (% of total population)** — proxy for agglomeration
   effects, infrastructure density, and market access.
4. **Industry (including construction), value added (% of GDP)** — captures
   the structural/industrial composition of the economy.
5. **Commercial bank branches (per 100,000 adults)** — proxy for financial
   sector development, reflecting the economy's capacity to channel capital
   (including FDI) into productive investment.

Of the 265 countries/territories in the raw dataset, 93 had at least one
missing value among the six variables above (missingness ranged from 48
missing observations for GDP per capita and urban population to 86 for
commercial bank branches). Missing values were handled using **complete-case
(listwise) deletion**: only countries with non-missing values on all six
variables were retained, as this is required for a valid pairwise
correlation matrix and a later regression on the same variable set, and
there is no indication the missingness is related to the variables'
*values* themselves (it reflects gaps in national statistical reporting
rather than, say, countries with low FDI systematically failing to report
GDP). This left **172 countries** for analysis.

**Correlation matrix of the five explanatory variables** (Pearson, n = 172):

| | FDI net inflows | Internet use % | Urban pop % | Industry % GDP | Bank branches |
|---|---|---|---|---|---|
| **FDI net inflows** | 1.000 | 0.249 | 0.250 | -0.050 | 0.102 |
| **Internet use %** | 0.249 | 1.000 | 0.734 | 0.056 | 0.482 |
| **Urban pop %** | 0.250 | 0.734 | 1.000 | 0.091 | 0.353 |
| **Industry % GDP** | -0.050 | 0.056 | 0.091 | 1.000 | -0.235 |
| **Bank branches** | 0.102 | 0.482 | 0.353 | -0.235 | 1.000 |

FDI net inflows show only weak positive correlations with the other four
explanatory variables (0.10–0.25), suggesting little risk of severe
multicollinearity between FDI and the control variables in a later
regression. The strongest pairwise correlation is between internet use and
urban population (0.734), which is expected (urban areas typically have
denser digital infrastructure) and worth monitoring if both are included
together in the same regression model.
