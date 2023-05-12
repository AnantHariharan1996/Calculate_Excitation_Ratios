%% Plot Dispersion Diagrams
clear; clc; close all;
% Plot frequency vs angular order

% Are we interested in Rayleigh or Love waves (spheroidal or toroidal)?
% Set the variable to 1 for Rayleigh, 0 for Love
RayleighOrLove = 0;

% Which velocity model do you want to use?
% choices are ATL2a, PREM...
Velmod = 'STW105C';

%%%%%%% Do not edit anything below this line %%%%%%%%
if RayleighOrLove
modename = 'spheroidal';
else
modename = 'toroidal';
end

Eigmatname = [Velmod '_' modename '_eigfxns_array.mat'];
Eiglookupname = [Velmod '_' modename '_TCUNL_Lookup.mat'];

load(Eigmatname); 
load(Eiglookupname)
Periods = Lookuptable(1,:); 
PhVel = Lookuptable(2,:);
U = Lookuptable(3,:);
N = Lookuptable(4,:); 
L = Lookuptable(5,:);
uniqueNs = unique(N); 
cmappp = jet(length(uniqueNs));
% do plotting below here
ncounter=0;

for currN = uniqueNs
    figure(1)

    ncounter=ncounter+1;    
    currdx= find(N == currN);      
    plot(L(currdx),1000./Periods(currdx),'-o','linewidth',2,'color',cmappp(ncounter,:))
    hold on
    xlabel('Angular order (l)')
    ylabel('Frequency (mHz)')
    grid on; box on;
    colormap(cmappp)
    barbar=colorbar; caxis([min(uniqueNs) max(uniqueNs)]);
    ylabel(barbar,'radial order n')
    
    set(gcf,'position',[193 131 913 735])
    titlestr = [modename ' Freq-Angular Order Plot for ' replace(Velmod,'_','\_')];
    title(titlestr)
    set(gca,'fontsize',20,'fontweight','bold')


 

end

ncounter=0;

for currN = uniqueNs

    ncounter=ncounter+1;    
    currdx= find(N == currN);      
    
   figure(2)
    plot(Periods(currdx),PhVel(currdx),'-o','linewidth',2,'color',cmappp(ncounter,:))
hold on
xlim([20 250])
ylim([3 10])
    colormap(cmappp)

    barbar=colorbar; caxis([min(uniqueNs) max(uniqueNs)]);
    ylabel(barbar,'radial order n')
    xlabel('Period (s)')
    ylabel('Phase Velocity (km/s)')
        set(gca,'fontsize',20,'fontweight','bold')
            set(gcf,'position',[193 131 913 735])
    titlestr = ['Phase Velocities for ' replace(Velmod,'_','\_')];


end

