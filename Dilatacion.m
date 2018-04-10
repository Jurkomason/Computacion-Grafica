function [B]=Dilatacion(A,DX,DY,DZ)

MTransformacion = [DX   0   0   0
                   0    DY  0   0
                   0    0   DZ  0
                   0    0   0   1];

B = MTransformacion*A;

return;
