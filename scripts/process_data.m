function [train_data, feature] = process_data(data, feature_col)
% normalizes the data, extracts the feature, and returns the feature and
% the normalized set with the feature removed
  train_data = normalize(data);
  feature = train_data(:, feature_col);
  train_data(:, feature_col) = [];
end

