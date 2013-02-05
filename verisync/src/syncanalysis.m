function S = syncanalysis(path, fdata, fmeta,  nchannels)
% syncanalysis outputs the frame, diode, sweep ticks from a 
%% Handle some 
if nargin < 4
    nchannels = 3;
end 

%% Read number of channels from meta file
n = getnchannels(fullfile(path,fmeta));
n = str2num(n{1});
%% Load Data
data = LoadBinary(fullfile(path,fdata), 'nChannels',  n);
% Get size of Data
[i,L] = size(data);
data = data(:,(L-2):L); 
%% Create sample array
samples = [1:i]';
%% Seperate Data Channels 
sweep = data(:, 1);
frame = data(:, 2);
diode = data(:, 3);

%% Calcualte the bit flip index
[us,~] = vsynchtiming([samples,sweep], 0);
[uf,~] = vsynchtiming([samples,frame],0);
[ud,~] = vsynchtiming([samples,diode],0);

%% Assign Timing Arrays
S.sweepticks = find(us == 1);
S.frametick = find(uf == 1);
S.diodeticks = find(ud == 1);

end
