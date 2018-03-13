function [deadData] =  dataLoad()

% function to check data exists, import if missing, and load data

findData = exist('deathData.mat');

if(findData ~=2)
    deadData=importdata('death_rate.txt',' ');
    save('deathData.mat','deadData');
end

load('deathData.mat');

end