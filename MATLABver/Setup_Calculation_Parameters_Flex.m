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
RayleighOrLove = 1;

% Enter the list of periods you want to use here
% This vector can even be just a 1x1 scalar or a vector
% e.g. Periodlist = [50 75 100 125];
Periodlist = [100 250 500];

% Output excitation at all frequencies on an earthquake-by-earthquake
% basis? Set to 1 if you want this option used.
Output_As_Spectra = 0;

% How many overtones should we be considering in the calculation?
% Set this to 0 for only the fundamental mode, and set to mode number N if
% you want higher modes up to that number N. 
MaxN = 0;

% Are we interested in minor or major-arc overtone interference?
% Set the variable to 1 for major, 0 for minor
MinorOrMajor = 0;

%Enter the input file name here in quotes (' '). It must be on your path.
Inputfilename = 'Mw72_19920425.txt';

% Visualize the Results? This is only really useful when thinking about excitation ratios.
VisualizeMyResults = 0;

% Which velocity model do you want to use?
% choices are 'atl2a','STW105C','prem','TAYAK'..
Velmod = 'atl2a';

% Output source phase or source amplitude? 0 for amplitude, 1 for phase. 
ExcitationOrPhase = 0;

%%%%%%%%%%%
%%%%%%%%%%%
addpath(genpath(Eigpath))
addpath(genpath(pwd))
