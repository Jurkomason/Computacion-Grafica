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
        function obj=FiguraCompleja()        
            
            fv = stlread('fairydoor2.stl');
            %x=[1 0 0; 0 -1 0; 0 0 1];
            %fv.vertices=fv.vertices*x;
            fv.vertices=transpose(fv.vertices);
            fv.faces=transpose(fv.faces);
            v=length(fv.vertices);
            f=length(fv.faces);
            fv.vertices=[fv.vertices; ones(1,v)];
            %fv.faces=[fv.faces; ones(1,f)];
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

