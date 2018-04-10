classdef FiguraCompleja < figuraGeometrica
    %Vigas y columnas
    properties
        escalaZ;
        puntoA=[1 0 0];
        puntoB=[0 1 0];
        matrizGeometrica=[];
        matrizTopologica=[];
    end
    
    methods
        function obj=FiguraCompleja(tipo)        
            if strcmp(tipo,'Puerta')
                fv = stlread('fairydoor2.stl');
                fv.vertices=transpose(fv.vertices);
                v=length(fv.vertices);
                fv.vertices=[fv.vertices; ones(1,v)];
            end
            if strcmp(tipo,'Ventana')
                fv = stlread('window1.stl');
                fv.vertices=transpose(fv.vertices);
                
                v=length(fv.vertices);
                fv.vertices=[fv.vertices; ones(1,v)];
                fv.vertices=RotacionX(fv.vertices,pi/2);
            end
                %x=[1 0 0; 0 -1 0; 0 0 1];
                %fv.vertices=fv.vertices*x;
                fv.faces=transpose(fv.faces);
                
                %fv.faces=[fv.faces; ones(1,f)];
                minX=min(fv.vertices(1,:));
                minY=min(fv.vertices(2,:));
                fv.vertices=Traslacion(fv.vertices,-minX,-minY,0);
                maxX=max(fv.vertices(1,:));
                fv.vertices=Dilatacion(fv.vertices,1/maxX,1/maxX,1/maxX);
                obj.matrizGeometrica=fv.vertices;
                obj.matrizTopologica=fv.faces;

            
        end
    end
    methods(Static)
        function p=graficar(matGeo, matTopo)
            matGeo(4,:)=[];
            matGeo=matGeo.';
            matTopo=matTopo.';
            p = patch('Faces',matTopo,'Vertices',matGeo);

            
            set(p, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none','FaceLighting',    'gouraud',     ...
                'AmbientStrength', 0.15);
            daspect([1 1 1]);

            camlight('headlight');
            material('dull');
        end


    end
    
end

