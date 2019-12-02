function [dose_box] = compute_dose_box (ctr_pt, rad)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes a dose box around the PTV or the OAR

%Input:
%ctr_pt = the center of the PTV/OAR
%rad = the radius of the PTV/OAR

%Output:
%dose_box = a matrix containing the lower left and upper right corner
%points of the dose box

upper_right = [ctr_pt(1,1) + rad, ctr_pt(1,2) + rad, ctr_pt(1,3) + rad];
lower_left = [ctr_pt(1,1) - rad, ctr_pt(1,2) - rad, ctr_pt(1,3) - rad];

dose_box = [upper_right; lower_left];
end

