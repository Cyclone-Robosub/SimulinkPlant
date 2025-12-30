Fb = ClassPlot("Fb",[3 1],[1; 2; 3],"Time (s)",...
    {"F (N)", "F (N)", "F (N)"},"Force in Body Coordinates",{"Fbx","Fby","Fbz"});

%name, subplot dim [NxM], signal(s) on each subplot [NMxK] where K is the
%number of signals in Fb, xlabel, ylabels, titles (if number of titles is
%less than the number of subplots it is assumed to be a super title),
%legend entries