clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRATICA 01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Dada a funcao de transferencia abaixo, determine:

G(S) = 6 / (s^2 + 9s + 9)

1. Controle o sistema representado pela funcao de transferencia acima pelo 
metodo de identificacao de Smith atraves de um controlador PID continuo de
Ziegler-Nichols e CohenCoon.

2. Dicretize os dois controladores PID encontrados atraves do metodo de 
discretizacao de Tustin, abordado na teoria, para 2 frequencias de 
amostragem: 0.1 e 0.001 segundos. Lembre-se de utilizar um filtro 
passa-baixa!

3. Confeccione um relatorio descrevendo estas situacoes, realizando 
comparacoes entre o sistema controlado pelo PID continuo e discreto.
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Parte1
%{
Pegando a funcao de transferencia real da planta dando uma entrada degrau por 7 
segundos com passo de T=0,0001s e salvando os dados de saidaXtempo na 
estrutura resp.ela
%}
sim('FTreal')
x_real = resp.time;
y_real = resp.signals.values;

%%%Parte2 
%{
- identificar que o sistema cresce ou decresce linearmente apos o
atraso de transporte e estabiliza em um valor, podemos considerar que o
sistema eh monotonico e sendo monotonico podemos aproxima-lo de uma sistema
de primeiro grau atraves do metodo de SMITH.
Aplicando o metodo de curva de reacao e analise por metodo de Smith para 
aproximar a planta de uma G(s) de primeira ordem.
- 1 Encontrar Tal: constante de tempo do sistema
- 2 Encontrar L: atraso de transporte do sistema.
- 3 Encontrar o K: constante de ganho estatico do sistema.
- 4 Montar a G(s) aproximada de 1ï¿½ ordem com os valores acima
%}
% 28,3% do valor que o sistema estabiliza
amp_28 = y_real(end)*0.283;
% 63,2% do valor que o sistema estabiliza
amp_63 = y_real(end)*0.632;
%calculo do K que eh o ganho estatico do sistema deltaY/deltaU
K = (y_real(end) - y_real(1))/(input.signals.values(end) - 0);

% definindo uma tolerancia de erro para encontrar os valores de tempo
% correspondentes a amp_28 e amp_63
tolerance1 = 0.0001;

%loop para buscar o valor de tempo correspondente aos valores de amp_28
%(28,3%) e amp_63(63,2%)
for i=1:length(y_real)
    if((y_real(i)>=amp_28-tolerance1) && (y_real(i)<=amp_28+tolerance1))
        t1_28 = x_real(i)
        y_real(i)
    end
    if((y_real(i)>=amp_63-tolerance1) && (y_real(i)<=amp_63+tolerance1))
        t2_63 = x_real(i)
        y_real(i)
    end
end

%Calculando as constantes L e T
T = 1.5*(t2_63 - t1_28);
L = 1.5*(t1_28 - (t2_63/3));
%Montando o sistema aproximado de primeiro grau atraves do metodo de SMITH
sim('FTaprox')
x_aprox = resp_aprox.time;
y_aprox = resp_aprox.signals.values;

%%%<Plotando os graficos da Figura 1>
figure(1)
%%%primeiro usando a funcao de transferencia real da planta
plot(x_real, y_real, 'b')
hold on
%%%segundo usando a aproximada obtida atraves do metodo de Smith
plot(x_aprox, y_aprox, 'r')
title('G(s) Real x G(s) Aproximada');
legend('Real', 'Aproximada por Curva de Reação|SMITH');
hold off

%%%Parte 3
%{
Aplicando o metodo de sintonizaï¿½ï¿½o de Ziegler e Nichols para encontrar 
valores de Kp, Ki e Kd para o PID.
%}
kp_ZN = 1.2*T/L;
ti_ZN = 2*L;
ki_ZN = kp_ZN/ti_ZN;
td_ZN = 0.5*L;
kd_ZN = kp_ZN*td_ZN;

%{
Aplicando o metodo de sincronizacao de Cohen-Coon para encontrar 
Kp, Ki, e Kd. OBS: No metodo de Cohen Coon precisamos da constante R que eh 
R = L/Tal
%}
R = L/T;
kp_CC = T/(L*(4/3 + R/4));
ti_CC = L*((32+6*R)/(13+8*R));
ki_CC = kp_CC/ti_CC;
td_CC = 4/(13+8*R);
kd_CC = kp_CC*td_CC;

%Valores encontrados por cada metodo
ZN = [kp_ZN ki_ZN kd_ZN]
CC = [kp_CC ki_CC kd_CC]

%%%Parte 4
%{
Controlando a planta com PID continuo sintonizado atraves dos metodos ZN e 
CC
%}
sim('PIDcontinuos_01') % Para T=0.1s
sim('PIDcontinuos_0001') % Para T=0.001s

