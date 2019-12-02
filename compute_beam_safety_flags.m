function [] = compute_beam_safety_flags(oar, ptv, num_beams, head, helmet_rad)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function iterates through each beam of the Gamma Knife and computes
%the values of the safety flag. The flag value is "1" if the beam is too close to the OAR. 
%If the beam is not too close to the OAR the flag value is "0".

%Input:
%oar = row vector containing the center point and radius of the oar
%ptv = row vector containing the center point and radius of the ptv
%num_beams = the number of beams that pass through the helmet
%head = row vector containing the center point and x, y, z coordinates for the elipsoid
%helmet_rad = the radius of the Gamma Knife helmet

%Output:
%Adds beam_safety_flag attribute to the beam struct

global beam

%The center of the sphere we are concerned with intersecting is the center
%of the OAR
x3 = oar(1,1);
y3 = oar(1,2);
z3 = oar(1,3);

for i = 1:num_beams
    dist = compute_radial_distance([x3, y3, z3], i);
    
    if (dist < (15+7.5))
        beam(i).safety_flag = 1; %The beam is too close to the OAR
    else
        beam(i).safety_flag = 0; %The beam is not too close to the OAR
    end    
    
end


%Make a 3D plot showing the unsafe beams
figure;
hold on;
title("3D Scene for Compute Beam Safety Flags");
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

ptv_x = ptv(1,1);
ptv_y = ptv(1,2);
ptv_z = ptv(1,3);

%plot the PTV
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

%Plot the beams that pass through the OAR
for i = 1:325
    if beam(i).safety_flag == 1
        p = [ptv_x, ptv_y, ptv_z] + (helmet_rad*beam(i).direction_vec);
        scatter3(p(1,1),p(1,2),p(1,3),'*','black');
        plot3([p(1,1),ptv_x], [p(1,2),ptv_y], [p(1,3),ptv_z]);
    end
end

hold off;

end

