function [poi] = intersect_line_and_ellipsoid(Lp1, Lp2, x_rad, y_rad, z_rad)
%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

%This function computes the intersection of a line and an elipsoid
%Input: two points on a line and the x, y and z radius of the ellipsoid
%Output: The intersection point in the top hemisphere of the head

try
    %Find the direction vector of the line and normalize
    v = Lp2 - Lp1;
    v = v / norm(v);

    %Solve for the coefficients in the quadratic formula
    a = (v(1,1).^2 / x_rad.^2) + (v(1,2).^2 / y_rad.^2) + (v(1,3).^2 / z_rad.^2);
    b = (2*Lp1(1,1)*v(1,1) / x_rad.^2) + (2*Lp1(1,2)*v(1,2) / y_rad.^2) + (2*Lp1(1,3)*v(1,3) / z_rad.^2);
    c = (Lp1(1,1).^2 / x_rad.^2) + (Lp1(1,2).^2 / y_rad.^2) + (Lp1(1,3).^2 / z_rad.^2) - 1;

    %Put the roots into a vector so we can plug them into the roots function
    roots_vec = [a, b, c];
    r = roots(roots_vec);
    determinant = b.^2 - (4 * a * c);

    %Check determinant to see how many points of intersection exist
    if determinant < 0 %There are no points of intersection
        intersection1 = "No Intersection";
        intersection2 = "No Intersection";
    elseif determinant == 0 %There is one point of intersection
        intersection1 = [Lp1(1,1) + r(1,1)*v(1,1), Lp1(1,2) + r(1,1)*v(1,2), Lp1(1,3) + r(1,1)*v(1,3)];
        intersection2 = "No_Intersection";
    else  %There are two points of intersection
        intersection1 = [Lp1(1,1) + r(1,1)*v(1,1), Lp1(1,2) + r(1,1)*v(1,2), Lp1(1,3) + r(1,1)*v(1,3)];
        intersection2 = [Lp1(1,1) + r(2,1)*v(1,1), Lp1(1,2) + r(2,1)*v(1,2), Lp1(1,3) + r(2,1)*v(1,3)];
    end
    
    %Isolate just the point of intersection in the top hemisphere of the
    %head
    if (intersection1(1,3) >= Lp1(1,3))
        poi = intersection1;
    else
        poi = intersection2;
    end
    
catch
    %Check if inputs are valid
    if (size(Lp1,2)~=3)
       warning("Error: parameter Lp1 is not 3 dimensions");
       return
    elseif (size(Lp2,2)~=3)
       warning("Error: parameter Lp2 is not 3 dimensions");
       return
    elseif (0 >= x_rad)
       warning("Error: x_rad must be larger than 0");
       return
    elseif (0 >= y_rad)
       warning("Error: y_rad must be larger than 0");
       return
    elseif (0 >= z_rad)
       warning("Error: z_rad must be larger than 0");
       return
    end
    
    
end


end

