clear all;
close all;
clc;

%% REAL
dataReactionCurveCoolingdownReal = getJsonDataFromFile('dataReactionCurve-coolingdown.json');
dataReactionCurveHeatingReal = getJsonDataFromFile('dataReactionCurve-heating.json');

dataReactionCurveCoolingdownReal = treatDataFromCurve(dataReactionCurveCoolingdownReal);
dataReactionCurveHeatingReal = treatDataFromCurve(dataReactionCurveHeatingReal);

%% APROX
sim('Smith')

dataReactionCurveCoolingdownAprox = ans.dataReactionCurveCoolingdownAprox.signals.values;
dataReactionCurveHeatingAprox = ans.dataReactionCurveHeatingAprox.signals.values;
timeAprox = ans.dataReactionCurveHeatingAprox.time;
%-------------------------------------------------------------------------%

figure()
plot(dataReactionCurveCoolingdownReal.timeX, dataReactionCurveCoolingdownReal.temperatureY, 'linewidth', 2)
grid on
grid minor
xlabel('Time(sec)')
ylabel('Temperature(Cº)')
xlim([0 1000])
hold on
plot(timeAprox, dataReactionCurveCoolingdownAprox, 'linewidth', 2) 
legend('Cooling plant curve','Smith approximate')
hold off

figure()
plot(dataReactionCurveHeatingReal.timeX, dataReactionCurveHeatingReal.temperatureY, 'linewidth', 2) 
grid on
grid minor
xlabel('Time(sec)')
ylabel('Temperature(Cº)')
xlim([0 1000])
hold on
plot(timeAprox, dataReactionCurveHeatingAprox, 'linewidth', 2) 
legend('Heating plant curve','Smith approximate')
hold off
