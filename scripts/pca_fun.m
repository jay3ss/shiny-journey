function [corr_mat] = pca_fun(F0,data_train_norm,data_test_norm)
% this function performs PCR based regression of the feature F0 using the 
% features of data_train_norm and uses the regression weights to estimate
% the feature F0 of data_test_norm. Evaluates accuracy and visualized
% histogram of estimation error. The L main featuuress are considered.
% 
% F0: index of estimated feature
% nbins: number of bins used in histogram
% data_train_norm: prepared and normalized data for training
% data_test_norm: prepared and normalized data for testing
[N,F]=size(data_train_norm);
RX_train=data_train_norm'*data_train_norm/N;
[U,Lambda] = eig(RX_train);
Z_train=data_train_norm*U;
Zx_train=Z_train;
Zx_train(:,F0)=[];
y_train=Z_train(:,F0);               % measured data on feature F0
Z_test=data_test_norm*U;
Zx_test=Z_test;
Zx_test(:,F0)=[];
y_test=Z_test(:,F0);             % measured data on feature F0y_test=data_test_norm(:,F0);         % measured data on feature F0

% correlation between feature 7 and the other features in the new basis
corr7=corr(Z_train(:,7),Z_train);
figure
plot(corr7)
grid on

% autocorrelation matrix
corr_mat=corr(Z_train)

figure
mesh(corr_mat)
grid on
title('correlation matrix');
