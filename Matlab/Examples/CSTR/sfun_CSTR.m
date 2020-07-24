function sfun_CSTR(block)
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
block.NumInputPorts  = 2; % Cantidad de entradas
block.NumOutputPorts = 3; % Cantidad de salidas

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Propiedades de los puertos de entrada
block.InputPort(1).Dimensions        = 1;
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = false;

% Propiedades de los puertos de entrada
block.InputPort(2).Dimensions        = 1;
block.InputPort(2).DatatypeID  = 0;  % double
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = false;

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

% Número de parámetros
block.NumDialogPrms  = 2; % Vector of parameters and vector of initial states

% Tiempo de muestreo
block.SampleTimes = [0, 0]; % Tiempo de muestreo heredado
% Definicion de la cantidad de variables de estado
block.NumContStates = 2; % Two state variables
  
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
y=(100/1.5714)*x(2); %Cb is the second state variable
block.OutputPort(1).Data = y;
block.OutputPort(2).Data = x(1);
block.OutputPort(3).Data = x(2);
%end Salidas

function ModeloEstados(block)
% Acá se escribe la función que calcula las derivadas de las variables de
% estado
%Constantes
param = block.DialogPrm(1).Data;
k1 = param(1);
k2 = param(2);
k3 = param(3);
V  = param(4);

x = block.ContStates.Data; % el valor del estado actual
Ca = x(1);
Cb = x(2);
u =  block.InputPort(1).Data; % input flowrate
Cai =  block.InputPort(2).Data; % input concentration
Fr=(634.1719/100)*(u); % actuator
%
dCadt = Fr/V*(Cai-Ca)-k1*Ca-k3*Ca^2;
dCbdt = -Fr/V*Cb+k1*Ca-k2*Cb;
block.Derivatives.Data = [dCadt;dCbdt]; % actualizacion del bloque de la S-function
%end ModeloEstados

function SetInputPortSamplingMode(s, port, mode)
s.InputPort(port).SamplingMode = mode;
%end SetInputPortSamplingMode