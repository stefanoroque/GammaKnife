function [point_dose_val] = compute_point_dose_from_beam(poi, beam_index)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function the dose at a point of interest from a single beam

%Input:
%poi = the point of interest
%beam_index = the index of the beam center line

%Output:
%point_dose_val = the dose delivered to the poi from the specified beam

global beam
global daf_table
global rdf_table
global D_not

%find the depth of the poi from the skin with respect to the beam
d = compute_depth_from_skin(poi, beam_index);
%find the radial distance 
r = compute_radial_distance(poi, beam_index);

%round the depth and radial distance since our dose function tables only have a
%resolution of 1mm
d = round(d);
r = round(r);

point_dose_val = D_not * daf_table(d+1) * rdf_table(r+1);

end

