function driftedCoordinates = toDriftedCoordinates(baseLocation,t)
    x = baseLocation(1);
    y = baseLocation(2);
    z = baseLocation(3);
    v = 30;
    xL = 49;
    yL = 44;
    zL = 20;
    xA = 2;
    yA = 3;
    zA = 0.4;
    driftedCoordinates = [(x + xA*cos((x-v*t)/xL)*cos((y-v*t)/yL)*cos((z-v*t)/zL)) (y + yA*cos((x-v*t)/xL)*cos((y-v*t)/yL)*cos((z-v*t)/zL)) (z + zA*cos((x-v*t)/xL)*cos((y-v*t)/yL)*cos((z-v*t)/zL)) baseLocation(4) baseLocation(5) baseLocation(6)];
end