%{
    Default prop locations and constants for _UCS models.
    
    Reminder These locations are in "World" coordinates not "Unreal"
    coordinates. The key difference is that z is pointing upwards in Unreal
    coordinates but in World z is pointing downwards. Currently both world
    and unreal are in cm as far as _UCS is concerned. This may change.
    If you are looking at unreal coordinates of a prop, just make sure to
    switch the z from positive to negative, everything else is the same.

    If any sim3d actors are not given poses here, or are not published in
    the simulink model, the prop will get teleported to the shadow
    dimension (far far away).
%}


gate1_Pose = [-780 1490 0 0 0 0];

%List of Path locations.
pathPoses = zeros(2, 6);
pathPoses(1,:) = [-553 1640 78.5 0 0 0];
pathPoses(2,:) = [337 1650 78.5 0 0 0];

%List of White Slalom locations
whiteSlalomPoses = zeros(6, 6);

whiteSlalomPoses(1,:) = [-90 1810 -40 0 0 0];
whiteSlalomPoses(2,:) = [10 1790 -40 0 0 0];
whiteSlalomPoses(3,:) = [120 1820 -40 0 0 0];
whiteSlalomPoses(4,:) = [-120 1500 -40 0 0 0];
whiteSlalomPoses(5,:) = [-20 1490 -40 0 0 0];
whiteSlalomPoses(6,:) = [100 1510 -40 0 0 0];

%List of Red Slalom locations
redSlalomPoses = zeros(3, 6);

redSlalomPoses(1,:) = [-90 1650 -40 0 0 0];
redSlalomPoses(2,:) = [0 1620 -40 0 0 0];
redSlalomPoses(3,:) = [90 1650 -40 0 0 0];

%Relative Gate Emoji Locations
searchRescueEmojiPose = [-3 80 -98 pi/2 0 pi/2];
surveyRepairEmojiPose = [-3 250 -98 pi/2 0 pi/2];