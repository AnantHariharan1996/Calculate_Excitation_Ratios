%%% Verify normalization of the eigenfunctions that we are using in this
%%% calculation

clear; clc; close all;
addpath(genpath(pwd))

%% Setup parameters to isolate which eigenfunctions do you want to check
Periodlist = [50 75 100 ]; RayleighOrLove= 1;
% Which velocity model do you want to use? Choices: ATL2a, PREM...
Velmod = 'TAYAK';
% Which overtones to consider in this calculation
Nstocheck = [0:1];

%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% only edit code above this line
Fail_List_N = [];
Fail_List_Period = [];

if RayleighOrLove
modename = 'spheroidal';
else
modename = 'toroidal';
end
%Load_Density
[radius,rho,vsv,vsh,vpv,vph,qmu,qkappa,eta] = load_model(Velmod);

[unique_rads,uniquedx] = unique(radius);
radius=radius(uniquedx);
density=rho(uniquedx);

Eigmatname = [Velmod '_' modename '_eigfxns_array.mat'];
Eiglookupname = [Velmod '_' modename '_TCUNL_Lookup.mat'];

load(Eigmatname)
load(Eiglookupname)
Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);
N = Lookuptable(4,:);
L = Lookuptable(5,:);

for currN = Nstocheck
    % first check for existence of eigenfunctions
    currdx = find(N == currN);
    tmpperiodlist = Periods(currdx);
    if min(tmpperiodlist) > min(Periodlist) || max(tmpperiodlist) < max(Periodlist)
    error(['ERROR: eigenfunctions do not span the period of interest for n=' num2str(currN) '. Use periods to be between ' num2str(max(tmpperiodlist)) ' and ' num2str(min(tmpperiodlist)) 's for n = ' num2str(currN)])        
    end
    %
    %Get relevant subset of lookup table
    currdx = find(N == currN);
    Tlist = Periods(currdx);
    for period = Periodlist
        Tdiff = abs(Tlist-period);
        [mindiff,cdx]=min(Tdiff);
        BestPeriod = Tlist(cdx);
        
        full_dx_match = find(N == currN & Periods == BestPeriod);
        tmpinfo = Eigmat(:,:,full_dx_match);

        if RayleighOrLove == 1
            U=tmpinfo(:,2);
            Uderiv=tmpinfo(:,3);
            V=tmpinfo(:,4);
            Vderiv=tmpinfo(:,5);
            r=tmpinfo(:,1);   
        elseif RayleighOrLove == 0
            W=tmpinfo(:,2);
            Wderiv=tmpinfo(:,3);
            r=tmpinfo(:,1);    
        end
        
        omega = 2*pi/BestPeriod;
        
        % interpolate density onto eigenfunction coords
        Density_Interped = interp1(radius,density,r);
        if RayleighOrLove == 1
            % perform integral for Spheroidal or Toroidal eigenfunctions. 
            val = trapz(r , Density_Interped.*(U.^2+V.^2).*r.^2 ) * omega^2;
        elseif RayleighOrLove == 0
            val = trapz(r , Density_Interped.*(W.^2).*r.^2 ) * omega^2;
        end      
        
        disp(['Integral for n = '  num2str(currN) ' and period = ' num2str(BestPeriod) 's :' num2str(val)])
        if abs(val-1) > 0.1
            Fail_List_N = [Fail_List_N currN];
            Fail_List_Period =[Fail_List_Period BestPeriod];
        end
    end
end
    
if length(Fail_List_N) > 0
disp(' ')
disp('Some eigenfunctions do not meet normalization requirement.')
for ijk = 1:length(Fail_List_N)
    disp(['N = ' num2str(Fail_List_N(ijk)) ',T = ' num2str(Fail_List_Period(ijk)) ' Failed.'])

end
else
disp(' ')
disp('All eigenfunctions you have inspected meet the normalization requirement!')

end