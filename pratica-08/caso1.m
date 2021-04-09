function dx=caso1(t,x);

%-------------------CEFET-MG Campus III Leopoldina ------------------------
%---------------- Engenharia de Controle e Automa��o ----------------------
%---------------- Laborat�rio Controle Autom�tico III----------------------

%Professor: Murillo Ferreira dos Santos

% Esta fun��o define a equa��o diferencial que ser� utilizada para
% construir o plano de fases atrav�s de um m�todo num�rico.

%-------------------------------------------------------------------
%Defini��o das vari�veis
%x(1)=x(t)
%x(2)=dx/dt

%-------------------------------------------------------------------
%Defini��o da equa��o diferencial a desenhar no Plano de Fase
%DDx + Dx + |x| = 0

%Equa��o diferencial em espa�o de estados
dx = [
        x(2);                   %Dx1  = x2
        -x(2)-abs(x(1))         %DDx2 = -x2 - |x|
     ]; 