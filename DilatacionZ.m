function [B]=DilatacionZ(A,D)

MTransformacion = [1    0   0   0
                   0    1   0   0
                   0    0   D   0
                   0    0   0   1];

B = MTransformacion*A;

return;