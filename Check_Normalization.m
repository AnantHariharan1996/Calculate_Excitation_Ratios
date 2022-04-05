%%% Verify normalization of the eigenfunctions that are spit out by mineos
%

clear; 
clc; close all;

addpath(genpath(pwd))

Load_Density
Eigfname = 'S_B0_50s';
tmpinfo=load(Eigfname);
U=tmpinfo(:,2);
Uderiv=tmpinfo(:,3);
V=tmpinfo(:,4);
Vderiv=tmpinfo(:,5);
r=tmpinfo(:,1);    

period = 50;
omega = 2*pi/period;

% interpolate density onto eigenfunction coords
Density_Interped = interp1(PREM_REF_Radius_meters,PREM_REF_Density,r);
val = trapz(r , Density_Interped.*(U.^2+V.^2).*r.^2 ) * omega^2;


    