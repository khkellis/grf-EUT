/*-------------------------------------------------------------------------------
  This file is part of generalized random forest (grf).

  grf is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  grf is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with grf. If not, see <http://www.gnu.org/licenses/>.
 #-------------------------------------------------------------------------------*/

#include "commons/utility.h"
#include "relabeling/EUTCARARelabelingStrategy.h"
#include "Rcpp.h"
#include <algorithm>

namespace grf {

  // Constructors. If no theta is specified, then use a default value "close" to log utility.
  EUTCARARelabelingStrategy::EUTCARARelabelingStrategy(){};

// Main relabeling function
bool EUTCARARelabelingStrategy::relabel(
    const std::vector<size_t>& samples,
    const Data& data,
    Eigen::ArrayXXd& responses_by_sample) const {

  double theta = calculateEquation4(samples, data);

  // Rcpp::Rcout << "The final value of theta is " << theta << "\n";

  double A_P = calculateEquation7(samples, data, theta);

  // Rcpp::Rcout << "The final value of A_P is " << A_P << "\n";

  std::vector<double> eq8_results = calculateEquation8(samples, data, A_P, theta);

  // Rcpp::Rcout << "The final values of rho are " << eq8_results << "\n";

  // Update responses_by_sample with results from Equation (8)
  for (size_t i = 0; i < samples.size(); ++i) {
      responses_by_sample(samples[i], 0) = eq8_results[i];
  }

  // Rcpp::Rcout << "The final labels are " << responses_by_sample << "\n";

  // Rcpp::Rcout << "The new labels are " << responses_by_sample << "\n";

  return false; // Or true if you encounter a condition to stop early
}

// Step 1: Calculate Equation (4)
double EUTCARARelabelingStrategy::calculateEquation4(
    const std::vector<size_t>& samples,
    const Data& data) const {

      // Define the objective function
      auto objectiveFunction = [&](double theta) {
        double loss = 0.0;
        for (size_t sample_idx : samples) {
            loss += score(sample_idx, data, theta);  // Sum the scores for each sample
        }
        return loss*loss; // squared loss to facilitate gradient-based optimization
      };

      // Define the derivative of the objective function with respect to theta
      auto objectiveDerivative = [&](double theta) {
        // Rcpp::Rcout << "The theta value at the start of objectiveDerivative is " << theta << "\n";
        double score_sum = 0.0;
        double score_deriv_sum = 0.0;
        for (size_t sample_idx : samples) {
            // Rcpp::Rcout << "The theta value within the loop of objectiveDerivative is " << theta << "\n";
            score_sum += score(sample_idx, data, theta);  // Sum the scores for each sample
            score_deriv_sum += score_deriv(sample_idx, data, theta); // Sum the derivatives for each sample
        }
        // Rcpp::Rcout << "score_sum is " << score_sum << "\n";
        // Rcpp::Rcout << "score_deriv_sum is " << score_deriv_sum << "\n";
        return 2*score_sum*score_deriv_sum;
      };



      // Optimization Setup
      double sqrt_theta = 0.24494897427;     // Initial guess
      double learning_rate = 0.03; // Adjust this value as needed
      double decay_rate = 0.9995;   // multiplicative learning rate decay
      int max_iterations = 5000;   // Maximum number of iterations
      double tolerance = 1e-7;     // Stopping criterion
      double eps = 3e-2;        // floor of theta values

      // Rcpp::Rcout << "The initial value of theta is " << sqrt_theta*sqrt_theta << "\n";

      double theta = sqrt_theta*sqrt_theta;

      // Gradient Descent
      for (int i = 0; i < max_iterations; ++i) {

        // Rcpp::Rcout << "index is " << i << "\n";


          double gradient = objectiveDerivative(theta); // Calculate the gradient of objectiveFunction w.r.t. theta_hat

          // Rcpp::Rcout << "Gradient is " << gradient << "\n";
          
          double theta = sqrt_theta*sqrt_theta;
          theta -= learning_rate * gradient; // Update theta_hat
          theta = std::max(theta, eps);
          learning_rate *= decay_rate;
          sqrt_theta = sqrt(theta);

          // Rcpp::Rcout << "The current value of sqrt_theta is " << sqrt_theta << "\n";

          // Rcpp::Rcout << "The current value of theta is " << sqrt_theta*sqrt_theta << "\n";

          // Check for convergence (optional)
          if (std::abs(gradient) < tolerance) {
              // Rcpp::Rcout << "Gradient has vanished to below tolerance of " << tolerance << "\n";
              break;
          }
      }

      

    double theta_hat = sqrt_theta*sqrt_theta;

    return theta_hat;
}

// Step 2: Calculate Equation (7)
double EUTCARARelabelingStrategy::calculateEquation7(
    const std::vector<size_t>& samples,
    const Data& data,
    const double theta_value) const {

      size_t num_samples = samples.size();

      double sum_val = 0.0;

      for (size_t sample : samples){
        sum_val += score_deriv(sample, data, theta_value);
      }

      double A_P = sum_val/num_samples;

    return A_P; // Replace with your actual calculation
}

// Step 3: Calculate Equation (8)
std::vector<double> EUTCARARelabelingStrategy::calculateEquation8(
    const std::vector<size_t>& samples,
    const Data& data,
    double equation7_result,
    double theta_value) const {

    std::vector<double> results;
    results.reserve(samples.size());  // Reserve space in advance

    // generate labels for each observation
    for (size_t sample_idx : samples) {
        double sample_score = score(sample_idx, data, theta_value);

        double result_for_sample = sample_score/equation7_result;

        results.push_back(result_for_sample); // Add the calculated result to the vector
    }

    return results;
}

// Auxiliary function: calculate the scoring function psi
double EUTCARARelabelingStrategy::score(
    const size_t sample_idx, const Data& data, const double theta_value) const {

    // Rcpp::Rcout << "The theta estimate at the start of score is " << theta_value << "\n";

  // ... (Calculate the loss for the given sample based on the data and responses)
  double high_price = data.get_high_price(sample_idx);
  double low_price = data.get_low_price(sample_idx);

  double demand = data.get_outcome(sample_idx);

  double numer = theta_value+low_price*log(low_price/high_price);
  double denom = 2*theta_value+(low_price-high_price)*log(low_price/high_price);

  double pred = std::min(numer/denom, 1.0);

  double loss = pred-demand;

  // Rcpp::Rcout << "The high_price is " << high_price << "\n";
  // Rcpp::Rcout << "The low_price is " << low_price << "\n";
  // Rcpp::Rcout << "The demand is " << demand << "\n";
  // Rcpp::Rcout << "The theta estimate is " << theta_value << "\n";
  // Rcpp::Rcout << "The score is " << loss << "\n";

  return loss;
}

// Auxiliary function: calculate the derivative of the scoring function psi
double EUTCARARelabelingStrategy::score_deriv(
    const size_t sample_idx, const Data& data, const double theta_value) const {

  // ... (Calculate the loss for the given sample based on the data and responses)
  double high_price = data.get_high_price(sample_idx);
  double low_price = data.get_low_price(sample_idx);

  double rate;

  if (log(high_price/low_price)+theta_value/high_price <= 0){
    rate = 0;
  } else{
    double numer = -(low_price+high_price)*log(low_price/high_price);
    double denom = (2*theta_value+(low_price-high_price)*log(low_price/high_price)) *
      (2*theta_value+(low_price-high_price)*log(low_price/high_price));

    rate = numer/denom;
  }

  

  // Rcpp::Rcout << "The high_price is " << high_price << "\n";
  // Rcpp::Rcout << "The low_price is " << low_price << "\n";
  // Rcpp::Rcout << "The theta estimate is " << theta_value << "\n";
  // Rcpp::Rcout << "The score_deriv is " << rate << "\n";

  return rate;
}

} // namespace grf