%Extraindo os valores de resposta do sistema controlado p/ T = 0,001
resp_controlled_PID_ZN_continuos_T01 = resp_controlledPID_ZNandCC_01continuos.signals.values(:,1);
resp_controlled_PID_CC_continuos_T01 = resp_controlledPID_ZNandCC_01continuos.signals.values(:,2);

%Extraindo os valores de resposta do sistema controlado p/ T = 0,001
resp_controlled_PID_ZN_continuos_T0001 = resp_controlledPID_ZNandCC_0001continuos.signals.values(:,1);
resp_controlled_PID_CC_continuos_T0001 = resp_controlledPID_ZNandCC_0001continuos.signals.values(:,2);

%%%<Plotando os atraves da Figura 2>
figure(2)
%Sintonizado por ZN
plot(resp_controlledPID_ZNandCC_0001continuos.time, resp_controlled_PID_ZN_continuos_T0001, 'g')
hold on
%Sintonizado por CC
plot(resp_controlledPID_ZNandCC_0001continuos.time, resp_controlled_PID_CC_continuos_T0001, 'k')
title('Reposta malha fechada com PID continuo sintonia ZN x CC p/ T=0.001s');
legend('Ziegler-Nichols', 'Cohen-Coon');
hold off

%%%<Plotando os atraves da Figura 3>
figure(3)
%Sintonizado por ZN
plot(resp_controlledPID_ZNandCC_01continuos.time, resp_controlled_PID_ZN_continuos_T01, 'g')
hold on
%Sintonizado por CC
plot(resp_controlledPID_ZNandCC_01continuos.time, resp_controlled_PID_CC_continuos_T01, 'k')
title('Reposta malha fechada com PID continuo sintonia ZN x CC p/ T=0.1s');
legend('Ziegler-Nichols', 'Cohen-Coon');
hold off

%%%Parte 5
%{
Calculando erros Absoluto, Absoluto Temporal, Quadratico, Quadratico
Temporal para o controle PID continuo sintonizado pelo metodo de 
Ziegles-Nichols e Cohen-Coon.
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T =0,001 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Declaracao das variaveis para calculo do somatorio dos erros
Ezn_a = 0; Ecc_a = 0;
Ezn_at = 0; Ecc_at = 0;
Ezn_q = 0; Ecc_q = 0;
Ezn_qt = 0; Ecc_qt = 0;

%Calculo dos erros
for i=1:length(resp_controlledPID_ZNandCC_0001continuos.time)
   %Integral do erro absoluto (IAE)
   Ezn_a = Ezn_a + abs(1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,1));
   Ecc_a = Ecc_a + abs(1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,2));
   
   %Integral do erro absoluto ponderado pelo tempo (ITAE)
   Ezn_at = Ezn_at + abs((1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,1))*resp_controlledPID_ZNandCC_0001continuos.time(i));
   Ecc_at = Ecc_at + abs((1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,2))*resp_controlledPID_ZNandCC_0001continuos.time(i));
    
   %Integral do erro quadratico (ISE)
   Ezn_q = Ezn_q + (1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,1))^2;
   Ecc_q = Ecc_q + (1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,2))^2;
   
   %Integral do erro quadratico ponderado pelo tempo (ITSE)
   Ezn_qt = Ezn_qt + ((1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,1))*resp_controlledPID_ZNandCC_0001continuos.time(i))^2;
   Ecc_qt = Ecc_qt + ((1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,2))*resp_controlledPID_ZNandCC_0001continuos.time(i))^2;
end

Erros = [Ezn_a Ecc_a
        Ezn_at Ecc_at
        Ezn_q  Ecc_q
        Ezn_qt Ecc_qt];
    
%%%<Plotando os atraves da Figura 4>
%%%Erros acumulativos por 4 metodos de diferentes
figure(4)
bar(Erros);
xNames = {'Absoluto';'Absoluto Temporal';'Quadrático';'Quadrático Temporal'};
title('Somatório dos Erros p/ T=0.001s');
legend('Ziegler-Nichols', 'Cohen-Coon');
set(gca,'xticklabel',xNames)
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T =0,1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Declaracao das variaveis para calculo do somatorio dos erros
Ezn_a = 0; Ecc_a = 0;
Ezn_at = 0; Ecc_at = 0;
Ezn_q = 0; Ecc_q = 0;
Ezn_qt = 0; Ecc_qt = 0;

