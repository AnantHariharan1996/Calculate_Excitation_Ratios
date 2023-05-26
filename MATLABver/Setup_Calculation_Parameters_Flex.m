 %% Edit Parameters below here, in this file only
%%
clear; close all; clc;
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Edit Parameters below here
addpath(genpath(pwd))

% Enter the path to the eigenfunction files
Eigpath = '/Users/ananthariharan/Github/Calculate_Excitation_Ratios';

% Are we interested in Rayleigh or Love wave overtone interference?
% Set the variable to 1 for Rayleigh, 0 for Love
RayleighOrLove = 0;

% Enter the list of periods you want to use here
% This vector can even be just a 1x1 scalar or a vector
% e.g. Periodlist = [50 75 100 125];
Periodlist = [10:10:50];

% How many overtones should we be considering in the calculation?
MaxN = 0;

% Are we interested in minor or major-arc overtone interference?
% Set the variable to 1 for major, 0 for minor
MinorOrMajor = 0;

%Enter the input file name here in quotes (' '). It must be on your path.
Inputfilename = 'DipSlip_Fault.txt';

% Visualize the Results? This is only really useful when thinking about excitation ratios.
VisualizeMyResults = 0;

% Which velocity model do you want to use?
% choices are ATL2a, PREM...
Velmod = 'atl2a';

% Output excitation at all frequencies on an earthquake-by-earthquake
% basis?
Output_As_Spectra = 0;

% Output source phase or source excitation? 0 for Excitation, 1 for phase. 
ExcitationOrPhase = 0;

%%%%%%%%%%%
%%%%%%%%%%%
addpath(genpath(Eigpath))
addpath(genpath(pwd))
