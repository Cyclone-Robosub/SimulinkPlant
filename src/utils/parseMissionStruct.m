function [command, current_maneuver_index, this_maneuver_end_time] = parseMissionStruct(mission_struct,time,...
    current_maneuver_index,this_maneuver_end_time)

%lookup current maneuver in the list
current_maneuver = mission_struct.command_type(current_maneuver_index);

%depending on what type of maneuver it is, update timers, index, and the
%command
switch current_maneuver
    case "Start"
        %advance the current maneuver index by one and reset the timer
        current_maneuver_index = current_maneuver_index + 1;
        command = {'',0};
        
    case "Forward"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = forwardProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end

       
    case "RightTurn"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = rightTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end
    case "LeftTurn"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = leftTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end
    case "Reverse"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = reverseProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end
    case "Up"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = upProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end
    case "Down"
        %get this maneuver's data
        this_maneuver_duration = mission_struct.var2(current_maneuver_index);
        this_maneuver_intensity = mission_struct.var1(current_maneuver_index);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = {"",0};
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = downProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = {"",0};
            
        end
    case "Stop"
        command = {'Stop',0};
    case "BarrelRole"
        %TBA
        error("Command is not ready yet ):");  
    case "FlatSpin"
        error("Command is not ready yet ):");
    case "Tumble"
        error("Command is not ready yet ):");
    otherwise
        error("Invalid command in the command structure");
end

end
