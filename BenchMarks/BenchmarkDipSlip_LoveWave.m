%%%%%%%%%
%%%%%%%%%
clear; clc; close all;
EQNfo = 'DipSlip_Fault.txt';
EQNfo=load(EQNfo); Deps = EQNfo(:,1);
% remake fig 3 panel B from H 2021
periodlist = [50:10:170];
for period = periodlist
fname = ['L_Exct_' num2str(period) 's_outputDipSlip_Fault'];
info = load(fname);
exct = info([2:end],:);
rats = exct(:,2)./exct(:,1);
scatter(period*ones(size(Deps)),Deps,250,log(rats),'filled','s'  )
hold on
caxis([-2.5 0])
colormap(viridis)
set(gca,'fontsize',16,'ydir','reverse')
end
    
    
    