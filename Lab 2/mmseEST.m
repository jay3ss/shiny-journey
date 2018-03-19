function [ mmse ] = mmseEST(F0,data_train_norm,data_test_norm,nbins,mmse)
y_train=data_train_norm(:,F0);       % measured data on feature F0
y_test=data_test_norm(:,F0);         % measured data on feature F0
X_train=data_train_norm; X_train(:,F0)=[]; % feature F0 is eliminated
X_test=data_test_norm;X_test(:,F0)=[];     % feature F0 is eliminated


%% Regression
w_mmse=inv(X_train'*X_train)*(X_train')*y_train; % MMSE weigths for training
yhat_train=X_train*w_mmse;  % MMSE estimate for training
yhat_test=X_test*w_mmse;    % MMSE wights for training are used for testing


% Reorder


% Should implement visualization
% Need to test ploting types

if F0<22
   w_ordered=[w_mmse(1:F0)' 0 w_mmse(F0+1:end)'];
else
   w_ordered=[w_mmse(1:F0-1)' 0];
end    

%Compute Error
error_train=y_train-yhat_train;
error_test=y_test-yhat_test;

%Compute Corrolation 
corrtrain_mmse=corr2(y_train,yhat_train);
corrtest_mmse=corr2(y_test,yhat_test);

% Compute Accuracy
accuracy_train=mean(abs(y_train-yhat_train).^2)/mean(abs(y_train).^2);
accuracy_test=mean(abs(y_test-yhat_test).^2)/mean(abs(y_test).^2);


%% Store in structure
mmseT.type= 'MMSE';
mmseT.nbins = nbins;

mmseT.y.train= y_train;
mmseT.y.test= y_test;
mmseT.x.train= X_train;
mmseT.x.test= X_test;

mmseT.yhat.train= yhat_train;
mmseT.yhat.test= yhat_test;
mmseT.w= w_mmse; 
mmseT.w_ordered= w_ordered;

mmseT.error.train= error_train;
mmseT.error.test= error_test;

mmseT.corr.train= corrtrain_mmse;
mmseT.corr.test= corrtest_mmse;

mmseT.acc.train= accuracy_train;
mmseT.acc.test= accuracy_test;

mmseT.F0= F0;

mmse=[mmse mmseT];



end

