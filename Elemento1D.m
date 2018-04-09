classdef Elemento1D < figuraGeometrica
    %Vigas y columnas
    properties
        tipoSeccion;
        diametro=1;
        base=1;
        altura=1;
        matrizGeometrica=[];
        matrizTopologica=[];
    end
    
    methods
        function obj=Elemento1D(seccion)
            obj.tipoSeccion=seccion;
            
            if(obj.tipoSeccion=='Rectangular')
                obj.matrizGeometrica=[0 1 0 1 0 1 0 1 
                                      0 0 1 1 1 1 0 0
                                      0 0 0 0 1 1 1 1
                                      1 1 1 1 1 1 1 1];
                              
                obj.matrizTopologica=[2 2 4 4 6 6 1 7 2 2 3 5
                                      1 3 3 5 5 7 2 2 4 6 1 1
                                      3 4 5 6 7 8 7 8 6 8 5 7];
                                  disp(size(obj.matrizGeometrica));               
            end
            
           
        end
        
        function obj = set.matrizGeometrica(obj,matGeo) 
            obj.matrizGeometrica=matGeo;
        end
        
        function mg = get.matrizGeometrica(obj)
             mg = obj.matrizGeometrica;
          end

    end
    
end

