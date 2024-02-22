
if RayleighOrLove
modename = 'spheroidal';
else
modename = 'toroidal';
end

Eigmatname = [Velmod '_' modename '_eigfxns_array.mat'];
Eiglookupname = [Velmod '_' modename '_TCUNL_Lookup.mat'];

load(Eigmatname)
load(Eiglookupname)
Periods = Lookuptable(1,:);
PhVel = Lookuptable(2,:);
N = Lookuptable(4,:);
L = Lookuptable(5,:);



% Check that this works at all periods and overtones
errcount=0;
for ijk = 1:length(Periodlist)
    Period=Periodlist(ijk);
    for n = 0:MaxN
        currdx = find(N == n);
        tmpperiodlist = Periods(currdx);
        if length(currdx) == 0
            disp(['No eigenfunctions for n=' num2str(n) ',for ' Velmod])
        end
        if min(Periods) > Period || max(Periods) < Period
           disp(['ERROR: eigenfunctions do not span the period of interest, ' num2str(Period) 's, for n=' num2str(n) '.']) 
           disp(['To avoid potential errors, use periods to be between ' num2str(max(tmpperiodlist)) ' and ' num2str(min(tmpperiodlist)) 's'])  
           errcount=errcount+1;
           ErrorList_N(errcount) = n;
           ErrorList_T(errcount) = Period;

            
        end
        
    end
end

clear Period

% Load info about source parameters here, from the input file
EventInfo = load(Inputfilename);
Depthlist = EventInfo(:,1); % in KM
Mrrlist = EventInfo(:,2);
Mttlist = EventInfo(:,3); Mpplist = EventInfo(:,4);
Mrtlist = EventInfo(:,5); Mrplist = EventInfo(:,6);
Mtplist = EventInfo(:,7); 

Azimuthlist = EventInfo(:,8); % in degrees. 



if MinorOrMajor
wvgrpdx=2;
else
wvgrpdx=1;
end


[radius,rho,vsv,vsh,vpv,vph,qmu,qkappa,eta] = load_model(Velmod);
Body_Radius2use = max(radius)./1000;
