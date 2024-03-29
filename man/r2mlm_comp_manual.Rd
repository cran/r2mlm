% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r2mlm_comp_manual.R
\name{r2mlm_comp_manual}
\alias{r2mlm_comp_manual}
\title{Compute R-squared differences between two multilevel models, manually
inputting parameter estimates.}
\usage{
r2mlm_comp_manual(
  data,
  within_covs_modA,
  between_covs_modA,
  random_covs_modA,
  gamma_w_modA,
  gamma_b_modA,
  Tau_modA,
  sigma2_modA,
  within_covs_modB,
  between_covs_modB,
  random_covs_modB,
  gamma_w_modB,
  gamma_b_modB,
  Tau_modB,
  sigma2_modB,
  bargraph = TRUE
)
}
\arguments{
\item{data}{Dataset with rows denoting observations and columns denoting
variables.}

\item{within_covs_modA, within_covs_modB}{List of numbers corresponding to the
columns in the dataset of the level-1 predictors used in the MLM (if none
used, set to NULL).}

\item{between_covs_modA, between_covs_modB}{List of numbers corresponding to
the columns in the dataset of the level-2 predictors used in the MLM (if
none used, set to NULL).}

\item{random_covs_modA, random_covs_modB}{List of numbers corresponding to the
columns in the dataset of the level-1 predictors that have random slopes in
the MLM (if no random slopes, set to NULL).}

\item{gamma_w_modA, gamma_w_modB}{Vector of fixed slope estimates for all
level-1 predictors, to be entered in the order of the predictors listed by
within_covs (if none, set to NULL).}

\item{gamma_b_modA, gamma_b_modB}{Vector of fixed intercept estimate (if
applicable; see has_intercept below) and fixed slope estimates for all
level-2 predictors, to be entered intercept first (if applicable) followed
by level-2 slopes in the order listed by between_covs (if none, set to
NULL).}

\item{Tau_modA, Tau_modB}{Random effect covariance matrix; note that the first
row/column denotes the intercept variance and covariances (if intercept is
fixed, set all to 0) and each subsequent row/column denotes a given random
slope’s variance and covariances (to be entered in the order listed by
random_covs).}

\item{sigma2_modA, sigma2_modB}{Level-1 residual variance.}

\item{bargraph}{Optional bar graph output, default is TRUE.}
}
\value{
If the inputs are valid models, then the output will be a list and
  associated graphical representation of R-squared decompositions.
}
\description{
\code{r2mlm_comp_manual} reads in raw data and multilevel model (MLM)
parameter estimates from two separate models under comparison (designated
Model A and Model B), and outputs all R-squared measures in the Rights and
Sterba (2019) framework for both models, as well as R-squared differences
between the two models. Definitions of these R-squared difference measures
are provided in Rights & Sterba (2020) Table 1; importantly, to detect the
impact of a specific kind of term (e.g., the kind of term added to Model A to
form Model B), a particular target single-source R-squared difference measure
from this framework is used. For instructions on how to identify which target
single-source R-squared difference measure to interpret to detect the impact
of which kind of term that distinguishes Model A from B, see Rights and
Sterba (2020) Table 2. Additionally, this function produces side-by-side
graphical comparisons of the R-squared measures for Model A vs. Model B that
can be used to visualize changes in each measure across models. This function
assumes all level-1 predictors are cluster-mean-centered for reasons
described in Rights & Sterba (2020). Any number of level-1 and/or level-2
predictors is supported and any of the level-1 predictors can have random
slopes. This function can be used with either the hierarchical or the
simultaneous model-building approach described in Rights and Sterba (2020).
This function can also be used with either nested or non-nested model
comparisons (in which R-squared estimates for Model A are subtracted from
those for Model B).
}
\examples{

# Model A: no "salary" components included

modelA <- lmer(satisfaction ~ 1 + control_c + control_m + s_t_ratio + (1 +
control_c | schoolID), data = teachsat, REML = TRUE, control =
lmerControl(optimizer = "bobyqa"))

# Model B: full model with "salary" components included

modelB <- lmer(satisfaction ~ 1 + salary_c + control_c + salary_m + control_m
+ s_t_ratio + (1 + salary_c + control_c | schoolID), data = teachsat, REML =
TRUE, control = lmerControl(optimizer = "bobyqa"))

r2mlm_comp_manual(data = teachsat,
                  within_covs_modA = c(4),
                  between_covs_modA = c(6, 8),
                  random_covs_modA = c(4),
                  gamma_w_modA = c(0.314410),
                  gamma_b_modA = c(6.892046, 0.059464, -0.037376),
                  Tau_modA = matrix(c(0.559, 0.0105, 0.0105, 0.0273),
                                    2, 2),
                  sigma2_modA = 1.19295,
                  within_covs_modB = c(5, 4),
                  between_covs_modB = c(7, 6, 8),
                  random_covs_modB = c(5, 4),
                  gamma_w_modB = c(0.074485, 0.310800),
                  gamma_b_modB = c(4.352652, 0.036759, 0.027532, -0.035250),
                  Tau_modB = matrix(c(0.387, 0.0000646, 0.00625,
                                      0.0000646, 0.00277, -0.000333,
                                      0.00625, -0.000333, 0.0285), 3, 3),
                 sigma2_modB = 0.550311)

}
\seealso{
Rights, J. D., & Sterba, S. K. (2019). Quantifying explained
  variance in multilevel models: An integrative framework for defining
  R-squared measures. Psychological Methods, 24(3), 309–338.
  <doi:10.1037/met0000184>

Rights, J. D., & Sterba, S. K. (2020). New recommendations on the
  use of R-squared differences in multilevel model comparisons. Multivariate
  Behavioral Research. <doi:10.1080/00273171.2019.1660605>

Other r2mlm model comparison functions: 
\code{\link{r2mlm_comp}()}
}
\concept{r2mlm model comparison functions}
