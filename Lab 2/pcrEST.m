function [ pcr ] = pcrEST(F0,data_train_norm,data_test_norm,L,nbins,pcr)
y_train=data_train_norm(:,F0);       % measured data on feature F0
y_test=data_test_norm(:,F0);         % measured data on feature F0
X_train=data_train_norm; X_train(:,F0)=[]; % feature F0 is eliminated
X_test=data_test_norm;X_test(:,F0)=[];     % feature F0 is eliminated


%% Regression

% Set up base change
[N,F]=size(X_train);
%L=F;
RX_train=X_train'*X_train/N;
[U,Lambda] = eig(RX_train);

Z_train=X_train*U; % Carry over, not needed?

LambdaL=Lambda(end+1-L:end,end+1-L:end);
UL=U(:,end+1-L:end);

% Calculate Weights
w_train=(UL/LambdaL)*UL'*X_train'*y_train/N; % PCR weigths for training
yhat_train=X_train*w_train;  % PCR estimate for training
yhat_test=X_test*w_train;    % PCR wights for training are used for testing

error_train=y_train-yhat_train;
error_test=y_test-yhat_test;

corr_mat=corr(Z_train);

corrtrain_pcr=corr2(y_train,yhat_train);
corrtest_pcr=corr2(y_test,yhat_test);


% Computer Accuracy
accuracy_train=mean(abs(y_train-yhat_train).^2)/mean(abs(y_train).^2);
accuracy_test=mean(abs(y_test-yhat_test).^2)/mean(abs(y_test).^2);



%% Store in structure
pcrT.type= 'PCR';
pcrT.nbins = nbins;
 
pcrT.y.train= y_train;
pcrT.y.test= y_test;
pcrT.x.train= X_train;
pcrT.x.test= X_test;

pcrT.z.train= Z_train;
pcrT.rx.train= RX_train;
 
pcrT.yhat.train= yhat_train;
pcrT.yhat.test= yhat_test;
pcrT.w= w_train; 
%pcrT.w_ordered= w_ordered;
 
pcrT.error.train= error_train;
pcrT.error.test= error_test;
 
pcrT.corr.train= corrtrain_pcr;
pcrT.corr.test= corrtest_pcr;
pcrT.corr.mat= corr_mat;
 
pcrT.acc.train= accuracy_train;
pcrT.acc.test= accuracy_test;
 
pcrT.F0= F0;
 
pcr=[pcr pcrT];

end

