%% Visualize Eigenfunctions
clear; clc; close all;
% Plot eigenfunctions for a specific mode number and approximate period, for either
% Rayleigh or Love waves

%% Setup parameters here
Periods2Find = [50 75];
ModeNumbers2Find = [1 1];

% Are we interested in Rayleigh or Love waves (spheroidal or toroidal)?
% Set the variable to 1 for Rayleigh, 0 for Love
RayleighOrLove = 0;

% Which velocity model do you want to use?
% choices are ATL2a, PREM...
Velmod = 'TAYAK';

% Y-axis range in km
yaxisrange = [0 1000]
%%%%%%% Do not edit anything below this line %%%%%%%%
if RayleighOrLove
modename = 'spheroidal';
else
modename = 'toroidal';
end
[radius,rho,vsv,vsh,vpv,vph,qmu,qkappa,eta] = load_model(Velmod);
Body_Radius2use = max(radius)./1000;

Eigmatname = [Velmod '_' modename '_eigfxns_array.mat'];
Eiglookupname = [Velmod '_' modename '_TCUNL_Lookup.mat'];

load(Eigmatname)
load(Eiglookupname)
Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);
N = Lookuptable(4,:);
L = Lookuptable(5,:);

% do plotting 
for ijk = 1:length(Periods2Find)
    
        currperiod = Periods2Find(ijk);
        currN = ModeNumbers2Find(ijk);
        currdx= find(N == currN);
        lsatN = L(currdx);
        periodsatN = Periods(currdx);
        diff = abs(periodsatN - currperiod);
        [mindiff,mindx]=min(diff);
        BestPeriod = periodsatN(mindx);
        BestL = lsatN(mindx);
        full_dx_match = find(N == currN & Periods == BestPeriod);
        tmpinfo = Eigmat(:,:,full_dx_match); 

    if RayleighOrLove
        U=tmpinfo(:,2);
        Uderiv=tmpinfo(:,3);
        V=tmpinfo(:,4);
        Vderiv=tmpinfo(:,5);
        r=tmpinfo(:,1);    
    elseif RayleighOrLove ==0
        W=tmpinfo(:,2);
        Wderiv=tmpinfo(:,3);
        r=tmpinfo(:,1);    
    end
    
    if RayleighOrLove
        figure(ijk)
        plot(10*U,(Body_Radius2use*1000-r)./1000,'-r','linewidth',2)
        hold on
        plot(Uderiv,(Body_Radius2use*1000-r)./1000,'-r','linewidth',2,'linestyle','--')
        plot(10*V,(Body_Radius2use*1000-r)./1000,'-b','linewidth',2)
        plot(Vderiv,(Body_Radius2use*1000-r)./1000,'-b','linewidth',2,'linestyle','--')
        legend('10 \times U','U''','10 \times V','V''','location','southeast')
    elseif RayleighOrLove==0
        figure(ijk)
        plot(10*W,(Body_Radius2use*1000-r)./1000,'-m','linewidth',2)
        hold on
        plot(Wderiv,(Body_Radius2use*1000-r)./1000,'-m','linewidth',2,'linestyle','--')
        legend('10 \times W','W''','location','southeast')
        
    end
    
    
    set(gca,'fontsize',18,'fontweight','bold','ydir','reverse')
    xlabel('10 \times Eigenfunction (m) or Dimensionless Derivative')
    ylabel('Depth (km)')
    grid on; box on;
    ylim(yaxisrange)
    set(gcf,'position',[50 222 791 601])
    titlestr = [modename ' Eigenfunctions for ' replace(Velmod,'_','\_') ', n = ' ...
        num2str(currN) ', Period = ' num2str(BestPeriod) 's, l = ' num2str(BestL)];
    title(titlestr)
end