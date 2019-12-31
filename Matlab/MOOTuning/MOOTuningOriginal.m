function varargout = MOOTuning(varargin)
% MOOTUNING MATLAB code for MOOTuning.fig
%      MOOTUNING, by itself, creates a new MOOTUNING or raises the existing
%      singleton*.
%
%      H = MOOTUNING returns the handle to a new MOOTUNING or the handle to
%      the existing singleton*.
%
%      MOOTUNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOOTUNING.M with the given input arguments.
%
%      MOOTUNING('Property','Value',...) creates a new MOOTUNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MOOTuning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MOOTuning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MOOTuning

% Last Modified by GUIDE v2.5 13-Jan-2017 12:00:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MOOTuning_OpeningFcn, ...
                   'gui_OutputFcn',  @MOOTuning_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MOOTuning is made visible.
function MOOTuning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MOOTuning (see VARARGIN)

% Choose default command line output for MOOTuning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MOOTuning wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.axes1);
image(imread('equation.png'))
axis off

axes(handles.axes3);
image(imread('cerlab_logo.png'))
axis off

%Coloca una imagen en cada bot�n
[a,map]=imread('help_button.png');
[r,c,d]=size(a);
x=ceil(r/100);
y=ceil(c/70);
g=a(2:x:end-1,4:y:end-3,:);
g(g==5)=5*2;
set(handles.help_button,'CData',g);

% --- Outputs from this function are returned to the command line.
function varargout = MOOTuning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu_metodo.
function popupmenu_metodo_Callback(hObject, eventdata, handles)
global archivo
switch get(hObject,'Value')
    case 1 %Insert params
        set(handles.uipanel_digitar,'Visible','on')
        set(handles.uipanel_digitar,'Title','Digitar par�metros de planta')
        set(handles.insert_k, 'String', '')
        set(handles.insert_a, 'String', '')
        set(handles.insert_T, 'String', '')
        set(handles.insert_L, 'String', '')
        %Others
        set(handles.uipanel_workspace,'Visible','off')
        set(handles.uipanel_csv,'Visible','off')      
    case 2 %Workspace
        set(handles.uipanel_workspace,'Visible','on')
        set(handles.workspace_time, 'String', '')
        set(handles.workspace_in, 'String', '')
        set(handles.workspace_out, 'String', '')
        set(handles.workspace_method, 'Value', 1)
        %Others
        set(handles.uipanel_digitar,'Visible','off')
        set(handles.uipanel_csv,'Visible','off')
    case 3 %Import .csv
        set(handles.csv_name,'String','')
        set(handles.csv_method,'Value',1)
        set(handles.uipanel_csv,'Visible','on')
        %set(handles.csv_identify,'Visible','on')
        archivo = 0;
        %Others
        set(handles.uipanel_workspace,'Visible','off')
        set(handles.uipanel_digitar,'Visible','off')
end


% --- Executes during object creation, after setting all properties.
function popupmenu_metodo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_metodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function workspace_time_Callback(hObject, eventdata, handles)
% hObject    handle to workspace_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of workspace_time as text
%        str2double(get(hObject,'String')) returns contents of workspace_time as a double


% --- Executes during object creation, after setting all properties.
function workspace_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to workspace_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function workspace_in_Callback(hObject, eventdata, handles)
% hObject    handle to workspace_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of workspace_in as text
%        str2double(get(hObject,'String')) returns contents of workspace_in as a double


% --- Executes during object creation, after setting all properties.
function workspace_in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to workspace_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function workspace_out_Callback(hObject, eventdata, handles)
% hObject    handle to workspace_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of workspace_out as text
%        str2double(get(hObject,'String')) returns contents of workspace_out as a double


% --- Executes during object creation, after setting all properties.
function workspace_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to workspace_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in workspace_method.
function workspace_method_Callback(hObject, eventdata, handles)
% hObject    handle to workspace_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns workspace_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from workspace_method


