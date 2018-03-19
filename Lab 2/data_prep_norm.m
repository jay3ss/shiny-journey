function [ Ntimes,w_prep, data_train_norm, data_test_norm ] = data_prep_norm( ntrain,Npatients,z )
% This function prepared and normalizes the data initially contained in z
%  ntrain: number of patients used for training
%  Npateints: total number of patients
%  z: data matrix
%  Ntimes: number of data collected for each patient
% w_prep: prepared data
%  data_train_norm: normalized data used for training
%  data_test_norm: normalized data used for testing
%
Ntimes=zeros(1,Npatients); % number of considered test times for each subject
z_prep=zeros(size(z));        % empty matrix
for npat=1:Npatients
    ind=find(z(:,1)==npat);    % row indices for subject npat
    npat_rows=z(ind,:);         % rows for subjects npat
    time1(1)=npat_rows(3,4); % first test time for subject npat
    for i1=2:size(ind)
     if any((abs(npat_rows(i1,4)-time1))<0.5) 
     else  % if the test time is not in the vector time1
         time1=[time1 npat_rows(i1,4)];  % we add that time
     end
    end
    time=sort(time1); % set of ordered test_times for subject npat
    clear time1          % time1 is cleared for next subject
    IT=length(time);  % number of test times for subject npat
    Ntimes(npat)=IT;
     for i2=1:IT
     ind_t=find(abs(npat_rows(:,4)-time(i2))<0.5);
     index=i2+sum(Ntimes)-IT;
     z_prep(index,:)=mean(npat_rows(ind_t,:));
     end
end
w_prep=z_prep(1:index,:); % prepared data
% size(w_prep);
ntest=Npatients-ntrain;
Nrows_train=sum(Ntimes(1:ntrain));
Nrows_test=sum(Ntimes(ntrain+1:end));
data_train=w_prep(1:Nrows_train,:);          % training data
data_test =w_prep(Nrows_train+1:end,:);  % test data
%
% data normalization
%
m_data_train=ones(Nrows_train,1)*mean(data_train,1); % mean value
data_train_norm=data_train-m_data_train; % zero mean value

v_data_train=ones(Nrows_train,1)*var(data_train,1); % variance
data_train_norm=data_train_norm./sqrt(v_data_train);   % unit variance 
avg_m_data_train=mean(mean(data_train_norm,1));
ang_v_data_train=mean(var(data_train_norm,1));

v_data_test=ones(Nrows_test,1)*var(data_test,1); % variance
m_data_test=ones(Nrows_test,1)*mean(data_test,1); % mean value
data_test_norm=data_test-m_data_test; % zero mean value
data_test_norm=data_test_norm./sqrt(v_data_test); % unit variance 
avg_m_data_test=mean(mean(data_test_norm,1));
avg_v_data_test=mean(var(data_test_norm,1));
end

