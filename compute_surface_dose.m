function [] = compute_surface_dose(ptv, oar)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the dose on the surfaces of the PTV and the OAR

%Input:
%ptv = row vector containing the center point and radius of the ptv
%oar = row vector containing the center point and radius of the oar



ptv_c = ptv(1,1:3);
ptv_rad = ptv(1,4);
oar_c = oar(1,1:3);
oar_rad = oar(1,4);

%Use the sphere command to get points on the surface of the PTV
[a,b,c] = sphere;
x = a * ptv_rad + ptv_c(1,1);
y = b * ptv_rad + ptv_c(1,2);
z = c * ptv_rad + ptv_c(1,3);

%Find the number of points on the surface
num_surface_p = size(x,1);

%Create a matrix to hold the dose at each point on the ptv surface
s_doses_ptv = zeros(num_surface_p,num_surface_p);
%Create a vector to gold the hottest dose location on the PTV surface
hottest_ptv = zeros(1,4);
%Create a vector to gold the coldest dose location on the PTV surface
coldest_ptv = zeros(1,4);
%Set dose of coldest to something very high to start
coldest_ptv(1,4) = 400;

for i=1:num_surface_p
    for k=1:num_surface_p
        surface_p = [x(i,k),y(i,k),z(i,k)];
        dose = compute_point_dose_from_all_beams(surface_p);
        s_doses_ptv(i,k) = dose;
        if dose > hottest_ptv(1,4) 
            hottest_ptv(1,4) = dose;
            hottest_ptv(1,1:3) = surface_p;
        end 

        if dose < coldest_ptv(1,4)
            coldest_ptv(1,4) = dose;
            coldest_ptv(1,1:3) = surface_p;
        end 
        
    end 
end 
 
disp("Hottest PTV dose location:")
disp(hottest_ptv(1,1:3))
disp("Hottest PTV dose value:")
disp(hottest_ptv(1,4))
disp("Coldest PTV dose location:")
disp(coldest_ptv(1,1:3))
disp("Coldest PTV dose value:")
disp(coldest_ptv(1,4))


%Plot the surface dose of the PTV
figure
title("Surface Dose of PTV");
hold on;
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;
surf(x,y,z,s_doses_ptv)
%Mark the hottest and coldest locations
plot3(hottest_ptv(1,1),hottest_ptv(1,2),hottest_ptv(1,3),'r*','markers',20);
plot3(coldest_ptv(1,1),coldest_ptv(1,2),coldest_ptv(1,3),'g*','markers',20);
colorbar;
hold off;


%Use the sphere command to get points on the surface of the OAR
[a,b,c] = sphere;
x = a * oar_rad + oar_c(1,1);
y = b * oar_rad + oar_c(1,2);
z = c * oar_rad + oar_c(1,3);

%Find the number of points on the surface
num_surface_p = size(x,1);

%Create a matrix to hold the dose at each point on the OAR surface
s_doses_oar = zeros(num_surface_p,num_surface_p);
%Create a vector to gold the hottest dose location on the OAR surface
hottest_oar = zeros(1,4);
%Create a vector to gold the coldest dose location on the OAR surface
coldest_oar = zeros(1,4);
%Set dose of coldest to something very high to start
coldest_oar(1,4) = 400;

for i=1:num_surface_p
    for k=1:num_surface_p
        surface_p = [x(i,k),y(i,k),z(i,k)];
        dose = compute_point_dose_from_all_beams(surface_p);
        s_doses_oar(i,k) = dose;
        if dose > hottest_oar(1,4) 
            hottest_oar(1,4) = dose;
            hottest_oar(1,1:3) = surface_p;
        end 

        if dose < coldest_oar(1,4)
            coldest_oar(1,4) = dose;
            coldest_oar(1,1:3) = surface_p;
        end 
        
    end 
end 

disp("Hottest OAR dose location:")
disp(hottest_oar(1,1:3))
disp("Hottest OAR dose value:")
disp(hottest_oar(1,4))
disp("Coldest OAR dose location:")
disp(coldest_oar(1,1:3))
disp("Coldest OAR dose value:")
disp(coldest_oar(1,4))
 
%Plot the surface dose of the OAR
figure
title("Surface Dose of OAR");
hold on;
xlabel("X-axis (mm)"); 
ylabel("Y-axis (mm)");
zlabel("Z-axis (mm)");
axis equal;
surf(x,y,z,s_doses_oar)
%Mark the hottest and coldest locations
plot3(hottest_oar(1,1),hottest_oar(1,2),hottest_oar(1,3),'r*','markers',20);
plot3(coldest_oar(1,1),coldest_oar(1,2),coldest_oar(1,3),'g*','markers',20);
colorbar;
hold off;


end

