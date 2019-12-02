function [] = compute_skin_entry_points(helmet_rad, ptv, head, num_beams)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the skin entry point for each beam

%Input:
%helmet_rad = the radius of the Gamma Knife helmet
%head = row vector containing the center point and x, y, z coordinates for the elipsoid
%ptv = row vector containing the center point and radius of the ptv
%num_beams = the number of beams that pass through the helmet

%Output:
%Adds skin_entry_point and isocenter_depth attributes to the beam struct

global beam
ptv_center = ptv(1,[1,2,3]);

%Iterate through the all the beams and calulate the skin entry point and
%the the depth of the isocenter from that skin entry point
for i = 1:num_beams
    [poi] = intersect_line_and_ellipsoid(ptv_center,ptv_center+(helmet_rad*beam(i).direction_vec),head(1,4),head(1,5),head(1,6));
    beam(i).skin_entry_point = poi;
    %Compute the ditance between the skin entry point and the isocenter
    beam(i).isocenter_depth = (((poi(1,1)-ptv_center(1,1))^2+(poi(1,2)-ptv_center(1,2))^2+(poi(1,3)-ptv_center(1,2))^2)^0.5); 
end

%Make a 3D plot showing the skin entry points
figure;
hold on;
title("3D Scene for Skin Entry Points");
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;
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

ptv_x = ptv_center(1,1);
ptv_y = ptv_center(1,2);
ptv_z = ptv_center(1,3);

%plot the PTV
ptv_rad = ptv(1,4);
[x,y,z] = sphere;
ptv_surf=surf(ptv_rad*x+ptv_x, ptv_rad*y+ptv_y, ptv_rad*z+ptv_z);
set(ptv_surf, 'FaceAlpha', 0.5)
shading interp

%plot 5 beams at random indexes
for i = 1:5
    random_idx = round(1+rand()*(325-1));
    p = [ptv_x, ptv_y, ptv_z] + (helmet_rad*beam(random_idx).direction_vec);
    scatter3(p(1,1),p(1,2),p(1,3),'*','black');
    entry_p = beam(random_idx).skin_entry_point;
    scatter3(entry_p(1,1),entry_p(1,2),entry_p(1,3),'*','red');
    plot3([p(1,1),ptv_x], [p(1,2),ptv_y], [p(1,3),ptv_z]);
end

hold off;
end

