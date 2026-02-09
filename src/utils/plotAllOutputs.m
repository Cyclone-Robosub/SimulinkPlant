function plotAllOutputs(plots,results,varargin)

%unpack optional argument(s)
if nargin > 2
    target_plot_names = varargin{1};
    plot_all_flag = false;
else
    target_plot_names = {};
    plot_all_flag = true;
end

if(~isempty(target_plot_names))
    names = cell(size(target_plot_names));
    for k = 1:length(plots)
        names{k} = plots(k).name;
    end
end

if(plot_all_flag)
    for k = 1:length(plots)
        plot(plots(k),results);
    end
else
    for k = 1:length(names)
        if(ismember(names{k},[target_plot_names{:}]))
            plot(plots(k),results);
        end
    end
end
    
end
