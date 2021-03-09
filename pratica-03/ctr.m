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

2 - Anlise: Determinar o espectro de um sinal quadrado com 100 amostras em
1 ciclo completo (as primeiras cinquenta amostras possuem valor 1 e as 
cinquenta seguintes possuem o valor 0) e deltaT = 0,01 segundos.

%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% ANALISE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%===== GERANDO O SINAL A SER ANALISADO ======
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

%gráfico da fundamental + harmônicas que compõe o sinal (Na primeira análise já foi dado no enunciado as componentes)
figure
plot(t, x1, 'k-.')
hold on
plot(t, x2, 'b-.')
plot(t, x3, 'g--')
plot(t, x, 'r')
xlabel('Tempo (seg)')
ylabel('Amplitude')
legend('x_1(Fundamental)','x_2(Terceira Harmônica)','x_3(Décima Harmônica)','x(Soma)')
hold off
%==============================================

% Calculando a FFT discreta do sinal da análise 1
X = fft(x);
Xjw = 2*(1/N)*X(1:N/2); %normalizando a respota da FFT pelo eixo das abscissas e ordenadas
Xjw(1) = Xjw(1)/2;  %termo F0 da Série de Fourier, que representa a parte CC

frequency = (0: N-1)/T;
frequency_cutoff = ceil(N/2); %frequencia de corte

%gráfico do espectro harmônico do sinal da análise 1
figure
hold on
stem(frequency(1:frequency_cutoff), abs(Xjw), 'k')
set(gca, 'xtick', 0:1:20);
grid on
grid minor
xlabel('Harmônicos')
ylabel('Amplitudes')
axis([0 20 0 1.5])
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% ANALISE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%===== GERANDO O SINAL A SER ANALISADO ======
N = 100; %numero de amostras por ciclo
f_w = 2*pi; %frequencia do sinal em rad/s
f_h = f_w/(2*pi); %frequencia do sinal em hertz
T = 1/f_h; %periodo do sinal
deltaT = T/N; %passo de tempo
t = 0:deltaT:(T-deltaT); %vetor de tempo

y = zeros(1,100);
for i=1:1:N
    if (i<=50)
        y(i) = 1;
    end
    if (i>50)
        y(i) = 0;
    end
end

%gráfico do sinal quadrado estudado na segunda análise
figure
hold on
plot(t,y,'r')
grid on
xlabel('Tempo (seg)')
ylabel('Amplitude')
legend('Sinal Quadrado Estudado')
axis([0 1 0 1.5])
hold off
%==============================================

%Foi calculado a Série de Fourier analitcamente (manualmente) e foi
%encontrado os seguintes sinais que representam de F0 até a 5ªHarmônica

F0 = 0.5; % F0=a0/2 que representa a componente CC do sinal
c1 = 0.6366; % amplitude c1 = sqrt(a1^2+b1^2)
c3 = 0.2122; % amplitude c3 = sqrt(a3^2+b3^2)
c5 = 0.1273; % amplitude c5 = sqrt(a5^2+b5^2)
y1 = c1*sin(2*pi*1*t); %fundamental
y3 = c3*sin(2*pi*3*t); %terceiro harmônico
y5 = c5*sin(2*pi*5*t); %quinto harmônico
y_analytics = y1+y3+y5; %sinal quadrado, somatorio de x1+x3+x5

%gráfico da fundamental + harmônicas que compõe o sinal da análise 2
figure
plot(t, y_analytics, 'k-.')
hold on
plot(t, y1, 'b--')
plot(t, y3, 'g--')
plot(t, y5, 'r')
xlabel('Tempo (seg)')
ylabel('Amplitude')
legend('y(Soma)', 'y_1(Fundamental)', 'y_3(Terceira Harmônica)','y_3(Quinta Harmônica)')
hold off

% Calculando a FFT discreta do sinal da análise 2
X = fft(y);
Xjw = 2*(1/N)*X(1:N/2); %normalizando a respota da FFT pelo eixo das abscissas e ordenadas
Xjw(1) = Xjw(1)/2; %termo F0 da Série de Fourier, que representa a parte CC

frequency = (0: N-1)/T;
frequency_cutoff = ceil(N/2); %frequencia de corte

%gráfico do espectro harmônico do sinal da análise 2
figure
hold on
stem(frequency(1:frequency_cutoff), abs(Xjw), 'k')
set(gca, 'xtick', 0:1:50);
grid on
grid minor
xlabel('Harmônicos')
ylabel('Amplitudes')
axis([0 50 0 0.7])
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

