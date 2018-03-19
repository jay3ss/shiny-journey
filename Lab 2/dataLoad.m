function [data] =  dataLoad()

% To faciliate script usage clean up and data verification is performed.
% Given that the data is not always stored, a quick check is performed
% incase it must be reimported.

findData = exist('updrs.mat');
if(findData ~=2)
    importStruct=importdata('parkinsons_updrs.data',',',1);
    parkinsonsupdrs = importStruct.data;
    save('updrs.mat','parkinsonsupdrs');
end
load('updrs.mat')
data=parkinsonsupdrs; 


end