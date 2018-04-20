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
    % End initialization code - DO NOT EDIT sfdsf

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)
    setGlobalFormas=[];
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
    setGlobalFormas=[];
    pos_size = get(handles.figure1,'Position');
    
    % Call modaldlg with the argument 'Position'.
    user_response = modal_nuevoProyecto('Title','Nuevo proyecto');
    switch user_response
    case 'No'
        %No hace nada
    case 'Si'
        cla reset;
        clearvars;
        clearvars -global;
        clc;
        
        T0 = [1 0 0 0
          0 1 0 0
          0 0 1 0
          0 0 0 1];
        dibujaTriedro(T0);
        grid on;
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        view(30, 20);
        
        prompt = {'X(mm)','Y(mm)','Z(mm)'};
        title = 'Dimensiones';
        dims = [1 50];
        definput = {'','',''};
        nuevas_dimensiones = inputdlg(prompt,title,dims,definput);
        
        xlim([0 str2double(nuevas_dimensiones{1,1})]);
        ylim([0 str2double(nuevas_dimensiones{2,1})]);
        zlim([0 str2double(nuevas_dimensiones{3,1})]);
        
        prompt = {'X','Y','Z'};
        title = 'Divisiones';
        dims = [1 50];
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
          %Pregunta tipo de seccion
