close all;
clear all;
clc;

sim('Discrete_Controle_MISO_2019a');

response = ans;
outputCotrolledSystem = response.systemout.signals.values;
referenceCotrolledSystem = response.setpoint.signals.values;
time = response.tout;

figure()
plot(time, outputCotrolledSystem, 'linewidth', 2) 
grid on
grid minor
xlabel('Time(sec)')
ylabel('Temperature(Cº)')
hold on
plot(time, referenceCotrolledSystem, 'linewidth', 2) 
legend('System output controlled','Setpoint')
hold off