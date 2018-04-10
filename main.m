function varargout = main(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_OpeningFcn, ...
                       'gui_OutputFcn',  @main_OutputFcn, ...
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

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)

    % Choose default command line output for main
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    T0 = [1 0 0 0
          0 1 0 0
          0 0 1 0
          0 0 0 1];
    dibujaTriedro(T0);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    view(30, 20);
    
% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

function BEmpezar_Callback(hObject, eventdata, handles)
    pos_size = get(handles.figure1,'Position');

    % Call modaldlg with the argument 'Position'.
    user_response = modal_nuevoProyecto('Title','Nuevo proyecto');
    switch user_response
    case 'No'
        %No hace nada
    case 'Si'
        prompt = {'X(mm)','Y(mm)','Z(mm)'};
        title = 'Dimensiones';
        dims = [1 35];
        definput = {'','',''};
        nuevas_dimensiones = inputdlg(prompt,title,dims,definput);
        
        xlim([0 str2double(nuevas_dimensiones{1,1})]);
        ylim([0 str2double(nuevas_dimensiones{2,1})]);
        zlim([0 str2double(nuevas_dimensiones{3,1})]);
        
        prompt = {'X','Y','Z'};
        title = 'Divisiones';
        dims = [1 35];
        definput = {'','',''};
        nuevas_divisiones = inputdlg(prompt,title,dims,definput);
        
        xticks(linspace(0,str2double(nuevas_dimensiones{1,1}),str2double(nuevas_divisiones{1,1})+1));
        yticks(linspace(0,str2double(nuevas_dimensiones{2,1}),str2double(nuevas_divisiones{2,1})+1));
        zticks(linspace(0,str2double(nuevas_dimensiones{3,1}),str2double(nuevas_divisiones{3,1})+1));
    end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function BCrear_Callback(hObject, eventdata, handles)
    % hObject    handle to BCrear (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    figura=get(handles.TiposFiguras,'SelectedObject');
    switch get(figura,'string')
       case 'Viga'
          viga=Elemento1D('Rectangular');  
          p0=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica);
          
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 35];
          definput = {'','',''};
          p1 = inputdlg(prompt,title,dims,definput);   
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 35];
          definput = {'','',''};
          p2 = inputdlg(prompt,title,dims,definput); 
          
          prompt = {'Y','Z'};
          title = 'Orientacion';
          dims = [1 35];
          definput = {'',''};
          orientacion = inputdlg(prompt,title,dims,definput);
          orientacion=str2num(cell2mat(orientacion));
          
          p1=str2num(cell2mat(p1));
          p2=str2num(cell2mat(p2));
          e1=(p2-p1)/norm(p2-p1);
          p3=[p1(1,1);p1(2,1)+3;p1(3,1)];
          p1p3=(p3-p1);
          e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);
          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e2(1,1) e3(1,1) p1(1,1)
                e1(2,1) e2(2,1) e3(2,1) p1(2,1)
                e1(3,1) e2(3,1) e3(3,1) p1(3,1)
                0 0 0 1];
            
          dibujaTriedro(TR);
          
          set(p0,'Visible','Off')
          
          viga.matrizGeometrica=DilatacionX(viga.matrizGeometrica,norm(p1- p2)); %Dilatacion
          p1=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica); 
                    
          pause(1);
          set(p1,'Visible','Off')
          
          angulo=atan(-orientacion(1,1)/orientacion(2,1));
          viga.matrizGeometrica=RotacionX(viga.matrizGeometrica,angulo); %Dilatacion
          p2=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica); 
                    
          pause(1);
          set(p2,'Visible','Off')
           
          viga.matrizGeometrica=TR*viga.matrizGeometrica; %Traslacion y rotacion
          viga.graficar(viga.matrizGeometrica,viga.matrizTopologica);
          
        case 'Pared'
            viga=Elemento1D('Rectangular');
           p0=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica);
          
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 35];
          definput = {'','',''};
          p1 = inputdlg(prompt,title,dims,definput);   
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 35];
          definput = {'','',''};
          p2 = inputdlg(prompt,title,dims,definput); 
          
            prompt = {'Grosor'};
          title = 'Grosor';
          dims = [1 35];
          definput = {''};
          g = inputdlg(prompt,title,dims,definput); 
          
          prompt = {'Z'};
          title = 'Altura';
          dims = [1 35];
          definput = {''};
          a = inputdlg(prompt,title,dims,definput);
          
          p1=str2num(cell2mat(p1));
          p2=str2num(cell2mat(p2));
          a=str2num(cell2mat(a));
          g=str2num(cell2mat(g));
          e1=(p2-p1)/norm(p2-p1);
          p3=[p1(1,1);p1(2,1)+3;p1(3,1)];
          p1p3=(p3-p1);
          e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);
          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e2(1,1) e3(1,1) p1(1,1)
                e1(2,1) e2(2,1) e3(2,1) p1(2,1)
                e1(3,1) e2(3,1) e3(3,1) p1(3,1)
                0 0 0 1];
            
          dibujaTriedro(TR);
          
          set(p0,'Visible','Off')
          
          viga.matrizGeometrica=DilatacionX(viga.matrizGeometrica,norm(p1- p2)); %Dilatacion
          p1=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica); 
                    
          pause(1);
          set(p1,'Visible','Off')
          
          p2=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica); 
                    
          pause(1);
          set(p2,'Visible','Off')
           
          viga.matrizGeometrica=TR*viga.matrizGeometrica; %Traslacion y rotacion
          viga.graficar(viga.matrizGeometrica,viga.matrizTopologica);
          
          viga.matrizGeometrica=DilatacionZ(viga.matrizGeometrica,a);
          viga.graficar(viga.matrizGeometrica,viga.matrizTopologica);
       case 'Puerta'
          puerta=FiguraCompleja();  
          disp(size(puerta.matrizGeometrica));
          p0=puerta.graficar(puerta.matrizGeometrica,puerta.matrizTopologica);   
          
            
       otherwise
            %No hace nada
    end

function BGuardar_Callback(hObject, eventdata, handles)
    % hObject    handle to BGuardar (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

function BAbrir_Callback(hObject, eventdata, handles)
    % hObject    handle to BAbrir (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
