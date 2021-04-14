function [K, T, L] = methodIdentificationSmith(vectorValues, vectorTime, inputFirstValue, inputFinalValue, tolerance)
%Treat the data from curve and return a new struct
%   Detailed explanation goes here

    deltaInput = inputFinalValue - inputFirstValue;
    deltaOutput = vectorValues(end) - vectorValues(1);

    % 28,3% do valor que o sistema estabiliza
    amp_28 = deltaOutput*0.283;
    % 63,2% do valor que o sistema estabiliza
    amp_63 = deltaOutput*0.632;
    %calculo do K que eh o ganho estatico do sistema deltaY/deltaU
    K = (deltaOutput)/(deltaInput);

    %loop para buscar o valor de tempo correspondente aos valores de amp_28
    %(28,3%) e amp_63(63,2%)
    for i=1:length(vectorValues)
        if( ((vectorValues(i) - vectorValues(1)) >= (amp_28-tolerance)) && ((vectorValues(i) - vectorValues(1))<=(amp_28+tolerance)) )
            t1_28 = vectorTime(i);
            vectorValues(i);
        end
        if( ((vectorValues(i) - vectorValues(1))>=(amp_63-tolerance)) && ((vectorValues(i) - vectorValues(1))<=(amp_63+tolerance)) )
            t2_63 = vectorTime(i);
            vectorValues(i);
        end
    end

    %Calculando as constantes L e T
    T = 1.5*(t2_63 - t1_28);
    L = 1.5*(t1_28 - (t2_63/3));
end