%           prompt = {'R: Rectangular, C: Circular'};
%           title = 'Tipo de seccion';
%           dims = [1 50];
%           definput = {''};
%           tipoSeccion = inputdlg(prompt,title,dims,definput);
          tipoSeccion='R';
          
          %Crea viga segun tipo de seccion
          switch tipoSeccion
              case 'C'
                  viga=Elemento1D('Circular');  
                  
              otherwise
                  viga=Elemento1D('Rectangular');
                  %Grafica posicion estandar
                  g0=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica,rgb('LimeGreen'));
                  
                  %Define ancho y alto de seccion
                  prompt = {'Ancho','Alto'};
                  title = 'Ancho y alto de seccion';
                  dims = [1 50];
                  definput = {'',''};
                  seccion = inputdlg(prompt,title,dims,definput);
                  viga.base=str2double(cell2mat(seccion(1,1)));
                  viga.altura=str2double(cell2mat(seccion(2,1)));
                  
                  %Dilatacion en Y y Z segun ancho y alto
                  set(g0,'Visible','Off');
                  viga.matrizGeometrica=Dilatacion(viga.matrizGeometrica,1,viga.base,viga.altura); 
                  g1=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica,rgb('LimeGreen'));
          end
          
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 50];
          definput = {'','',''};
          p1 = inputdlg(prompt,title,dims,definput);
          p1=[str2double(cell2mat(p1(1,1)));str2double(cell2mat(p1(2,1)));str2double(cell2mat(p1(3,1)))];
                    
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 50];
          definput = {'','',''};
          p2 = inputdlg(prompt,title,dims,definput);
          p2=[str2double(cell2mat(p2(1,1)));str2double(cell2mat(p2(2,1)));str2double(cell2mat(p2(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto para orientacion';
          dims = [1 50];
          definput = {'','',''};
          p3 = inputdlg(prompt,title,dims,definput);
          p3=[str2double(cell2mat(p3(1,1)));str2double(cell2mat(p3(2,1)));str2double(cell2mat(p3(3,1)))];

          %Dilatacion en X segun p1 y p2
          set(g1,'Visible','Off');
          viga.matrizGeometrica=Dilatacion(viga.matrizGeometrica,norm(p1- p2),1,1); 
          g2=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica,rgb('LimeGreen')); 
          
%           prompt = {'Y','Z'};
%           title = 'Rotación YZ';
%           dims = [1 50];
%           definput = {'',''};
%           orientacion = inputdlg(prompt,title,dims,definput);
%           orientacion=[str2double(cell2mat(orientacion(1,1)));str2double(cell2mat(orientacion(2,1)))];
          
          e1=(p2-p1)/norm(p2-p1);
%           p3=[p1(1,1);p1(2,1)+3;p1(3,1)];
          p1p3=(p3-p1);

          e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);

          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e2(1,1) e3(1,1) p1(1,1)
                e1(2,1) e2(2,1) e3(2,1) p1(2,1)
                e1(3,1) e2(3,1) e3(3,1) p1(3,1)
                0 0 0 1];
            
          dibujaTriedro(TR);
     
          %Rotacion segun orientacion
          set(g2,'Visible','Off');
%           angulo=atan(-orientacion(1,1)/orientacion(2,1));
%           viga.matrizGeometrica=RotacionX(viga.matrizGeometrica,angulo); 
%           g3=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica,rgb('LimeGreen')); 
%                     
%           pause(1);
%           set(g3,'Visible','Off')
           
          %Traslacion y rotacion final
          viga.matrizGeometrica=TR*viga.matrizGeometrica; 
          g4=viga.graficar(viga.matrizGeometrica,viga.matrizTopologica,rgb('LimeGreen'));
          vigas=getGlobalViga();
          vigas=[vigas; viga];
          setGlobalViga(vigas)
        case 'Pared'
          pared=Elemento2D();
          p0=pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('MediumBlue')); 
          %pp0=puerta.graficar(puerta.matrizGeometrica,puerta.matrizTopologica);  
          %pp0.FaceColor = rgb('Sienna');
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 50];
          definput = {'','',''};
          inicioPared = inputdlg(prompt,title,dims,definput);
          inicioPared=[str2double(cell2mat(inicioPared(1,1)));str2double(cell2mat(inicioPared(2,1)));str2double(cell2mat(inicioPared(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 50];
          definput = {'','',''};
          finPared = inputdlg(prompt,title,dims,definput);
          finPared=[str2double(cell2mat(finPared(1,1)));str2double(cell2mat(finPared(2,1)));str2double(cell2mat(finPared(3,1)))];
          
          prompt = {'Z'};
          title = 'Altura';
          dims = [1 50];
          definput = {''};
          altura = inputdlg(prompt,title,dims,definput);
          altura=str2double(cell2mat(altura(1,1)));
          
          prompt = {'Grosor'};
          title = 'Grosor';
          dims = [1 50];
          definput = {''};
          grosor = inputdlg(prompt,title,dims,definput);
          grosor=str2double(cell2mat(grosor(1,1)));
          
          x=finPared(1,1)-inicioPared(1,1);
          y=finPared(2,1)-inicioPared(2,1);
          
          dil=norm(finPared-inicioPared);
          if(x<=y)
             pared.matrizGeometrica=Dilatacion(pared.matrizGeometrica,dil,grosor,altura);
             %pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('Gray'));
          end
          if(x>y)
             pared.matrizGeometrica=Dilatacion(pared.matrizGeometrica,grosor,dil,altura);
             %pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('Gray'));
          end
          
          
          %puerta.matrizGeometrica=Traslacion(puerta.matrizGeometrica,inicioPuerta(1,1),inicioPuerta(2,1),inicioPuerta(3,1));
          pause(1);
    
          e1=(finPared-inicioPared)/norm(finPared-inicioPared);
          p3=[inicioPared(1,1);inicioPared(2,1)+3;inicioPared(3,1)];
          p1p3=(p3-inicioPared);
          if e1(1,1)==0 && e1(3,1)==0
              e2=[-1;0;0];
          else
              e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);
          end 
          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e2(1,1) e3(1,1) inicioPared(1,1)
                e1(2,1) e2(2,1) e3(2,1) inicioPared(2,1)
                e1(3,1) e2(3,1) e3(3,1) inicioPared(3,1)
                0 0 0 1];
          pared.matrizGeometrica= TR*pared.matrizGeometrica;
          pp1=pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('MediumBlue'));  
          set(p0,'Visible','Off');
         
          paredes=getGlobalPared();
          paredes=[paredes; pared];
          setGlobalPared(paredes)   
       case 'Piso'

           piso=Elemento2D();
           p0=piso.graficar(piso.matrizGeometrica,piso.matrizTopologica,rgb('Orange'));
          
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 50];
          definput = {'','',''};
          p1 = inputdlg(prompt,title,dims,definput);
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 50];
          definput = {'','',''};
          p2 = inputdlg(prompt,title,dims,definput); 
          
          prompt = {'Largo'};
          title = 'Largo';
          dims = [1 50];
          definput = {''};
          a = inputdlg(prompt,title,dims,definput);
          
          prompt = {'Grosor'};
          title = 'Grosor';
          dims = [1 50];
          definput = {''};
          g = inputdlg(prompt,title,dims,definput); 
          
          p11=str2double(cell2mat(p1(1)));
          p21=str2double(cell2mat(p2(1)));
          p12=str2double(cell2mat(p1(2)));
          p22=str2double(cell2mat(p2(2)));
          p13=str2double(cell2mat(p1(3)));
          p23=str2double(cell2mat(p2(3)));
          
          x=p21-p11;
          y=p22-p12;
          z=p23-p13;
                   
          g=str2double(cell2mat(g));
          a=str2double(cell2mat(a));
          
          if(x<y)
             piso.matrizGeometrica=DilatacionX(piso.matrizGeometrica,a); 
             piso.matrizGeometrica=DilatacionY(piso.matrizGeometrica,y);
             %pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('Gray'));
          end
          if(x>y)
             piso.matrizGeometrica=DilatacionY(piso.matrizGeometrica,a); 
             piso.matrizGeometrica=DilatacionX(piso.matrizGeometrica,x);
             %pared.graficar(pared.matrizGeometrica,pared.matrizTopologica,rgb('Gray'));
          end
          
          piso.matrizGeometrica=DilatacionZ(piso.matrizGeometrica,g);
          
          
          piso.matrizGeometrica=Traslacion(piso.matrizGeometrica,p11,p12,p13);
          piso.graficar(piso.matrizGeometrica,piso.matrizTopologica,rgb('Orange'));
          set(p0,'Visible','Off');
          pisos=getGlobalPiso();
          pisos=[pisos; piso];
          setGlobalPiso(pisos)
      case 'Puerta'
          puerta=FiguraCompleja('Puerta');  
          pp0=puerta.graficar(puerta.matrizGeometrica,puerta.matrizTopologica);  
          pp0.FaceColor = rgb('Sienna');
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 50];
          definput = {'','',''};
          inicioPuerta = inputdlg(prompt,title,dims,definput);
          inicioPuerta=[str2double(cell2mat(inicioPuerta(1,1)));str2double(cell2mat(inicioPuerta(2,1)));str2double(cell2mat(inicioPuerta(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 50];
          definput = {'','',''};
          finPuerta = inputdlg(prompt,title,dims,definput);
          finPuerta=[str2double(cell2mat(finPuerta(1,1)));str2double(cell2mat(finPuerta(2,1)));str2double(cell2mat(finPuerta(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto para orientacion';
          dims = [1 50];
          definput = {'','',''};
          p3 = inputdlg(prompt,title,dims,definput);
          p3=[str2double(cell2mat(p3(1,1)));str2double(cell2mat(p3(2,1)));str2double(cell2mat(p3(3,1)))];

          prompt = {'Altura'};
          title = 'Altura';
          dims = [1 50];
          definput = {''};
          altura = inputdlg(prompt,title,dims,definput);
          altura=str2double(cell2mat(altura(1,1)));
          
          dil=norm(finPuerta-inicioPuerta);
          puerta.matrizGeometrica=Dilatacion(puerta.matrizGeometrica,dil,dil,altura);
          
          %puerta.matrizGeometrica=Traslacion(puerta.matrizGeometrica,inicioPuerta(1,1),inicioPuerta(2,1),inicioPuerta(3,1));
          pause(1);
          set(pp0,'Visible','Off');
          
          e1=(finPuerta-inicioPuerta)/norm(finPuerta-inicioPuerta);
%         p3=[p1(1,1);p1(2,1)+3;p1(3,1)];
          p1p3=(p3-inicioPuerta);

          e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);

          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e2(1,1) e3(1,1)  inicioPuerta(1,1)
                e1(2,1) e2(2,1) e3(2,1)  inicioPuerta(2,1)
                e1(3,1) e2(3,1) e3(3,1)  inicioPuerta(3,1)
                0 0 0 1];
            
          dibujaTriedro(TR);
          puerta.matrizGeometrica= TR*puerta.matrizGeometrica;
          pp1=puerta.graficar(puerta.matrizGeometrica,puerta.matrizTopologica);  
          pp1.FaceColor = rgb('Sienna');

       case 'Ventana'
          ventana=FiguraCompleja('Ventana');  
          pv0=ventana.graficar(ventana.matrizGeometrica,ventana.matrizTopologica);  
          pv0.FaceColor = rgb('SteelBlue');
          prompt = {'X','Y','Z'};
          title = 'Punto inicial';
          dims = [1 50];
          definput = {'','',''};
          inicioVentana = inputdlg(prompt,title,dims,definput);
          inicioVentana=[str2double(cell2mat(inicioVentana(1,1)));str2double(cell2mat(inicioVentana(2,1)));str2double(cell2mat(inicioVentana(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto final';
          dims = [1 50];
          definput = {'','',''};
          finVentana = inputdlg(prompt,title,dims,definput); 
          finVentana=[str2double(cell2mat(finVentana(1,1)));str2double(cell2mat(finVentana(2,1)));str2double(cell2mat(finVentana(3,1)))];
          
          prompt = {'X','Y','Z'};
          title = 'Punto para orientacion';
          dims = [1 50];
          definput = {'','',''};
          p3 = inputdlg(prompt,title,dims,definput);
          p3=[str2double(cell2mat(p3(1,1)));str2double(cell2mat(p3(2,1)));str2double(cell2mat(p3(3,1)))];

          
          prompt = {'Altura'};
          title = 'Altura';
          dims = [1 50];
          definput = {''};
          altura = inputdlg(prompt,title,dims,definput); 

          altura=str2double(cell2mat(altura(1,1)));
          dil=norm(finVentana-inicioVentana);
          ventana.matrizGeometrica=Dilatacion(ventana.matrizGeometrica,dil,dil,altura);
%         puerta.matrizGeometrica=Dilatacion(puerta.matrizGeometrica,0,0,altura);
          
          pause(1);
          set(pv0,'Visible','Off');
          
           e1=(finVentana-inicioVentana)/norm(finVentana-inicioVentana);
%         p3=[p1(1,1);p1(2,1)+3;p1(3,1)];
          p1p3=(p3-inicioVentana);

          e2=(p1p3-(p1p3.'*e1)*e1)/norm(p1p3-(p1p3.'*e1)*e1);

          e2=e2/norm(e2);
          e3=cross(e1,e2);
          
          TR = [e1(1,1) e3(1,1) e2(1,1)  inicioVentana(1,1)
                e1(2,1) e3(2,1) e2(2,1)  inicioVentana(2,1)
                e1(3,1) e3(3,1) e2(3,1)  inicioVentana(3,1)
                0 0 0 1];
            
          dibujaTriedro(TR);
          ventana.matrizGeometrica= TR*ventana.matrizGeometrica;
          pv1=ventana.graficar(ventana.matrizGeometrica,ventana.matrizTopologica);  
          pv1.FaceColor = rgb('SteelBlue');

       otherwise
            %No hace nada
    end

function BTemblor_Callback(hObject, eventdata, handles)
    % hObject    handle to BTemblor (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
          vigas=getGlobalViga
          pisos=getGlobalPiso;
          paredes=getGlobalPared;
          
          graficasVigas=[];
          graficasPisos=[];
          graficasParedes=[];
          
          matrizT=[1 0 0 1; 0 1 0 0; 0 0 1 0; 0 0 0 1];
          sVi=size(vigas)
          sPi=size(pisos);
          sPa=size(paredes);
          
          for a=[0:0.2:5 sort(0:0.2:5,'descend') sort(-5:0.2:0,'descend') sort(-5:0.2:0,'ascend')]
              %Vigas
              %------------------------------------------------------
              for i=1:sVi(1,1)
                  mgeo=vigas(i).matrizGeometrica;
                  filaz=mgeo(3,:);
                  tamfilaz=size(filaz);

                  for j=1:tamfilaz(1,2)
                      filaz(1,j)=(a*filaz(1,j))/15;
                  end

                  mgeo(4,:)=filaz;

                  x=matrizT*mgeo;
                  x(4,:)=1;
                  p=vigas(i).graficar(x,vigas(i).matrizTopologica, rgb('LimeGreen'));
                  graficasVigas=[graficasVigas p];
                  
              end
                           
              % Pisos
              % --------------------------------------------------------------
              
              for i=1:sPi(1,1)
                  mgeo=pisos(i).matrizGeometrica;
                  filaz=mgeo(3,:);
                  tamfilaz=size(filaz);

                  for j=1:tamfilaz(1,2)
                      filaz(1,j)=(a*filaz(1,j))/15;
                  end

                  mgeo(4,:)=filaz;

                  x=matrizT*mgeo;
                  x(4,:)=1;
                  p=pisos(i).graficar(x,vigas(i).matrizTopologica, rgb('Orange'));
                  graficasPisos=[graficasPisos p];
                  
              end
                           
              % Paredes
              % -------------------------------------------------------------
              for i=1:sPa(1,1)
                  mgeo=paredes(i).matrizGeometrica;
                  filaz=mgeo(3,:);
                  tamfilaz=size(filaz);

                  for j=1:tamfilaz(1,2)
                      filaz(1,j)=(a*filaz(1,j))/15;
                  end

                  mgeo(4,:)=filaz;

                  x=matrizT*mgeo;
                  x(4,:)=1;
                  p=paredes(i).graficar(x,vigas(i).matrizTopologica, rgb('MediumBlue'));
                  graficasParedes=[graficasParedes p];
                  
              end
              
              tamGraficasVigas=size(graficasVigas);
              for k=1:tamGraficasVigas(1,2)
                  pause(0.0001);
                  set(graficasVigas(k),'Visible','Off');
              end
              graficasVigas=[];
              
              tamGraficasPisos=size(graficasPisos);
              for k=1:tamGraficasPisos(1,2)
                  pause(0.0001);
                  set(graficasPisos(k),'Visible','Off');
              end
              graficasPisos=[];
              
              tamGraficasParedes=size(graficasParedes);
              for k=1:tamGraficasParedes(1,2)
                  pause(0.0001);
                  set(graficasParedes(k),'Visible','Off');
              end
              graficasParedes=[];
          end
          
          
   

function BAbrir_Callback(hObject, eventdata, handles)
    % hObject    handle to BAbrir (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BGenerar.
function BGenerar_Callback(hObject, eventdata, handles)
% hObject    handle to BGenerar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 plano=get(handles.gProyecciones,'SelectedObject');
    
    switch get(plano,'string')
       
       case 'XY'
          vigas=getGlobalViga;
          pisos=getGlobalPiso;
          paredes=getGlobalPared;
          matrizT=[1 0 0 0; 0 1 0 0; 0 0 0 0; 1 1 1 1];
          sVi=size(vigas);
          sPi=size(pisos);
          sPa=size(paredes);
          figure;
          for i=1:sVi(1,1)
              x=matrizT*vigas(i).matrizGeometrica;
              vigas(i).graficar(x,vigas(i).matrizTopologica, rgb('LimeGreen'));
          end
          for j=1:sPi(1,1)
              y=matrizT*pisos(i).matrizGeometrica;
              pisos(i).graficar(y,pisos(i).matrizTopologica, rgb('Orange'));
          end
          for k=1:sPa(1,1)
              z=matrizT*paredes(i).matrizGeometrica;
              paredes(i).graficar(z,paredes(i).matrizTopologica, rgb('MediumBlue'));
          end
          
       case 'YZ'
          vigas=getGlobalViga;
          pisos=getGlobalPiso;
          paredes=getGlobalPared;
          matrizT=[0 0 0 0; 0 1 0 0; 0 0 1 0; 1 1 1 1];
          sVi=size(vigas);
          sPi=size(pisos);
          sPa=size(paredes);
          figure;
          for i=1:sVi(1,1)
              x=matrizT*vigas(i).matrizGeometrica;
              vigas(i).graficar(x,vigas(i).matrizTopologica, rgb('LimeGreen'));
          end
          for j=1:sPi(1,1)
              y=matrizT*pisos(i).matrizGeometrica;
              pisos(i).graficar(y,pisos(i).matrizTopologica, rgb('Orange'));
          end
          for k=1:sPa(1,1)
              z=matrizT*paredes(i).matrizGeometrica;
              paredes(i).graficar(z,paredes(i).matrizTopologica, rgb('MediumBlue'));
          end
           
       case 'ZX'
          vigas=getGlobalViga;
          pisos=getGlobalPiso;
          paredes=getGlobalPared;
          matrizT=[1 0 0 0; 0 0 0 0; 0 0 1 0; 1 1 1 1];
          sVi=size(vigas);
          sPi=size(pisos);
          sPa=size(paredes);
          figure;
          for i=1:sVi(1,1)
              x=matrizT*vigas(i).matrizGeometrica;
              vigas(i).graficar(x,vigas(i).matrizTopologica, rgb('LimeGreen'));
          end
          for j=1:sPi(1,1)
              y=matrizT*pisos(i).matrizGeometrica;
              pisos(i).graficar(y,pisos(i).matrizTopologica, rgb('Orange'));
          end
          for k=1:sPa(1,1)
              z=matrizT*paredes(i).matrizGeometrica;
              paredes(i).graficar(z,paredes(i).matrizTopologica, rgb('MediumBlue'));
          end          
    end

