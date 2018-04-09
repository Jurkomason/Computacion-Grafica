classdef (Abstract)figuraGeometrica
    
    properties (Abstract)
        matrizGeometrica
        matrizTopologica
    end
    
    methods(Static)
        function p=graficar(matGeo, matTopo)
            matGeo(4,:)=[];
            matGeo=matGeo.';
            matTopo=matTopo.';
            
            p = patch('Faces',matTopo,'Vertices',matGeo);
            set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
            daspect([1 1 1]);

            camlight; lighting phong

        end
    end
    
end

