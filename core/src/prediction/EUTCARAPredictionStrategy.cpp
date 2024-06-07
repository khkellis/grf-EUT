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

#include <cmath>
#include <vector>
#include "commons/utility.h"
#include "commons/Data.h"
#include "prediction/EUTCARAPredictionStrategy.h"

namespace grf {

// basic constructor - parameter estimates get input using `weights_by_sample`
EUTCARAPredictionStrategy::EUTCARAPredictionStrategy() {}

size_t EUTCARAPredictionStrategy::prediction_length() const {
  return 1;
}


std::vector<double> EUTCARAPredictionStrategy::predict(
    size_t sample,
    const std::unordered_map<size_t, double>& weights_by_sample,
    const Data& train_data,
    const Data& data) const {

        double theta = determine_parameters(sample, weights_by_sample, train_data, data);

        double high_price = data.get_high_price(sample);
        double low_price = data.get_low_price(sample);

        double numer = theta+low_price*log(high_price/low_price);
        double denom = 2*theta+(low_price-high_price)*log(high_price/low_price);

        return {numer/denom};
}

std::vector<double> EUTCARAPredictionStrategy::compute_variance(
    size_t sample,
    const std::vector<std::vector<size_t>>& samples_by_tree,
    const std::unordered_map<size_t, double>& weights_by_sample,
    const Data& train_data,
    const Data& data,
    size_t ci_group_size) const {

        // input variance calculations here

        // for now, leave a dummy variance value of 1
        double variance = 1;

    return {variance};
}





    double EUTCARAPredictionStrategy::determine_parameters(size_t sample,
    const std::unordered_map<size_t, double>& weights_by_sample,
    const Data& train_data,
    const Data& data) const {

            double theta;

            // if theta already estimated for given alphas, parameter retrieval
            if (parameters.count(weights_by_sample)){
                theta = parameters[weights_by_sample];
            } else{
                // else if not yet estimated, then estimate using gradient descent

                // Define the derivative of the objective function with respect to theta
                auto objectiveDerivative = [&](double theta_hat) {
                    double score_sum = 0.0;
                    double score_deriv_sum = 0.0;
                    size_t num_nonzero_weights = weights_by_sample.size();

                    for (const auto& pair : weights_by_sample) {
                        size_t key = pair.first;
                        double weight = pair.second;

                        score_sum += weight*score(key, train_data, theta_hat);  // Sum the scores for each sample
                        score_deriv_sum += weight*score_deriv(key, train_data, theta_hat); // Sum the derivatives for each sample
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

                theta = theta_hat;
            }

            return theta;
    }


    // Auxiliary function: calculate the scoring function psi
    double EUTCARAPredictionStrategy::score(
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
    double EUTCARAPredictionStrategy::score_deriv(
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
