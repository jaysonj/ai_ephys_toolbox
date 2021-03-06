%% Analyze Sync Data
close all
clear all 
clc

path = 'C:\Users\Jay\Dropbox\matlab\verisync\data\';
file = '2012_1220sys02sync1.dat';
meta = '2012_1220sys02sync1.meta';
%%
data  =  LoadBinary([path,file], 'nChannels', 3);

%% Data
sweep_full = data(:,1);
%% Some Variables
n = length(sweep_full);
samples = [1:n]';
threshold = 3000; 

%% Find start and end of sweep data
[us,ds] = vsynchtiming([samples,sweep_full-threshold], 0);
idx = find(us == 1); 

%% Start and finish of Sweeps
start_index = idx(1);
end_index = idx(end);

%% Registering Data
sweep = data(start_index:end_index, 1);
frame = data(start_index:end_index, 2);
diode = data(start_index:end_index, 3);

n = length(sweep);
samples = [1:n]';

% %% Quick Llok
% plot([sweep(1:1000),frame(1:1000), diode(1:1000)])
% legend('sweep', 'frame', 'diode') 

%% Calibrate Sweep Timing to Frame Timing
[us,~] = vsynchtiming([samples,sweep],0);
[uf,~] = vsynchtiming([samples,frame],0);

us_idx = find(us == 1);
uf_idx = find(uf == 1);

% %% Quick Look
plot([sweep,frame])
hold on; plot(us_idx, repmat(4000,1,length(us_idx)), 'gx')
plot(uf_idx, repmat(4000,1,length(uf_idx)), 'rd')

%% Drop first Sweep and Last Frame
us_idx = us_idx(2:end);
uf_idx = uf_idx(1:end-1);

length(us_idx)
length(uf_idx)

%% Quick Look
close all
 plot([sweep-threshold,frame-threshold], '-*')
legend('sweep', 'frame')
hold on; plot(us_idx, repmat(0,1,length(us_idx)), 'gx')
plot(uf_idx, repmat(0,1,length(uf_idx)), 'rd')

%% Compare Timings
close all
df_idx = (us_idx-uf_idx)

while ~isempty(find(abs(df_idx) > 150,1))
    tidx = find(abs(df_idx) > 150, 1, 'first')
    u = us_idx(tidx)
    f = uf_idx(tidx)
    if ( u < f )
        uf_idx(end) = [];
        us_idx(tidx) = [];
        
    else
        uf_idx(tidx) = [];
        us_idx(end) = [];
    end 
       df_idx = (us_idx-uf_idx)
       
 end
%%
df_idx = (us_idx-uf_idx)
plot(df_idx)
mean(df_idx)
std(df_idx)
%%

idx = find(abs(us_idx-uf_idx) > 150)

%% Get Peaks from Photodiode. 
[ds,~] = vsynchtiming([samples,diode-500], 0);
d_idx = find(ds ==1)
%%
close all
plot([sweep(:),frame(:),diode(:)], '-*')
legend('sweep', 'frame')
hold on; plot(us_idx, repmat(4000,1,length(us_idx)), 'gx')
plot(uf_idx, repmat(4000,1,length(uf_idx)), 'rd')
plot(d_idx, repmat(500,1,length(d_idx)), 'bo')
%% Test for Frame Variance of Photodiode

%% Quick Look
close all
x1 = 4.16E5;
x2 = 4.2E5;
plot([sweep(:),frame(:),diode(:)], '-*')
legend('sweep', 'frame', 'diode')
hold on; plot(us_idx, repmat(0,1,length(us_idx)), 'gx')
plot(uf_idx, repmat(0,1,length(uf_idx)), 'rd')

