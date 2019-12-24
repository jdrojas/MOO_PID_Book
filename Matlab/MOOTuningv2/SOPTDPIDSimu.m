%[y,x,u]=SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0)
%
%cmex function que simula un sistema de segundo orden sobreamortiguado
%en lazo cerrado con un controlador PID de dos grados de libertad
%
% Entradas de la función:
%       ParamPlant=[k;tau;L;a] : Parámetros de la planta
%               k:Ganancia,         tau: Constante de tiempo mayor
%               L: Tiempo muerto,   a: Relación de ctes de tiempo 0<=a<=1
%       ParamContr=[Kp,Ti,Td,alpha,beta,gamma] : Parámetros del controlador
%               Kp: Ganancia proporcional
%               Ti: Tiempo integral
%               Td: Tiempo derivativo
%               alpha: Constante del filtro de la derivada
%               beta: peso sobre el valor deseado para la parte
%               proporcional
%               %gamma: peso sobre el valor deseado para la parte
%               derivativa
%       time: vector de tiempo de la simulación. Tiene que ser monótono y
%       es el que define el paso de integracion.
%       r: vector de valores deseados (un valor para cada instante de
%           tiempo)
%       di: vector de perturbaciones a la entrada de la planta (load
%           disturbances) (un valor para cada instante de tiempo)
%       do: vector de perturbaciones a la salida de la planta (output
%           disturbances) (un valor para cada instante de tiempo)
%       x0: vector 4x1 que contiene el estado inicial (dos de la planta y
%       dos del controlador)
%
% Salidas de la función:
%       y: vector del mismo tamaño que time con la salida que corresponde
%           al sistema.
%       x: matriz con el valor de los estados en cada instante de tiempo
%       u: Vector con la salida correspondiente del controlador
% Es recomendable que el tiempo muerto sea mayor que el paso de integracion
% y que el paso de integracion sea pequeño.