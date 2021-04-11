function filteredData = treatDataFromCurve(data)
%Treat the data from curve and return a new struct
%   Detailed explanation goes here
    filteredData = struct('timeX', [], 'temperatureY', []);
    aux = 0.0;
    for i=1:length(data.timeX)
        if (data.timeX(i) > aux || i == 1)
            filteredData.timeX(i) = data.timeX(i);
            filteredData.temperatureY(i) = data.temperatureY(i);
        else
            break
        end

        aux = data.timeX(i);
    end
end

