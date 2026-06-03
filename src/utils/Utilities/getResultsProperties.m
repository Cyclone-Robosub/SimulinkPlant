function new_results = getResultsProperties(results, properties)
% Modifies a Simulink.SimulationOutput object so that it only contains the
% desired properties

all_properties = results.who;
new_results = results;

% Validate that all properties in properties list exist
for k = 1:numel(properties)
    exists = results.find(properties(k));
    if(numel(exists) == 0)
        error("Property %s not found", properties(k))
    end
end

% Remove any properties not in properties list
for k = 1:numel(all_properties)
    if(~any(properties == all_properties(k)))
        new_results = removeProperty(new_results, all_properties(k));
    end
end

end