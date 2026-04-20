
%dummy data
clear results Data
Time = linspace(0,10,300)';
example_vector = timeseries([ones(size(Time)),2*ones(size(Time)),3*ones(size(Time))],Time);
example_scalar = timeseries(4*ones(size(Time)),Time);

%dummy results structure with 2 data fields, 1 vector "example_vector" and
%1 scalar "example scalar"
results = Simulink.SimulationOutput;
results.example_vector = example_vector;
results.example_scalar = example_scalar;
results.Time = Time;

%% Example 1: 2x1 Subplot with Two Different Fields
close all
clc
example1 = ClassPlot("FigName",["example_vector","example_scalar"],...
    [2,1], {[1, 2, 3],[4]},["v_label1","v_label2"],"h_label",...
    ["subtitle1","subtitle2"],"supertitle",{["x","y","z"],["w"]});
plot(example1, results);

%% Example 2: 2x2 Subplot with One Signal on Each
example2 = ClassPlot("FigName",["example_vector","example_scalar"],...
    [2,2],{[1],[2],[3],[4]},["v_label1","v_label2","v_label3","vlabel4"],...
    "h_label",["subtitle1","subtitle2","subtitle3","subtitle4"],...
    "supertitle",{["x"],["y"],["z"],["w"]});
plot(example2, results)

%% Example 3: All Signals on One Plot
example3 = ClassPlot("FigName",["example_vector","example_scalar"],...
    [1,1],{[1 2 3 4]},["v_label1"],"h_label",[""],...
    "supertitle",{["x" "y" "z" "w"]});
plot(example3, results)
