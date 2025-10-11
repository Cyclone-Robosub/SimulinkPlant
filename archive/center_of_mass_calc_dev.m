%{
Development script for calculating the center of mass for an assembly of
rigid bodies given:

1. Geometric shape - supported geometries are rectangular prism, sphere,
cylinder
2. Position vector from an origin to the geometric center of each shape
3. Additional shape-dependent properites
    a. rectangular prism, geometric center, coordinate of three base
    coordinates and one upper plane coordinate
    b. sphere - TBA
    c. cylinder - TBA

References
https://en.wikipedia.org/wiki/List_of_moments_of_inertia
https://en.wikipedia.org/wiki/Parallel_axis_theorem
https://en.wikipedia.org/wiki/Outer_product

To do
1. Update plotShape for cases sphere and cylinder
2. Update localMomentOfInertia for sphere and cylinder
3. Add function to calculate the system center of mass from the list of
shapes
3. Move functions to utils
4. Move calculation to constants
5. Write unit tests for each function

KJH 10/11/25
%}
close all;
clear all;
clc;
%% Example Usage
%structure for the shape
cube.type = "Cube";
cube.position = [0;0;0];
cube.I = zeros(3);
cube.mass = 1;
cube.p1 = [-1 -0.5 .5]';
cube.p2 = [-1 0.5 .5]';
cube.p3 = [1 0.5 0.5]';

cube.p4 = [1 0.5 -0.5]';
system_com = 0; %to do: add a function to calculate this form shapes


%Example calls
plotShape(cube);
cube.I = localMomentOfInertia(cube);
shapes = [cube];

%system_com = systemCenterOfMass(shapes);

cube.J = parallelAxisTheorem(system_com,cube);
J_total = totalMomentOfInertia(shapes)

%% Functions
function J_total = totalMomentOfInertia(shapes)
    J_total = zeros(3);
    for k = 1:length(shapes)
        J_total = J_total + shapes(1).J;
    end
end

function J = parallelAxisTheorem(system_com,cube)
    R = cube.position - system_com;
    J = cube.I + cube.mass*(dot(R,R)*eye(3) - R*R');
end

function I = localMomentOfInertia(shape)
    switch shape.type
        case "Cube"
            h = abs(shape.p4(3) - shape.p3(3));
            w = abs(shape.p2(2) - shape.p1(2));
            l = abs(shape.p2(1) - shape.p3(1));
            Izz = (1/12)*shape.mass*(w^2 + l^2);
            Iyy = (1/12)*shape.mass*(l^2 + h^2);
            Ixx = (1/12)*shape.mass*(w^2 + h^2);
            I = diag([Ixx Iyy Izz]);
            
        case "Sphere"
            warning("Sphere is not ready.");
        case "Cylinder"
            warning("Cylinder is not ready.");
        otherwise
            warning("Invalid shape.");
    end
end

function plotShape(shape)
    switch shape.type
        case "Cube"
            p1 = shape.p1;
            p2 = shape.p2;
            p3 = shape.p3;
            p4 = shape.p4;
            p5 = -p2;
            p6 = [p3(1) p1(2) p3(3)]';
            p7 = -p3;
            p8 = -p6;
            points = [p1 p2 p3 p4 p5 p6 p7 p8];
            X = points(1,:);
            Y = points(2,:);
            Z = points(3,:);
            figure
            plot3(X,Y,Z,'LineStyle','None','Marker','.','MarkerSize',20)
            xlim([-5,5]);
            ylim([-5,5]);
            zlim([-5,5]);
        case "Sphere"
            warning("Sphere is not ready.");
        case "Cylinder"
            warning("Cylinder is not ready.");
        otherwise
            warning("Invalid shape.");
    end
end