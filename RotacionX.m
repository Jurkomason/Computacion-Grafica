function [B]=RotacionX(A,alfa)
%alfa: angulo de rotacion contrario a la manecillas del reloj

MTransformacion = [1    0            0          0
                   0    cos(alfa)    -sin(alfa) 0
                   0    sin(alfa)    cos(alfa)  0
                   0    0            0          1];

B = MTransformacion*A;

return;
