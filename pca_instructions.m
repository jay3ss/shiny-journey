
[N,F]=size(X_train);
L=F;                          % number of features I am keeping
RX_train=X_train'*X_train/N;  % autocorrelation of X
[U,Lambda] = eig(RX_train);   % matrix decomposition
Z_train=X_train*U;            % modified features
LambdaL=Lambda(end+1-L:end,end+1-L:end);
UL=U(:,end+1-L:end);
w_train=(UL/LambdaL)*UL'*X_train'*y_train/N; % PCA weigths for training
yhat_train=X_train*w_train;  % PCA estimate for training
yhat_test=X_test*w_train;    % PCA wights for training are used for testing


