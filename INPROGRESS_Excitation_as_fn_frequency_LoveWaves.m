%% Calculate Excitation as a function of frequency
%
clear;
clc;
close all;


%%% Set up Parameters here
nlist = [0:1:2];
MinorOrMajor = 0;

RayleighOrLove = 0;

Depthlist = 19.8; % in KM
Mrrlist = 6.690000e+26;
Mttlist = -5.350000e+26; Mpplist = -1.340000e+26;
Mrtlist = 1.210000e+27; Mrplist = -5.520000e+26;
Mtplist = 2.370000e+26; 

Azimuthlist = 270; % in degrees. 
% If the Azimuth is set to 9999, we just use the maximum of the
% radiation pattern



for n = nlist
    
   if RayleighOrLove == 1
        flist = dir(['Eigenfunction_Files/S_B' num2str(n) '_*s' ]);
        fname=[ 'atl2a_Rayl_TUc_br' num2str(n) '.dms'];
        tucinfo=load(fname);
        Tlist=tucinfo(:,1);
        Clist=tucinfo(:,3);   
   elseif RayleighOrLove == 0
        flist = dir(['Eigenfunction_Files/T_B' num2str(n) '_*s' ]);
        fname=[ 'atl2a_Love_TUc_br' num2str(n) '.dms'];
        tucinfo=load(fname);
        Tlist=tucinfo(:,1);
        Clist=tucinfo(:,3);
   end
    
   periodlist = [];
   Excitationlist = [];
   
    for ijk = 1:length(flist)
        
        fname = flist(ijk).name;
        periodstr = extractBetween(fname,['T_B' num2str(n) '_'],'s');
        periodstr=periodstr{1};
        period = str2num(periodstr)
        periodlist(ijk) = period;
        
        % get phase velocity
        Tdiff = abs(Tlist-period);
        [mindiff,cdx]=min(Tdiff);
        CurrC = Clist(cdx);
        CurrC = deg2rad(km2deg(CurrC));
            
        if RayleighOrLove == 0
        % Load eigenfunctions
        Eigfname=['T_B' num2str(n) '_' num2str(period) 's'];
        tmpinfo=load(Eigfname);
        W=tmpinfo(:,2);
        Wderiv=tmpinfo(:,3);
        r=tmpinfo(:,1);    
        
        else
            
            
        end
        if n > 0 & MinorOrMajor
            wvgrpdx=2;
        else
            wvgrpdx=1;
        end
        
        % Now, get excitation for the chosen source combination
        if RayleighOrLove == 0

        if Azimuthlist == 9999
         [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2 ] = ...
                GetLoveSourceAmpandPhase([0:0.5:360],1000*Depthlist,period,...
                r, W, Wderiv,Mrrlist,Mttlist,...
                Mpplist,Mrtlist,Mrplist,...
                Mtplist,CurrC,wvgrpdx); 
            
            
         Excitationlist(ijk) = max(B_SourceAmp);
         
         
        else
         [ B_SourceAmp,B_SourcePhase,B_Complex_Rad_Pattern,B_Term1,...
                B_Term2 ] = ...
                GetLoveSourceAmpandPhase(Azimuthlist,1000*Depthlist,period,...
                r, W, Wderiv,Mrrlist,Mttlist,...
                Mpplist,Mrtlist,Mrplist,...
                Mtplist,CurrC,wvgrpdx); 
            
            
         Excitationlist(ijk) = B_SourceAmp;
        end
       
            
            
        end
        
    end
    
    [sortperiod,sortdx] = sort(periodlist);
    excitationsortec=Excitationlist(sortdx);
    semilogx(sortperiod,excitationsortec,'-o','linewidth',4)
    hold on
    
    
end
counter=0;
for n = nlist
    counter=counter+1;
    legendstr{counter} = [num2str(n) 'T'];
end
legend(legendstr)
xlim([6 200])
xlabel('Period (s)')
ylabel('Raw Excitation')
set(gca,'fontweight','bold','fontsize',20)