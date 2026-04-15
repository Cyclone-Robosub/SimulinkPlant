%Function that takes world coordinates, then converts them to image
%coordinates. It also takes camera pose, camera intrinsic matrix (K), and
%distortion coefficients (d_Coef). d_Coef should be in [k1 k2 p1 p2 k3]
%format. Assumes all vectors are in row not column form.
function r = worldToImageCoord(p, cameraPos, K, d_Coef)
    cameraExt = getCameraExtrinsic(cameraPos);
    k = K;
    cameraInt = zeros(4,4);
    cameraInt(1:3, 1:3) = k(1:3, 1:3);
    p = transpose(p);
    cameraMatrix = cameraInt*cameraExt;
    r_Un = cameraMatrix * p;
    r_Un = r_Un/r_Un(3);
    r = distortR(r_Un, d_Coef);
end

function distortedR = distortR(rU, d_Coef)
    k1 = d_Coef(1);
    k2 = d_Coef(2);
    p1 = d_Coef(3);
    p2 = d_Coef(4);
    k3 = d_Coef(5);
    x = rU(1);
    y = rU(2);
    r = (x^2 + y^2)^0.5;
    rDistort = (1 + k1 * r^2 + k2 * r^4 + k3 * r^6);
    x_Distort = x * rDistort + 2 * p1 * x * y + p2 * (r^2 + 2 * x ^ 2);
    y_Distort = y * rDistort + 2 * p2 * x * y + p1 * (r^2 + 2 * y ^ 2);
    distortedR = [x_Distort, y_Distort];
end
    
%Camera extrinsic matrix function.
function cameraExt = getCameraExtrinsic(cameraPos)

    %Roll Matrix:
    RM = getRollMatrix(cameraPos(4));

    %Pitch Matrix:
    PM = getPitchMatrix(cameraPos(5));

    %Yaw Matrix:
    YM = getYawMatrix(cameraPos(6));

    %Translation Matrix:
    TM = [1 0 0 -cameraPos(1); 0 1 0 -cameraPos(2); 0 0 1 -cameraPos(3); 0 0 0 1];

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