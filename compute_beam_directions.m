function [] = compute_beam_directions(ptv, helmet_rad)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the longitude, latitude and unit direction vector
%of each pencil beams centerline in the Gamma Knife

%Input:
%ptv = the center and radius of the PTV

%Output:
%Adds direction_vec, latitude and longitude attributes to the beam structs

ret_mat = zeros(325, 5);
global beam

for i = 0:8  %Loop for the elevation angle
    for j = 1:36  %Loop for azimuth angle
        azim = (j*10) * (pi/180);
        elev = (i*10) * (pi/180);
        [x, y, z] = sph2cart(azim, elev, helmet_rad); 
        beam_vec = [x, y, z]/norm([x, y, z]); %Normalize the direction vec
        ret_mat(i*36+j,[1, 2, 3]) = beam_vec;
        ret_mat(i*36+j,[4, 5]) = [elev, azim];
        beam(i*36+j).direction_vec = beam_vec;
        beam(i*36+j).latitude = elev;
        beam(i*36+j).longitude = azim;
    end
end

%Add the last point (top of helmet)
elev = (9*10) * (pi/180);
[x, y, z] = sph2cart(0, elev, helmet_rad); 
beam_vec = [x, y, z]/norm([x, y, z]); %Normalize the direction vec
beam(325).direction_vec = beam_vec;
beam(325).latitude = elev;
beam(325).longitude = azim;

%Draw a 3D scene of the beams
figure;
hold on;
title("3D Scene for Compute Beam Directions");
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;
%plot the coordinate axis
plot3([0, 15], [0, 0], [0, 0], "red");
plot3([0, 0], [0, 15], [0, 0], "red");
plot3([0, 0], [0, 0], [0, 15], "red");

%Plot the beams coming from the helmet
ptv_x = ptv(1,1);
ptv_y = ptv(1,2);
ptv_z = ptv(1,3);
for i = 1:325
    p = [ptv_x, ptv_y, ptv_z] + (helmet_rad*beam(i).direction_vec);
    scatter3(p(1,1),p(1,2),p(1,3),'*','black');
    plot3([p(1,1),ptv_x], [p(1,2),ptv_y], [p(1,3),ptv_z]);     
end

hold off;

end

