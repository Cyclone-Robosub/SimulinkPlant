%example for classplot
clc
close all

results = Simulink.SimulationOutput;

t = linspace(0,100,100)';
example_signal = timeseries([ones(size(t)),2*ones(size(t)), 3*ones(size(t))],t);

results.example_signal = example_signal;


example_plot = ClassPlot("Example","example_signal",[3,1],{1,2,3},["var 1","var 2","var 3"],["Tim1","Time2","Time3"],["var1 title","var2 title","var3 title"],"supertitle",{"signal1","signal2","signal3"});
example_plot.plot(results)
