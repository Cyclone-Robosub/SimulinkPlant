Fb = ClassPlot("Fb",[3 1],[1; 2; 3],"Time (s)",...
    {"F (N)", "F (N)", "F (N)"},"Force in Body Coordinates",{"Fbx"; "Fby";"Fbz"});

%name, subplot dim [NxM], signal(s) on each subplot [NMxK] where K is the
%number of signals in Fb, xlabel, ylabels, titles (if number of titles is
%less than the number of subplots it is assumed to be a super title),
%legend entries

%dummy data
clear results Data
Time = linspace(0,10,300)';
example_vector = timeseries([ones(size(Time)),2*ones(size(Time)),3*ones(size(Time))],Time);
example_scalar = timeseries(4*ones(size(Time)),Time);



%dummy results structure with 2 data fields, 1 vector and 1 scalar
results = Simulink.SimulationOutput;
results.example_vector = example_vector;
results.example_scalar = example_scalar;
results.Time = Time;

%% Example 1: Plot All Vector Components on One Graph

example1 = ClassPlot("example_vector",[1 1],[1 2 3],"Time (s)",...
    {"Value (units)"}, {"Example Title"},["X" "Y" "Z"]);
example1 = example1.loadData(results);
plot(example1)

