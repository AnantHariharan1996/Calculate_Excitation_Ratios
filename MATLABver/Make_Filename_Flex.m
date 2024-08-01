%%%%%%%%%%%%%%%%%%%%%%%
%%%% Make Output Filenames %%%%
%%%%%%%%%%%%%%%%%%%%%%%
if RayleighOrLove == 1
    Wave = 'R';
elseif RayleighOrLove == 0
    Wave = 'L';
end

% if MinorOrMajor == 1
%     Arc = 'Maj';
% elseif MinorOrMajor == 0
%     Arc = 'Mnr';
% end


RawExcitationFname = [Wave '_Exct_' ...
    num2str(min(Periodlist)) '_' num2str(max(Periodlist)) 's_output' Inputfilename(1:end-4)];
RawPhaseFname = [Wave '_Phase_' ...
    num2str(min(Periodlist)) '_' num2str(max(Periodlist)) 's_output' Inputfilename(1:end-4)];
% ExcitationRatioFname = [Wave '_' Arc '_ExctRtio_T_'  ...
%     num2str(period) 's_output' Inputfilename(1:end-4)];

