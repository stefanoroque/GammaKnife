function [depth] = compute_depth_from_skin(poi, beam_index)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function calculates the skin depth belinging to an arbitrary point of
%interest with respect to the pencil beam

%Input:
%poi = the point of interest
%beam_index = the index of the beam center line

%Output:
%depth = The depth of the poi with respect to the beam

global beam

beam_line = beam(beam_index).direction_vec;
p1 = beam(beam_index).skin_entry_point;

%Find second vector (hypotenuse of the triangle)
c = poi - p1;

%Compute the vector normal to the beam, towards the poi
distance_vec = c - beam_line*dot(beam_line,c);

%Subtract the distance vector to the poi so find a point on the beam center
%line that is at the same depth as the poi
p2 = poi - distance_vec;

%The depth is the distance between the skin entry point and the point
%we just found
depth = sqrt((p2(1,1)-p1(1,1))^2+(p2(1,2)-p1(1,2))^2+(p2(1,3)-p1(1,3))^2);

end

