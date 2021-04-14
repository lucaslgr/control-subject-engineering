clc
clear
close all

%lendos os dados dos arquivos
dataHeating = getJsonDataFromFile('dataReactionCurve-heating.json');
dataCoolingDown = getJsonDataFromFile('dataReactionCurve-coolingdown.json');

%filtrando os dados das curvas
filteredDataHeating = treatDataFromCurve(dataHeating);
filteredDataCoolingDown = treatDataFromCurve(dataCoolingDown);

%plotando os graficos
figure(1)
hold on
plot(filteredDataHeating.timeX,filteredDataHeating.temperatureY, 'r')
xlabel('Tempo(s)')
ylabel('Temperatura(ºC)')
title('Curva de Reação da Planta - Esquentando')
hold off

figure(2)
hold on
plot(filteredDataCoolingDown.timeX,filteredDataCoolingDown.temperatureY, 'b')
xlabel('Tempo(s)')
ylabel('Temperatura(ºC)')
title('Curva de Reação da Planta - Esfriando')
hold off

%calculando as constantes para encontrar a G(s) aproximada da planta pelo
%metodo de SMITH aplicado a curva ded reacao
%[K1_SK, Tau1_SK, L1_SK] = methodIdentificationSK(filteredDataHeating.temperatureY, filteredDataHeating.timeX, 0, 100, 0.5)
%[K2_SK, Tau2_SK, L2_SK] = methodIdentificationSK(filteredDataCoolingDown.temperatureY, filteredDataCoolingDown.timeX, 0, 100, 0.5)

[K1, Tau1, L1] = methodIdentificationSmith(filteredDataHeating.temperatureY, filteredDataHeating.timeX, 0, 1, 2)
[K2, Tau2, L2] = methodIdentificationSmith(filteredDataCoolingDown.temperatureY, filteredDataCoolingDown.timeX, 0, 1, 2)