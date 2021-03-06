clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 03 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo: Analisar sinais periodicos no dominio da frequencia com o uso da
Transformada Discreta de Fourier (DFT - Discrete Fourier Transform)

1 - Analise: Determinar o espectro do sinal x(t) determinado a seguir,
amostrado com N=100 pontos por ciclo.

x(t) =1,0sin(2PIt) + 0,2sin(6PIt) + 0,05sin(20PIt)

1. Qual a frequencia fundamental deste sinal? (Hz)
2. Gere o grafico com sinal em funcao do tempo e seu espectro. Qual a
componente CC deste sinal? O resultado da fft, Xjw(1), condiz com o
esperado?
3. Qual o módulo das componentes Xjw(2), Xjw(4) e Xjw(11)? Esses valores
sao correspondentes as amplitudes das componentes senoidais do sinal?
4. Existe defasagem entre Xjw(2), Xjw(4) e Xjw(11)? Mostre a justificativa.

2 - Analise: Determinar o espectro de um sinal quadrado com 100 amostras em
1 (um) ciclo completo (as cinquenta primeiras amostras possuem valor "1" e
as cinquenta seguintes possuem valor "0") e deltaT = 0.01 segundos.

1. Qual a frequencia fundamental deesse sinal? (Hz)
2. Gere o grafico com o sinal em funcao do tempo e seu espectro. Qual a
componente CC deste sinal? O resultado da fft, Xjw(1), condiz com o
esperado?
3. Qual o modulo dos componentes Xjw(2), Xjw(4), Xjw(6)? Esses valores sao
correspondentes as amplitudes das componentes senoidais dos sinal?
4. Existe defasagem entre Xjw(2), Xjw(4) e Xjw(6)? Mostre justificativa.

%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=================== GERANDO O SINAL A SER ANALISADO ======================
N = 1000; %numero de amostras
f_w = 2*pi; %frequencia do sinal em rad/s
f_h = f_w/(2*pi); %frequencia do sinal em hertz
T = 1/f_h; %periodo do sinal
deltaT = T/N; %passo de tempo
t = 0:deltaT:(T-deltaT); %vetor de tempo

%calculando cada termo do sinal para o respectivo ponto no tempo
x1 = 1.0*sin(2*   pi*t);
x2 = 0.2*sin(6*   pi*t);
x3 = 0.05*sin(20* pi*t);
%somando todas as partes do sinal
x = x1 + x2 + x3;

figure
plot(t, x1, 'k:')
hold on
plot(t, x2, 'b-.')
plot(t, x3, 'g--')
plot(t, x, 'r')
xlabel('Tempo (seg)')
ylabel('Amplitude')
legend('x_1','x_2','x_3','x')
hold off

X = fft(x);
Xjw = 2*(1/N)*X(1:N/2);
Xjw(1) = Xjw(1)/2;

figure
plot(abs(Xjw), 'k')
grid on
xlabel('Harmonicos')
ylabel('Amplitudes')
axis([0 20 0 1.5])

%==========================================================================



%%%%%%%%%%%%%%%%%%%%%%%%%%% ANALISE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Q1



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%% ANALISE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

