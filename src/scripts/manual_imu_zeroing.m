%{
A quick script to calculate the IMU rotation angle from a set of IMU data. 

Collect the data using Matlab HIL while the robot is stationary.
%}

%path to the ddRb_meas.mat file
path = '/home/kjhaydon/Github/SimulinkPlant/src/scripts/data.mat';

data = load(path,"acc_data");
acc_meas = squeeze(data.acc_data.Data);

avg_meas = mean(acc_meas')';

expected = [0;0;-9.81];

%angle between the vectors [0 to 180]
theta1 = acos(dot(avg_meas, expected)/9.81^2);

%rotation matrix candiates
Cb_imu_1 = [1 0 0;...
    0 cos(theta1) -sin(theta1);...
    0 sin(theta1) cos(theta1)];

Cb_imu_2 = [1 0 0;...
    0 cos(-theta1) -sin(-theta1);...
    0 sin(-theta1) cos(-theta1)];

%find the measurement using this
acc_candidate_1 = Cb_imu_1*avg_meas;
acc_candidate_2 = Cb_imu_2*avg_meas;

%find which one is closes to expected

if(norm(acc_candidate_1 - expected) < norm(acc_candidate_2 - expected))
    acc_candidate_1
    Cb_imu_1
else
    acc_candidate_2
    Cb_imu_2
end





