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
sim('pt2_signal1_saturation');
saturation1 = ans.output_saturation1;
saturation1_input1 = saturation1.signals.values(:,1);
saturation1_input2 = saturation1.signals.values(:,2);
saturation1_output1 = saturation1.signals.values(:,3);
saturation1_output2 = saturation1.signals.values(:,4);
saturation1_time = saturation1.time;

figure
hold on
plot(saturation1_time,saturation1_input1, 'k-');
plot(saturation1_time,saturation1_input2, 'r-');
plot(saturation1_time,saturation1_output1, 'g-');
plot(saturation1_time,saturation1_output2, 'b-');
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
saturation2 = ans.output_saturation2;
saturation2_output1 = saturation2.signals.values(:,1);
saturation2_output2 = saturation2.signals.values(:,2);
saturation2_time = saturation1.time;


figure
hold on
plot(saturation2_time,saturation2_output1, 'k-');
plot(saturation2_time,saturation2_output2, 'r-');
legend({
    'Saída p/ soma das respostas individuais',
    'Saída p/ resposta respectiva ao sinal da soma dos dois sinais de entrada'
});
xlabel('Tempo')
ylabel('Amplitudes')
hold off