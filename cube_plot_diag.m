function corners = cube_plot_diag(corner1 ,corner2, cl)
%Compiled by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

% draws a cube with the diagonal corners "corner1 ,corner2"
% The output is the plot and also the coordinates of all 8 corners. 

%This function was taken from:
%https://www.mathworks.com/matlabcentral/fileexchange/61119-cube-by-diagonal-corners
%Author:
%Abolfazl Mohebbi
cn_x = (corner1(1)+corner2(1))/2;
cn_y = (corner1(2)+corner2(2))/2;
cn_z = (corner1(3)+corner2(3))/2;
L = abs(corner1(1)-corner2(1));
W = abs(corner1(2)-corner2(2));
H = abs(corner1(3)-corner2(3));
x1 = cn_x - L/2; x2 = x1; x5 = x1; x6 = x1;
x3 = cn_x + L/2; x4 = x3; x7 = x3; x8 = x3; 
y1 = cn_y - W/2; y4=y1; y5=y1; y8=y1;  
y2 = cn_y + W/2; y3=y2; y6=y2; y7=y2; 
z1 = cn_z + H/2; z2=z1; z3=z1; z4=z1;
z5 = cn_z - H/2; z6=z5; z7=z5; z8=z5;
corners_d = [x1, x2, x3, x4, x1;
             y1, y2, y3, y4, y1;
             z1, z2, z3, z4, z1];
corners_u = [x5, x6, x7, x8, x5;
             y5, y6, y7, y8, y5;
             z5, z6, z7, z8, z5];
Lwid = 1.2;         
line (corners_d(1,:), corners_d(2,:), corners_d(3,:),'LineWidth',Lwid,'Color',cl); 
line (corners_u(1,:), corners_u(2,:), corners_u(3,:),'LineWidth',Lwid,'Color',cl); 
line ([x1, x5],[y1, y5],[z1, z5],'LineWidth',Lwid,'Color',cl);
line ([x2, x6],[y2, y6],[z2, z6],'LineWidth',Lwid,'Color',cl);
line ([x3, x7],[y3, y7],[z3, z7],'LineWidth',Lwid,'Color',cl);
line ([x4, x8],[y4, y8],[z4, z8],'LineWidth',Lwid,'Color',cl);
corners = [corners_u(:,1:4) corners_d(:,1:4)];
end