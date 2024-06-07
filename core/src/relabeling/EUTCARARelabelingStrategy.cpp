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

namespace grf {

  // Constructors. If no theta is specified, then use a default value "close" to log utility.
  EUTCARARelabelingStrategy::EUTCARARelabelingStrategy() : theta(0.06) {}
  EUTCARARelabelingStrategy::EUTCARARelabelingStrategy(double theta) : theta(theta) {}

// Main relabeling function
bool EUTCARARelabelingStrategy::relabel(
    const std::vector<size_t>& samples,
    const Data& data,
    Eigen::ArrayXXd& responses_by_sample) {

  calculateEquation4(samples, data);
  double A_P = calculateEquation7(samples, data);
  std::vector<double> eq8_results = calculateEquation8(samples, data, A_P);

  // Update responses_by_sample with results from Equation (8)
  for (size_t i = 0; i < samples.size(); ++i) {
      responses_by_sample(samples[i], 0) = eq8_results[i]; 
  }

  return false; // Or true if you encounter a condition to stop early
}

// Step 1: Calculate Equation (4)
double EUTCARARelabelingStrategy::calculateEquation4(
    const std::vector<size_t>& samples,
    const Data& data) {

      // Define the objective function
      auto objectiveFunction = [&](double theta_hat) {
        double loss = 0.0;
        for (size_t sample_idx : samples) {
            loss += score(sample_idx, data, theta_hat);  // Sum the scores for each sample
        }
        return loss*loss; // squared loss to facilitate gradient-based optimization
      };

      // Define the derivative of the objective function with respect to theta
      auto objectiveDerivative = [&](double theta_hat) {
        double score_sum = 0.0;
        double score_deriv_sum = 0.0;
        for (size_t sample_idx : samples) {
            score_sum += score(sample_idx, data, theta_hat);  // Sum the scores for each sample
            score_deriv_sum += score_deriv(sample_idx, data, theta_hat); // Sum the derivatives for each sample
        }
        return 2*score_sum*score_deriv_sum;
      };



      // Optimization Setup
      double theta_hat = 0.06;     // Initial guess
      double learning_rate = 0.01; // Adjust this value as needed
      int max_iterations = 100;   // Maximum number of iterations
      double tolerance = 1e-4 ;     // Stopping criterion

      // Gradient Descent
      for (int i = 0; i < max_iterations; ++i) {
          double gradient = objectiveDerivative(theta_hat); // Calculate the gradient of objectiveFunction w.r.t. theta_hat
          theta_hat -= learning_rate * gradient; // Update theta_hat

          // Check for convergence (optional)
          if (std::abs(gradient) < tolerance) {
              break;
          }
      }

    this->theta = theta_hat; // Store the estimated theta_hat value
}

// Step 2: Calculate Equation (7)
double EUTCARARelabelingStrategy::calculateEquation7(
    const std::vector<size_t>& samples,
    const Data& data) const {

      size_t num_samples = samples.size();

      double theta_value = this->theta;

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
    double equation7_result) const {

    std::vector<double> results;
    results.reserve(samples.size());  // Reserve space in advance

    // generate labels for each observation
    for (size_t sample_idx : samples) {
        double theta_value = this->theta;
        double sample_score = score(sample_idx, data, theta_value);

        double result_for_sample = sample_score/equation7_result;

        results.push_back(result_for_sample); // Add the calculated result to the vector
    }

    return results;
}

// Auxiliary function: calculate the scoring function psi
double EUTCARARelabelingStrategy::score(
    const size_t sample_idx, const Data& data, const size_t theta_value) const {

  // ... (Calculate the loss for the given sample based on the data and responses)
  double high_price = data.get_high_price(sample_idx);
  double low_price = data.get_low_price(sample_idx);

  double demand = data.get_outcome(sample_idx);

  double numer = theta_value+low_price*log(high_price/low_price);
  double denom = 2*theta_value+(low_price-high_price)*log(high_price/low_price);

  double loss = numer/denom-demand;

  return loss;
}

// Auxiliary function: calculate the derivative of the scoring function psi
double EUTCARARelabelingStrategy::score_deriv(
    const size_t sample_idx, const Data& data, const size_t theta_value) const {

  // ... (Calculate the loss for the given sample based on the data and responses)
  double high_price = data.get_high_price(sample_idx);
  double low_price = data.get_low_price(sample_idx);

  double demand = data.get_outcome(sample_idx);

  double numer = -(low_price+high_price)*log(high_price/low_price);
  double denom = (2*theta_value+(low_price-high_price)*log(low_price/high_price)) *
    (2*theta_value+(low_price-high_price)*log(low_price/high_price));

  double rate = numer/denom-demand;

  return rate;
}

} // namespace grf