clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 04 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Objetivo: Analisar sinais periodicos no dominio da frequencia com o uso da
Transformada Discreta de Fourier (DFT - Discrete Fourier Transform).
Reconstruir o sinal logo após, provando ser aceitável a representação em
Funções Descritivas considerando somente o primeiro harmônico ou harmônico
fundamental.

Elemento não linear utilizado na prática: Relé ideal com frequência de 2PI
rad/seg com Upper Limit = 2 e Lower Limit = 1
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%============================= QUESTAO 1 ==================================
%%
%Representar o elemento não linear relé ideal atraves da serie de Fourier
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
Yjw(1) = Yjw(1)/2;  %termo F0 da Série de Fourier, que representa a parte CC
frequency = (0: N-1)/T;
frequency_cutoff = ceil(N/2); %frequencia de corte

%gráfico do espectro harmônico do sinal da análise 1
figure
hold on
stem(frequency(1:frequency_cutoff), abs(Yjw), 'k')
set(gca, 'xtick', 0:1:50);
set(gca, 'ytick', 0:0.1:1.6);
grid on
grid minor
xlabel('Harmônicos')
ylabel('Amplitudes')
axis([0 50 0 1.6])
hold off
%==========================================================================
%============================= QUESTAO 2 ==================================
%%
%Reconstitua o sinal aproximado considerando N até 1. Comente quão
%aproximada esta a reconstituição.
%
%%
figure
hold on
t = [0:0.001:1];
%inserindo o sinal de saída IDEAL para o relé ideal

plot(t,[2*ones(1,ceil(length(t)/2)-1) 1*ones(1,ceil(length(t)/2))], 'k--');
%plot(t(ceil(length(t)/2)-1:ceil(length(t)/2)),[2 1],'k--');
%plot(t(ceil(length(t)/2):length(t)),1*ones(1,ceil(length(t)/2)),'k--');

%calculando o valor médio
f0 = Yjw(1);
number_of_harmonics = 50;
number_of_harmonics = number_of_harmonics + 1;

harmonics_function =  abs(f0*ones(1,length(t))); %valor medio
plot(t,harmonics_function, 'r-');
legends = {'Relé Ideal', 'Valor Médio'};

for N=2:number_of_harmonics
    %harmonics_function = harmonics_function + real(Yjw(N))*cos(2*pi*1*(N-1)*t) + imag(Yjw(N))*sin(2*pi*1*(N-1)*t);
    current_harmonic = abs(Yjw(N))*cos(t*2*pi*f_h*(N-1) + angle(Yjw(N)));
    if(abs(Yjw(N)) >= 0.01)
        %legends{N + 1} = strcat(num2str(N-1),'º Harmônico');
    else
        %legends{N + 1} = strcat(num2str(N-1),'º Harmônico = ZERO');
    end
    %plot(t,current_harmonic)
    harmonics_function = harmonics_function + current_harmonic;
    %plot(t,harmonics_function)
end
legends{end + 1} = 'Sinal de n até 50º harmônico';
plot(t,harmonics_function)
legend(legends);
hold off
%==========================================================================
