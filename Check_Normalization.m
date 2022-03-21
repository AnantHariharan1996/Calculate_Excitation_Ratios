%%% Verify normalization of the eigenfunctions that are spit out by mineos
%

clear; 
clc; close all;

addpath(genpath(pwd))

   rn = 6371000;
    bigg = 6.6723e-11; % m/kg/s2
    rhobar = 5515; % kg/m3
    scale = 1/(rn*sqrt(rn*pi*bigg)*rhobar);

EigInfo = load('T_B9_75s')

W=EigInfo(:,2);
Wderiv=EigInfo(:,3);
r=EigInfo(:,1);    

period = 75;

% get density here

% scale = 1/(rn*sqrt(rn*pi*bigg)*rhobar)
% such that 
% 1 = trapz(r , rho.*(U.^2+V.^2).*r.^2 ) * omega^2;
% 1 = trapz(r , rho.*(W.^2     ).*r.^2 ) * omega^2;


    