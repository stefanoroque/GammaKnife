function [dose_mat] = compute_dose(dose_box, voxel_size)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the dose inside the dose box with a given dose
%voxel size

%Input:
%dose_box = a matrix containing the lower left and upper right corner
%points of the dose box
%voxel_size = the side length (in mm) of each voxel

%Output:
%dose_mat = 3D dose matrix containing the total dose delivered to each
%voxel

upper_right = dose_box(1,:);
lower_left = dose_box(2,:);

%find the side length of the dose_box
db_side_len = upper_right(1,1) - lower_left(1,1);
%Create the 3D dose matrix
mat_dim = round(db_side_len / voxel_size);
dose_mat = zeros(mat_dim, mat_dim, mat_dim);

starting_x = lower_left(1,1);
starting_y = lower_left(1,2);
starting_z = lower_left(1,3);
ending_x = upper_right(1,1);
ending_y = upper_right(1,2);
ending_z = upper_right(1,3);

%create counter for the dose_matrix
dose_mat_x = 1;

%iterate through the X-dimension
for i=starting_x:voxel_size:ending_x
    %iterate through the Y-dimension
    dose_mat_y = 1;
    for j=starting_y:voxel_size:ending_y
        %iterate through the Z-dimension
        dose_mat_z = 1;
        for k=starting_z:voxel_size:ending_z
            poi = [i, j, k];
            %Calculate the dose at that voxel
            dose_mat(dose_mat_x, dose_mat_y, dose_mat_z) = round(compute_point_dose_from_all_beams(poi));
            dose_mat_z = dose_mat_z + 1;
        end
        dose_mat_y = dose_mat_y + 1;
    end
    dose_mat_x = dose_mat_x + 1;
end

end