%Calculo dos erros
for i=1:length(resp_controlledPID_ZNandCC_01continuos.time)
   %Integral do erro absoluto (IAE)
   Ezn_a = Ezn_a + abs(1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,1));
   Ecc_a = Ecc_a + abs(1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,2));
   
   %Integral do erro absoluto ponderado pelo tempo (ITAE)
   Ezn_at = Ezn_at + abs((1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,1))*resp_controlledPID_ZNandCC_01continuos.time(i));
   Ecc_at = Ecc_at + abs((1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,2))*resp_controlledPID_ZNandCC_01continuos.time(i));
    
   %Integral do erro quadratico (ISE)
   Ezn_q = Ezn_q + (1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,1))^2;
   Ecc_q = Ecc_q + (1 - resp_controlledPID_ZNandCC_0001continuos.signals.values(i,2))^2;
   
   %Integral do erro quadratico ponderado pelo tempo (ITSE)
   Ezn_qt = Ezn_qt + ((1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,1))*resp_controlledPID_ZNandCC_01continuos.time(i))^2;
   Ecc_qt = Ecc_qt + ((1 - resp_controlledPID_ZNandCC_01continuos.signals.values(i,2))*resp_controlledPID_ZNandCC_01continuos.time(i))^2;
end

Erros = [Ezn_a Ecc_a
        Ezn_at Ecc_at
        Ezn_q  Ecc_q
        Ezn_qt Ecc_qt];
    
%%%<Plotando os atraves da Figura 4>
%%%Erros acumulativos por 4 metodos de diferentes
figure(5)
bar(Erros);
xNames = {'Absoluto';'Absoluto Temporal';'Quadrático';'Quadrático Temporal'};
title('Somatório dos Erros p/ T=0.1s');
legend('Ziegler-Nichols', 'Cohen-Coon');
set(gca,'xticklabel',xNames)
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Parte1
%{
Montando a tf G(s) do controlador para discretiza-la pelo metodo de Tustin
em T=0.1s e T=0.001s
OBS: Estamos utilizando um filtro passa-baixa
%}
G_controller_zn = tf([kp_ZN+kd_ZN 20*kp_ZN+ki_ZN 20*ki_ZN],[1 20 0]);
G_controller_cc = tf([kp_CC+kd_CC 20*kp_CC+ki_CC 20*ki_CC],[1 20 0]);

%Discretizacao do controlador G(z) pelo metodo de Tustin
Gcontroller_discreetizedTUSTIN_T01_controller_zn = c2d(G_controller_zn, 0.1, 'Tustin');
Gcontroller_discreetizedTUSTIN_T0001_controller_zn = c2d(G_controller_zn, 0.001, 'Tustin');
Gcontroller_discreetizedTUSTIN_T01_controller_cc = c2d(G_controller_cc, 0.1, 'Tustin');
Gcontroller_discreetizedTUSTIN_T0001_controller_cc = c2d(G_controller_cc, 0.001, 'Tustin');

%Chamando o diagrama de bloco que aplica os PID's discretos na planta cada
%cada frequencia diferente
sim('PIDdiscret_01'); %Para T=0,1s
sim('PIDdiscret_0001'); %Para T=0,001s

%Extraindo os valores de resposta do sistema controlado p/ T = 0,001
resp_controlled_PID_ZN_discret_T01 = resp_controlledPID_ZNandCC_01discret.signals.values(:,1);
resp_controlled_PID_CC_discret_T01 = resp_controlledPID_ZNandCC_01discret.signals.values(:,2);

%Extraindo os valores de resposta do sistema controlado p/ T = 0,001
resp_controlled_PID_ZN_discret_T0001 = resp_controlledPID_ZNandCC_0001discret.signals.values(:,1);
resp_controlled_PID_CC_discret_T0001 = resp_controlledPID_ZNandCC_0001discret.signals.values(:,2);

%Plotando os atraves da planta controlada pelos controladores discretizados e sintonizados por ZN e CC nos tempos 
%de amostragem de 0.1 0.001 G(z)
%%====<T=0.1s>======
figure(6)
plot(resp_controlledPID_ZNandCC_01discret.time, resp_controlled_PID_ZN_discret_T01, 'b')
hold on
plot(resp_controlledPID_ZNandCC_01discret.time, resp_controlled_PID_CC_discret_T01, 'k')
title('Reposta malha fechada com PID discreto sintonia ZN x CC p/ T=0.1s');
legend('Ziegler-Nichols', 'Cohen-Coon');
%%====<T=0.001s>=====
figure(7)
plot(resp_controlledPID_ZNandCC_0001discret.time, resp_controlled_PID_ZN_discret_T0001, 'c')
hold on
plot(resp_controlledPID_ZNandCC_0001discret.time, resp_controlled_PID_CC_discret_T0001, 'm')
title('Reposta malha fechada com PID discreto sintonia ZN x CC p/ T=0.001s');
legend('Ziegler-Nichols', 'Cohen-Coon');
hold off





