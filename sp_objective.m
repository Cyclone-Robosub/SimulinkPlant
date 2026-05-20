function values = sp_objective(v, Simulator, Exp)
%MSD_OBJECTIVE 
%   This function compares the simulated data to the experimental data. It
%   is utilized in parameter estimation to preform regressoin.
%       v = array that contains parameter information and the initial states and parameters
%       Simulator = simulator that gets run based on the sim.
%       Exp = Experiment set up from collected data.

%signal tracking requirement
r = sdo.requirements.SignalTracking;
r.Type = '==';
r.Method = 'Residuals';
r.Normalize =  'off';

%update experiment with estimated parameter values;
Exp = setEstimatedValues(Exp,v);

%running simulator to comapare with experimental data.
Simulator = createSimulator(Exp,Simulator);
Simulator = sim(Simulator);
    
SimLog = Simulator.LoggedData.logsout{1}.Values;
    
    
imu_lin_acc = SimLog.ddRi;
lin_acc_x = timeseries(squeeze(imu_lin_acc.Data(1,:,:)),imu_lin_acc.Time);
ref_lin_acc_x = timeseries(squeeze(Exp.OutputData(1).Values.Data(1,:,:)),Exp.OutputData(1).Values.Time);
lin_acc_x_error = evalRequirement(r,lin_acc_x,ref_lin_acc_x);
lin_acc_y = timeseries(squeeze(imu_lin_acc.Data(2,:,:)),imu_lin_acc.Time);
ref_lin_acc_y = timeseries(squeeze(Exp.OutputData(1).Values.Data(2,:,:)),Exp.OutputData(1).Values.Time);
lin_acc_y_error = evalRequirement(r,lin_acc_y,ref_lin_acc_y);
lin_acc_z = timeseries(squeeze(imu_lin_acc.Data(3,:,:)),imu_lin_acc.Time);
ref_lin_acc_z = timeseries(squeeze(Exp.OutputData(1).Values.Data(3,:,:)),Exp.OutputData(1).Values.Time);
lin_acc_z_error = evalRequirement(r,lin_acc_z,ref_lin_acc_z);


imu_ang_vel = SimLog.wb;
ang_vel_x = timeseries(squeeze(imu_ang_vel.Data(1,:,:)), imu_ang_vel.Time);
ref_ang_vel_x = timeseries(squeeze(Exp.OutputData(2).Values.Data(1,:,:)),Exp.OutputData(2).Values.Time);
ang_vel_x_error = evalRequirement(r,ang_vel_x,ref_ang_vel_x);
ang_vel_y = timeseries(squeeze(imu_ang_vel.Data(2,:,:)), imu_ang_vel.Time);
ref_ang_vel_y = timeseries(squeeze(Exp.OutputData(2).Values.Data(2,:,:)),Exp.OutputData(1).Values.Time);
ang_vel_y_error = evalRequirement(r,ang_vel_y,ref_ang_vel_y);
ang_vel_z = timeseries(squeeze(imu_ang_vel.Data(3,:,:)), imu_ang_vel.Time);
ref_ang_vel_z = timeseries(squeeze(Exp.OutputData(2).Values.Data(3,:,:)),Exp.OutputData(1).Values.Time);
ang_vel_z_error = evalRequirement(r,ang_vel_z,ref_ang_vel_z);

%{
imu_mag = SimLog.imu_mag;
mag_x = timeseries(squeeze(imu_mag.Data(1,:,:)), imu_mag.Time);
ref_mag_x = timeseries(squeeze(Exp.OutputData(3).Values.Data(1,:,:)),Exp.OutputData(3).Values.Time);
mag_x_error = evalRequirement(r,mag_x,ref_mag_x);
mag_y = timeseries(squeeze(imu_mag.Data(2,:,:)), imu_mag.Time);
ref_mag_y = timeseries(squeeze(Exp.OutputData(3).Values.Data(2,:,:)),Exp.OutputData(3).Values.Time);
mag_y_error = evalRequirement(r,mag_y,ref_mag_y);
mag_z = timeseries(squeeze(imu_mag.Data(3,:,:)), imu_mag.Time);
ref_mag_z = timeseries(squeeze(Exp.OutputData(3).Values.Data(3,:,:)),Exp.OutputData(3).Values.Time);
mag_z_error = evalRequirement(r,mag_z,ref_mag_z);
%}

