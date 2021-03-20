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

%================= PARTE 2 - Elemento N-Linear: Dead Zone =================
%%
% Explica��o: 
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
    ' Entrada = 0,03send(60\pit + 180�)',
    'Sa�da p/ Entrada = 0,09send(20\pit)',
    'Sa�da p/ Entrada = 0,03send(60\pit + 180�)'
});
xlabel('Tempo')
ylabel('Amplitudes')
hold off

%Comparando a soma das sa�das, com o a sa�da utilizando a soma das entradas
%pelo m�todo de superposi��o
saturation2 = ans.output_saturation2;
saturation2_output1 = saturation2.signals.values(:,1);
saturation2_output2 = saturation2.signals.values(:,2);
saturation2_time = saturation1.time;


figure
hold on
plot(saturation2_time,saturation2_output1, 'k-');
plot(saturation2_time,saturation2_output2, 'r-');
legend({
    'Sa�da p/ soma das respostas individuais',
    'Sa�da p/ resposta respectiva ao sinal da soma dos dois sinais de entrada'
});
xlabel('Tempo')
ylabel('Amplitudes')
hold off