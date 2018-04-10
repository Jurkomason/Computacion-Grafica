function [B]=Traslacion(A,DX,DY,DZ)

MTransformacion = [1    0   0   DX
                   0    1   0   DY
                   0    0   1   DZ
                   0    0   0   1];

B = MTransformacion*A;

return;

