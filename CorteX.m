function [B]=CorteX(A,C)

MTransformacion = [1    C
                   0    1];

B = MTransformacion*A';

return;
