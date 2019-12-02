function [dose] = daf(dep)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the dose of a Gamma Knife beam at a certain depth

%Input:
%The depth of the beam (in mm)

%Output:
%The dose delivered at that depth

if ((dep >= 0) && (dep <= 20))
    dose = 0.5 + (0.025 * dep);
    return
    
elseif ((dep > 20) && (dep < 200))
    dose = 1 - (0.005 * (dep-20));
    return
  
elseif (dep >= 200)
    dose = 0;
    return
    
else
    warning("Error: Cannot have a negative depth");
    return
end
end

