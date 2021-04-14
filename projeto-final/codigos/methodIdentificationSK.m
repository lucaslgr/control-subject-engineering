function [K, T, L] = methodIdentificationSK(vectorValues, vectorTime, inputFirstValue, inputFinalValue, tolerance)
%Treat the data from curve and return a new struct
%   Detailed explanation goes here

    deltaInput = inputFinalValue - inputFirstValue;
    deltaOutput = vectorValues(end) - vectorValues(1);

    % 35,3% do valor que o sistema estabiliza
    amp_35 = deltaOutput*0.353;
    % 85,3% do valor que o sistema estabiliza
    amp_85 = deltaOutput*0.853;
    %calculo do K que eh o ganho estatico do sistema deltaY/deltaU
    K = (deltaOutput)/(deltaInput);

    %loop para buscar o valor de tempo correspondente aos valores de amp_35
    %(28,3%) e amp_85(63,2%)
    for i=1:length(vectorValues)
        if( ((vectorValues(i) - vectorValues(1)) >= (amp_35-tolerance)) && ((vectorValues(i) - vectorValues(1))<=(amp_35+tolerance)) )
            t1_35 = vectorTime(i);
            vectorValues(i);
        end
        if( ((vectorValues(i) - vectorValues(1))>=(amp_85-tolerance)) && ((vectorValues(i) - vectorValues(1))<=(amp_85+tolerance)) )
            t2_85 = vectorTime(i);
            vectorValues(i);
        end
    end

    %Calculando as constantes L e T
    T = 0.67*(t2_85 - t1_35);
    L = 1.3*t1_35 - 0.29*t2_85;
end

