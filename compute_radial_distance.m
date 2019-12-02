function [radial_dist] = compute_radial_distance(poi, beam_index)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function calculates the distance between an arbitary point of
%interest and the center line of a beam

%Input:
%poi = the point of interest
%beam_index = the index of the beam center line

%Output:
%radial_dist = the distance of the point from the beam center line

global beam

%The first point on the beam center line
Lp1 = beam(beam_index).skin_entry_point;
%The second point on the beam center line
Lp2 = Lp1 + beam(beam_index).direction_vec;

a = Lp2 - Lp1;
%turn this vector into a unit vector
v = a / norm(a);
%Find second vector (hypotenuse of the triangle)
c = poi - Lp1;
%Compute the distance between the point and the line
radial_dist = norm(c - v*dot(v,c));




end

