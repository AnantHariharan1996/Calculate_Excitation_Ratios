%% Calculate Excitation as a function of frequency
%


%% Loop over every event

for evnum = 1:length(Mtplist)


Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);
N = Lookuptable(4,:);
L = Lookuptable(5,:);
clear AllStore

for currN = 0:MaxN
    
    idx = find(N == currN);
    PeriodsAtN = Periods(idx);
    PhvelsAtN = PhVel(idx);

    
   periodlist = [];
   Excitationlist = [];
   pcounter=0;
   for currperiod = PeriodsAtN
       pcounter=   pcounter+1;
       CurrC =  deg2rad(km2deg(PhvelsAtN(pcounter)));
        full_dx_match = find(N == currN & Periods == currperiod);
        tmpinfo = Eigmat(:,:,full_dx_match);
        
        if RayleighOrLove 

            U=tmpinfo(:,2);
            Uderiv=tmpinfo(:,3);
            V=tmpinfo(:,4);
            Vderiv=tmpinfo(:,5);
            r=tmpinfo(:,1);  

            [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
            B_Term2,B_Term3 ] = ...
            GetRayleighSourceAmpandPhase(Azimuthlist(evnum),1000*Depthlist(evnum),currperiod,...
            r, U, Uderiv,V,Vderiv,Mrrlist(evnum),Mttlist(evnum),...
            Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
            Mtplist(evnum),CurrC,wvgrpdx );  


        else

            W=tmpinfo(:,2);
            Wderiv=tmpinfo(:,3);
            r=tmpinfo(:,1);    

            [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
            B_Term2 ] = ...
            GetLoveSourceAmpandPhase(Azimuthlist(evnum),1000*Depthlist(evnum),currperiod,...
            r, W, Wderiv,Mrrlist(evnum),Mttlist(evnum),...
            Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
            Mtplist(evnum),CurrC,wvgrpdx );  
            
        end

        Excitationlist(pcounter) = B_SourceAmp;
        
    end
    % store excitation and periods
    figure(evnum)
    [sortperiod,sortdx] = sort(PeriodsAtN);
    excitationsortec=Excitationlist(sortdx);
    semilogx(sortperiod,excitationsortec,'-o','linewidth',4)    
    hold on
xlim([6 200])
xlabel('Period (s)')
ylabel('Raw Excitation')
set(gca,'fontweight','bold','fontsize',20)
%ylim([0 7e18])
%AllStore(evnum).periods()
end

% output information for this event

end