% --- Executes during object creation, after setting all properties.
function workspace_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to workspace_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in workspace_identify.
function workspace_identify_Callback(hObject, eventdata, handles)
%
%Llamando archivos desde el workspace
t = evalin('base', get(handles.workspace_time,'String'));
u = evalin('base', get(handles.workspace_in,'String'));
y = evalin('base', get(handles.workspace_out,'String'));
%
%%Obteniendo par�metros de planta
switch get(handles.workspace_method,'Value')
    case 1
        [K,a,T,L,Gmodel]=IdentFun(t,u,y,'Alfaro123');
        axes(handles.axes2);
        r=lsim(Gmodel,u,t);
        sup = max([max(r),max(u),max(y)]);
        inf = min([min(r),min(u),min(y)]);
        plot(t,u,'k',t,r,'r',t,y,'b','LineWidth',1.5);
        ylim([-0.1+inf sup*1.1]);
        xlim([t(1) t(end)])
        title('Plant responses');
        xlabel('Time (s)');
        ylabel('Amplitude');
        legend('Input','Plant','Alfaro123');
        handles.state_axes = 'Alfaro';
        handles.t = t;
        handles.y = y;
        handles.r = r;
        handles.u = u;
    case 2
        [K,a,T,L,Gmodel]=IdentFun(t,u,y,'Opt');
        axes(handles.axes2);
        r=lsim(Gmodel,u,t);
        sup = max([max(r),max(u),max(y)]);
        inf = min([min(r),min(u),min(y)]);
        plot(t,u,'k',t,r,'r',t,y,'b','LineWidth',1.5);
        ylim([-0.1+inf sup*1.1]);
        xlim([t(1) t(end)])
        title('Plant responses');
        xlabel('Time (s)');
        ylabel('Amplitude');
        legend('Input','Plant','Optimization')
        handles.state_axes = 'Optimization';
        handles.t = t;
        handles.y = y;
        handles.r = r;
        handles.u = u;
end

%Imprime en el recuadro modelo planta
set(handles.plant_k,'String',num2str(K))
set(handles.plant_a,'String',num2str(a))
set(handles.plant_T,'String',num2str(T))
set(handles.plant_L,'String',num2str(L))

%Guarda estado de gr�fico
guidata(hObject,handles)

function csv_name_Callback(hObject, eventdata, handles)
% hObject    handle to csv_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of csv_name as text
%        str2double(get(hObject,'String')) returns contents of csv_name as a double


% --- Executes during object creation, after setting all properties.
function csv_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to csv_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in csv_method.
function csv_method_Callback(hObject, eventdata, handles)
% hObject    handle to csv_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns csv_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from csv_method


% --- Executes during object creation, after setting all properties.
function csv_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to csv_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in csv_identify.
function csv_identify_Callback(hObject, eventdata, handles)
%Importar y extraer datos del csv
global archivo
if strcmp(get(handles.csv_name,'String'), '') == 1
    errordlg('Debe seleccionar un archivo .csv','Error')
    
