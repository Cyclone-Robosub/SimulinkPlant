function plotSensorBus(sensor_data)
%Unpack relevant bus elements
sensor_data
t = sensor_data.Time; %this might not be correct

%DVL velocity
dvl_dRb = sensor_data.dvl_vel;
figure('Name','dvl_dRb','NumberTitle','off')
plot(t, dvl_dRb(:,1))
hold on
plot(t, dvl_dRb(:,2))
plot(t, dvl_dRb(:,3))
title("dvl_dRb")



%DVL pos
dvl_Rb = sensor_data.dvl_pos;
figure('Name','dvl_Rb','NumberTitle','off')
plot(t, dvl_Rb(:,1))
hold on
plot(t, dvl_Rb(:,2))
plot(t, dvl_Rb(:,3))
legend(["1","2","3"])

title("dvl_Rb")

%DVL eul
dvl_Eul = sensor_data.dvl_eul;
figure('Name','dvl_Eul','NumberTitle','off')
plot(t, dvl_Eul(:,1))
hold on
plot(t, dvl_Eul(:,2))
plot(t, dvl_Eul(:,3))
legend(["1","2","3"])
title("dvl_Eul")

%DVL alt
dvl_alt = sensor_data.dvl_alt;
plot(t, dvl_alt(:,1))
hold on
plot(t, dvl_alt(:,2))
plot(t, dvl_alt(:,3))
legend(["1","2","3"])
title("dvl_alt")

%IMU acc
imu_ddRb = sensor_data.imu_lin_acc;
plot(t, imu_ddRb(:,1))
hold on
plot(t, imu_ddRb(:,2))
plot(t, imu_ddRb(:,3))
legend(["1","2","3"])
title("imu_ddRb")

%IMU wb
imu_wb = sensor_data.imu_ang_vel;
plot(t, imu_wb(:,1))
hold on
plot(t, imu_wb(:,2))
plot(t, imu_wb(:,3))
legend(["1","2","3"])
title("imu_wb")


end