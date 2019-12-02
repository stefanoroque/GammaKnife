function [] = dosimetry_analysis(ptv, oar, voxel_size, D_100, D_oarmax)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function analyzes the the dose computed in the compute_dose_function

%Input:
%ptv = row vector containing the center point and radius of the ptv
%oar = row vector containing the center point and radius of the oar
%voxel_size = the side length (in mm) of each voxel
%max
%D_100 = The dose perscrobed to the PTV
%D_oarmax = The maximum dose that the OAR can receive

%Testing for the PTV
figure;
hold on;
title("100% Isodose Surface and PTV");
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;
%plot the PTV
ptv_x = ptv(1,1);
ptv_y = ptv(1,2);
ptv_z = ptv(1,3);
ptv_rad = ptv(1,4);
[x,y,z] = sphere;
ptv_surf=surf(ptv_rad*x+ptv_x, ptv_rad*y+ptv_y, ptv_rad*z+ptv_z);
set(ptv_surf, 'FaceAlpha', 0.5)
shading interp

dose_box_ptv = compute_dose_box (ptv(1,1:3), ptv(1,4));
disp("STARTING TO CREATE THE DOSE BOX")
tic
dose_mat_ptv = compute_dose(dose_box_ptv, voxel_size);
disp("DONE CREATING THE DOSE BOX")
toc



%Find every point that recieves at least 100% of the dose prescribed to the
%PTV
upper_right = dose_box_ptv(1,:);
lower_left = dose_box_ptv(2,:);
starting_x = lower_left(1,1);
starting_y = lower_left(1,2);
starting_z = lower_left(1,3);
ending_x = upper_right(1,1);
ending_y = upper_right(1,2);
ending_z = upper_right(1,3);

%Create a matrix to hold the points that have a dose over 170
isodose_mat = zeros(1,3);
%Make a counter to keep track of the row in the isodose_mat
isodose_counter = 1;


%iterate through the X-dimension
dose_mat_ptv_x = 1;
for i=starting_x:voxel_size:ending_x
    %iterate through the Y-dimension
    dose_mat_ptv_y = 1;
    for j=starting_y:voxel_size:ending_y
        %iterate through the Z-dimension
        dose_mat_ptv_z = 1;
        for k=starting_z:voxel_size:ending_z
            if (dose_mat_ptv(dose_mat_ptv_x, dose_mat_ptv_y, dose_mat_ptv_z) >= 170) %dose is 100+% of dose prescribed
                %Add the point to the matrix
                isodose_mat(isodose_counter,:) = [i, j, k];
                isodose_counter = isodose_counter + 1;
            end
            dose_mat_ptv_z = dose_mat_ptv_z + 1;
        end
        dose_mat_ptv_y = dose_mat_ptv_y + 1;
    end
    dose_mat_ptv_x = dose_mat_ptv_x + 1;
end

%Plot the 100% isodose surface
b = boundary(isodose_mat);
trisurf(b,isodose_mat(:,1),isodose_mat(:,2),isodose_mat(:,3),'Facecolor','red','FaceAlpha',0.7);
hold off;

%Compute the dose volume histogram for the PTV
%create a matrix to hold the values to be used for the histogram
ptv_histo_mat = zeros(2,151);
for f = 1:151
    %Fill the relative dose % row
    ptv_histo_mat(1,f) = f - 1;
end

side_len = ending_x - starting_x;
num_voxels_1d = side_len / voxel_size; %number of voxels per side length depends on voxel_size and side_len
total_voxels = num_voxels_1d * num_voxels_1d * num_voxels_1d;

for percent = 0:150
    %iterate through the X-dimension
    counter = 0;
    dose_mat_ptv_x = 1;
    for i=starting_x:voxel_size:ending_x
        %iterate through the Y-dimension
        dose_mat_ptv_y = 1;
        for j=starting_y:voxel_size:ending_y
            %iterate through the Z-dimension
            dose_mat_ptv_z = 1;
            for k=starting_z:voxel_size:ending_z
                if (dose_mat_ptv(dose_mat_ptv_x, dose_mat_ptv_y, dose_mat_ptv_z) >= (percent*0.01*D_100)) 
                    %Add one to the counter
                    counter = counter + 1;
                end
                dose_mat_ptv_z = dose_mat_ptv_z + 1;
            end
            dose_mat_ptv_y = dose_mat_ptv_y + 1;
        end
        dose_mat_ptv_x = dose_mat_ptv_x + 1;
    end
    %Add the counter to the histogram matrix
    ptv_histo_mat(2,percent+1) = counter;
end

%Convert the counters in the ptv_histo_mat to a relative dose percentage
for w = 1:151
    num_v = ptv_histo_mat(2,w);
    ptv_histo_mat(2,w) = (num_v/total_voxels)*100;
    if ptv_histo_mat(2,w) > 100
        ptv_histo_mat(2,w) = 100;
    end
end    

%Plot the PTV histogram
figure;
hold on;
title('PTV Dose Voume Histogram (DVH)');
xlabel('Relative Dose (%)');
ylabel('Ratio of Total Structural Volume (%)');
plot(ptv_histo_mat(1,:), ptv_histo_mat(2,:));
hold off;


%Compute the dose volume histogram for the OAR 
dose_box_oar = compute_dose_box (oar(1,1:3), oar(1,4));
dose_mat_oar = compute_dose(dose_box_oar, voxel_size);
upper_right = dose_box_oar(1,:);
lower_left = dose_box_oar(2,:);
starting_x = lower_left(1,1);
ending_x = upper_right(1,1);

%create a matrix to hold the values to be used for the histogram
oar_histo_mat = zeros(2,151);
for f = 1:151
    %Fill the relative dose % row
    oar_histo_mat(1,f) = f - 1;
end

side_len = ending_x - starting_x;
num_voxels_1d = side_len / voxel_size; %number of voxels per side length depends on voxel_size and side_len
total_voxels = num_voxels_1d * num_voxels_1d * num_voxels_1d;

for percent = 0:150
    %iterate through the X-dimension
    counter = 0;
    dose_mat_oar_x = 1;
    for i=starting_x:voxel_size:ending_x
        %iterate through the Y-dimension
        dose_mat_oar_y = 1;
        for j=starting_y:voxel_size:ending_y
            %iterate through the Z-dimension
            dose_mat_oar_z = 1;
            for k=starting_z:voxel_size:ending_z
                if (dose_mat_oar(dose_mat_oar_x, dose_mat_oar_y, dose_mat_oar_z) >= (percent*0.01*D_oarmax)) 
                    %Add one to the counter
                    counter = counter + 1;
                end
                dose_mat_oar_z = dose_mat_oar_z + 1;
            end
            dose_mat_oar_y = dose_mat_oar_y + 1;
        end
        dose_mat_oar_x = dose_mat_oar_x + 1;
    end
    %Add the counter to the histogram matrix
    oar_histo_mat(2,percent+1) = counter;
end


%Convert the counters in the oar_histo_mat to a relative dose percentage
for w = 1:151
    num_v = oar_histo_mat(2,w);
    oar_histo_mat(2,w) = (num_v/total_voxels)*100;
    if oar_histo_mat(2,w) > 100
        oar_histo_mat(2,w) = 100;
    end
end    

%Plot the histogram for the OAR
figure;
hold on;
title('OAR Dose Voume Histogram (DVH)');
xlabel('Relative Dose (%)');
ylabel('Ratio of Total Structural Volume (%)');
plot(oar_histo_mat(1,:), oar_histo_mat(2,:));
hold off;




end