else
    if exist(archivo,'file') && strcmp(get(handles.csv_name,'String'), 'Falta archivo') == 0 
        x=importdata(archivo);
        t=x(:,1);
        u=x(:,2);
        y=x(:,3);
        %
        %Selecci�n de m�todo
        switch get(handles.csv_method,'Value')
            case 1
                [K,a,T,L,Gmodel]=IdentFun(t,u,y,'Alfaro123');
                axes(handles.axes2);
                r=lsim(Gmodel,u,t);
                sup = max([max(u),max(y),max(y)]);
                inf = min([min(u),min(y),min(y)]);
                plot(t,u,'k',t,y,'r',t,r,'b','LineWidth',1.5);
                ylim([inf-0.1*abs(sup-inf) sup+0.1*abs(sup-inf)])
                legend('Input','Plant','Alfaro123');
                title('Plant responses')
                xlabel('Time (s)');
                ylabel('Amplitude');
                handles.state_axes = 'Alfaro';
                handles.t = t;
                handles.y = y;
                handles.r = r;
                handles.u = u;
            case 2
                [K,a,T,L,Gmodel]=IdentFun(t,u,y,'Opt');
                axes(handles.axes2);
                r=lsim(Gmodel,u,t);
                sup = max([max(u),max(y),max(y)]);
                inf = min([min(u),min(y),min(y)]);
                plot(t,u,'k',t,y,'r',t,r,'b','LineWidth',1.5);
                ylim([inf-0.1*abs(sup-inf) sup+0.1*abs(sup-inf)])
                legend('Input','Plant','Optimization');
                title('Plant responses')
                xlabel('Time (s)');
                ylabel('Amplitude');
                handles.state_axes = 'Optimization';
                handles.t = t;
                handles.y = y;
                handles.r = r;
                handles.u = u;
        end
        %
        %Imprime en el recuadro modelo planta
        %Formaci�n del denominador
        den = [T,a*T];
        T = max(den);
        a = min(den)/max(den);
        set(handles.plant_k,'String',num2str(K))
        set(handles.plant_a,'String',num2str(a))
        set(handles.plant_T,'String',num2str(T))
        set(handles.plant_L,'String',num2str(L))
    else
        errordlg('Seleccione un archivo .csv','Error')
    end
end

%Guarda variables en handles
guidata(hObject,handles)




function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function insert_k_Callback(hObject, eventdata, handles)
% hObject    handle to insert_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of insert_k as text
%        str2double(get(hObject,'String')) returns contents of insert_k as a double


% --- Executes during object creation, after setting all properties.
function insert_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to insert_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function insert_a_Callback(hObject, eventdata, handles)
% hObject    handle to insert_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of insert_a as text
%        str2double(get(hObject,'String')) returns contents of insert_a as a double


% --- Executes during object creation, after setting all properties.
function insert_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to insert_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function insert_T_Callback(hObject, eventdata, handles)
% hObject    handle to insert_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of insert_T as text
%        str2double(get(hObject,'String')) returns contents of insert_T as a double


% --- Executes during object creation, after setting all properties.
function insert_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to insert_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_insert.
function pushbutton_insert_Callback(~, eventdata, handles)
% set(handles.plant_k,'String',get(handles.insert_k,'String'))
% set(handles.plant_a,'String',get(handles.insert_a,'String'))
% set(handles.plant_T,'String',get(handles.insert_T,'String'))
% set(handles.plant_L,'String',get(handles.insert_L,'String'))
% k = str2double(get(handles.insert_k,'String'));
% a = str2double(get(handles.insert_k,'String'));
% T = str2double(get(handles.insert_k,'String'));
% L = str2double(get(handles.insert_k,'String'));
% s = tf('s');
% ps = k*exp(-L*s)/((T*s+1)*(a*T*s+1));
% t = linspace(0,str2double(get(handles.simulation_time,'String')),1000).';
% u = 1*(t>=str2double(get(handles.simulation_time,'String'))*0.1);
% y = lsim(ps,u,t);
% sup = max(y);
% inf = min(y);
% %Plot
% axes(handles.axes2);
% plot(t,y,'LineWidth',1.5);
% hold on
% plot(t,u,'LineWidth',1.5);
% ylim([-0.1+inf sup*1.1])
% hold off
% title('Respuesta de la planta ante una entrada tipo escal�n');
% handles.state_axes = 'Insert';
% handles.t = t;
% handles.y = y;
% handles.r = u;
% guidata(hObject,handles)


function insert_L_Callback(hObject, eventdata, handles)
% hObject    handle to insert_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of insert_L as text
%        str2double(get(hObject,'String')) returns contents of insert_L as a double


% --- Executes during object creation, after setting all properties.
function insert_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to insert_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in csv_import.
function csv_import_Callback(hObject, eventdata, handles)
%
global archivo
[fileName, pathName] = uigetfile('*.csv');
fullNameWithPath = fullfile(pathName, fileName);
archivo = fullNameWithPath;
set(handles.csv_name,'String',fileName);

