function dx=caso2(t,x);

%-------------------CEFET-MG Campus III Leopoldina ------------------------
%---------------- Engenharia de Controle e Automação ----------------------
%---------------- Laboratório Controle Automático III----------------------

%Professor: Murillo Ferreira dos Santos

% Esta função define a equação diferencial que será utilizada para
% construir o plano de fases através de um método numérico.

%-------------------------------------------------------------------
%Definição das variáveis
%x(1)=x(t)
%x(2)=dx/dt

%-------------------------------------------------------------------
%Definição da equação diferencial a desenhar no Plano de Fase
%m.DDx -b.(1 - x^2).Dx + k.x = 0

%Definindo as constantes
b = 1;
k = 1;
m = 1;

%Equação diferencial em espaço de estados
dx = [
        x(2);                           %Dx1  = x2
        (b*(1-x(1)^2)*x(2) - k*x(1))/m   %(b*(1-x^2).Dx - k.x)/m
     ]; 