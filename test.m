clear;
data = dataLoad;
sz = size(data);
cols = sz(2);     % number of features actually
Rx = data'*data / cols; % Find the covariance 
