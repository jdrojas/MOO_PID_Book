function sfun_WTP(block)
% Plantilla para implementar modelos en variable de estado sencillos
% como una S-Function
% 
% El nombre del archivo y el de la función (ver linea 1) deben ser iguales

%
% Acá solo se llama a la función setup, no agregue nada más a esta función
% principal
%
setup(block);

% -------------------------------------------------------------------------
% Function: setup ===================================================
% Abstract:
% Acá se definen las caracterísiticas básicas del bloque de la S-function:
%   - Puertos de entrada
%   - Puertos de salida
%   - Definición de parámetros
%   - Opciones
%
%
function setup(block)

% Se registra el número de puertos de entrada y salida
block.NumInputPorts  = 4; % Cantidad de entradas
block.NumOutputPorts = 4; % Cantidad de salidas

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Propiedades de los puertos de entrada
block.InputPort(1).Dimensions        = 1;
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = false;

block.InputPort(2).Dimensions        = 1;
block.InputPort(2).DatatypeID  = 0;  % double
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = false;

block.InputPort(3).Dimensions        = 1;
block.InputPort(3).DatatypeID  = 0;  % double
block.InputPort(3).Complexity  = 'Real';
block.InputPort(3).DirectFeedthrough = false;

block.InputPort(4).Dimensions        = 1;
block.InputPort(4).DatatypeID  = 0;  % double
block.InputPort(4).Complexity  = 'Real';
block.InputPort(4).DirectFeedthrough = false;

% Propiedades de los puertos de salida
block.OutputPort(1).Dimensions       = 1;
block.OutputPort(1).DatatypeID  = 0; % double
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

block.OutputPort(2).Dimensions       = 1;
block.OutputPort(2).DatatypeID  = 0; % double
block.OutputPort(2).Complexity  = 'Real';
block.OutputPort(2).SamplingMode = 'Sample';

block.OutputPort(3).Dimensions       = 1;
block.OutputPort(3).DatatypeID  = 0; % double
block.OutputPort(3).Complexity  = 'Real';
block.OutputPort(3).SamplingMode = 'Sample';

block.OutputPort(4).Dimensions       = 1;
block.OutputPort(4).DatatypeID  = 0; % double
block.OutputPort(4).Complexity  = 'Real';
block.OutputPort(4).SamplingMode = 'Sample';

% Número de parámetros
block.NumDialogPrms  = 2; % Vector of parameters and vector of initial states

% Tiempo de muestreo
block.SampleTimes = [0, 0]; % Tiempo de muestreo heredado
% Definicion de la cantidad de variables de estado
block.NumContStates = 4; % Two state variables
  
block.SimStateCompliance = 'DefaultSimState';
% -----------------------------------------------------------------
% Ahora se registran los métodos internos de la S-function
% -----------------------------------------------------------------
block.RegBlockMethod('InitializeConditions', @Inicializacion);
block.RegBlockMethod('Outputs', @Salidas);     
block.RegBlockMethod('Derivatives', @ModeloEstados);
block.RegBlockMethod('SetInputPortSamplingMode',@SetInputPortSamplingMode); % Necesario para tener dos salidas
%end setup

function Inicializacion(block)

block.ContStates.Data = block.DialogPrm(2).Data; % The initial state is in the second parameter
%end Inicializacion

%
function Salidas(block)
% Acá se escribe las ecuaciones de salida
x = block.ContStates.Data; % el estado actual
block.OutputPort(1).Data = x(1);
block.OutputPort(2).Data = x(2);
block.OutputPort(3).Data = x(3);
block.OutputPort(4).Data = x(4);
%end Salidas

function ModeloEstados(block)
% Acá se escribe la función que calcula las derivadas de las variables de
% estado
%Constantes
param = block.DialogPrm(1).Data;
Y = param(1);
r = param(2);
beta = param(3);
KDO  = param(4);
alpha = param(5);
umax = param(6);
Ks = param(7);
K0 = param(8);
DOmax = param(9);

Qair = block.InputPort(1).Data; % aeration rate
D =  block.InputPort(2).Data; % dilution rate
Sin =  block.InputPort(3).Data; % influent substrate concentration
DOin =  block.InputPort(4).Data; % influent dissolved oxygen concentration

states = block.ContStates.Data; % el valor del estado actual
X = states(1);
S = states(2);
DO = states(3);
Xr = states(4);

u = umax * (S/(Ks+S))*(DO/(KDO+DO));
%
dXdt = u*X - D*(1+r)*X + r*D*Xr;
dSdt = -u/Y*X -D*(1+r)*S + D*Sin;
dDOdt = -K0*u/Y*X - D*(1+r)*DO + alpha*Qair*(DOmax-DO) + D*DOin;
dXrdt = D*(1+r)*X - D*(beta+r)*Xr;
block.Derivatives.Data = [dXdt;dSdt;dDOdt;dXrdt]; % actualizacion del bloque de la S-function
%end ModeloEstados

function SetInputPortSamplingMode(s, port, mode)
s.InputPort(port).SamplingMode = mode;
%end SetInputPortSamplingMode