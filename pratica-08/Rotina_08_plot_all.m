%-------------------CEFET-MG Campus III Leopoldina ------------------------
%---------------- Engenharia de Controle e Automação ----------------------
%---------------- Laboratório Controle Automático III ----------------------

%Professor: Murillo Ferreira dos Santos

%--------------------------------------------------------------------------
%----------------------------- EXERCÍCIO ----------------------------------
%--------------------------------------------------------------------------

clear all;
clc;
close all;

%-------------------------------------------------------------------
%Variável auxiliar
aux = 1;

%-------------------------------------------------------------------
%Incremento de tempo
dt = 0.001;

%-------------------------------------------------------------------
%Intervalo de tempo a considerar
t0    = 0;
t_max = 50;

for i=t0:dt:t_max
    vector_t(aux) = [i];
    aux = aux + 1;
end
aux = 1;

%-------------------------------------------------------------------
%Número de curvas no gráfico
n = 5;

%-------------------------------------------------------------------
%Valores máximos da grelha - Utilizados para apresentar os resultados
x_max  = 4;
Dx_max = 4;

%-------------------------------------------------------------------
%Inicialização da posição e da velocidade: Condições iniciais LETRA A
for i=1:n;
    for j=1:n;
        %Posição inicial na grelha
        x1 = 1;%(i - (n+1)/2)*x_max/n;  
        %x1 = (i - (n+1)/2)*x_max/n;        
        %Velocidade inicial na grelha
        x2 = 0;%(j-(n+1)/2)*Dx_max/n;
        %x2 = (j-(n+1)/2)*Dx_max/n;
        %Vetor inicial
        x0_a = [x1;x2];
        
        x1 = 0;
        x2 = 1;
        x0_b = [x1;x2];
        
        x1 = -1;
        x2 = -1;
        x0_c = [x1;x2];
        
        %Integração das equações pelo método de Runge Kutta 4 (5)
        [t,xa] = ode45('caso2',vector_t,x0_a);
        [t,xb] = ode45('caso2',vector_t,x0_b);
        [t,xc] = ode45('caso2',vector_t,x0_c);
        %Representação das trajetórias no plano de fase
        if (aux==1) %primeiro plot
            plot(xa(:,1),xa(:,2),'r-')
            hold on
            aux = 2;
        else
            plot(xa(:,1),xa(:,2),'r-')
        end        
    end
end
hold off

%Apresentação da parte importante do gráfico
axis([-x_max,x_max,-Dx_max,Dx_max])

%Desenho dos eixos do gráfico
line([-x_max,x_max],[0,0])
line([0,0],[-Dx_max,Dx_max])

%Legendas
title('Gráfico do plano de fase para equação diferencial requerida')
xlabel('x2')
ylabel('x1')

figure
subplot(2,1,1)
hold on
plot(t,xa(:,1))
plot(t,xb(:,1))
plot(t,xc(:,1))
legend('x1=1 e x2=0', 'x1=0 e x2=1', 'x1=-1 e x2=-1')
xlabel('Tempo')
ylabel('x1(Posição)')
hold off

subplot(2,1,2)
hold on
plot(t,xa(:,2))
plot(t,xb(:,2))
plot(t,xc(:,2))
legend('x1=1 e x2=0', 'x1=0 e x2=1', 'x1=-1 e x2=-1')
xlabel('Tempo')
ylabel('x2(Velocidade)')
hold off