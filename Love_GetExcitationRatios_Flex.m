%% Loops to Calculate Excitation ratios
%% for a specific period, and for a set of events
Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);


% Loop over overtones
for currN = [0:1:MaxN]
    %Get relevant subset of lookup table
    currdx = find(N == currN);
    Clist = PhVel(currdx);
    Tlist = Periods(currdx);
    
  
    periodcounter = 0;

    % Loop over periods
    for period = Periodlist
  
        Tdiff = abs(Tlist-period);
        [mindiff,cdx]=min(Tdiff);
        CurrC = Clist(cdx);
        CurrC = deg2rad(km2deg(CurrC));
        BestPeriod = Tlist(cdx);


    
        Make_Filename_Flex
        
        periodcounter = periodcounter +1;
        % Load eigenfunction at the closest period
        
        full_dx_match = find(N == currN & Periods == BestPeriod);
        tmpinfo = Eigmat(:,:,full_dx_match);
        
        W=tmpinfo(:,2);
        Wderiv=tmpinfo(:,3);
        r=tmpinfo(:,1);    
        
        if currN > 0 & MinorOrMajor
            wvgrpdx=2;
        else
            wvgrpdx=1;
        end
        
        % Loop over events
        for evnum = 1:1:length(Depthlist)
            disp(['Percent Complete for n = ' num2str(currN) ' : ' num2str(100*evnum/length(Depthlist)) '%'])
            
            
            if Azimuthlist(evnum) == 9999

                [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2 ] = ...
                GetLoveSourceAmpandPhase([0:0.5:360],1000*Depthlist(evnum),period,...
                r, W, Wderiv,Mrrlist(evnum),Mttlist(evnum),...
                Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
                Mtplist(evnum),CurrC,wvgrpdx );  
            
                tmpmax = max(B_SourceAmp); maxB_SourceAmp = tmpmax(1);

                PeriodStruc(periodcounter).RawExcitation_Mat(evnum,currN+1) = maxB_SourceAmp;                
                
            else
                            
                [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2 ] = ...
                GetLoveSourceAmpandPhase(Azimuthlist(evnum),1000*Depthlist(evnum),period,...
                r, W, Wderiv,Mrrlist(evnum),Mttlist(evnum),...
                Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
                Mtplist(evnum),CurrC,wvgrpdx );  

                PeriodStruc(periodcounter).RawExcitation_Mat(evnum,currN+1) = B_SourceAmp;
                
            end
        end
    end  
    
    
    
end

periodcounter=0;

for period = Periodlist
    Make_Filename
    periodcounter=periodcounter+1;
        
    RawExcitation_Mat = PeriodStruc(periodcounter).RawExcitation_Mat;
    
    for overtone_num = [1:1:MaxN]
        ExcitationRatio_Mat(:,overtone_num) = RawExcitation_Mat(:,overtone_num+1)./RawExcitation_Mat(:,1);
    end
    
    % Output Raw Excitations as text file
    dlmwrite(RawExcitationFname,PeriodStruc(periodcounter).RawExcitation_Mat,'delimiter','\t','precision','%.25f')
    
    if MaxN > 0
    % Output Excitation Ratios as text file  
    dlmwrite(ExcitationRatioFname,ExcitationRatio_Mat,'delimiter','\t','precision','%.25f')
    end
        clear ExcitationRatio_Mat

    
end



