clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 04 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo: Analisar sinais periodicos no dominio da frequencia com o uso da
Transformada Discreta de Fourier (DFT - Discrete Fourier Transform).
Reconstruir o sinal logo ap�s, provando ser aceit�vel a representa��o em
Fun��es Descritivas considerando somente o primeiro harm�nico ou harm�nico
fundamental.

Elemento n�o linear utilizado na pr�tica: Rel� ideal com frequ�ncia de 2PI
rad/seg com Upper Limit = 2 e Lower Limit = 1
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================= QUESTAO 1 ==================================
%%
%Representar o elemento n�o linear rel� ideal atraves da serie de Fourier
%de froma generica para "n" harmonicos. Apresente a formulacao teorica
%juntamente com a representacao obtida atraves da funcao fft do MATLAB.
%
%%

f_w = 2*pi; %frequencia do sinal senoidal em rad/s
f_h = f_w/(2*pi); %frequencia do sinal senoidal em hertz
T = 1/f_h; %periodo do sinal senoidal

sim('relay_MFS');

y = output_relay.signals.values; %saida do relay para entrada senoidal
N = (length(y) - 1); %numero de amostras

% Calculando a FFT discreta do sinal
Y = fft(y);
Yjw = 2*(1/N)*Y(1:ceil(N/2)); %normalizando a respota da FFT pelo eixo das abscissas e ordenadas
Yjw(1) = Yjw(1)/2;  %termo F0 da S�rie de Fourier, que representa a parte CC
frequency = (0: N-1)/T;
frequency_cutoff = ceil(N/2); %frequencia de corte

%gr�fico do espectro harm�nico do sinal da an�lise 1
figure
hold on
stem(frequency(1:frequency_cutoff), abs(Yjw), 'k')
set(gca, 'xtick', 0:1:50);
set(gca, 'ytick', 0:0.1:1.6);
grid on
grid minor
xlabel('Harm�nicos')
ylabel('Amplitudes')
axis([0 50 0 1.6])
hold off
%==========================================================================
%============================= QUESTAO 2 ==================================
%%
%Reconstitua o sinal aproximado considerando N at� 1. Comente qu�o
%aproximada esta a reconstitui��o.
%
%%
figure
hold on
t = [0:0.001:1];
%inserindo o sinal de sa�da IDEAL para o rel� ideal

plot(t,[2*ones(1,ceil(length(t)/2)-1) 1*ones(1,ceil(length(t)/2))], 'k--');
%plot(t(ceil(length(t)/2)-1:ceil(length(t)/2)),[2 1],'k--');
%plot(t(ceil(length(t)/2):length(t)),1*ones(1,ceil(length(t)/2)),'k--');

%calculando o valor m�dio
f0 = Yjw(1);
number_of_harmonics = 50;
number_of_harmonics = number_of_harmonics + 1;

harmonics_function =  abs(f0*ones(1,length(t))); %valor medio
plot(t,harmonics_function, 'r-');
legends = {'Rel� Ideal', 'Valor M�dio'};

for N=2:number_of_harmonics
    %harmonics_function = harmonics_function + real(Yjw(N))*cos(2*pi*1*(N-1)*t) + imag(Yjw(N))*sin(2*pi*1*(N-1)*t);
    current_harmonic = abs(Yjw(N))*cos(t*2*pi*f_h*(N-1) + angle(Yjw(N)));
    if(abs(Yjw(N)) >= 0.01)
        %legends{N + 1} = strcat(num2str(N-1),'� Harm�nico');
    else
        %legends{N + 1} = strcat(num2str(N-1),'� Harm�nico = ZERO');
    end
    %plot(t,current_harmonic)
    harmonics_function = harmonics_function + current_harmonic;
    %plot(t,harmonics_function)
end
legends{end + 1} = 'Sinal de n at� 50� harm�nico';
plot(t,harmonics_function)
legend(legends);
hold off
%==========================================================================
