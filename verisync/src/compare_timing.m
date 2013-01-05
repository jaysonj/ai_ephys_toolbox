%% Sweep, Frame, Delay
% calculates from logical index of leading edge frame and sweep ticks 
%  f = [00000000000100000000010]
%  s = [00000000001000000000010]


% f-s = [00000000-1-1000000000]

function [idx_s, idx_f, dfidx] = compare_timing(sweep_logical, frame_logical)

    
    idx_s = find(sweep_logical  == 1);
    idx_f = find(frame_logical == 1);
if ( length(idx_s) == length(idx_f))
    dfidx = idx_s - idx_f;

else
    length(idx_s), length(idx_f)
    msgbox('logically indexed vectors are not the same length')
    %idx_s = NaN;
    %idx_f = NaN;
    dfidx = NaN;
end


