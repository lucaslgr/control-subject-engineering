function dx=caso1(t,x);

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
%DDx + Dx + |x| = 0

%Equação diferencial em espaço de estados
dx = [
        x(2);                   %Dx1  = x2
        -x(2)-abs(x(1))         %DDx2 = -x2 - |x|
     ]; 