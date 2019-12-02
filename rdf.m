function [rdose] = rdf(dist)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the radial dose of a Gamm Knife beam

%Input:
%The distance from the beam center (in mm)

%Output:
%The radial dose at that distance

if ((dist >= 0) && (dist <= 7.5))
    rdose = 1;
    return
    
elseif ((dist > 7.5) && (dist < 22.5))
    rdose = 1 - (1/15*(dist-7.5));
    return
    
elseif (dist >= 22.5)
    rdose = 0;
    return

else
    warning("Error: Cannot have a negative depth");
    return
end
end

