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
            x=[1 0 0; 0 -1 0; 0 0 1];
            fv.vertices=fv.vertices*x;
            transpose(fv.vertices);
            transpose(fv.faces);
            v=length(fv.vertices);
            f=length(fv.faces);
            fv.vertices=[fv.vertices; ones(1,v)];
            fv.faces=[fv.faces; ones(1,f)];
            obj.matrizGeometrica=fv.vertices;
            obj.matrizTopologica=fv.faces;
                     
        end


    end
    
end

