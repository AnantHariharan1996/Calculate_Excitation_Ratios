%% Write out CMT Input file;
clear; clc; 
CMTFolder = dir('CMT_MATFILES/*.mat');

for ijk = 1:length(CMTFolder)
    100*ijk/length(CMTFolder)
fname  = CMTFolder(ijk).name;
load(['CMT_MATFILES/' fname])
OUTPUT(ijk,1) = earthquake.Dep;
OUTPUT(ijk,2:7) = earthquake.M;
OUTPUT(ijk,8)=9999;
IDlist{ijk} = earthquake.EventName;
end
dlmwrite(['CMTCATALOG_ALL.txt'],OUTPUT,'delimiter','\t','precision','%.6f')
writecell(IDlist', 'IDlist_for_CMTCATALOG_ALL')