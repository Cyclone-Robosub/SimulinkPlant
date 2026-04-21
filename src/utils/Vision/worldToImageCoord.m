%{
Function that takes world coordinates, then converts them to
imagecoordinates. It also takes camera pose, camera intrinsic matrix (K), and distortion coefficients (d_Coef). 
d_Coef should be in [k1 k2 p1 p2 k3] format. Assumes all vectors are in row not column form.
%}

function r_Image = worldToImageCoord(r_World, manateePos, cameraPos, K, d_Coef)
    manateeExt = getExtrinsic(manateePos);
    cameraExt = getExtrinsic(cameraPos);

    %Convert camera intrinsic to 4x4.
    cameraInt = zeros(4,4);
    cameraInt(1:3, 1:3) = K(1:3, 1:3);
    
    r_World = transpose(r_World);

    %{
    Rotation Matrices (PM90 YM90) to switch so that z is pointing forward, x to the
    right and y to the left. To be applied after manatee and camera
    extrinsics.
    %}
    PM90 = getPitchMatrix(-pi / 2);
    YM90 = getYawMatrix(-pi / 2);
    
    cameraMatrix = cameraInt*YM90*PM90*cameraExt*manateeExt;
    r_Un = cameraMatrix * r_World;
    z = r_Un(3);
    r_Image = zeros(1,3);
    if z > 0
        r_Un = r_Un / z;
        %r_Image = r_Un(1:2);
        r_Image2d = distortR(r_Un, d_Coef, K(1,3), K(2,3), K(1,1),K(2,2));
        r_Image(1) = r_Image2d(1);
        r_Image(2) = r_Image2d(2);
        if r_Image(1) <= 1920 && r_Image(2) < 1080
            r_Image(3) = 1;
        end
    else
        r_Image = [-1 -1 0];
    end
end

function distortedR = distortR(rU, d_Coef, xCenter, yCenter, focal_X, focal_Y)
    k1 = d_Coef(1);
    k2 = d_Coef(2);
    p1 = d_Coef(3);
    p2 = d_Coef(4);
    k3 = d_Coef(5);
    x = (rU(1) - xCenter) / focal_X;
    y = (rU(2) - yCenter) / focal_Y;
    r = (x^2 + y^2)^0.5;
    rDistort = (1 + k1 * r^2 + k2 * r^4 + k3 * r^6);
    x_Distort = x * rDistort + 2 * p1 * x * y + p2 * (r^2 + 2 * x ^ 2);
    y_Distort = y * rDistort + 2 * p2 * x * y + p1 * (r^2 + 2 * y ^ 2);
    distortedR = [(x_Distort*focal_X + xCenter), (y_Distort*focal_Y + yCenter)];
end

%Camera extrinsic matrix function.
function cameraExt = getExtrinsic(pos)

    %Roll Matrix:
    RM = getRollMatrix(-pos(4));

    %Pitch Matrix:
    PM = getPitchMatrix(-pos(5));

    %Yaw Matrix:
    YM = getYawMatrix(-pos(6));

    %Translation Matrix:
    TM = [1 0 0 -pos(1); 0 1 0 -pos(2); 0 0 1 -pos(3); 0 0 0 1];

    %Camera External Matrix Computed in Translation => Yaw => Pitch => Roll
    %order:
    cameraExt = RM*PM*YM*TM;
end

%roll rotation matrix function.
function rollM = getRollMatrix(roll)
    rollM = [1 0 0 0; 0 cos(roll) -sin(roll) 0; 0 sin(roll) cos(roll) 0; 0 0 0 1];
end
%pitch rotation matrix function.
function pitchM = getPitchMatrix(pitch)
    pitchM = [cos(pitch) 0 sin(pitch) 0; 0 1 0 0; -sin(pitch) 0 cos(pitch) 0; 0 0 0 1];
end

%yaw rotation matrix function.
function yawM = getYawMatrix(yaw)
    yawM = [cos(yaw) -sin(yaw) 0 0; sin(yaw) cos(yaw) 0 0; 0 0 1 0; 0 0 0 1];
end