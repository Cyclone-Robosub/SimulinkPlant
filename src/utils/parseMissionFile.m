function [command, current_maneuver_index, this_maneuver_end_time] = parseMissionFile(mission_file,time,...
    current_maneuver_index,this_maneuver_end_time)

%lookup current maneuver in the listhold on
current_maneuver = mission_file(current_maneuver_index,1);

%depending on what type of maneuver it is, update timers, index, and the
%command
switch current_maneuver
    case 1 %"Start"
        %advance the current maneuver index by one and reset the timer
        current_maneuver_index = current_maneuver_index + 1;
        command = [1,0]; %[type,value]
        
    case 2 %"Forward"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [2,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = forwardProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [2,0];
            
        end

       
    case 3 %"RightTurn"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [3,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = rightTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [3,0];
            
        end
    case 4 %"LeftTurn"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [4,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = leftTurnProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [4,0];
            
        end
    case 5 %"Reverse"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [5,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = reverseProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [5,0];
            
        end
    case 6 %"Up"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [6,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = upProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [6,0];
            
        end
    case 7 %"Down"
        %get this maneuver's data
        this_maneuver_duration = mission_file(current_maneuver_index,2);
        this_maneuver_intensity = mission_file(current_maneuver_index,3);

        %see if another maneuver just ended
        if(this_maneuver_end_time==-1)
            this_maneuver_end_time = time + this_maneuver_duration;
            command = [7,0];
        elseif(this_maneuver_end_time > time)
            %we still have time left in the maneuver
            this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
            command = downProfile(this_maneuver_time,this_maneuver_intensity,this_maneuver_duration);
        else
            %the maneuver timer has expired
            %advance the index, indicate you just ended, reset vars
            current_maneuver_index = current_maneuver_index+1;
            this_maneuver_end_time=-1;
            command = [7,0];
            
        end
    case 8 %"Stop"
        command = [8,0];
    case 9 %"BarrelRole"
        %TBA
        error("Command is not ready yet ):");  
    case 10 %"FlatSpin"
        error("Command is not ready yet ):");
    case 11 %"Tumble"
        error("Command is not ready yet ):");
    otherwise
        error("Invalid command in the command structure");
end

end
