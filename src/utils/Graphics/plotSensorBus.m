function plotSensorBus(sensor_data)
%Unpack relevant bus elements
sensor_data = sensor_data.sensors;


%DVL velocity
dvl_dRb = sensor_data.dvl_vel;
t = dvl_dRb.Time;
dvl_dRb = squeeze(dvl_dRb.Data)';
figure('Name','dvl_dRb','NumberTitle','off')
plot(t, dvl_dRb(:,1))
hold on
plot(t, dvl_dRb(:,2))
plot(t, dvl_dRb(:,3))
title("dvl_dRb")
legend(["1","2","3"])



%DVL pos
dvl_Rb = sensor_data.dvl_pos;
t = dvl_Rb.Time;
dvl_Rb = squeeze(dvl_Rb.Data)';
figure('Name','dvl_Rb','NumberTitle','off')
plot(t, dvl_Rb(:,1))
hold on
plot(t, dvl_Rb(:,2))
plot(t, dvl_Rb(:,3))
title("dvl_dRb")
legend(["1","2","3"])
title("dvl_Rb")

%DVL eul
dvl_Eul = sensor_data.dvl_eul;
t = dvl_Eul.Time;
dvl_Eul = squeeze(dvl_Eul.Data)';
figure('Name','dvl_Eul','NumberTitle','off')
plot(t, dvl_Eul(:,1))
hold on
plot(t, dvl_Eul(:,2))
plot(t, dvl_Eul(:,3))
title("dvl_dRb")
legend(["1","2","3"])
title("dvl_Eul")

%DVL alt
dvl_alt = sensor_data.dvl_alt;
t = dvl_alt.Time;
dvl_alt = squeeze(dvl_alt.Data)';
figure('Name','dvl_alt','NumberTitle','off')
plot(t, dvl_alt(:,1))
title("dvl_alt")

%IMU acc
imu_ddRb = sensor_data.imu_lin_acc;
t = imu_ddRb.Time;
imu_ddRb = squeeze(imu_ddRb.Data)';
figure('Name','imu_ddRb','NumberTitle','off')
plot(t, imu_ddRb(:,1))
hold on
plot(t, imu_ddRb(:,2))
plot(t, imu_ddRb(:,3))
title("dvl_dRb")
legend(["1","2","3"])
title("imu_ddRb")

%IMU wb
imu_wb = sensor_data.imu_ang_vel;
t = imu_wb.Time;
imu_wb = squeeze(imu_wb.Data)';
figure('Name','imu_wb','NumberTitle','off')
plot(t, imu_wb(:,1))
hold on
plot(t, imu_wb(:,2))
plot(t, imu_wb(:,3))
title("dvl_dRb")
legend(["1","2","3"])
title("imu_wb")


end