function [B]=DilatacionX(A,D)

MTransformacion = [D    0   0   0
                   0    1   0   0
                   0    0   1   0
                   0    0   0   1];

B = MTransformacion*A;

return;
