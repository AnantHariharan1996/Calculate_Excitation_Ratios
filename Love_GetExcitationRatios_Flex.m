%% Loops to Calculate Excitation ratios
%% for a specific period, and for a set of events
Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);
ncounter=0;

% Loop over overtones
for currN = [0:1:MaxN]
    %Get relevant subset of lookup table
    currdx = find(N == currN);
    Clist = PhVel(currdx);
    Tlist = Periods(currdx);
        ncounter=ncounter+1;

  
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
        
        if MinorOrMajor
            wvgrpdx=2;
        else
            wvgrpdx=1;
        end
        
        % Loop over events
        for evnum = 1:1:length(Depthlist)
            disp(['Percent Complete for n = ' num2str(currN) ' : ' num2str(100*evnum/length(Depthlist)) '%'])
            
            
   
                            
                [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2 ] = ...
                GetLoveSourceAmpandPhase(Azimuthlist(evnum),1000*Depthlist(evnum),period,...
                r, W, Wderiv,Mrrlist(evnum),Mttlist(evnum),...
                Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
                Mtplist(evnum),CurrC,wvgrpdx );  

                PeriodStruc(periodcounter).RawExcitation_Mat(evnum,currN+1) = B_SourceAmp;
                 PeriodStruc(periodcounter).RawPhase_Mat(evnum,currN+1) = B_SourcePhase;
       
            
        end
    end  
    
                    PeriodStruc(periodcounter).Periodlist(ncounter)=BestPeriod;

    
end

periodcounter=0;

for period = Periodlist
    Make_Filename_Flex
    periodcounter=periodcounter+1;
        
    RawExcitation_Mat = PeriodStruc(periodcounter).RawExcitation_Mat;
    RawExcitation_Mat_towrite(1,:) = PeriodStruc(periodcounter).Periodlist;
    RawExcitation_Mat_towrite(2:length(RawExcitation_Mat(:,1))+1,:) = RawExcitation_Mat;

    RawPhase_Mat = PeriodStruc(periodcounter).RawPhase_Mat;
    RawPhase_Mat_towrite(1,:) = PeriodStruc(periodcounter).Periodlist;
    RawPhase_Mat_towrite(2:length(RawPhase_Mat(:,1))+1,:) = RawPhase_Mat;


    if ExcitationOrPhase==1
           % Output Raw phase as text file
    dlmwrite(RawPhaseFname,RawPhase_Mat_towrite,'delimiter','\t','precision','%.25f')
    elseif ExcitationOrPhase==0

    % Output Raw Excitations as text file
    dlmwrite(RawExcitationFname,RawExcitation_Mat_towrite,'delimiter','\t','precision','%.25f')
    end

    
end



