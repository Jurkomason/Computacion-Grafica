classdef Elemento2D < figuraGeometrica
    %Paredes y pisos
    properties
        espesor=1;
        puntoa= [1 0 0];
        puntob= [0 1 0];
        puntoc= [0 0 0];
        matrizGeometrica=[];
        matrizTopologica=[];
    end
    
    methods
        function obj=Elemento2D()
            
         
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
end