dvl_vel = SimLog.dRi;
vel_x = timeseries(squeeze(dvl_vel.Data(1,:,:)),dvl_vel.Time);
ref_vel_x = timeseries(squeeze(Exp.OutputData(3).Values.Data(1,:,:)),Exp.OutputData(3).Values.Time);
vel_x_error = evalRequirement(r,vel_x,ref_vel_x);
vel_y = timeseries(squeeze(dvl_vel.Data(2,:,:)),dvl_vel.Time);
ref_vel_y = timeseries(squeeze(Exp.OutputData(3).Values.Data(2,:,:)),Exp.OutputData(3).Values.Time);
vel_y_error = evalRequirement(r,vel_y,ref_vel_y);
vel_z = timeseries(squeeze(dvl_vel.Data(3,:,:)),dvl_vel.Time);
ref_vel_z = timeseries(squeeze(Exp.OutputData(3).Values.Data(3,:,:)),Exp.OutputData(3).Values.Time);
vel_z_error = evalRequirement(r,vel_z,ref_vel_z);

%{
dvl_alt = SimLog.dvl_alt;
alt = timeseries(squeeze(dvl_alt.Data(:,:)),dvl_alt.Time);
ref_alt = timeseries(squeeze(Exp.OutputData(5).Values.Data),Exp.OutputData(5).Values.Time);
alt_error = evalRequirement(r,alt,ref_alt);
%}

dvl_eul = SimLog.qib;
%{
for i = 1:length(dvl_eul.Data)
    dvl_eul.Data([1:3],:,i) = quatToEul(dvl_eul.Data(:,:,i));
end
%}
eul_phi = timeseries(squeeze(dvl_eul.Data(1,:,:)),dvl_eul.Time);
ref_eul_phi = timeseries(squeeze(Exp.OutputData(4).Values.Data(1,:,:)),Exp.OutputData(4).Values.Time);
eul_phi_error = evalRequirement(r,eul_phi,ref_eul_phi);
eul_psi = timeseries(squeeze(dvl_eul.Data(2,:,:)),dvl_eul.Time);
ref_eul_psi = timeseries(squeeze(Exp.OutputData(4).Values.Data(2,:,:)),Exp.OutputData(4).Values.Time);
eul_psi_error = evalRequirement(r,eul_psi,ref_eul_psi);
eul_theta = timeseries(squeeze(dvl_eul.Data(3,:,:)),dvl_eul.Time);
ref_eul_theta = timeseries(squeeze(Exp.OutputData(4).Values.Data(3,:,:)),Exp.OutputData(4).Values.Time);
eul_theta_error = evalRequirement(r,eul_theta,ref_eul_theta);


dvl_pos = SimLog.Ri;
pos_x = timeseries(squeeze(dvl_pos.Data(1,:,:)),dvl_pos.Time);
ref_pos_x = timeseries(squeeze(Exp.OutputData(5).Values.Data(1,:,:)),Exp.OutputData(5).Values.Time);
pos_x_error = evalRequirement(r,pos_x,ref_pos_x);
pos_y = timeseries(squeeze(dvl_pos.Data(2,:,:)),dvl_pos.Time);
ref_pos_y = timeseries(squeeze(Exp.OutputData(5).Values.Data(2,:,:)),Exp.OutputData(5).Values.Time);
pos_y_error = evalRequirement(r,pos_y,ref_pos_y);
pos_z = timeseries(squeeze(dvl_pos.Data(3,:,:)),dvl_pos.Time);
ref_pos_z = timeseries(squeeze(Exp.OutputData(5).Values.Data(3,:,:)),Exp.OutputData(5).Values.Time);
pos_z_error = evalRequirement(r,pos_z,ref_pos_z);


Error = [lin_acc_x_error(:); lin_acc_y_error(:);lin_acc_z_error(:); ...
         ang_vel_x_error(:);ang_vel_y_error(:);ang_vel_z_error(:);...
         %mag_x_error(:);mag_y_error(:);mag_z_error(:);...
         vel_x_error(:);vel_y_error(:);vel_z_error(:);...
         %alt_error(:);...
         eul_phi_error(:);eul_psi_error(:);eul_theta_error(:);...
         pos_x_error(:);pos_y_error(:);pos_z_error(:)];

values.F = Error(:);
end