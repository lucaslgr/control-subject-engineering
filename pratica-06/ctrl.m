clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 06 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo:  Realizar a simulação de sistemas não lineares com o SIMULINK, 
observando o comportamento das respostas para os casos de estabilidade/
instabilidade e ciclo limite..
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Montando a G(s) do sistema
num = 10;
den = conv([1 0], [1, 1]);
den = conv(den, [1, 2]);
linear_system = tf(num, den);
%Gerando o diagrama de Nyquist do sistema
nyquist(linear_system)
hold on

%Montando a função descritiva e plotando a sua inversa: 1/N
M = 1;
X = 0.1:0.01:10;
n = length(X);
for k=1:n
   N(k) = (4*M)/(pi*X(k)); %Encontrando os valores que compõe a função descritiva do sistema
   NInv(k)= -1/N(k); %1/N: Inverso da função descritiva do sistema
end

plot(real(NInv), imag(NInv), 'r')
legend('Diagrama de Nyquist', '1/N (N = Função Descritiva)');
title('Análise de Estabilidade e Ciclo Limite do Sistema');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');
axis([-3 0 -2 2]);
hold off