%% Write Output

periodcounter=0;
MegaMat_Excite=[];
MegaMat_Phase=[];
Mat_Excite=[];
Mat_Phase=[];
for period = Periodlist
    Make_Filename_Flex
    periodcounter=periodcounter+1;
        
    RawExcitation_Mat = PeriodStruc(periodcounter).RawExcitation_Mat;
    RawExcitation_Mat_towrite(1,:) = PeriodStruc(periodcounter).Periodlist;
    RawExcitation_Mat_towrite(2:length(RawExcitation_Mat(:,1))+1,:) = RawExcitation_Mat;

    Row1 = [0:1:MaxN];
    Row2 = period.*ones(size(Row1));
    Row3 = PeriodStruc(periodcounter).Periodlist;

   
    % row 1 is n
    % row 2 is input period
    % row 3 is actual period
    % row 4 onwards is excitation. 
    Mat_Excite(1,:) = Row1;
    Mat_Excite(2,:) = Row2;
    Mat_Excite(3,:) = Row3;
    Mat_Excite(4:4+length(RawExcitation_Mat(:,1))-1,:) = RawExcitation_Mat;
    MegaMat_Excite=[MegaMat_Excite Mat_Excite];

    RawPhase_Mat = PeriodStruc(periodcounter).RawPhase_Mat;
    RawPhase_Mat_towrite(1,:) = PeriodStruc(periodcounter).Periodlist;
    RawPhase_Mat_towrite(2:length(RawPhase_Mat(:,1))+1,:) = RawPhase_Mat;
    Mat_Phase(1,:) = Row1;
    Mat_Phase(2,:) = Row2;
    Mat_Phase(3,:) = Row3;
    Mat_Phase(4:4+length(RawExcitation_Mat(:,1))-1,:) = RawPhase_Mat;
    MegaMat_Phase=[MegaMat_Phase Mat_Phase];

    clear Mat_Phase
    clear Mat_Excite
   
end

% Set information corresponding to 
% modes that are out of the search domain to zero.
if exist('ErrorList_N','var') == 1
for jklm = 1:length(ErrorList_N)
    currN = ErrorList_N(jklm);
    currT = ErrorList_T(jklm);
    idx = find(MegaMat_Excite(1,:) == currN & MegaMat_Excite(2,:) == currT);
    MegaMat_Excite(3:end,idx) = NaN;
    MegaMat_Phase(3:end,idx) = NaN;
    
end
end

if ExcitationOrPhase==1
% Output Raw phase as text file
dlmwrite(RawPhaseFname,MegaMat_Phase,'delimiter','\t','precision','%.25f')
elseif ExcitationOrPhase==0
% Output Raw Excitations as text file
dlmwrite(RawExcitationFname,MegaMat_Excite,'delimiter','\t','precision','%.25f')
end