if fileName == 0
    set(handles.csv_name,'String','Falta archivo');
    errordlg('Seleccione un archivo .csv','Error')
end


% --- Executes on slider movement.
function slider_jdi_Callback(hObject, eventdata, handles)
%
 set(handles.user_jdi,'String',round(get(hObject,'Value')*1000)/1000)



% --- Executes during object creation, after setting all properties.
function slider_jdi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_jdi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_jdo_Callback(hObject, eventdata, handles)
%
set(handles.user_jdo,'String',round(get(hObject,'Value')*1000)/1000)
%


% --- Executes during object creation, after setting all properties.
function slider_jdo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_jdo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_jr_Callback(hObject, eventdata, handles)
%
set(handles.user_jr,'String',round(get(hObject,'Value')*1000)/1000)


% --- Executes during object creation, after setting all properties.
function slider_jr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_jr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu_ms.
function popupmenu_ms_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ms contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ms
if get(handles.tunning, 'Value') == 1
    cond = str2double(get(handles.plant_L,'String'))/str2double(get(handles.plant_T,'String'));
if 0.1 < cond && cond < 2
    t0=0.18;
    a=str2double(get(handles.plant_a,'String'));
    Ms = -0.2*get(handles.popupmenu_ms,'Value')+2.2;
    Jdimax=get(handles.slider_jdi,'Value');
    Jdomax=get(handles.slider_jdo,'Value');
    Jrmax=get(handles.slider_jr,'Value');
    
    %Funci�n buscar controlador
    [kp,zi,zd,B]=interpolarControl(t0,a,Ms,Jdimax,Jdomax,Jrmax);

    %Imprimir valores
    set(handles.control_kp,'String',round((kp/str2double(get(handles.plant_k,'String')))*10000)/10000);
    set(handles.control_ti,'String',round((zi*str2double(get(handles.plant_T,'String')))*10000)/10000);
    set(handles.control_td,'String',round((zd*str2double(get(handles.plant_T,'String')))*10000)/10000);
    set(handles.control_b,'String',round((B)*10000)/10000);
    
    %plot figure
    K = str2double(get(handles.plant_k,'String'));
    T = str2double(get(handles.plant_T,'String')); 
    a = str2double(get(handles.plant_a,'String')); 
    L = str2double(get(handles.plant_L,'String')); 
    Kp = str2double(get(handles.control_kp,'String'));
    Ti = str2double(get(handles.control_ti,'String'));
    Td = str2double(get(handles.control_td,'String'));
    beta = str2double(get(handles.control_b,'String'));
    time = str2double(get(handles.simulation_time,'String'));
    
    Jdo = get(handles.plot_jdo,'Value');
    Jdi = get(handles.plot_jdi,'Value');
    Jr = get(handles.plot_jr,'Value');

    [t,y]= ploter(K,T,a,L,Kp,Ti,Td,beta,time,Jdo,Jdi,Jr);

    axes(handles.axes2);   
    plot(t,y,'LineWidth',1.5);
    %ylim([-0.5 1.5])
    title('Respuesta de la planta')
else
    errordlg(['L/T = ' num2str(cond) ', this value must be between 0.1 and 2.0'],'Error')
end
end



% --- Executes during object creation, after setting all properties.
function popupmenu_ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tunning.
function tunning_Callback(hObject, eventdata, handles)
%Obtenci�n de variables
%t0=str2num(get(handles.edit_L,'String'))/str2num(get(handles.edit_T,'String'))
%Condici�n L/T
if isempty(get(handles.plant_k,'String')) == 1 || isempty(get(handles.plant_a,'String')) == 1 ...
        || isempty(get(handles.plant_T,'String')) == 1 || isempty(get(handles.plant_L,'String')) == 1
    errordlg('You must complete the plant parameters','Error')
    set(hObject,'Value',0)
