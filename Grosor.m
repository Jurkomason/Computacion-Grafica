function [B]=Grosor(A,D,p1,p2)

if(p1 < p2)
MTransformacion = [D    0   0   0
                   0    1   0   0
                   0    0   1   0
                   0    0   0   1];

B = MTransformacion*A;
return ;
end
if(p1 >= p2)
MTransformacion = [1    0   0   0
                   0    D   0   0
                   0    0   1   0
                   0    0   0   1];

B = MTransformacion*A;
return ;
end
