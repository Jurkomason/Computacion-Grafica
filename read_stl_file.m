function  read_stl_file(name)
f = fopen(name, 'r');
new_line = fgetl(f);

vertex = [ 0 0 0 ];
count_vertex = 1;
count_faces  = 1;
count_normal = 1;
i = 1;

while ischar(new_line)
   
     array_new_line=strsplit(new_line);
 
     %Busca normales  
     contiene_normal=contains(array_new_line, 'normal');
         
     k=1;
     encuentra_normal=0;
     [~,columna_normal]=size(contiene_normal);
         
    while (k<=columna_normal && encuentra_normal==0)
        if(contiene_normal(1,k)==1)
            encuentra_normal=1;
        end
        k=k+1;
    end
        
    if (encuentra_normal)
        normal = [str2double(array_new_line(k))  str2double(array_new_line(k+1))  str2double(array_new_line(k+2))];
        N(count_normal,:) = normal;
        count_normal = count_normal + 1;
    end
    
    %Busca vertices
    contiene_vertice=contains(array_new_line, 'vertex');
        
    k=1;
    encuentra_vertice=0;
    [fila_vertice,columna_vertice]=size(contiene_vertice);
        
    while (k<=columna_vertice && encuentra_vertice==0)
        if(contiene_vertice(1,k)==1)
            encuentra_vertice=1;
        end
        k=k+1;
    end
        
    if (encuentra_vertice)
        vertex = [str2double(array_new_line(k))  str2double(array_new_line(k+1))  str2double(array_new_line(k+2))];
        %sGuarda vertice
        V(count_vertex,:) = vertex;
        %Verifica triangulo
        if mod(count_vertex,3)==0
            %Guarda triangulo
            F(count_faces,:) = [ count_vertex-2 count_vertex-1 count_vertex ];
            count_faces = count_faces + 1;
        end
        count_vertex = count_vertex + 1;
 
    end
    new_line = fgetl(f);
end

fclose(f);

% test readed file

p = patch('Faces',F,'Vertices',V);
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
daspect([1 1 1]);

xlabel('Axis X');
ylabel('Axis Y');
zlabel('Axis Z');
camlight; lighting phong
grid on

return

