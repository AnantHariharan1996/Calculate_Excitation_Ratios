%%%%%%%%%
%%%%%%%%%
clear; clc; close all;
EQNfo = 'DipSlip_Fault.txt';
EQNfo=load(EQNfo); Deps = EQNfo(:,1);
% remake fig 3 panel B from H 2021
periodlist = [50:10:170];
fname = ['L_Exct_' num2str(min(periodlist)) '_' ...
    num2str(max(periodlist)) 's_outputDipSlip_Fault'];
info = load(fname);
n = info(1,:);
t = info(2,:);
Exct = info(4:end,:);

% interested in the excitation ratio between n1/n0
for ijk = 1:length(periodlist)

n1dx = find(t == periodlist(ijk) & n == 1);
n0dx = find(t == periodlist(ijk) & n == 0);
rats = Exct(:,n1dx)./Exct(:,n0dx);
scatter(periodlist(ijk)*ones(size(Deps)),Deps,250,log(rats),'filled','s'  )
hold on
caxis([-2.5 0])
colormap(viridis)


end

set(gca,'fontsize',16,'ydir','reverse')



    
    
    