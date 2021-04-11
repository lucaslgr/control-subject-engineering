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

[K1, T1, L1] = methodIdentificationSmith(filteredDataHeating.temperatureY, filteredDataHeating.timeX)
[K2, T2, L2] = methodIdentificationSmith(filteredDataCoolingDown.temperatureY, filteredDataCoolingDown.timeX)




