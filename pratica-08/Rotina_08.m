%-------------------CEFET-MG Campus III Leopoldina ------------------------
%---------------- Engenharia de Controle e Automa��o ----------------------
%---------------- Laborat�rio Controle Autom�tico III ----------------------

%Professor: Murillo Ferreira dos Santos

%--------------------------------------------------------------------------
%----------------------------- EXERC�CIO ----------------------------------
%--------------------------------------------------------------------------

clear all;
clc;
close all;

%-------------------------------------------------------------------
%Vari�vel auxiliar
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
%N�mero de curvas no gr�fico
n = 5;

%-------------------------------------------------------------------
%Valores m�ximos da grelha - Utilizados para apresentar os resultados
x_max  = 4;
Dx_max = 4;

%-------------------------------------------------------------------
%Inicializa��o da posi��o e da velocidade: Condi��es iniciais LETRA A
for i=1:n;
    for j=1:n;
        %Posi��o inicial na grelha
        x1 = -1;%(i - (n+1)/2)*x_max/n;  
        %x1 = (i - (n+1)/2)*x_max/n;        
        %Velocidade inicial na grelha
        x2 = -1;%(j-(n+1)/2)*Dx_max/n;
        %x2 = (j-(n+1)/2)*Dx_max/n;
        %Vetor inicial
        x0 = [x1;x2];
        %Integra��o das equa��es pelo m�todo de Runge Kutta 4 (5)
        [t,x] = ode45('caso2',vector_t,x0);
        %Representa��o das trajet�rias no plano de fase
        if (aux==1) %primeiro plot
            plot(x(:,1),x(:,2),'r-')
            hold on
            aux = 2;
        else
            plot(x(:,1),x(:,2),'r-')
        end        
    end
end
hold off

%Apresenta��o da parte importante do gr�fico
axis([-x_max,x_max,-Dx_max,Dx_max])

%Desenho dos eixos do gr�fico
line([-x_max,x_max],[0,0])
line([0,0],[-Dx_max,Dx_max])

%Legendas
title('Gr�fico do plano de fase para equa��o diferencial requerida')
xlabel('x2')
ylabel('x1')

figure
subplot(2,1,1)
plot(t,x(:,1))
xlabel('tempo')
ylabel('x1')

subplot(2,1,2)
plot(t,x(:,2))
xlabel('tempo')
ylabel('x2')