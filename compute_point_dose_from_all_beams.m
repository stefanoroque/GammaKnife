function [point_dose_val] = compute_point_dose_from_all_beams(poi)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function the dose at a point of interest from all beams

%Input:
%poi = the point of interest

%Output:
%point_dose_val = the dose delivered to the poi from all beams

global beam

point_dose_val = 0;
%Loop through each beam on the helmet and add the dose from that beam to
%the total, since total dose is cumulative
for i = 1:325
    %Only use the beam if its beam center does not pass through the OAR
    if (beam(i).safety_flag == 0)  %The beam center did not intersect the OAR
    single_dose = compute_point_dose_from_beam(poi, i);
    point_dose_val = point_dose_val + single_dose;
    end
end

end

