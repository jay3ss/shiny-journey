function [train_data, feature] = process_data(data, feature_col,feat_delete)
% normalizes the data, extracts the feature, and returns the feature and
% the normalized set with the feature removed
  train_data = normalize(data);
  feature = train_data(:, feature_col);
  
% feature reduction 
 train_data(:, feat_delete) = [];
  
  %train_data(:, feature_col) = [];
end

