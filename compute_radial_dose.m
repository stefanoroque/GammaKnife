function [rdf_table] = compute_radial_dose(head_a, head_b, head_c)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the Radial Dose Function at all possible distances from the beam center and puts them
%into a vector

%Input:
%The dimensions of the elipsoid that simulates the head

%Output:
%A vector containing the radial doses at all the possible distances from the beam center within the
%head

%Find maximum possible depth in the head
m = max([2*head_a; 2*head_b; 2*head_c]);

rdf_table = zeros(1,m+1);

for i = 0:m
    rdf_table(1,i+1) = rdf(i);
end

end

