classdef (Abstract)figuraGeometrica
    
    properties(Abstract)
        matrizGeometrica
        matrizTopologica
    end
    
    methods
        function obj = figuraGeometrica(matrizGeo,matrizTopo)
         obj.matrizGeometrica = matrizGeo;
         obj.matrizTopologica = matrizTopo;
        end
        
        function graficar
         
        end
    end
    
end

