%% Edit Parameters below here, in this file only
%%
clear; close all; clc;
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Edit Parameters below here
addpath(genpath(pwd))
% Are we interested in Rayleigh or Love wave overtone interference?
% Set the variable to 1 for Rayleigh, 0 for Love
RayleighOrLove = 0;

% Enter the list of periods you want to use here
% This vector can even be just a 1x1 scalar or a vector
% e.g. Periodlist = [50 75 100 125];
Periodlist = [50];

% How many overtones should we be considering in the calculation?
MaxN = 1;

% Are we interested in minor or major-arc overtone interference?
% Set the variable to 1 for major, 0 for minor
MinorOrMajor = 0;

%Enter the input file name here in quotes (' '). It must be on your path.
Inputfilename = 'StrikeSlip_Fault.txt';

% Visualize the Results? This is only really useful when thinking about excitation ratios.
VisualizeMyResults = 1;


%%%%%%%%%%%%%%%% Edit Parameters above here


% Check that this works at all periods and overtones
for ijk = 1:length(Periodlist)
    Period=Periodlist(ijk);
    for n = 0:MaxN
        if RayleighOrLove == 1
       eigfname=['S_B' num2str(n) '_' num2str(Period) 's']; 
        elseif RayleighOrLove == 0
       eigfname=['T_B' num2str(n) '_' num2str(Period) 's']; 
        
        end
        
        %check existence of file
       if exist(eigfname,'file') ~= 2
           disp(['The Eigenfunction ' eigfname ', for mode ' num2str(n) ' at ' num2str(Period) 's does not exist.'])
            error('Error: Eigenfunction you want has not been calculated at this period. Use different periods or different modes.')
        end 
        
    end
end

clear Period


%%%%%%%%%%%%%%%% Edit Parameters above here

% Load info about source parameters here, from the input file
EventInfo = load(Inputfilename);
Depthlist = EventInfo(:,1); % in KM
Mrrlist = EventInfo(:,2);
Mttlist = EventInfo(:,3); Mpplist = EventInfo(:,4);
Mrtlist = EventInfo(:,5); Mrplist = EventInfo(:,6);
Mtplist = EventInfo(:,7); 

Azimuthlist = EventInfo(:,8); % in degrees. 
% If the Azimuth is set to 9999, we just use the maximum of the
% radiation pattern

