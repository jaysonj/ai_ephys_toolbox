function S = syncanalysis(path, fdata, fmeta, trim)
% syncanalysis outputs the frame, diode, sweep ticks from a
%% Handle some for testing
if nargin ==0
    fdata = '2012_1220sys02sync1.dat';
    fmeta = '2012_1220sys02sync1.meta';
    path = 'C:\Users\jayj\Dropbox\matlab\verisync\data';
    trim = 1;
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
if trim
    %% Some Variables
    threshold = 3000;
    
    %% Find start and end of sweep data
    [us,ds] = vsynchtiming([samples,sweep-threshold], 0);
    idx = find(us == 1);
    
    %% Start and finish of Sweeps
    start_index = idx(1);
    end_index = idx(end);
    
    %% Registering Data
%     sweep = data(start_index:end_index, 1);
%     frame = data(start_index:end_index, 2);
%     diode = data(start_index:end_index, 3);
    
end

%% Calculate the bit flip index
[us,~] = vsynchtiming([samples(start_index:end_index),sweep(start_index:end_index)],0);
[uf,~] = vsynchtiming([samples(start_index:end_index),frame(start_index:end_index)],0);
[ud,~] = vsynchtiming([samples(start_index:end_index),diode(start_index:end_index)-500],0);
%ud = [ud1,ud2];
%% Assign Timing Arrays
S.sweepticks = find(us == 1);
S.frameticks = find(uf == 1);
S.diodeticks = find(ud == 1);
S.samples = samples;
if trim
    S.trimstart = start_index;
    S.trimend = end_index;
end
S.data = data;
end