else
%if get(hObject,'Value') == 1
%    set(hObject,'String','Sintonizando')
    cond = str2double(get(handles.plant_L,'String'))/str2double(get(handles.plant_T,'String'));
    if 0.1 < cond && cond < 2
        t0=cond;
        a=str2double(get(handles.plant_a,'String'));
        Ms = -0.2*get(handles.popupmenu_ms,'Value')+2.2;
        Jdimax=get(handles.slider_jdi,'Value');
        Jdomax=get(handles.slider_jdo,'Value');
        Jrmax=get(handles.slider_jr,'Value');

        %Funci�n buscar controlador
        [kp,zi,zd,B]=interpolarControl(t0,a,Ms,Jdimax,Jdomax,Jrmax);

        if isnan(kp) ||  isnan(zi) || isnan(zd) || isnan(B)
            h = msgbox('Desired values combination is not in the Pareto frontier, try other combination', 'Error','error');
        else
        %Imprimir valores
        set(handles.control_kp,'String',round((kp/str2double(get(handles.plant_k,'String')))*10000)/10000);
        set(handles.control_ti,'String',round((zi*str2double(get(handles.plant_T,'String')))*10000)/10000);
        set(handles.control_td,'String',round((zd*str2double(get(handles.plant_T,'String')))*10000)/10000);
        set(handles.control_b,'String',round((B)*10000)/10000);
        
        %plot figure
        K = str2double(get(handles.plant_k,'String'));
        T = str2double(get(handles.plant_T,'String')); 
        a = str2double(get(handles.plant_a,'String')); 
        L = str2double(get(handles.plant_L,'String')); 
        Kp = str2double(get(handles.control_kp,'String'));
        Ti = str2double(get(handles.control_ti,'String'));
        Td = str2double(get(handles.control_td,'String'));
        beta = str2double(get(handles.control_b,'String'));
        time = str2double(get(handles.simulation_time,'String'));
        Jdo = get(handles.plot_jdo,'Value');
        Jdi = get(handles.plot_jdi,'Value');
        Jr = get(handles.plot_jr,'Value');

        [t,y,timePert]= ploter(K,T,a,L,Kp,Ti,Td,beta,time,Jdo,Jdi,Jr);
        handles.t = t;
        handles.y = y;
        % ---- Calculo de los IAE ----%
        Graficas=Jdo+Jdi+Jr;
        switch Graficas
            case 3
                diIndices=find((t>=timePert(1))&(t<timePert(2)));
                doIndices=find((t>=timePert(2))&(t<timePert(3)));
                rIndices=find((t>=timePert(3)));
            case 2
                if Jr==0
                    diIndices=find((t>=timePert(1))&(t<timePert(2)));
                    doIndices=find((t>=timePert(2)));
                    rIndices=[];
                elseif Jdo==0
                    diIndices=find((t>=timePert(1))&(t<timePert(3)));
                    doIndices=[];
                    rIndices=find((t>=timePert(3)));
                else %Jdi=0
                    diIndices=[];
                    doIndices=find((t>=timePert(2))&(t<timePert(3)));
                    rIndices=find((t>=timePert(3)));
                end
            case 1
                if Jdi==0
                    diIndices = [];
                else
                    diIndices=find((t>=timePert(1)));
                end
                
                if Jdo==0
                    doIndices = [];
                else
                    doIndices=find((t>=timePert(2)));
                end
                
                if Jr==0
                    rIndices = [];
                else
                    rIndices=find((t>=timePert(3)));
                end
            otherwise
                diIndices = [];
                doIndices = [];
                rIndices = [];
        end
        % Jdi
            if isempty(diIndices)
                set(handles.text_Jdi_Val,'String','-');
            else
                IAE=trapz(t(diIndices),abs(y(diIndices)));
                set(handles.text_Jdi_Val,'String',num2str(IAE));
            end
        % Jdo
            if isempty(doIndices)
                set(handles.text_Jdo_Val,'String','-');
            else
                IAE=trapz(t(doIndices),abs(y(doIndices)));
                set(handles.text_Jdo_Val,'String',num2str(IAE));
            end
         % Jr
            if isempty(rIndices)
                set(handles.text_Jr_Val,'String','-');
            else
                IAE=trapz(t(rIndices),abs(1-y(rIndices)));
                set(handles.text_Jr_Val,'String',num2str(IAE));
            end
        % Calculo Ms
        ParamPlant=[K;T;L;a];
        ParamControl=[Kp,Ti,Td,0.1]; %parguideametros del controlador
        Ms=MsCalc2(ParamPlant,ParamControl);
        set(handles.text_Ms_Val,'String',num2str(Ms));
        axes(handles.axes2);   
        plot(t,y,'LineWidth',1.5);
        if Jdo+Jdi+Jr ~= 0
            ylim([-0.1+min(y) 1.1*max(y)])
        end
        xlabel('Time (s)')
        ylabel('Amplitude')
        title('Plant response')
        %Activate button for save results
        set(handles.save_result,'Enable','on')
        end
    else
        errordlg(['L/T = ' num2str(cond) ', this value must be between 0.1 and 2.0'],'Error')
        set(hObject,'Value',0)
    end
