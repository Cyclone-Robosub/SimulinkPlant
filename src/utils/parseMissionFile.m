function [X_target,command_FF, current_maneuver_index, this_maneuver_end_time] = parseMissionFile(mode_id,mission_file,time,...
    current_maneuver_index,this_maneuver_end_time) %#codegen

%TODO - add logic for X_target

switch mode_id 
    case 0
        command_FF = [0 0];
        X_target = zeros(6,1);
    case 1
        %lookup current maneuver in the listhold on
        if(current_maneuver_index < length(mission_file))
            current_maneuver = mission_file(current_maneuver_index,1);
            
            %depending on what type of maneuver it is, update timers, index, and the
            %command_FF
            switch current_maneuver
                case 1 %"Start"
                    %advance the current maneuver index by one and reset the timer
                    current_maneuver_index = current_maneuver_index + 1;
                    command_FF = [1 0]; %[type,value]
                    
                case 2 %"Forward"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [2 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = forwardProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [2 0];
                        
                    end
            
                   
                case 3 %"RightTurn"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [3 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = rightTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [3 0];
                        
                    end
                case 4 %"LeftTurn"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [4 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = leftTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [4 0];
                        
                    end
                case 5 %"Reverse"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [5 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = reverseProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [5 0];
                        
                    end
                case 6 %"Up"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [6 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = upProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [6 0];
                        
                    end
                case 7 %"Down"
                    %get this maneuver's data
                    this_maneuver_duration = mission_file(current_maneuver_index,2);
                    this_maneuver_intensity = mission_file(current_maneuver_index,3);
            
                    %see if another maneuver just ended
                    if(this_maneuver_end_time==-1)
                        this_maneuver_end_time = time + this_maneuver_duration;
                        command_FF = [7 0];
                    elseif(this_maneuver_end_time > time)
                        %we still have time left in the maneuver
                        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
                        command_FF = downProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
                    else
                        %the maneuver timer has expired
                        %advance the index, indicate you just ended, reset vars
                        current_maneuver_index = current_maneuver_index+1;
                        this_maneuver_end_time=-1;
                        command_FF = [7 0];
                        
                    end
                case 8 %"Stop"
                    command_FF = [8 0];
                case 9 %"BarrelRole"
                    %TBA
                    error("command_FF is not ready yet ):");  
                case 10 %"FlatSpin"
                    error("command_FF is not ready yet ):");
                case 11 %"Tumble"
                    error("command_FF is not ready yet ):");
                case 0
                    current_maneuver_index = current_maneuver_index+1;
                     this_maneuver_end_time=-1;
                    command_FF = [0 0];
                otherwise
                    error("Invalid command_FF in the command_FF structure");
            end
        else
            command_FF = [0 0];
        end
        X_target = zeros(6,1);
    case 2
        command_FF = [0 0];
        %TODO - determine where X_target comes from here
        X_target = zeros(6,1);
    otherwise
        command_FF = [0 0];
        X_target = zeros(6,1);


end
end
