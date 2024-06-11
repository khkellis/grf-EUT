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

#ifndef GRF_EUTCARARELABELINGSTRATEGY_H
#define GRF_EUTCARARELABELINGSTRATEGY_H

#include <vector>

#include "commons/Data.h"
#include "relabeling/RelabelingStrategy.h"
#include "tree/Tree.h"

namespace grf {

class EUTCARARelabelingStrategy final : public RelabelingStrategy {
public:
  // Constructors (if needed)
  EUTCARARelabelingStrategy();
  EUTCARARelabelingStrategy(double theta);

  // Main relabeling function (calls the three steps)
  bool relabel(const std::vector<size_t>& samples,
               const Data& data,
               Eigen::ArrayXXd& responses_by_sample) const;

private:
  // Step 1: Calculate Equation (4)
  double calculateEquation4(const std::vector<size_t>& samples, const Data& data) const;

  // Step 2: Calculate Equation (7)
  double calculateEquation7(const std::vector<size_t>& samples, 
                            const Data& data,
                            const double theta_value) const;

  // Step 3: Calculate Equation (8)
  std::vector<double> calculateEquation8(
      const std::vector<size_t>& samples,
      const Data& data,
      double equation7_result,
      const double theta_value
  ) const;

  // Any other private helper functions or member variables you might need

  // Auxiliary function to calculate psi
  double score(const size_t sample_idx,  // Index of the sample to score
               const Data& data, const double theta_value) const;

  // Auxiliary function to calculate the derivative of psi
  double score_deriv(const size_t sample_idx, // Index of the sample to score
                     const Data& data, const double theta_value) const;

  DISALLOW_COPY_AND_ASSIGN(EUTCARARelabelingStrategy);
};

} // namespace grf

#endif // GRF_EUTCARARELABELINGSTRATEGY_H