%else
%    set(hObject,'String','Sintonizar')
%end
handles.state_axes = 'Tunning';
guidata(hObject,handles)
end


% --- Executes on button press in save_result.
function save_result_Callback(hObject, eventdata, handles)
%Se escriben los datos en la direcci�n indicada por el usuario
[arq,dir,filterindex] = uiputfile('*.csv','Save .txt file');
if filterindex==0
else
    fileName=fullfile(dir,arq);
    Characteristic = {'Plant parameters';'K';'T';'a';'L';'Desirable characteristics';'Jdi' ...
        ;'Jdo';'Jr';'Ms';'Controller parameters';'Kp';'Ti';'Td';'B'};
    switch get(handles.popupmenu_ms,'Value')
        case 1
            ms = '2.0';
        case 2
            ms = '1.8';
        case 3
            ms = '1.6';
    end
    
    Value = {'Value';get(handles.plant_k,'String');get(handles.plant_T,'String');...
        get(handles.plant_a,'String');get(handles.plant_L,'String');'Value'; ...
        get(handles.slider_jdi,'Value');get(handles.slider_jdo,'Value');get(handles.slider_jr,'Value'); ...
        ms;'Value';get(handles.control_kp,'String'); ...
        get(handles.control_ti,'String');get(handles.control_td,'String'); ...
        get(handles.control_b,'String')};
    T = table(Characteristic,Value);
    writetable(T,fileName);
end

% --- Executes on button press in export_figure.
function export_figure_Callback(hObject, eventdata, handles)
%disp(handles.state_axes)
switch handles.state_axes
    case 'Alfaro'
        t = handles.t;
        y = handles.y;
        r = handles.r;
        u = handles.u;
        figure(1)
        sup = max([max(u),max(y),max(y)]);
        inf = min([min(u),min(y),min(y)]);
        plot(t,u,'k',t,y,'r',t,r,'b','LineWidth',1.5);
        ylim([inf-0.1*abs(sup-inf) sup+abs(sup-inf)*0.1])
        title('Plant responses')
        xlabel('Time (s)');
        ylabel('Amplitude');
        legend('Input','Plant','Alfaro123');
    case 'Optimization'
        t = handles.t;
        y = handles.y;
        r = handles.r;
        u = handles.u;
        figure(1)
        sup = max([max(u),max(y),max(y)]);
        inf = min([min(u),min(y),min(y)]);
        plot(t,u,'k',t,y,'r',t,r,'b','LineWidth',1.5);
        ylim([inf-0.1*abs(sup-inf) sup+abs(sup-inf)*0.1])
        title('Plant responses')
        xlabel('Time (s)');
        ylabel('Amplitude');
        legend('Input','Plant','Optimization');
    case 'Insert'
        t = handles.t;
        y = handles.y;
        u = handles.r;
        sup = max(y);
        inf = min(y);
        figure(1)
        plot(t,u,'r',t,y,'b','LineWidth',1.5);
        ylim([-0.1+inf sup*1.1])
        title('Step response');
        xlabel('Time (s)');
        ylabel('Amplitude');
        legend('Input','Output')
    case 'Tunning'
        t = handles.t;
        assignin('base','t',t)
        y = handles.y;
        assignin('base','y',y)
        figure(1)
        plot(t,y,'k','LineWidth',1.5);
        xlabel('Time (s)')
        ylabel('Amplitude')
        sup = max(y);
        inf = min(y);
        ylim([inf-0.1*abs(sup-inf) sup+abs(sup-inf)*0.1])
        title('Plant response')
