function [K, T, L] = methodIdentificationSmith(vectorValues, vectorTime)
%Treat the data from curve and return a new struct
%   Detailed explanation goes here

    % 28,3% do valor que o sistema estabiliza
    amp_28 = vectorValues(end)*0.283;
    flag_amp_28_found = false;
    % 63,2% do valor que o sistema estabiliza
    amp_63 = vectorValues(end)*0.632;
    flag_amp_63_found = false;
    %calculo do K que eh o ganho estatico do sistema deltaY/deltaU
    K = (vectorValues(end) - vectorValues(1))/(1 - 0);

    % definindo uma tolerancia de erro para encontrar os valores de tempo
    % correspondentes a amp_28 e amp_63
    %tolerance1 = 0.001; %%EU subtitui pelas flags que encontram o primeiro valor
    %maior ou igual

    %loop para buscar o valor de tempo correspondente aos valores de amp_28
    %(28,3%) e amp_63(63,2%)
    for i=1:length(vectorValues)
        if((vectorValues(i)>=amp_28) && flag_amp_28_found == false)
            t1_28 = vectorTime(i);
            vectorValues(i);
            flag_amp_28_found = true;
        end
        if((vectorValues(i)>=amp_63) && flag_amp_63_found == false)
            t2_63 = vectorTime(i);
            vectorValues(i);
            flag_amp_63_found = true;
        end
    end

    %Calculando as constantes L e T
    T = 1.5*(t2_63 - t1_28);
    L = 1.5*(t1_28 - (t2_63/3));
end

