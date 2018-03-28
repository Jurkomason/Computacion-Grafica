function [B]=ReflexionX(A)

MTransformacion = [1    0
                   0    -1];

B = MTransformacion*A';

return;
