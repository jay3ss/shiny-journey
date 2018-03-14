close all
clear all

load(fullfile('..', 'data', 'deathData.mat'));
z = deadData;    % data matrix
[rows, cols] = size(z);            % number of rows and columns

% Separate training and test data
num_train=45;
train_data = deadData(1:num_train,:);
test_data = deadData(num_train+1:rows,:);

% Normalize the data
train_data_norm = normalize(train_data);
test_data_norm = normalize(test_data);

% Find correlation
RX_train = train_data_norm'*train_data_norm/rows;

% Find eigenvectors
[U, lambdas] = eig(RX_train);

% Process data
feature_col = 17;
[train_data_norm, train_feature] = process_data(train_data, feature_col);
[test_data_norm, test_feature] = process_data(test_data, feature_col);


%
% MMSE regression
%
nbins=50; % number of bins for histogram
eps_g=0.00001; % stopping criterion for gradient algorithm
gamma_g=0.0001; % step for gradient algorithm
eps_s=0.00001; % stopping criterion for steepest descent algorithm
M=10000; % maximum number of optimization steps
index=[7 5];
%
for ind=1:2
    F0=index(ind);
    y_train=data_train_norm(:,F0);       % measured data on feature F0
    y_test=data_test_norm(:,F0);         % measured data on feature F0
    X_train=data_train_norm; X_train(:,F0)=[]; % feature F0 is eliminated
    X_test=data_test_norm; X_test(:,F0)=[];    % feature F0 is eliminated
    % MMSE estimate--------------------------------------------------------
    w_train=(X_train'*X_train)\(X_train')*y_train; % MMSE weigths for training
    w_mmse_train=w_train;
    [yhat_train,yhat_test] = plotting(w_train,X_train,X_test,y_train,y_test,nbins);    
    % msv of error---------------------------------------------------------
    msv_train(1,ind)=mean(abs(y_train-yhat_train).^2);
    msv_test(1,ind)=mean(abs(y_test-yhat_test).^2);
    % gradient estimate----------------------------------------------------
    [w_train] = gradient_algorithm(X_train,y_train,eps_g,gamma_g,M); % gradient weigths for training
    w_grad_train=w_train;
    [yhat_train,yhat_test] = plotting(w_train,X_train,X_test,y_train,y_test,nbins);    
    % msv of error---------------------------------------------------------
    msv_train(2,ind)=mean(abs(y_train-yhat_train).^2);
    msv_test(2,ind)=mean(abs(y_test-yhat_test).^2);
    % steepest descent estimate----------------------------------------------------
    [w_train] = steepest_algorithm(X_train,y_train,eps_s,M); % gradient weigths for training
    w_step_train=w_train;
    [yhat_train,yhat_test] = plotting(w_train,X_train,X_test,y_train,y_test,nbins);    % msv of error---------------------------------------------------------
    % msv of error---------------------------------------------------------
    msv_train(3,ind)=mean(abs(y_train-yhat_train).^2);
    msv_test(3,ind)=mean(abs(y_test-yhat_test).^2);
    % plot of weights------------------------------------------------------
    figure
    stem(w_mmse_train,'r');
    grid on
    hold on
    stem(w_grad_train,'g');
    stem(w_step_train,'k');
    legend('mmse','gradient','steepest');
    title(' w ');
    hold off
  
end


figure
plot(msv_train(:,1),'-or');
hold on
plot(msv_test(:,1),'-ok');
plot(msv_train(:,2),'-sr');
plot(msv_test(:,2),'-sk');
grid on
legend('training 7','testing 7','training 5','testing 5');
title(' msv of error F0=5,7');
% Comment: different w lead to similar perfromance: there are multiple solutions

figure
plot(data_train_norm(:,22),data_train_norm(:,7),'.');
grid on
xlabel('feature 22');
ylabel('feature 7');

figure
plot(data_train_norm(:,9),data_train_norm(:,7),'.');
grid on
xlabel('feature 9');
ylabel('feature 7');
% Comment: not always the relationship among the features is linear

% correlation between feature 7 and the other features
corr7=corr(data_train_norm(:,7),data_train_norm);
figure
plot(corr7)
grid on
% Comment: certain features are very correlated
% the existence of multiple solution is due to correlation among features

% autocorrelation matrix
corr_mat=corr(data_train_norm)

figure
mesh(corr_mat)
grid on
title('correlation matrix');

% PCA: Principal Component Analysis
[corr_mat] = pca_fun(F0,data_train_norm,data_test_norm);