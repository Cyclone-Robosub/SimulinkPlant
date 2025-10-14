function forces_N  = oldPWMToForce(thruster_pwms)
    %{
        This function  uses a polynomial fit to the pwm vs thrust curve 
        for the T200 Thrusters to calculate the 8 thruster force vectors.
    %}
    %preallocate
    forces_N = 0; 
    
    
    % First condition: 1100 <= x < 1460
    index_array = (thruster_pwms >= 1100 & thruster_pwms < 1460);

    
    forces_N(index_array) =  (-1.76709811615214e-07) * thruster_pwms(index_array).^3 ...
                 + (0.000566300482093069) * thruster_pwms(index_array).^2 ...
                 + (-0.478920592563405) * thruster_pwms(index_array) ...
                 + 41.55273858905;
    
    % Second condition: 1460 <= x <= 1540
    index_array = (thruster_pwms >= 1460 & thruster_pwms <= 1540);
    forces_N(index_array) = 0;
    
    % Third condition: 1540 < x <= 1900
    index_array = (thruster_pwms > 1540 & thruster_pwms <= 1900);
    forces_N(index_array) = (-1.81933850672702e-07) * thruster_pwms(index_array).^3 ...
                 + (0.00109777888824906) * thruster_pwms(index_array).^2 ...
                 + (-2.03121269418349) * thruster_pwms(index_array) ...
                 + (1189.65910925401);
    
    % Handle out-of-range values
    if any(isnan(forces_N))
        error('Some values in x_array are out of the valid range [1100..1900].');
    end

    
end
