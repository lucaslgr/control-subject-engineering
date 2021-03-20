clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 05 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo: Analisar componentes não lineares básicos, verificando que o 
princípio da superposição não é válido para tais elementos. Para sinais de 
excitação senoidal, verificar a deformação do sinal de saída, com o 
aparecimento de componentes harmônicos na saída de elementos não lineares.
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%================= PARTE 2 - Elemento N-Linear: Dead Zone =================
%%
% Explicação: 
%
%%

%Pegando o respectivo sinal de saida para cada entrada
sim('pt2_signal2_deadzone');
deadZone1 = ans.output_deadzone1;
deadZone1_input1 = deadZone1.signals.values(:,1);
deadZone1_input2 = deadZone1.signals.values(:,2);
deadZone1_output1 = deadZone1.signals.values(:,3);
deadZone1_output2 = deadZone1.signals.values(:,4);
deadZone1_time = deadZone1.time;

figure
hold on
plot(deadZone1_time,deadZone1_input1, 'k-');
plot(deadZone1_time,deadZone1_input2, 'r-');
plot(deadZone1_time,deadZone1_output1, 'g-');
plot(deadZone1_time,deadZone1_output2, 'b-');
legend({
    ' Entrada = 0,09send(20\pit)',
    ' Entrada = 0,03send(60\pit + 180º)',
    'Saída p/ Entrada = 0,09send(20\pit)',
    'Saída p/ Entrada = 0,03send(60\pit + 180º)'
});
xlabel('Tempo')
ylabel('Amplitudes')
hold off

%Comparando a soma das saídas, com o a saída utilizando a soma das entradas
%pelo método de superposição
deadZone2 = ans.output_deadzone2;
deadZone2_output1 = deadZone2.signals.values(:,1);
deadZone2_output2 = deadZone2.signals.values(:,2);
deadZone2_time = deadZone1.time;

figure
hold on
plot(deadZone2_time,deadZone2_output1, 'k-');
plot(deadZone2_time,deadZone2_output2, 'r-');
legend({
    'Saída p/ soma das respostas individuais',
    'Saída p/ resposta respectiva ao sinal da soma dos dois sinais de entrada'
});
xlabel('Tempo')
ylabel('Amplitudes')
hold off