clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 07 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo:  Realizar a simulação de sistemas não lineares com o SIMULINK, 
observando o comportamento das respostas para os casos de estabilidade/
instabilidade e ciclo limite..
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Montando a G(s) do sistema
num = 3;
den = [2 1];
%Gerando a funcao de atraso de transporte utilizando a funcao pade
[delay_num, delay_den] = pade(0.1 , 2);

num = conv(num, delay_num);
den = conv(den, delay_den);

linear_system = tf(num, den)
%Gerando o diagrama de Nyquist do sistema da parte linear
nyquist(linear_system)
hold on

%Montando a função descritiva e plotando a sua inversa: 1/N
%caracteristica do elemento n-linear relay
M = 5;
h = 0.1; %referente a histerese
X = 0.1:0.01:10;
n = length(X);
for k=1:n
   N(k) = ((4*M)/(pi*X(k))) * exp(i*(-asin(h/X(k)) )); %Encontrando os valores que compõe a função descritiva do sistema
   NInv(k)= -1/N(k); %1/N: Inverso da função descritiva do sistema
end

plot(real(NInv), imag(NInv), 'r')
legend('Diagrama de Nyquist', '1/N (N = Função Descritiva)');
title('Análise de Estabilidade e Ciclo Limite do Sistema');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');
axis([-0.15 0.1 -0.2 0.2]);
set(gca,'ytick',-0.2:.02:0.2)
set(gca,'xtick',-0.15:.02:0.1)
hold off
