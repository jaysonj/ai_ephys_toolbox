%% Analyze Sync Data

path = 'C:\Users\jayj\Desktop\amplipex_systems\analysis\verisync\data\';
file = '20130104_SNCYTEST_SYSTEM2_001.dat';
%meta = '2012_1220sys02sync1.meta';
data  =  LoadBinary([path,file], 'nChannels', 3);

%% Prims
[r,c] = size(data);
rowvect = (r>c);
n = length(rowvect); %number of samples
%% Quick look
figure(1), plot(data(:,1))
title frame

figure(2), plot(data(:,2))
title sweep

figure(3), plot(data(:,3))
title pdiode



%% Grab Sub set
%  select a couple of point in the middle

x1 = 4E5;
x2 = 8E5;
x3 = 3.375E5;
x4 = 3.400E5; 
t = 1/20000; 

data_sub = data(x1:x2,:);
data_super_sub = data_sub(x3:x4,:);

%% Super Sub Plot
plot(data_super_sub)

frame = data_super_sub(:, 2);
sweep = data_super_sub(:, 1);
pdiode = data_super_sub(:, 3);

%% Spline Interpolation
thresh = 4000;
samples = 1:length(frame);
s = spline(1:(length(frame)),frame);

%% Find vsynch start
close all
[uf,df] = vsynchtiming([samples',frame-thresh], 0);
idx = find(uf==1);
plot(idx,repmat(5000, 1,length(idx)), 'ro')
hold on
plot(frame)

%% find sweep start
[us,ds] = vsynchtiming([samples',sweep-thresh], 0);
idx = find(us==1);
plot(idx,repmat(5000, 1,length(idx)), 'ro')
hold on
plot(sweep)

%% find pdiode start
close all
thresh2 = 400;
dd = diff(pdiode).*10;
[us,ds] = vsynchtiming([samples(1:end-1)',abs(dd)], 0);
plot(pdiode)
hold on
idx1 = find(us==1);
idx2 = find(ds==1);
plot(idx1,repmat(200, 1,length(idx1)), 'ro')
plot(idx2,repmat(200, 1,length(idx2)), 'ro')



%% compare timing
n = length(data(:,1));
s = [1:n]';
uf =  vsynchtiming([s,data(:,2)-thresh],0); %frame
us =  vsynchtiming([s,data(:,1)-thresh],0);
[idx_f, idx_s, dfidx] = compare_timing(uf,us);
figure()
plot(dfidx)

%% Find vsynch start
start_index = find(data(:,1)>400, 1, 'first');
close all
[uf,df] = vsynchtiming([s(start_index:end),data(start_index:end,2)-thresh], 0);
idx = find(uf==1);
plot(idx,repmat(5000, 1,length(idx)), 'ro')
hold on
plot(data(start_index:end,2))

%% Find vsynch start
hold on
[us,ds] = vsynchtiming([s(start_index:end),data(start_index:end,1)-thresh], 0);
idx = find(us==1);
plot(idx,repmat(5000, 1,length(idx)), 'gx')
hold on
plot(data(start_index:end,1))

last_index = idx(end);

%% compare timing
n = length(data(start_index:last_index,1));
s = [1:n]';
uf =  vsynchtiming([s,data(:,2)-thresh],0); %frame
us =  vsynchtiming([s,data(:,1)-thresh],0);
[idx_f, idx_s, dfidx] = compare_timing(uf,us);
figure()
plot(dfidx)

%% Sanity Check
path = 'C:\Users\jayj\Desktop\amplipex_systems\data\2012_11_29\';
file = '2012_1129sys02exp06.dat';
meta = '2012_1129sys02exp06.meta';
data  =  LoadBinary([path,file], 'nChannels', 35);
data = data(:,33:35);
%%
close all
figure(1), plot(data(:,1))
title sweep

figure(2), plot(data(:,2))
title frame

figure(3), plot(data(:,3))
title pdiode

%%

frame = data(:,2);

sweep = data(:,1);

pdiode = data(:,3);

samples = 1:length(frame);
%%
thresh = 5000;
u = vsynchtiming([samples',frame-thresh],0);
idx1 = find(u==1);

plot(idx2,repmat(5000, 1,length(idx2)), 'ro')
hold on 
plot(frame)


%% 

t = (1:length(data(:, 1)))./20000;

t1 = 1;
t2 = 2.5E5;

plot(t(t1:t2),data(t1:t2,:))


%%

t1 = 7.8E5;
t2 = 9.3E5;

plot(t(t1:t2),data(t1:t2,:))