end


% --- Executes on button press in plot_jdo.
function plot_jdo_Callback(hObject, eventdata, handles)



% --- Executes on button press in plot_jdi.
function plot_jdi_Callback(hObject, eventdata, handles)



% --- Executes on button press in plot_jr.
function plot_jr_Callback(hObject, eventdata, handles)




function simulation_time_Callback(hObject, eventdata, handles)
% hObject    handle to simulation_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simulation_time as text
%        str2double(get(hObject,'String')) returns contents of simulation_time as a double


% --- Executes during object creation, after setting all properties.
function simulation_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simulation_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in csv_modify.
function csv_modify_Callback(hObject, eventdata, handles)
set(handles.uipanel_csv,'Visible','off')
set(handles.uipanel_digitar,'Visible','on')
set(handles.uipanel_digitar,'Title','Modify plant parameters')
set(handles.insert_k, 'String', get(handles.plant_k,'String'))
set(handles.insert_a, 'String', get(handles.plant_a,'String'))
set(handles.insert_T, 'String', get(handles.plant_T,'String'))
set(handles.insert_L, 'String', get(handles.plant_L,'String'))


% --- Executes on button press in pushbutton_insert.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_insert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_in.
function pushbutton_in_Callback(hObject, eventdata, handles)
if isempty(get(handles.insert_k,'String')) == 1 || ...
        isempty(get(handles.insert_a,'String')) == 1 || ...
        isempty(get(handles.insert_T,'String')) == 1 || ...
        isempty(get(handles.insert_L,'String')) == 1
    msgbox('You must enter the required values','Error','error'); 
else
    set(handles.plant_k,'String',get(handles.insert_k,'String'))
    set(handles.plant_a,'String',get(handles.insert_a,'String'))
    set(handles.plant_T,'String',get(handles.insert_T,'String'))
    set(handles.plant_L,'String',get(handles.insert_L,'String'))
    k = str2double(get(handles.insert_k,'String'));
    a = str2double(get(handles.insert_a,'String'));
    T = str2double(get(handles.insert_T,'String'));
    L = str2double(get(handles.insert_L,'String'));
    s = tf('s');
    ps = k*exp(-L*s)/((T*s+1)*(a*T*s+1));
    t = linspace(0,str2double(get(handles.simulation_time,'String'))*0.8,1000).';%-str2double(get(handles.simulation_time,'String'))*0.2
    u = 1*(t>=str2double(get(handles.simulation_time,'String'))/10);
    y = lsim(ps,u,t);
    sup = max([y;u]);
    inf = min([y;u]);
    %Plot
    axes(handles.axes2);
    plot(t,u,'r',t,y,'b','LineWidth',1.5);
    ylim([-0.1+inf sup*1.1])
    title('Step response');
    xlabel('Time (s)')
    ylabel('Amplitude')
    legend('Input','Output')
    handles.state_axes = 'Insert';
    handles.t = t;
    handles.y = y;
    handles.r = u;
    guidata(hObject,handles)
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in help_button.
function help_button_Callback(hObject, eventdata, handles)
% hObject    handle to help_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('help_file.pdf')


% --- Executes during object creation, after setting all properties.
function save_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function export_figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to export_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function export_figure_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to export_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
