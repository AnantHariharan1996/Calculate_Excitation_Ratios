%% Excitation_Ratio_Calculation_Main
%% See the README file for instructions on 
%% how to format the input file containing input information

% Anant Hariharan, 2021

clear; close all; clc;
homedir = pwd; 
addpath(genpath(homedir))

%%%%%Solicit user inputs%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Setup_Calculation_Parameters_Flex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Preprocessing

%%%%%Do Actual Calculations%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if RayleighOrLove == 1
    Rayleigh_GetExcitationRatios_Flex
elseif RayleighOrLove == 0
    Love_GetExcitationRatios_Flex
end

%%%%%Visualize the Results%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if VisualizeMyResults
Visualize_Results
end
