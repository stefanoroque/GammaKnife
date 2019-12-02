function [daf_table] = compute_depth_dose(head_a, head_b, head_c)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the DAF at all possible beam depths and puts them
%into a vector

%Input:
%The dimensions of the elipsoid that simulates the head

%Output:
%A vector containing the doses at all the possible beam depths within the
%head

%Find maximum possible depth in the head
m = max([2*head_a; 2*head_b; 2*head_c]);

daf_table = zeros(1,m+1);

for i = 0:m
    daf_table(1,i+1) = daf(i);
end

end

