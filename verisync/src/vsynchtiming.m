%VSYNCTIMING    Detects vsync timing in amplipex data series
%   VSYNCTIMING(data) retuns the sample at which the vsync bit crosses zero
%   data should be formated as a 2xN array of [sample voltage]
%  
%   data can be formated as data-threshold, or 
%   for approximate mid pulse width
%   data can be formated as diff(data)
%   
%   returns the logical index of the zero crossing
%   
%   Example
%       [leadingedge trailingedge] = vsynctiming(data)
%       leadingedge = vsynctiming(data)
%       
%   See Also SWEEPTIMING
%   Allen Institute 2012: Jayson Jochim, Automation Engineering
%   $Revision 1.0.0 $ Date: 2012/12/20

function [leading trailing] = vsynchtiming(data, distance)
    n = data(1:end-1,2);
    m = data(2:end,2);
    d = distance; 
    
    leading = (n >= 0 & m <= 0)& abs(n-0) > d; leading(end +1) = 0;
    trailing = (n <= 0 & m>=0)& abs(m-0) > d; trailing(end+1) = 0;
    