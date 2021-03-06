clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 05 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo: Analisar componentes n�o lineares b�sicos, verificando que o 
princ�pio da superposi��o n�o � v�lido para tais elementos. Para sinais de 
excita��o senoidal, verificar a deforma��o do sinal de sa�da, com o 
aparecimento de componentes harm�nicos na sa�da de elementos n�o lineares.
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%========= PARTE 1 - Elemento N-Linear: Coulomb & Viscous Friction ========
%%
% Explica��o: 
%
%%

%Entrada senoidal com amplitude X=0.001
sim('pt1_sin_waves_coulomb_viscous_friction');
sinWaveX001 = ans.sinWaveX001;
sinWaveX001_input = sinWaveX001.signals.values(:,1);
sinWaveX001_output = sinWaveX001.signals.values(:,2);
sinWaveX001_time = sinWaveX001.time;

figure
hold on
plot(sinWaveX001_time,sinWaveX001_input, 'k-');
plot(sinWaveX001_time,sinWaveX001_output, 'r-');
legend({'Entrada Senoidal', 'Sa�da'});
xlabel('Tempo')
ylabel('Amplitudes')
hold off

%Entrada senoidal com amplitude X=0.51
sinWaveX051 = ans.sinWaveX051;
sinWaveX051_input = sinWaveX051.signals.values(:,1);
sinWaveX051_output = sinWaveX051.signals.values(:,2);
sinWaveX051_time = sinWaveX051.time;

figure
hold on
plot(sinWaveX051_time,sinWaveX051_input, 'k-');
plot(sinWaveX051_time,sinWaveX051_output, 'g-');
legend({'Entrada Senoidal', 'Sa�da'});
xlabel('Tempo')
ylabel('Amplitudes')
hold off

%Entrada senoidal com amplitude X=1.01
sinWaveX101 = ans.sinWaveX101;
sinWaveX101_input = sinWaveX101.signals.values(:,1);
sinWaveX101_output = sinWaveX101.signals.values(:,2);
sinWaveX101_time = sinWaveX101.time;

figure
hold on
plot(sinWaveX101_time,sinWaveX101_input, 'k-');
plot(sinWaveX101_time,sinWaveX101_output, 'b-');
legend({'Entrada Senoidal', 'Sa�da'});
xlabel('Tempo')
ylabel('Amplitudes')
hold off

%Todas as saidas para todas entradas
sinWaveXAll = ans.sinWaveXAll;
sinWaveXAll_output001 = sinWaveXAll.signals.values(:,1);
sinWaveXAll_output051 = sinWaveXAll.signals.values(:,2);
sinWaveXAll_output101 = sinWaveXAll.signals.values(:,3);
sinWaveXAll_time = sinWaveXAll.time;

figure
hold on
plot(sinWaveXAll_time,sinWaveXAll_output001, 'r-');
plot(sinWaveXAll_time,sinWaveXAll_output051, 'g-');
plot(sinWaveXAll_time,sinWaveXAll_output101, 'b-');
legend({
    'Sa�da p/ Entrada com amplitude X = 0,01',
    'Sa�da p/ Entrada com amplitude X = 0,51',
    'Sa�da p/ Entrada com amplitude X = 1,01'
    });
xlabel('Tempo')
ylabel('Amplitudes')
hold off