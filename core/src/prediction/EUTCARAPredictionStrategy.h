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

#ifndef GRF_EUTCARAPREDICTIONSTRATEGY_H
#define GRF_EUTCARAPREDICTIONSTRATEGY_H


#include <cstddef>
#include <unordered_map>
#include "Eigen/Dense"
#include "commons/Data.h"
#include "prediction/Prediction.h"
#include "prediction/DefaultPredictionStrategy.h"
#include "prediction/PredictionValues.h"
#include "ObjectiveBayesDebiaser.h"
#include <functional>
#include <random>

namespace grf {

struct VectorHash {
    std::size_t operator()(const std::vector<unsigned long>& vec) const {
        std::hash<unsigned long> hasher; // Standard hasher for unsigned long
        std::size_t seed = 0; 

        // Use a random number generator for seed variation (optional)
        std::random_device rd;
        std::mt19937 gen(rd()); 
        std::uniform_int_distribution<std::size_t> dis;
        seed = dis(gen);

        for (const auto& val : vec) {
            seed ^= hasher(val) + 0x9e3779b9 + (seed << 6) + (seed >> 2); 
        }
        return seed;
    }
};

class EUTCARAPredictionStrategy final: public DefaultPredictionStrategy {

public:
    EUTCARAPredictionStrategy();

    size_t prediction_length() const;

    /**
    * EUTCARAPredictionStrategy::predict computes relative CARA demand.
    */
    std::vector<double> predict(size_t sample,
                                const std::unordered_map<size_t, double>& weights_by_sample,
                                const Data& train_data,
                                const Data& data) const;

    std::vector<double> compute_variance(
        size_t sample,
        const std::vector<std::vector<size_t>>& samples_by_tree,
        const std::unordered_map<size_t, double>& weights_by_sample,
        const Data& train_data,
        const Data& data,
        size_t ci_group_size) const;

private:
    mutable std::unordered_map<std::vector<unsigned long>, double, VectorHash> parameters;

    // Check if theta for a given weights_by_sample has been calculated - if so, then reuse
    double determine_parameters(size_t sample,
                                const std::unordered_map<size_t, double>& weights_by_sample,
                                const Data& train_data,
                                const Data& data) const;

    // Auxiliary function to calculate psi
    double score(const size_t sample_idx,  // Index of the sample to score
                const Data& data, const double theta_value) const;

    // Auxiliary function to calculate the derivative of psi
    double score_deriv(const size_t sample_idx, // Index of the sample to score
                        const Data& data, const double theta_value) const;
};

} // namespace grf

#endif // GRF_EUTCARAPREDICTIONSTRATEGY_H



