%% Visualize_Results
close all

cmap2use=jet(MaxN+1);
periodcounter=0;
for Period = Periodlist
    periodcounter=periodcounter+1;
    ExcitationRatioFname = [Wave '_' Arc '_ExctRtio_T_'  ...
    num2str(Period) 's_output' Inputfilename(1:end-4)];

    Ratios = load(ExcitationRatioFname);
    
    if RayleighOrLove
    % Get intersection distance
    [ MinorXlist, MajorXlist ] = Get_Rayleigh_Dist_Intersection( Period,MaxN );

    else
        
    [ MinorXlist, MajorXlist ] = Get_Love_Dist_Intersection( Period,MaxN );
        
    end
    Medianlist=[];
    for n = [1:1:MaxN]
        
        CurrentN_RatioList = Ratios(:,n);
        Medianlist=[Medianlist median(CurrentN_RatioList)];
        
        
    end
    
    
    % If Rayleigh waves, and majarc plot median at the intersection distance
    if MaxN > 0 & MinorOrMajor

    figure(999)
        subplot(round(sqrt(length(Periodlist))),round(sqrt(length(Periodlist))),periodcounter)

        scatter(MinorXlist,Medianlist,250,'filled','MarkerFaceAlpha',0.5)
    xlabel('Epicentral Distance at Intersection ($^\circ$)','interpreter','latex')
    ylabel('Excitation Ratio','interpreter','latex')
    for n = 1:length(Medianlist)
        text(MinorXlist(n),Medianlist(n),['n = ' num2str(n)],'fontsize',20)
        
    end
    grid on; box on;
    
    if strcmp(Inputfilename,'EventList_ExampleInputFile.txt') & Period == 100
        title('Fig. 14 c), Hariharan et al., 2021')
    else
        title(['T =' num2str(Period) 's, Median Excitation Ratios @ Intersection Distance'])  
    end
    set(gca,'fontsize',20)
        set(gca,'fontweight','bold')
    end

    % Scatter Excitations as a function of depth
    
    figure()
        for n = [1:1:MaxN+1]
            currNexcitation = PeriodStruc(periodcounter).RawExcitation_Mat(:,n);
            legendstr{n} = ['n = ' num2str(n-1)];
            subplot(1,2,1)
                scatter(currNexcitation,Depthlist,50,cmap2use(n,:),'filled')
                hold on

        end
    hlegend=legend(legendstr)
    ylabel('Depth (km)','interpreter','latex')
    xlabel('Excitation','interpreter','latex')
    title(['\textbf{ Period = ' num2str(Period) 's}'],'interpreter','latex')
    set(gca,'fontsize',20,'ydir','reverse')
        grid on; box on;
    set(gca,'fontweight','bold')

    % Scatter Excitation Ratios as a function of depth

    for n = [1:1:MaxN]
    CurrentN_RatioList = Ratios(:,n);
    legendstr{n} = ['n' num2str(n) '/' 'n0'];
                subplot(1,2,2)

    scatter(CurrentN_RatioList,Depthlist,50,cmap2use(n,:),'filled')
    hold on
    end   
        hlegend=legend(legendstr)
    ylabel('Depth (km)','interpreter','latex')
    xlabel('Excitation Ratio','interpreter','latex')
    title(['\textbf{ Period = ' num2str(Period) 's}'],'interpreter','latex')
    set(gca,'fontsize',20,'ydir','reverse')
    grid on; box on;
    xlim([0 5])
    set(gca,'fontweight','bold')
    
end

