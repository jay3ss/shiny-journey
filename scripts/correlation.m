function [corr_mat, feature_corr] = correlation(data, feature_col)
% this function performs PCR based regression of the feature F0 using the 
% features of data_train_norm and uses the regression weights to estimate
% the feature F0 of data_test_norm. Evaluates accuracy and visualized
% histogram of estimation error. The L main featuuress are considered.
% 
% F0: index of estimated feature
% nbins: number of bins used in histogram
% data_train_norm: prepared and normalized data for training
% data_test_norm: prepared and normalized data for testing
[rows, cols] = size(data);
RX = data'*data/rows; 
[U,lambda] = eig(RX);
z = data*U;
z_feature = z(:, feature_col);
z(:, feature_col) = [];

% correlation between feature 7 and the other features in the new basis
feature_corr = corr(z_feature,z);
corr_mat = corr(z); % autocorrelation matrix
