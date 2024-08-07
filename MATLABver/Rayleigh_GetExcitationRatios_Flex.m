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
        [CurrC_AltVersion] = km2rad_anysphere(Clist(cdx),Body_Radius2use);
        CurrC=CurrC_AltVersion;
        BestPeriod = Tlist(cdx);


    
        Make_Filename_Flex
        
        periodcounter = periodcounter +1;

        % Load eigenfunction at the closest period
        
        full_dx_match = find(N == currN & Periods == BestPeriod);
        tmpinfo = Eigmat(:,:,full_dx_match);

        U=tmpinfo(:,2);
        Uderiv=tmpinfo(:,3);
        V=tmpinfo(:,4);
        Vderiv=tmpinfo(:,5);
        r=tmpinfo(:,1);    
           % pre-processing loop to aid with interpolation
         r=tmpinfo(:,1);    
        for abcdef = 1:length(r)-1
        if r(abcdef+1) == r(abcdef)
            r(abcdef) = r(abcdef)+0.001;
        end
        end

        if  MinorOrMajor
            wvgrpdx=2;
        else
            wvgrpdx=1;
        end
        
        % Loop over events
        for evnum = 1:1:length(Depthlist)
            
            disp(['Percent Complete for n = ' num2str(currN) ' : ' num2str(100*evnum/length(Depthlist)) '%'])
            

                
                [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2,B_Term3 ] = ...
                GetRayleighSourceAmpandPhase(Azimuthlist(evnum),1000*Depthlist(evnum),period,...
                r, U, Uderiv,V,Vderiv,Mrrlist(evnum),Mttlist(evnum),...
                Mpplist(evnum),Mrtlist(evnum),Mrplist(evnum),...
                Mtplist(evnum),CurrC,wvgrpdx );  
            
                 PeriodStruc(periodcounter).RawExcitation_Mat(evnum,currN+1) = B_SourceAmp;
                  PeriodStruc(periodcounter).RawPhase_Mat(evnum,currN+1) = B_SourcePhase;
      
            
        


            
        end
                        PeriodStruc(periodcounter).Periodlist(ncounter)=BestPeriod;

    end  
    
    

end
WriteOutput