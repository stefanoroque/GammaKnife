function [] = draw_3d_scene(head, ptv, oar)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function draws a 3d scene containing the head, PTV, OAR, isocenter,
%dose box, and coordinate axis

%Input:
%head = row vector containing the center point and x, y, z coordinates for the elipsoid
%ptv = row vector containing the center point and radius of the ptv
%oar = row vector containing the center point and radius of the oar

%Output:
%3d plot containing the scene

figure;
hold on;
title("3D Scene");
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;

%plot the coordinate axis
plot3([0, 15], [0, 0], [0, 0], "black");
plot3([0, 0], [0, 15], [0, 0], "black");
plot3([0, 0], [0, 0], [0, 15], "black");

%plot the head
hx = head(1,1);
hy = head(1,2);
hz = head(1,3);
ha = head(1,4);
hb = head(1,5);
hc = head(1,6);
[x, y, z] = ellipsoid(hx,hy,hz,ha,hb,hc);
h = surf(x, y, z); 
set(h, 'FaceAlpha', 0.2)
shading interp

%plot the PTV
ptv_x = ptv(1,1);
ptv_y = ptv(1,2);
ptv_z = ptv(1,3);
ptv_rad = ptv(1,4);
[x,y,z] = sphere;
ptv_surf=surf(ptv_rad*x+ptv_x, ptv_rad*y+ptv_y, ptv_rad*z+ptv_z);
set(ptv_surf, 'FaceAlpha', 0.5)
shading interp

%plot the OAR
oar_x = oar(1,1);
oar_y = oar(1,2);
oar_z = oar(1,3);
oar_rad = oar(1,4);
[x,y,z] = sphere;
oar_surf=surf(oar_rad*x+oar_x, oar_rad*y+oar_y, oar_rad*z+oar_z);
set(oar_surf, 'FaceAlpha', 0.5)
shading interp

%plot the isocenter
plot3(ptv_x, ptv_y, ptv_z, "*");

%Plot the PTV dose box
ptv_dose_box = compute_dose_box([ptv_x, ptv_y, ptv_z], ptv_rad);
corner1 = ptv_dose_box(1,:);
corner2 = ptv_dose_box(2,:);
cube_plot_diag(corner1 ,corner2, 'b');

%Plot the OAR dose box
oar_dose_box = compute_dose_box([oar_x, oar_y, oar_z], oar_rad);
corner1 = oar_dose_box(1,:);
corner2 = oar_dose_box(2,:);
cube_plot_diag(corner1 ,corner2, 'r');

hold off;


end

